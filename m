Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:39152 "EHLO
        mx0a-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751180AbeC3SWS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Mar 2018 14:22:18 -0400
Received: from pps.filterd (m0075552.ppops.net [127.0.0.1])
        by mx0a-00003501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2UIIvjH033806
        for <linux-block@vger.kernel.org>; Fri, 30 Mar 2018 14:22:17 -0400
Received: from mail-ot0-f198.google.com (mail-ot0-f198.google.com [74.125.82.198])
        by mx0a-00003501.pphosted.com with ESMTP id 2h1q9t0q5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 30 Mar 2018 14:22:17 -0400
Received: by mail-ot0-f198.google.com with SMTP id z39-v6so5338774ota.11
        for <linux-block@vger.kernel.org>; Fri, 30 Mar 2018 11:22:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8be5e46f7b63290638383f05769211e6858e2267.camel@wdc.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de> <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <CANo=J16HKWi+t2zK4LOAM+hhTJC=oNBr+-AJpJYvnipjmf3KPw@mail.gmail.com> <8be5e46f7b63290638383f05769211e6858e2267.camel@wdc.com>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Fri, 30 Mar 2018 12:21:55 -0600
Message-ID: <CANo=J15fR6H0COYrBx=5a4uwwBS4AJKNWhks8-Ugc5DMDtg3TQ@mail.gmail.com>
Subject: Re: Multi-Actuator SAS HDD First Look
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "hare@suse.de" <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart-

Yes, the header LUN field. Sorry!

We hadn't intended to broadcast - we expect to see a LUN specified.
For a device specific command both LUNs will be affected regardless of
which LUN is specified in the transport field. e.g. if we command LUN1
to stop (START STOP UNIT) then LUN0 will also be stopped.

Sorry if my terminology wasn't entirely clear - some jargon and
informal usage slipping through.

Best regards,
-Tim

-Tim

On Fri, Mar 30, 2018 at 12:17 PM, Bart Van Assche
<Bart.VanAssche@wdc.com> wrote:
> On Fri, 2018-03-30 at 12:07 -0600, Tim Walker wrote:
>> Concerning how we are currently allocating commands to LUNs or the
>> device as a whole, here is a list based on the current two LUN model.
>> This model has LUN0 & LUN1, both reporting 1/2 the total storage. Our
>> definition of "device based" is that it ignores the LUN field and
>> executes the command on the entire device. [ ... ]
>
> Hello Tim,
>
> Can you clarify what "LUN field" means in this context? Are you referring
> to a field in the SAS transport header or perhaps to the obsolete LUN
> field in the SCSI CDB? Additionally, as far as I know every SCSI command
> should be executed by exactly one SCSI LUN. I'm not aware of any support
> in the SCSI specs for broadcasting a single SCSI command to multiple LUNs.
>
> Thanks,
>
> Bart.
>
>
>
>



-- 
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
