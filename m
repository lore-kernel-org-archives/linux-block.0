Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752358AbeCaMVY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Mar 2018 08:21:24 -0400
Subject: Re: Multi-Actuator SAS HDD First Look
To: Tim Walker <tim.t.walker@seagate.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Cc: dgilbert <dgilbert@interlog.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de>
 <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <CANo=J16HKWi+t2zK4LOAM+hhTJC=oNBr+-AJpJYvnipjmf3KPw@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9765f035-9a0d-6640-223f-63f2c964e064@suse.de>
Date: Sat, 31 Mar 2018 14:21:20 +0200
MIME-Version: 1.0
In-Reply-To: <CANo=J16HKWi+t2zK4LOAM+hhTJC=oNBr+-AJpJYvnipjmf3KPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/30/2018 08:07 PM, Tim Walker wrote:
> Hello-
> 
> Concerning how we are currently allocating commands to LUNs or the
> device as a whole, here is a list based on the current two LUN model.
> This model has LUN0 & LUN1, both reporting 1/2 the total storage. Our
> definition of "device based" is that it ignores the LUN field and
> executes the command on the entire device. In other words, sending a
> device based command to LUN1 will also act on LUN0. "LUN-based"
> commands affect only the LUN they're addressed to. I'm soliciting
> feedback and suggestions, as well as subject matter experts to point
> out pain points and incompatibilities. Thank you for your input.
> 
Uh. You will have fun pushing that past T-10 ...

> These commands ignore the LUN field and affect all LUNs on the device:
> 0x00: TEST UNIT READY. Applies to entire device. The drive will return
> a GOOD status only if both LUNs can service medium access commands.
Please, don't.
TEST UNIT READY is the _only_ command at SPC level allowing us to check
the state of the LUN. Moving that up the device (ie target) level is
leaving us with no idea about the status of the actual LUN.

> 0x01: REZERO. Applies to entire device. The command will force the
> seek to LBA 0 on both LUNs. The thermal compensation and other actions
> are also taken at both LUNs (actuators)."
Why? Is there any necessity that a REZERO of one LUN has a dependency on
the other?

> 0x04: FORMAT UNIT. Applies to entire device. The format parameters are
> applied to both LUN's. The format operation is done in parallel on the
> two LUN's. Format with defect list is not supported for the Dual LUN
> drive."
Again, why? Just for performance reasons?
That surely can be done by issuing a FORMAT UNIT command asynchonously
to both devices ...

> 0x12: INQUIRY. Applies to entire device. The same information is
> returned for the Inquiry command regardless of LUN setting. Each LUN
> has different identifier.
Strongly against it.
INQUIRY is _THE_ prime identifer of the LUN, Both LUNs might return the
same INQUIRY data, at the very least page 0x93 of the VPD data _NEEDS_
to be different both both LUNs.
Please keep it at LUN level.

> 0x1B: START STOP UNIT. Applies to entire device. The command will
> apply to both actuators - it will cause both actuators to be either
> spin down or spin-up depending on the command options. If the command
> fails on either actuator check condition is returned.
Already discussed. Probably no other way around it.

> 0x35: SYNCRONIZE CACHE. Applies to entire device. This will be a
> device command and only support the option to flush the entire cache.
> The drive does not support the flush of a particular LBA range only.
Fine with that; most HBAs have the same limitation.

> 0x37: READ DEFECT DATA (10). Applies to entire device. Device based
> defect list is returned - this will include the defects from both the
> LUNs. The heads are sequentially numbered across both LUNs.
Hmm. Again, why?

> 0x3B: WRITE BUFFER (10) Download. Applies to entire device. This is a
> device based command - as part of the download the code on both the
> LUN's will be updated.
About to be expected. Okay.

> 0x3B: WRITE BUFFER (10) other than download. Applies to entire device.
> Other than download Device based command - there is only one common
> buffer for the two LUNs.
See above. Okay.

> 0x3C: READ BUFFER (10). Applies to entire device. Device based command
> - there is only one common buffer for the two LUNs.
Might be worthwhile adding a new option to READ/WRITE BUFFER (eg using
one of the bits before the 'MODE' field), specifying that this command
applies to all LUNs on this device.

> 0x48 0x01: SANITIZE overwrite. Applies to entire device. Treated as a
> device level command - sanitize operation performed on both LUNs when
> command received.> 0x48 0x03: SANITIZE security erase. Applies to entire device. Treated
> as a device level command - sanitize operation performed on both LUNs
> when command received.
> 0x48 0x1F: SANITIZE exit failure mode. Applies to entire device.
Emphatically no.
That would allow one application on one LUN erasing the contents of the
other LUN, which might be in use by a completely different application.

> 0x91: SYNCRONIZE CACHE (16). Applies to entire device. Same as Sync Cache.
> 0x4C: LOG SELECT (10). Applies to entire device. One global set of log
> pages for both LUNs. Any LBA information is stored as an internal LBA
> value, i.e. LUN1 LBAs start at LUN0 last_LBA + 1.
> 0x4D: LOG SENSE (10). Applies to entire device. One global set of log
> pages for both LUNs. Any LBA information is stored as an internal LBA
> value, i.e. LUN1 LBAs start at LUN0 last_LBA + 1.
> 0x55: MODE SELECT (10). Applies to entire device. Same as Mode select.
> 0x5A: MODE SENSE (10). Applies to entire device. Same as Mode sense.
> 0x9E 0x17: GET PHYSICAL ELEMENT STATUS. Applies to entire device.
> 0x9E 0x18: REMOVE ELEMENT AND TRUNCATE. Applies to entire device.
> 0xA0: REPORT LUNS. Applies to entire device. Returns information on
> the two/multiple LUNs supported by the drive.
> 0xA2: SECURITY PROTOCOL IN. Applies to entire device.
> 0xA3 0x0C: REPORT SUPPORTED OP CODES. Applies to entire device.
> 0xA3 0x0D: REPORT SUPPORTED TMFS. Applies to entire device.
> 0xA3 0x0F: REPORT TIMESTAMP. Applies to entire device.
> 0xA4 0x0C: REMOVE I_T NEXUS. Applies to entire device.
> 0xB7: READ DEFECT DATA (12). Applies to entire device.
> 0xF7: READ UDS DATA. Applies to entire device.
> 
> These commands honor the LUN field and affect the addressed LUN only:
> 0x5E: PERSISTENT RESERVE IN. LUN Specific.
> 0x5F: PERSISTENT RESERVE OUT. LUN Specific.
> 0x9F 0x11: WRITE LONG (16). LUN Specific. Only support WR_UNCOR option
> to make the sectors un-correctable.
> 0xA3 0x05: REPORT DEVICE ID. LUN Specific.
> 0xA4 0x06: SET DEVICE ID. LUN Specific.
> 0xB5: SECURITY PROTOCOL OUT. LUN Specific.
> 0x03: REQUEST SENSE.  LUN Specific. The command returns the sense data
> for the respective LUN.
> 0x07: REASSIGN BLOCKS. LUN Specific. The reassign command will be LUN
> specific. It reassigns the defective blocks in the defect list to the
> reassign area on the respective LUN.
> 0x25: READ CAPACITY (10). LUN Specific. The capacity for the LUN
> specified in the CDB is returned - the capacity can be different for
> the two LUN's in the drive.
> 0x3E: READ LONG (10). LUN Specific
> 0x3F 0x11: WRITE LONG (10). LUN Specific
> 0x94 0x01: CLOSE ZONE. LUN Specific. ZBC.
> 0x94 0x02: FINISH ZONE. LUN Specific. ZBC.
> 0x94 0x03: OPEN ZONE. LUN Specific. ZBC.
> 0x94 0x04: RESET WRITE POINTER. LUN Specific. ZBC.
> 0x95 0x00: REPORT_ZONES. LUN Specific. The ZBC zone information is
> returned per LUN.
> 0x9B: READ BUFFER (16). LUN Specific. Same as Read Buffer.
> 0x9E 0x10: READ CAPACITY (16). LUN Specific.
> 
> These commands can affect the device OR the LUN:
> 0x15: MODE SELECT (6). Device/ LUN. Single set of mode page parameters
> are supported for the two LUN's. Only the 'Number of Blocks' in the
> Block Descriptor may be different for the two LUNs. The option to set
> the capacity for a LUN is not supported. If sector size is changed it
> will impact both LUNs."
> 0x1A: MODE SENSE (6). Device/ LUN. Capacity on each LUN can be
> different and so the 'Number of Blocks' in the Block Descriptor may be
> different for the two LUNs.
> 0x1C: RECEIVE DIAGNOSTIC. Device/LUN. The data for the LUN specified
> in the command is returned.
> 0x1D: SEND DIAGNOSTIC. Device/ LUN. The device will perform the
> diagnostic operations (self-test) on both the LUNs. The 'translate
> address' operation is performed on the LUN specified.
> 
In general, I think it would be far better treating this entire device
just like a normal target having two LUNs.
I would actually advocating having a device with _three_ LUNs, where one
LUN would serve as an endpoint for all device-centric commands, and the
other LUNs simply won't implement the device-centric commands.
Then you wouldn't need this dance with commands which might be executed
at device or LUN context, and the whole thing might be better aligned
with T10.

I guess we should talk at LSF about this ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
