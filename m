Return-Path: <linux-scsi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de> <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Fri, 30 Mar 2018 12:07:05 -0600
Message-ID: <CANo=J16HKWi+t2zK4LOAM+hhTJC=oNBr+-AJpJYvnipjmf3KPw@mail.gmail.com>
Subject: Re: Multi-Actuator SAS HDD First Look
To: linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, dgilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hello-

Concerning how we are currently allocating commands to LUNs or the
device as a whole, here is a list based on the current two LUN model.
This model has LUN0 & LUN1, both reporting 1/2 the total storage. Our
definition of "device based" is that it ignores the LUN field and
executes the command on the entire device. In other words, sending a
device based command to LUN1 will also act on LUN0. "LUN-based"
commands affect only the LUN they're addressed to. I'm soliciting
feedback and suggestions, as well as subject matter experts to point
out pain points and incompatibilities. Thank you for your input.

These commands ignore the LUN field and affect all LUNs on the device:
0x00: TEST UNIT READY. Applies to entire device. The drive will return
a GOOD status only if both LUNs can service medium access commands.
0x01: REZERO. Applies to entire device. The command will force the
seek to LBA 0 on both LUNs. The thermal compensation and other actions
are also taken at both LUNs (actuators)."
0x04: FORMAT UNIT. Applies to entire device. The format parameters are
applied to both LUN's. The format operation is done in parallel on the
two LUN's. Format with defect list is not supported for the Dual LUN
drive."
0x12: INQUIRY. Applies to entire device. The same information is
returned for the Inquiry command regardless of LUN setting. Each LUN
has different identifier.
0x1B: START STOP UNIT. Applies to entire device. The command will
apply to both actuators - it will cause both actuators to be either
spin down or spin-up depending on the command options. If the command
fails on either actuator check condition is returned.
0x35: SYNCRONIZE CACHE. Applies to entire device. This will be a
device command and only support the option to flush the entire cache.
The drive does not support the flush of a particular LBA range only.
0x37: READ DEFECT DATA (10). Applies to entire device. Device based
defect list is returned - this will include the defects from both the
LUNs. The heads are sequentially numbered across both LUNs.
0x3B: WRITE BUFFER (10) Download. Applies to entire device. This is a
device based command - as part of the download the code on both the
LUN's will be updated.
0x3B: WRITE BUFFER (10) other than download. Applies to entire device.
Other than download Device based command - there is only one common
buffer for the two LUNs.
0x3C: READ BUFFER (10). Applies to entire device. Device based command
- there is only one common buffer for the two LUNs.
0x48 0x01: SANITIZE overwrite. Applies to entire device. Treated as a
device level command - sanitize operation performed on both LUNs when
command received.
0x48 0x03: SANITIZE security erase. Applies to entire device. Treated
as a device level command - sanitize operation performed on both LUNs
when command received.
0x48 0x1F: SANITIZE exit failure mode. Applies to entire device.
0x91: SYNCRONIZE CACHE (16). Applies to entire device. Same as Sync Cache.
0x4C: LOG SELECT (10). Applies to entire device. One global set of log
pages for both LUNs. Any LBA information is stored as an internal LBA
value, i.e. LUN1 LBAs start at LUN0 last_LBA + 1.
0x4D: LOG SENSE (10). Applies to entire device. One global set of log
pages for both LUNs. Any LBA information is stored as an internal LBA
value, i.e. LUN1 LBAs start at LUN0 last_LBA + 1.
0x55: MODE SELECT (10). Applies to entire device. Same as Mode select.
0x5A: MODE SENSE (10). Applies to entire device. Same as Mode sense.
0x9E 0x17: GET PHYSICAL ELEMENT STATUS. Applies to entire device.
0x9E 0x18: REMOVE ELEMENT AND TRUNCATE. Applies to entire device.
0xA0: REPORT LUNS. Applies to entire device. Returns information on
the two/multiple LUNs supported by the drive.
0xA2: SECURITY PROTOCOL IN. Applies to entire device.
0xA3 0x0C: REPORT SUPPORTED OP CODES. Applies to entire device.
0xA3 0x0D: REPORT SUPPORTED TMFS. Applies to entire device.
0xA3 0x0F: REPORT TIMESTAMP. Applies to entire device.
0xA4 0x0C: REMOVE I_T NEXUS. Applies to entire device.
0xB7: READ DEFECT DATA (12). Applies to entire device.
0xF7: READ UDS DATA. Applies to entire device.

These commands honor the LUN field and affect the addressed LUN only:
0x5E: PERSISTENT RESERVE IN. LUN Specific.
0x5F: PERSISTENT RESERVE OUT. LUN Specific.
0x9F 0x11: WRITE LONG (16). LUN Specific. Only support WR_UNCOR option
to make the sectors un-correctable.
0xA3 0x05: REPORT DEVICE ID. LUN Specific.
0xA4 0x06: SET DEVICE ID. LUN Specific.
0xB5: SECURITY PROTOCOL OUT. LUN Specific.
0x03: REQUEST SENSE.  LUN Specific. The command returns the sense data
for the respective LUN.
0x07: REASSIGN BLOCKS. LUN Specific. The reassign command will be LUN
specific. It reassigns the defective blocks in the defect list to the
reassign area on the respective LUN.
0x25: READ CAPACITY (10). LUN Specific. The capacity for the LUN
specified in the CDB is returned - the capacity can be different for
the two LUN's in the drive.
0x3E: READ LONG (10). LUN Specific
0x3F 0x11: WRITE LONG (10). LUN Specific
0x94 0x01: CLOSE ZONE. LUN Specific. ZBC.
0x94 0x02: FINISH ZONE. LUN Specific. ZBC.
0x94 0x03: OPEN ZONE. LUN Specific. ZBC.
0x94 0x04: RESET WRITE POINTER. LUN Specific. ZBC.
0x95 0x00: REPORT_ZONES. LUN Specific. The ZBC zone information is
returned per LUN.
0x9B: READ BUFFER (16). LUN Specific. Same as Read Buffer.
0x9E 0x10: READ CAPACITY (16). LUN Specific.

These commands can affect the device OR the LUN:
0x15: MODE SELECT (6). Device/ LUN. Single set of mode page parameters
are supported for the two LUN's. Only the 'Number of Blocks' in the
Block Descriptor may be different for the two LUNs. The option to set
the capacity for a LUN is not supported. If sector size is changed it
will impact both LUNs."
0x1A: MODE SENSE (6). Device/ LUN. Capacity on each LUN can be
different and so the 'Number of Blocks' in the Block Descriptor may be
different for the two LUNs.
0x1C: RECEIVE DIAGNOSTIC. Device/LUN. The data for the LUN specified
in the command is returned.
0x1D: SEND DIAGNOSTIC. Device/ LUN. The device will perform the
diagnostic operations (self-test) on both the LUNs. The 'translate
address' operation is performed on the LUN specified.

Best regards,
-Tim
(303) 775-3770

On Fri, Mar 30, 2018 at 7:07 AM, Tim Walker <tim.t.walker@seagate.com> wrote:
> Hi Doug-
>
> Currently, the dual actuator firmware safely spins the drive down if
> either LUN receives the START STOP UNIT command.  In other words, if
> LUN1 receives the command, it will flush any dirty data from LUN1l and
> LUN0, then spin down, taking both LUN1 & LUN0 off line. Alternatively,
> we've had input that either:
> a) Both LUNs must receive the START STOP UNIT command before the drive
> will spin down, OR
> b) Move the storage to LUN1 & LUN2, keeping LUN0 (with no storage) for
> device specific commands such as START STOP UNIT that do not directly
> access the media.
>
> Thanks for the question.
>
> Best regards,
> -Tim
>
> On Thu, Mar 29, 2018 at 12:03 PM, Douglas Gilbert <dgilbert@interlog.com> wrote:
>> On 2018-03-26 11:08 AM, Hannes Reinecke wrote:
>>>
>>> On Fri, 23 Mar 2018 08:57:12 -0600
>>> Tim Walker <tim.t.walker@seagate.com> wrote:
>>>
>>>> Seagate announced their split actuator SAS drive, which will probably
>>>> require some kernel changes for full support. It's targeted at cloud
>>>> provider JBODs and RAID.
>>>>
>>>> Here are some of the drive's architectural points. Since the two LUNs
>>>> share many common components (e.g. spindle) Seagate allocated some
>>>> SCSI operations to be LUN specific and some to affect the entire
>>>> device, that is, both LUNs.
>>>>
>>>> 1. Two LUNs, 0 & 1, each with independent lba space, and each
>>>> connected to an independent read channel, actuator, and set of heads.
>>>> 2. Each actuator addresses 1/2 of the media - no media is shared
>>>> across the actuators. They seek independently.
>>>> 3. One World Wide Name (WWN) is assigned to the port for device
>>>> address. Each Logical Unit has a separate World Wide Name for
>>>> identification in VPD page.
>>>> 4. 128 deep command queue, shared across both LUNs
>>>> 5. Each LUN can pull commands from the queue independently, so they
>>>> can implement their own sorting and optimization.
>>>> 6. Ordered tag attribute causes the command to be ordered across both
>>>> Logical Units
>>>> 7. Head of Queue attribute causes the command to be ordered with
>>>> respect to a single Logical Unit
>>>> 8. Mode pages are device-based (shared across both Logical Units)
>>>> 9. Log pages are device-based.
>>>> 10. Inquiry VPD pages (with minor exceptions) are device based.
>>>> 11. Device health features (SMART, etc) are device based
>>>>
>>>> Seagate wants the multi-actuator design to integrate into the stack as
>>>> painlessly as possible.The interface design is still in the early
>>>> stages, so I am gathering requirements and recommendations, and also
>>>> providing any information necessary to help scope integrating a
>>>> multi-LUN device into the MQ stack. So, I am soliciting any pertinent
>>>> feedback including:
>>>>
>>>> 1. Painful incompatibilities between the Seagate proposal and current
>>>> MQ architecture
>>>> 2. Linux changes needed
>>>> 3. Drive interface changes needed
>>>> 4. Anything else I may have overlooked
>>>>
>>> So far it looks okay; just make sure to have VPD page 0x83
>>> entries properly associated.
>>> To all intents and purposes these devices seem to look like 'normal'
>>> devices with two LUNs; nothing special with that.
>>> Real question would be in which areas those devices differentiate from
>>> the two indepdendent LUN scenario.
>>>
>>> There might be issues with per-device informations like SMART etc;
>>> ideally they are available from _both_ LUNs.
>>> Otherwise they'll show up as blank from one LUN, causing consternation
>>> with any management software.
>>
>>
>> Further to this point, some types of damage, such as to a head
>> or (one side of) a platter would degrade one LU, possibly making
>> it unusable for storage, while the other side (and the other LU)
>> would be fine.
>>
>> I'm curious how you plan to implement the START STOP UNIT command.
>> If one side of the platter is in "start" state and the other side
>> in "stop" state, will the heads on the stopped side be parked (if
>> they can be parked)? And if both sides (LUs) are stopped I would
>> hope you really would spin down the disk, then if either is started
>> the disk would be spun up.
>>
>> Getting T10 to add a bit to the Block Device Characteristics VPD page
>> might be helpful. It could be a "shares a spindle" bit with the other
>> LUs identified in the SCSI Ports VPD page. Such an indication would
>> help an enclosure find out if a Multi-Actuator disk was really spun down
>> and ready to be removed or replaced. I think SES and smartmontools may
>> need tweaks to handle this new device model sensibly.
>>
>> Doug Gilbert
>>
>>
>
>
>
> --
> Tim Walker
> Product Design Systems Engineering, Seagate Technology
> (303) 775-3770



-- 
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
