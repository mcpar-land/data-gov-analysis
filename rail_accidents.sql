.echo on
.maxwidth 110

create view df_raw as select * from read_csv('data/rail_accidents.csv.gz', all_varchar=true);

-- check this shit out

.maxrows 200
.mode csv
select column_name from (describe table df_raw);

.maxrows 40
.mode duckbox


create view df as select
    strptime(
        date || ' ' || regexp_replace(replace(time, 'None', 'AM'), '^0:(\d+)', '12:\1'),
        '%m/%d/%Y %I:%M %p'
    ) datetime, 
    struct_pack(*columns('^Other Railroad')) other_railroad,
    struct_pack(*columns('^Maintenance Railroad')) maintenance_railroad,
    "Grade Crossing ID" grade_crossing_id,
    struct_pack(*columns('^Accident Type')) accident_type,
    struct_pack(*columns('^Hazmat')) hazmat,
    "Persons Evacuated",
    "Subdivision",
    "Division Code" ,
    "Division",
    "Station",
    "Milepost",
    struct_pack(*columns('^State')) state,
    struct_pack(*columns('^County')) county,
    "District",
    "Temperature",
    struct_pack(*columns('^Visibility')) visibility,
    struct_pack(*columns('^Weather Condition')) weater_condition,
    struct_pack(*columns('^Track')) track,
    struct_pack(*columns('^Train Direction')) train_direction,
    struct_pack(*columns('^Equipment Type')) equipment_type,
    "Equipment Attended",
    "Train Number",
    "Train Speed",
    "Recorded Estimated Speed",
    "Maximum Speed",
    "Gross Tonnage",
    struct_pack(*columns('^Signalization')) signalization,
    struct_pack(*columns('^Method of Operation')) method_of_operation,
    struct_pack(*columns('^Adjunct')) adjunct,
    struct_pack(*columns('^Remote Control Locomotive')) remote_control_locomotive,
    struct_pack(*columns('^First Car')) first_car,
    struct_pack(*columns('^Causing Car')) causing_car,
    "Positive Alcohol Tests" positive_alcohol_tests,
    "Positive Drug Tests" positive_drug_tests,
    "Passengers Transported" passengers_transported,
    "Head End Locomotives" head_end_locomotives,
    "Mid Train Manual Locomotives",
    "Mid Train Remote Locomotives",
    "Rear End Manual Locomotives",
    "Rear End Remote Locomotives",
    "Derailed Head End Locomotives",
    "Derailed Mid Train Manual Locomotives",
    "Derailed Mid Train Remote Locomotives",
    "Derailed Rear End Manual Locomotives",
    "Derailed Rear End Remote Locomotives",
    "Loaded Freight Cars",
    "Loaded Passenger Cars",
    "Empty Freight Cars",
    "Empty Passenger Cars",
    "Cabooses",
    "Derailed Loaded Freight Cars",
    "Derailed Loaded Passenger Cars",
    "Derailed Empty Freight Cars",
    "Derailed Empty Passenger Cars",
    "Derailed Cabooses",
    "Equipment Damage Cost",
    "Track Damage Cost",
    "Total Damage Cost",
    struct_pack(*columns('^Primary Accident Cause')) primary_accident_cause,
    struct_pack(*columns('^Contributing Accident Cause')) contributing_accident_cause,
    struct_pack(*columns('^Accident Cause')) accident_cause,
    struct_pack(*columns('On Duty$')) staff_on_duty,
    struct_pack(*columns('Killed')) killed,
    struct_pack(*columns('Injured')) injured,
    "Special Study 1",
    "Special Study 2",
    "Latitude"::FLOAT latitude,
    "Longitude"::FLOAT longitude,
    "Narrative",
    struct_pack(*columns('^Joint Track')) joint_track,
    struct_pack(*columns('^Class')) "class",
    "Joint CD",
    "Incident Key",
    "Report Key",
    struct_pack(*columns('^Reporting Railroad')) reporting_railroad,
    struct_pack(*columns('^Reporting Parent Railroad')) reporting_parent_railroad,
    struct_pack(*columns('^Other Railroad')) other_railroad,
    struct_pack(*columns('^Other Parent Railroad')) other_parent_railroad,
    struct_pack(*columns('^Maintenance Railroad')) maintenance_railroad,
    struct_pack(*columns('^Maintenance Parent Railroad')) maintenance_parent_railroad,
    "Location"
from df_raw;

select latitude, longitude from df where latitude is not null and longitude is not null using sample 20;

select
    (latitude is not null and latitude != 0) has_coords,
    min(datetime) min_date,
    max(datetime) max_date,
    count(*)
from df group by has_coords;
