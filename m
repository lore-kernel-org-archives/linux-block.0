Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:46122 "EHLO
        mx0a-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752623AbeDPBf7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Apr 2018 21:35:59 -0400
Received: from pps.filterd (m0075554.ppops.net [127.0.0.1])
        by mx0a-000cda01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3G1XhdX033107
        for <linux-block@vger.kernel.org>; Sun, 15 Apr 2018 21:35:56 -0400
Received: from mail-ot0-f197.google.com (mail-ot0-f197.google.com [74.125.82.197])
        by mx0a-000cda01.pphosted.com with ESMTP id 2hcf8d8kyh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Sun, 15 Apr 2018 21:35:56 -0400
Received: by mail-ot0-f197.google.com with SMTP id a13-v6so293487oti.4
        for <linux-block@vger.kernel.org>; Sun, 15 Apr 2018 18:35:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <236addea-463c-3802-29c2-c8df9a31c285@interlog.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de> <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de> <20180403074637.GB13259@infradead.org>
 <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
 <20180406082418.127a0ec6@pentland.suse.de> <20180406064236.GA17456@infradead.org>
 <361c204d-f9be-978a-5778-81ecaeb143e0@interlog.com> <CANo=J176w+NiskEDU_-dZ0CmmHCp-ZquPqKgY7_3oyMED_r3Zg@mail.gmail.com>
 <c5bf0358-ba24-1196-7cfd-8bfec558c514@suse.de> <236addea-463c-3802-29c2-c8df9a31c285@interlog.com>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Sun, 15 Apr 2018 19:35:34 -0600
Message-ID: <CANo=J14RnmVWuw+5jRukwbptVnHNRYbhPiwhYv+RZTQ6nGuHGw@mail.gmail.com>
Subject: Re: Multi-Actuator SAS HDD First Look
To: dgilbert <dgilbert@interlog.com>
Cc: Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 9, 2018 at 10:02 AM, Douglas Gilbert <dgilbert@interlog.com> wrote:
>
> On 2018-04-09 02:17 AM, Hannes Reinecke wrote:
>>
>> On 04/09/2018 04:08 AM, Tim Walker wrote:
>>>
>>> On Fri, Apr 6, 2018 at 11:09 AM, Douglas Gilbert <dgilbert@interlog.com> wrote:
>>>>
>>>>
>>>> On 2018-04-06 02:42 AM, Christoph Hellwig wrote:
>>>>>
>>>>>
>>>>> On Fri, Apr 06, 2018 at 08:24:18AM +0200, Hannes Reinecke wrote:
>>>>>>
>>>>>>
>>>>>> Ah. Far better.
>>>>>> What about delegating FORMAT UNIT to the control LUN, and not
>>>>>> implementing it for the individual disk LUNs?
>>>>>> That would make an even stronger case for having a control LUN;
>>>>>> with that there wouldn't be any problem with having to synchronize
>>>>>> across LUNs etc.
>>>>>
>>>>>
>>>>>
>>>>> It sounds to me like NVMe might be a much better model for this drive
>>>>> than SCSI, btw :)
>>>>
>>>>
>>>>
>>>> So you found a document that outlines NVMe's architecture! Could you
>>>> share the url (no marketing BS, please)?
>>>>
>>>>
>>>> And a serious question ... How would you map NVMe's (in Linux)
>>>> subsystem number, controller device minor number, CNTLID field
>>>> (Identify ctl response) and namespace id onto the SCSI subsystem's
>>>> h:c:t:l ?
>>>>
>>>> Doug Gilbert
>>>>
>>>
>>> Hannes- yes, a drive system altering operation like FORMAT UNIT is
>>> asking for a dedicated management port, as the NVMe folks apparently
>>> felt. But what is the least painful endpoint type for LUN0?
>>>
>>>
>> I would probably use 'processor device' (ie type 3) as it's the least
>> defined, so you can do basically everything you like with it.
>> Possibly 'Enclosure Services' (type 0x0d) works, too, but then you have
>> to check with the SES spec if it allows the things you'd need.
>
>
> Processor device type (0x3) please. Then you are only required to support
> the mandatory commands in SPC and that is not many. And then nothing
> precludes you from implementing Start Stop Unit, Sanitize and/or Format
> Unit on it. And as I pointed out earlier, you could even throw in a
> copy manager (see SPC). Also as far as I know Linux, FreeBSD and Windows
> will leave a Processor device type LU alone and just have a SCSI
> pass-through device attached to it, and that is exactly what you want.
> By default only root/administrator can open those pass-through devices.
>
> If you chose SES type (0xd) then the Linux kernel ses driver (and the
> FreeBSD equivalent) would attempt to attach to it before the user space
> could countermand it (as things stand). And SES additionally makes the
> SEND DIAGNOSTIC and RECEIVE DIAGNOSTIC RESULTS commands mandatory and
> at least one diagnostic page (0x0) mandatory. If it doesn't supply
> any other SES dpages then those two drivers are going to get pretty
> confused (which would be a good test for them). Also it could get
> confusing from an administration point of view. I'm guessing many of
> these Multi-Actuator SAS HDDs will end up in big enclosures. And
> those enclosures most likely would present a SES device. Multiple dummy
> enclosures within a real enclosure will look strange (especially as
> SES already has a concept of a sub-enclosure).
>
> Doug Gilbert
>
>

I also believe the dual-actuator, or any significant HDD parallelism,
would map well onto an NVMe target, or NVMe-oF behind nvmet. Maybe a
lightweight virtual NVMe controller that would efficiently present the
HDD logs/mode pages/etc via the admin queue and the LUNs as fixed
namespaces...?

Doug, I will flesh your three LUN idea out some more and send it up
the flagpole over here. Thanks for the input.

I'd like to have a conversation at LSFMM and maybe pull together a
fairly well defined consensus recommendation. Is that possible? Can we
schedule it?

Best regards,
-Tim
