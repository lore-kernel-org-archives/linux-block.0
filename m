Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57825 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750703AbdAWGAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 01:00:47 -0500
From: Song Liu <songliubraving@fb.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>, Jens Axboe <axboe@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [LSF/MM TOPIC] block level event logging for storage media
 management
Date: Mon, 23 Jan 2017 06:00:41 +0000
Message-ID: <92E1CE17-4F28-4934-BB60-358FA334AA5F@fb.com>
References: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com>
 <CAA9_cmd_XMbw_26ePCSWLxP9PoTn36n8sO5buE2iTCoPnK+CHg@mail.gmail.com>
In-Reply-To: <CAA9_cmd_XMbw_26ePCSWLxP9PoTn36n8sO5buE2iTCoPnK+CHg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Dan,=20

I think the the block level event log is more like log only system. When en=
 event=20
happens,  it is not necessary to take immediate action. (I guess this is di=
fferent
to bad block list?).=20

I would hope the event log to track more information. Some of these individ=
ual=20
event may not be very interesting, for example, soft error or latency outli=
ers.=20
However, when we gather event log for a fleet of devices, these "soft event=
"=20
may become valuable for health monitoring.=20

Thanks,
Song


> On Jan 20, 2017, at 9:46 PM, Dan Williams <dan.j.williams@intel.com> wrot=
e:
>=20
> On Wed, Jan 18, 2017 at 3:34 PM, Song Liu <songliubraving@fb.com> wrote:
>>=20
>> Media health monitoring is very important for large scale distributed st=
orage systems.
>> Traditionally, enterprise storage controllers maintain event logs for at=
tached storage
>> devices. However, these controller managed logs do not scale well for la=
rge scale
>> distributed systems.
>>=20
>> While designing a more flexible and scalable event logging systems, we t=
hink it is better
>> to build the log in block layer. Block level event logging covers all ma=
jor storage media
>> (SCSI, SATA, NVMe), and thus minimizes redundant work for different prot=
ocols.
>>=20
>> In this LSF/MM, we would like to discuss the following topics with the c=
ommunity:
>>    1. Mechanism for drivers report events (or errors) to block layer.
>>       Basically, we will need a traceable function for the drivers to re=
port errors
>>       (most likely right before calling end_request or bio_endio).
>>=20
>>    2. What mechanism (ftrace, BPF, etc.) is mostly preferred for the eve=
nt logging?
>>=20
>>    3. How should we categorize different events?
>>       Currently, there are existing code that translates ATA error (ata_=
to_sense_error)
>>       and NVMe error (nvme_trans_status_code) to SCSI sense code. So we =
can
>>       leverage SCSI Key Code Qualifier for event categorizations.
>>=20
>>    4. Detailed discussions on data structure for event logging.
>>=20
>> We will be able to show a prototype implementation during LSF/MM.
>=20
> Hi Song,
>=20
> How is this distinct from tracking a badblocks list?
>=20
> I'm interested in this topic since we have both media error reporting
> / scrubbing for nvdimms as well "SMART" media health retrieval
> commands.

