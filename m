Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.infotech.no ([82.134.31.41]:50471 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752783AbeDBQbP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Apr 2018 12:31:15 -0400
Reply-To: dgilbert@interlog.com
Subject: Re: Multi-Actuator SAS HDD First Look
To: Tim Walker <tim.t.walker@seagate.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de>
 <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <CANo=J16HKWi+t2zK4LOAM+hhTJC=oNBr+-AJpJYvnipjmf3KPw@mail.gmail.com>
 <8be5e46f7b63290638383f05769211e6858e2267.camel@wdc.com>
 <CANo=J15fR6H0COYrBx=5a4uwwBS4AJKNWhks8-Ugc5DMDtg3TQ@mail.gmail.com>
 <fbdcf0a4133d60c6e8e6b6dbadc9fa27bb1af314.camel@wdc.com>
 <CANo=J1788-mA2bL3j-MOkZ2uuHoo7DdccdB_WhaP1WQRxzsfiA@mail.gmail.com>
 <3351f24c47e16ce33f9fc9e70e703d7aaf5ff67f.camel@wdc.com>
 <8eef0097-6ee8-b489-6afc-23c5f876b841@interlog.com>
 <CANo=J16aQufOtrOkKKPpQs3tU74z3xJKDSqiT7vbO6BPYegyAg@mail.gmail.com>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <c7a4c7ae-087d-59ab-483a-ce850bd11481@interlog.com>
Date: Mon, 2 Apr 2018 12:29:58 -0400
MIME-Version: 1.0
In-Reply-To: <CANo=J16aQufOtrOkKKPpQs3tU74z3xJKDSqiT7vbO6BPYegyAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018-04-02 11:34 AM, Tim Walker wrote:
> On Sat, Mar 31, 2018 at 10:52 AM, Douglas Gilbert <dgilbert@interlog.com> wrote:
>> On 2018-03-30 04:01 PM, Bart Van Assche wrote:
>>>
>>> On Fri, 2018-03-30 at 12:36 -0600, Tim Walker wrote:
>>>>
>>>> Yes I will be there to discuss the multi-LUN approach. I wanted to get
>>>> these interface details out so we could have some background and
>>>> perhaps folks would come with ideas. I don't have much more to put
>>>> out, but I will certainly answer questions - either on this list or
>>>> directly.
>>>
>>>
>>> Hello Tim,
>>>
>>> As far as I know the Linux SCSI stack does not yet support any SCSI
>>> devices
>>> for which a single SCSI command affects multiple (two in this case) LUNs.
>>> Adding such support may take significant work. There will also be the
>>> disadvantage that most SCSI core contributors do not have access to a
>>> multi-
>>> actuator device and hence that their changes may break support for multi-
>>> actuator devices.
>>
>>
>> Hmmm, INQUIRY (3PC bit) and REPORT LUNS seem to be counter examples to
>> Bart's assertion. Plus there are a more that tell you about things outside
>> the addressed LU, for example the SCSI Ports VPD page tells you about other
>> SCSI ports hence other LUs) on the current device.
>>
>>
>>  From Tim's command list:
>>
>> Device level
>> ------------
>> 0x0, 0x1: okay
>> 0x4 (Format unit): yikes, that could be a nasty surprise, accessing a file
>>    system on the other LU and getting an error "Not ready, format in
>> progress"!!
>> 0x12: standard INQUIRY okay, VPD pages not so much LU id different; relative
>>    port id, different; target port id different (at the least)
>> 0x1b (SSU): storage LUs need to know this model, otherwise the logic on
>>    each LU could get into a duel: "I want it spun up; no, I want it spun
>>    down ..."
>> 0x35, 0x37, 0x3b, 0x3c: okay
>> 0x48 (sanitize): similar to Format unit above
>> 0x91,0x4c,0x4d: okay
>> MODE SENSE/SELECT(6,10): depends on page, block descriptor needs to be
>>    partially device level (since LB size may be changed by FU which is
>>    device level)
>> rest of device level: okay or (I) don't know
>> 0xf7: READ UDS DATA, that's interesting, but proprietary I guess
>>
>> Perhaps you could add a rider on FU and SAN: they get rejected unless the
>> other storage LU is in (logical) spun down state.
>>
>>
>> LU specific
>> -----------
>> all okay, I hoping READ(6,10,12,16,32) and their WRITE cousins will be
>>    there also :-) Plus the TMF: LU reset
>>
>> Device or LU
>> ------------
>> all okay
>>
>>
>> I'm intrigued by your 3 LU model. My wish list for that:
>>
>> LUN 0 would be processor device type (0x3) so it wouldn't confuse the
>> OS (Linux) that it held storage (READ CAPACITY is mandatory for PDT 0x0
>> and cannot represent a 0 block LU) and you could pick and choose which
>> SCSI commands to implement on it. LUN 0 TUR could report what the spindle
>> was really doing, SSU could do precisely what it is told (and SSU on LUNs
>> 1 and 2 would be an "and" for spin down and an "or" for spin up). I've
>> got several boxes full of SAS cables and only one cable that I can think
>> of that lets me get to the secondary SAS port. So on LUN 0 you could have
>> a proprietary (unless T10 takes it on board) mode page to enable the user
>> to say which ports that LUNs 1 and 2 where accessible on. Obviously LUN 0
>> would need to be accessible on both ports. [A non-accessible LUN would
>> still respond to INQUIRY but with a first byte of 07f: PDT=0x1f (unknown)
>> and PQ=3 which implies it is there but inaccessible via the current port.]
>>
>> A processor PDT opens up the possibility of putting a copy manager on
>> LUN 0. Think offloaded (from main machine's perspective) backups and
>> restores where LUN 1 or 2 is the source or destination.
>>
>> Enough dreaming.
>>
>> Doug Gilbert
> 
> 
> 
> Thanks for all the input from everybody. I'll collate it for a meeting
> with our interface architect.

Just to amplify the case against a FU or SAN being allowed at almost any
time from either storage LU irrespective of what the other was doing.
Imagine one initiator has some important data on one LU and has an
EXCLUSIVE ACCESS persistent reservation on it. Then another initiator
(e.g. on a different machine) sends a FU to the other LU which is
honoured, wiping the whole device. One unhappy customer ....

Doug Gilbert
