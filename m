Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:59764 "EHLO
        mx0b-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752162AbeDRLQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Apr 2018 07:16:58 -0400
Received: from pps.filterd (m0075028.ppops.net [127.0.0.1])
        by mx0b-00003501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3IB3FCe011805
        for <linux-block@vger.kernel.org>; Wed, 18 Apr 2018 07:16:58 -0400
Received: from mail-ot0-f200.google.com (mail-ot0-f200.google.com [74.125.82.200])
        by mx0b-00003501.pphosted.com with ESMTP id 2he1vqgq9v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 18 Apr 2018 07:16:58 -0400
Received: by mail-ot0-f200.google.com with SMTP id l4-v6so835173otf.9
        for <linux-block@vger.kernel.org>; Wed, 18 Apr 2018 04:16:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2fc74a844eaff408c8e5aac563f31145682aeed2.camel@wdc.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de> <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de> <20180403074637.GB13259@infradead.org>
 <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
 <20180406082418.127a0ec6@pentland.suse.de> <20180406064236.GA17456@infradead.org>
 <361c204d-f9be-978a-5778-81ecaeb143e0@interlog.com> <CANo=J176w+NiskEDU_-dZ0CmmHCp-ZquPqKgY7_3oyMED_r3Zg@mail.gmail.com>
 <c5bf0358-ba24-1196-7cfd-8bfec558c514@suse.de> <236addea-463c-3802-29c2-c8df9a31c285@interlog.com>
 <CANo=J14RnmVWuw+5jRukwbptVnHNRYbhPiwhYv+RZTQ6nGuHGw@mail.gmail.com> <2fc74a844eaff408c8e5aac563f31145682aeed2.camel@wdc.com>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Wed, 18 Apr 2018 05:16:36 -0600
Message-ID: <CANo=J16sS6VCAy5Q4oXfOUYdvchpwAXPAeRU0OdJrTSA0zuJ0Q@mail.gmail.com>
Subject: Re: Multi-Actuator SAS HDD First Look
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Apr 15, 2018 at 10:31 PM, Bart Van Assche
<Bart.VanAssche@wdc.com> wrote:
> On Sun, 2018-04-15 at 19:35 -0600, Tim Walker wrote:
>> I also believe the dual-actuator, or any significant HDD parallelism,
>> would map well onto an NVMe target, or NVMe-oF behind nvmet. Maybe a
>> lightweight virtual NVMe controller that would efficiently present the
>> HDD logs/mode pages/etc via the admin queue and the LUNs as fixed
>> namespaces...?
>>
>> Doug, I will flesh your three LUN idea out some more and send it up
>> the flagpole over here. Thanks for the input.
>>
>> I'd like to have a conversation at LSFMM and maybe pull together a
>> fairly well defined consensus recommendation. Is that possible? Can we
>> schedule it?
>
> Hello Tim,
>
> I think that you have to submit a request to the LSF/MM program committee
> (lsf-pc@lists.linux-foundation.org) to add an item to the official agenda.
> In case this topic wouldn't be added to the official agenda we can still
> discuss this topic in a meeting room at the LSF/MM location.
>
> Bart.
>
>
>

Hello Bart-

It would be good if we could set up an informal meeting time and
location at LSFMM to discuss these dual actuator topics. so far you,
Doug, Hannes, and Christoph have expressed the most interest, plus
Damien. Can we set an hour aside one afternoon?

-Tim

-- 
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
