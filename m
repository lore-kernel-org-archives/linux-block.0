Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.infotech.no ([82.134.31.41]:33774 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752958AbeDIQCr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Apr 2018 12:02:47 -0400
Reply-To: dgilbert@interlog.com
Subject: Re: Multi-Actuator SAS HDD First Look
To: Hannes Reinecke <hare@suse.de>,
        Tim Walker <tim.t.walker@seagate.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de>
 <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de>
 <20180403074637.GB13259@infradead.org>
 <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
 <20180406082418.127a0ec6@pentland.suse.de>
 <20180406064236.GA17456@infradead.org>
 <361c204d-f9be-978a-5778-81ecaeb143e0@interlog.com>
 <CANo=J176w+NiskEDU_-dZ0CmmHCp-ZquPqKgY7_3oyMED_r3Zg@mail.gmail.com>
 <c5bf0358-ba24-1196-7cfd-8bfec558c514@suse.de>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <236addea-463c-3802-29c2-c8df9a31c285@interlog.com>
Date: Mon, 9 Apr 2018 12:02:42 -0400
MIME-Version: 1.0
In-Reply-To: <c5bf0358-ba24-1196-7cfd-8bfec558c514@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018-04-09 02:17 AM, Hannes Reinecke wrote:
> On 04/09/2018 04:08 AM, Tim Walker wrote:
>> On Fri, Apr 6, 2018 at 11:09 AM, Douglas Gilbert <dgilbert@interlog.com> wrote:
>>>
>>> On 2018-04-06 02:42 AM, Christoph Hellwig wrote:
>>>>
>>>> On Fri, Apr 06, 2018 at 08:24:18AM +0200, Hannes Reinecke wrote:
>>>>>
>>>>> Ah. Far better.
>>>>> What about delegating FORMAT UNIT to the control LUN, and not
>>>>> implementing it for the individual disk LUNs?
>>>>> That would make an even stronger case for having a control LUN;
>>>>> with that there wouldn't be any problem with having to synchronize
>>>>> across LUNs etc.
>>>>
>>>>
>>>> It sounds to me like NVMe might be a much better model for this drive
>>>> than SCSI, btw :)
>>>
>>>
>>> So you found a document that outlines NVMe's architecture! Could you
>>> share the url (no marketing BS, please)?
>>>
>>>
>>> And a serious question ... How would you map NVMe's (in Linux)
>>> subsystem number, controller device minor number, CNTLID field
>>> (Identify ctl response) and namespace id onto the SCSI subsystem's
>>> h:c:t:l ?
>>>
>>> Doug Gilbert
>>>
>>
>> Hannes- yes, a drive system altering operation like FORMAT UNIT is
>> asking for a dedicated management port, as the NVMe folks apparently
>> felt. But what is the least painful endpoint type for LUN0?
>>
>>
> I would probably use 'processor device' (ie type 3) as it's the least
> defined, so you can do basically everything you like with it.
> Possibly 'Enclosure Services' (type 0x0d) works, too, but then you have
> to check with the SES spec if it allows the things you'd need.

Processor device type (0x3) please. Then you are only required to support
the mandatory commands in SPC and that is not many. And then nothing
precludes you from implementing Start Stop Unit, Sanitize and/or Format
Unit on it. And as I pointed out earlier, you could even throw in a
copy manager (see SPC). Also as far as I know Linux, FreeBSD and Windows
will leave a Processor device type LU alone and just have a SCSI
pass-through device attached to it, and that is exactly what you want.
By default only root/administrator can open those pass-through devices.

If you chose SES type (0xd) then the Linux kernel ses driver (and the
FreeBSD equivalent) would attempt to attach to it before the user space
could countermand it (as things stand). And SES additionally makes the
SEND DIAGNOSTIC and RECEIVE DIAGNOSTIC RESULTS commands mandatory and
at least one diagnostic page (0x0) mandatory. If it doesn't supply
any other SES dpages then those two drivers are going to get pretty
confused (which would be a good test for them). Also it could get
confusing from an administration point of view. I'm guessing many of
these Multi-Actuator SAS HDDs will end up in big enclosures. And
those enclosures most likely would present a SES device. Multiple dummy
enclosures within a real enclosure will look strange (especially as
SES already has a concept of a sub-enclosure).

Doug Gilbert
