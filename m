Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:41116 "EHLO
        mx0a-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751973AbeC3Sg4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Mar 2018 14:36:56 -0400
Received: from pps.filterd (m0075555.ppops.net [127.0.0.1])
        by mx0a-00003501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2UIX03v040295
        for <linux-block@vger.kernel.org>; Fri, 30 Mar 2018 14:36:55 -0400
Received: from mail-ot0-f197.google.com (mail-ot0-f197.google.com [74.125.82.197])
        by mx0a-00003501.pphosted.com with ESMTP id 2h1taur36p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 30 Mar 2018 14:36:55 -0400
Received: by mail-ot0-f197.google.com with SMTP id s6-v6so5416972oth.20
        for <linux-block@vger.kernel.org>; Fri, 30 Mar 2018 11:36:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fbdcf0a4133d60c6e8e6b6dbadc9fa27bb1af314.camel@wdc.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de> <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <CANo=J16HKWi+t2zK4LOAM+hhTJC=oNBr+-AJpJYvnipjmf3KPw@mail.gmail.com>
 <8be5e46f7b63290638383f05769211e6858e2267.camel@wdc.com> <CANo=J15fR6H0COYrBx=5a4uwwBS4AJKNWhks8-Ugc5DMDtg3TQ@mail.gmail.com>
 <fbdcf0a4133d60c6e8e6b6dbadc9fa27bb1af314.camel@wdc.com>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Fri, 30 Mar 2018 12:36:33 -0600
Message-ID: <CANo=J1788-mA2bL3j-MOkZ2uuHoo7DdccdB_WhaP1WQRxzsfiA@mail.gmail.com>
Subject: Re: Multi-Actuator SAS HDD First Look
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Yes I will be there to discuss the multi-LUN approach. I wanted to get
these interface details out so we could have some background and
perhaps folks would come with ideas. I don't have much more to put
out, but I will certainly answer questions - either on this list or
directly.

Best regards,
-Tim

On Fri, Mar 30, 2018 at 12:31 PM, Bart Van Assche
<Bart.VanAssche@wdc.com> wrote:
> On Fri, 2018-03-30 at 12:21 -0600, Tim Walker wrote:
>
>> Yes, the header LUN field. Sorry!
>
>>
>
>> We hadn't intended to broadcast - we expect to see a LUN specified.
>
>> For a device specific command both LUNs will be affected regardless of
>
>> which LUN is specified in the transport field. e.g. if we command LUN1
>
>> to stop (START STOP UNIT) then LUN0 will also be stopped.
>
>>
>
>> Sorry if my terminology wasn't entirely clear - some jargon and
>
>> informal usage slipping through.
>
>
>
> Hello Tim,
>
>
>
> Do you perhaps plan to attend LSF/MM next month? It probably will be easi=
er
>
> to discuss this further in person instead of continuing this e-mail threa=
d.
>
> See also https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__events.li=
nuxfoundation.org_events_lsfmm-2D2018_&d=3DDwIGaQ&c=3DIGDlg0lD0b-nebmJJ0Kp8=
A&r=3DNW1X0yRHNNEluZ8sOGXBxCbQJZPWcIkPT0Uy3ynVsFU&m=3DMebnGjWzpdtum7IWMvt4l=
PVFr7aZr4pLz9A4pVL9uFM&s=3DSPtZIJ6pKfO5rlo4MokPxd09lri5kKheGP56t-zooiY&e=3D=
.
>
>
>
> Thanks,
>
>
>
> Bart.
>
>
>
>
>
>
>
>
>



--=20
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
