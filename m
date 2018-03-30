Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:56852 "EHLO
        mx0b-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751223AbeC3NXp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Mar 2018 09:23:45 -0400
Received: from pps.filterd (m0075029.ppops.net [127.0.0.1])
        by mx0b-00003501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2UD3PG1027663
        for <linux-block@vger.kernel.org>; Fri, 30 Mar 2018 09:08:20 -0400
Received: from mail-oi0-f69.google.com (mail-oi0-f69.google.com [209.85.218.69])
        by mx0b-00003501.pphosted.com with ESMTP id 2h1m5dratf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 30 Mar 2018 09:08:19 -0400
Received: by mail-oi0-f69.google.com with SMTP id l67-v6so4698636oif.23
        for <linux-block@vger.kernel.org>; Fri, 30 Mar 2018 06:08:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de> <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Fri, 30 Mar 2018 07:07:56 -0600
Message-ID: <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
Subject: Re: Multi-Actuator SAS HDD First Look
To: dgilbert <dgilbert@interlog.com>
Cc: Hannes Reinecke <hare@suse.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Doug-

Currently, the dual actuator firmware safely spins the drive down if
either LUN receives the START STOP UNIT command.  In other words, if
LUN1 receives the command, it will flush any dirty data from LUN1l and
LUN0, then spin down, taking both LUN1 & LUN0 off line. Alternatively,
we've had input that either:
a) Both LUNs must receive the START STOP UNIT command before the drive
will spin down, OR
b) Move the storage to LUN1 & LUN2, keeping LUN0 (with no storage) for
device specific commands such as START STOP UNIT that do not directly
access the media.

Thanks for the question.

Best regards,
-Tim

On Thu, Mar 29, 2018 at 12:03 PM, Douglas Gilbert <dgilbert@interlog.com> wrote:
> On 2018-03-26 11:08 AM, Hannes Reinecke wrote:
>>
>> On Fri, 23 Mar 2018 08:57:12 -0600
>> Tim Walker <tim.t.walker@seagate.com> wrote:
>>
>>> Seagate announced their split actuator SAS drive, which will probably
>>> require some kernel changes for full support. It's targeted at cloud
>>> provider JBODs and RAID.
>>>
>>> Here are some of the drive's architectural points. Since the two LUNs
>>> share many common components (e.g. spindle) Seagate allocated some
>>> SCSI operations to be LUN specific and some to affect the entire
>>> device, that is, both LUNs.
>>>
>>> 1. Two LUNs, 0 & 1, each with independent lba space, and each
>>> connected to an independent read channel, actuator, and set of heads.
>>> 2. Each actuator addresses 1/2 of the media - no media is shared
>>> across the actuators. They seek independently.
>>> 3. One World Wide Name (WWN) is assigned to the port for device
>>> address. Each Logical Unit has a separate World Wide Name for
>>> identification in VPD page.
>>> 4. 128 deep command queue, shared across both LUNs
>>> 5. Each LUN can pull commands from the queue independently, so they
>>> can implement their own sorting and optimization.
>>> 6. Ordered tag attribute causes the command to be ordered across both
>>> Logical Units
>>> 7. Head of Queue attribute causes the command to be ordered with
>>> respect to a single Logical Unit
>>> 8. Mode pages are device-based (shared across both Logical Units)
>>> 9. Log pages are device-based.
>>> 10. Inquiry VPD pages (with minor exceptions) are device based.
>>> 11. Device health features (SMART, etc) are device based
>>>
>>> Seagate wants the multi-actuator design to integrate into the stack as
>>> painlessly as possible.The interface design is still in the early
>>> stages, so I am gathering requirements and recommendations, and also
>>> providing any information necessary to help scope integrating a
>>> multi-LUN device into the MQ stack. So, I am soliciting any pertinent
>>> feedback including:
>>>
>>> 1. Painful incompatibilities between the Seagate proposal and current
>>> MQ architecture
>>> 2. Linux changes needed
>>> 3. Drive interface changes needed
>>> 4. Anything else I may have overlooked
>>>
>> So far it looks okay; just make sure to have VPD page 0x83
>> entries properly associated.
>> To all intents and purposes these devices seem to look like 'normal'
>> devices with two LUNs; nothing special with that.
>> Real question would be in which areas those devices differentiate from
>> the two indepdendent LUN scenario.
>>
>> There might be issues with per-device informations like SMART etc;
>> ideally they are available from _both_ LUNs.
>> Otherwise they'll show up as blank from one LUN, causing consternation
>> with any management software.
>
>
> Further to this point, some types of damage, such as to a head
> or (one side of) a platter would degrade one LU, possibly making
> it unusable for storage, while the other side (and the other LU)
> would be fine.
>
> I'm curious how you plan to implement the START STOP UNIT command.
> If one side of the platter is in "start" state and the other side
> in "stop" state, will the heads on the stopped side be parked (if
> they can be parked)? And if both sides (LUs) are stopped I would
> hope you really would spin down the disk, then if either is started
> the disk would be spun up.
>
> Getting T10 to add a bit to the Block Device Characteristics VPD page
> might be helpful. It could be a "shares a spindle" bit with the other
> LUs identified in the SCSI Ports VPD page. Such an indication would
> help an enclosure find out if a Multi-Actuator disk was really spun down
> and ready to be removed or replaced. I think SES and smartmontools may
> need tweaks to handle this new device model sensibly.
>
> Doug Gilbert
>
>



-- 
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
