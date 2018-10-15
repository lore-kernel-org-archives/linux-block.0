Return-Path: <prvs=8198fdf91=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH v4 00/11] Zoned block device support improvements
Date: Mon, 15 Oct 2018 00:45:57 +0000
Message-ID: 
 <BN3PR0401MB16409A77BC3EA6E37073DD17E7FD0@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181012100850.23316-1-damien.lemoal@wdc.com>
 <f6062f58-8f8a-b90a-9163-5938632e1a6a@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Jens,=0A=
=0A=
On 2018/10/14 7:43, Jens Axboe wrote:=0A=
> On 10/12/18 4:08 AM, Damien Le Moal wrote:=0A=
>> This series improves zoned block device support (reduce overhead) and=0A=
>> introduces many simplifications to the code (overall, there are more del=
etions=0A=
>> than insertions).=0A=
>>=0A=
>> In more details:=0A=
>> * Patches 1 to 3 are SCSI side (sd driver) cleanups and improvements red=
ucing=0A=
>>   the overhead of report zones command execution during disk scan and=0A=
>>   revalidation.=0A=
>> * Patches 4 to 9 improve the useability and user API of zoned block devi=
ces.=0A=
>> * Patch 10 is the main part of this series. This patch replaces the=0A=
>>   REQ_OP_ZONE_REPORT BIO/request operation for executing report zones co=
mmands=0A=
>>   with a block device file operation, removing the need for the command =
reply=0A=
>>   payload in-place rewriting in the BIO buffer. This leads to major=0A=
>>   simplification of the code in many places.=0A=
>> * Patch 11 further simplifies the code of low level drivers by providing=
 a=0A=
>>   generic implementation of zoned block device request queue zone bitmap=
s=0A=
>>   initialization and revalidation.=0A=
>>=0A=
>> Please consider the addition of these patches in 4.20.=0A=
>> Comments are as always welcome.=0A=
> =0A=
> How do we want to funnel this series? 1-3 look separate, so perhaps they=
=0A=
> should go through the scsi tree. Then I can take the rest. Or do some=0A=
> of the later ones depend on 1-3 being in, in terms of applying cleanly?=
=0A=
> I can also take all of them, looks like only #3 needs a SCSI ack.=0A=
=0A=
Patch 10 and 11 will not apply cleanly for the scsi part without 1-3 in fir=
st.=0A=
1-3, 10 and 11 would need an ack/review from Martin (SCSI).=0A=
And 10-11 also probably need an ack/review from Mike for the DM changes.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
