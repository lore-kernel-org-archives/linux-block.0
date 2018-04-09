Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60807 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbeDIGRi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Apr 2018 02:17:38 -0400
Subject: Re: Multi-Actuator SAS HDD First Look
To: Tim Walker <tim.t.walker@seagate.com>,
        dgilbert <dgilbert@interlog.com>
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
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c5bf0358-ba24-1196-7cfd-8bfec558c514@suse.de>
Date: Mon, 9 Apr 2018 08:17:35 +0200
MIME-Version: 1.0
In-Reply-To: <CANo=J176w+NiskEDU_-dZ0CmmHCp-ZquPqKgY7_3oyMED_r3Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/09/2018 04:08 AM, Tim Walker wrote:
> On Fri, Apr 6, 2018 at 11:09 AM, Douglas Gilbert <dgilbert@interlog.com> wrote:
>>
>> On 2018-04-06 02:42 AM, Christoph Hellwig wrote:
>>>
>>> On Fri, Apr 06, 2018 at 08:24:18AM +0200, Hannes Reinecke wrote:
>>>>
>>>> Ah. Far better.
>>>> What about delegating FORMAT UNIT to the control LUN, and not
>>>> implementing it for the individual disk LUNs?
>>>> That would make an even stronger case for having a control LUN;
>>>> with that there wouldn't be any problem with having to synchronize
>>>> across LUNs etc.
>>>
>>>
>>> It sounds to me like NVMe might be a much better model for this drive
>>> than SCSI, btw :)
>>
>>
>> So you found a document that outlines NVMe's architecture! Could you
>> share the url (no marketing BS, please)?
>>
>>
>> And a serious question ... How would you map NVMe's (in Linux)
>> subsystem number, controller device minor number, CNTLID field
>> (Identify ctl response) and namespace id onto the SCSI subsystem's
>> h:c:t:l ?
>>
>> Doug Gilbert
>>
> 
> Hannes- yes, a drive system altering operation like FORMAT UNIT is
> asking for a dedicated management port, as the NVMe folks apparently
> felt. But what is the least painful endpoint type for LUN0?
> 
> 
I would probably use 'processor device' (ie type 3) as it's the least
defined, so you can do basically everything you like with it.
Possibly 'Enclosure Services' (type 0x0d) works, too, but then you have
to check with the SES spec if it allows the things you'd need.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
