Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:42020 "EHLO
        mx0a-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757591AbeDICJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Apr 2018 22:09:18 -0400
Received: from pps.filterd (m0075553.ppops.net [127.0.0.1])
        by mx0a-00003501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3928AX6009334
        for <linux-block@vger.kernel.org>; Sun, 8 Apr 2018 22:09:17 -0400
Received: from mail-oi0-f71.google.com (mail-oi0-f71.google.com [209.85.218.71])
        by mx0a-00003501.pphosted.com with ESMTP id 2h7y450066-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Sun, 08 Apr 2018 22:09:17 -0400
Received: by mail-oi0-f71.google.com with SMTP id d77-v6so4339708oig.5
        for <linux-block@vger.kernel.org>; Sun, 08 Apr 2018 19:09:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <361c204d-f9be-978a-5778-81ecaeb143e0@interlog.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de> <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de> <20180403074637.GB13259@infradead.org>
 <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
 <20180406082418.127a0ec6@pentland.suse.de> <20180406064236.GA17456@infradead.org>
 <361c204d-f9be-978a-5778-81ecaeb143e0@interlog.com>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Sun, 8 Apr 2018 20:08:55 -0600
Message-ID: <CANo=J176w+NiskEDU_-dZ0CmmHCp-ZquPqKgY7_3oyMED_r3Zg@mail.gmail.com>
Subject: Re: Multi-Actuator SAS HDD First Look
To: dgilbert <dgilbert@interlog.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 6, 2018 at 11:09 AM, Douglas Gilbert <dgilbert@interlog.com> wrote:
>
> On 2018-04-06 02:42 AM, Christoph Hellwig wrote:
>>
>> On Fri, Apr 06, 2018 at 08:24:18AM +0200, Hannes Reinecke wrote:
>>>
>>> Ah. Far better.
>>> What about delegating FORMAT UNIT to the control LUN, and not
>>> implementing it for the individual disk LUNs?
>>> That would make an even stronger case for having a control LUN;
>>> with that there wouldn't be any problem with having to synchronize
>>> across LUNs etc.
>>
>>
>> It sounds to me like NVMe might be a much better model for this drive
>> than SCSI, btw :)
>
>
> So you found a document that outlines NVMe's architecture! Could you
> share the url (no marketing BS, please)?
>
>
> And a serious question ... How would you map NVMe's (in Linux)
> subsystem number, controller device minor number, CNTLID field
> (Identify ctl response) and namespace id onto the SCSI subsystem's
> h:c:t:l ?
>
> Doug Gilbert
>

Hannes- yes, a drive system altering operation like FORMAT UNIT is
asking for a dedicated management port, as the NVMe folks apparently
felt. But what is the least painful endpoint type for LUN0?


-- 
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
