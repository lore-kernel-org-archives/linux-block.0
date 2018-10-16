Return-Path: <prvs=820d6586b=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v4 00/11] Zoned block device support improvements
Date: Tue, 16 Oct 2018 03:43:36 +0000
Message-ID: 
 <BN3PR0401MB16408DC28A398B655DA37F12E7FE0@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181012100850.23316-1-damien.lemoal@wdc.com>
 <f6062f58-8f8a-b90a-9163-5938632e1a6a@kernel.dk>
 <BN3PR0401MB16409A77BC3EA6E37073DD17E7FD0@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <af21e631-78bc-71f3-60a9-d021f074dab8@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Martin, Mike,=0A=
=0A=
On 2018/10/16 11:34, Jens Axboe wrote:=0A=
> On 10/14/18 6:45 PM, Damien Le Moal wrote:=0A=
>> Jens,=0A=
>>=0A=
>> On 2018/10/14 7:43, Jens Axboe wrote:=0A=
>>> On 10/12/18 4:08 AM, Damien Le Moal wrote:=0A=
>>>> This series improves zoned block device support (reduce overhead) and=
=0A=
>>>> introduces many simplifications to the code (overall, there are more d=
eletions=0A=
>>>> than insertions).=0A=
>>>>=0A=
>>>> In more details:=0A=
>>>> * Patches 1 to 3 are SCSI side (sd driver) cleanups and improvements r=
educing=0A=
>>>>   the overhead of report zones command execution during disk scan and=
=0A=
>>>>   revalidation.=0A=
>>>> * Patches 4 to 9 improve the useability and user API of zoned block de=
vices.=0A=
>>>> * Patch 10 is the main part of this series. This patch replaces the=0A=
>>>>   REQ_OP_ZONE_REPORT BIO/request operation for executing report zones =
commands=0A=
>>>>   with a block device file operation, removing the need for the comman=
d reply=0A=
>>>>   payload in-place rewriting in the BIO buffer. This leads to major=0A=
>>>>   simplification of the code in many places.=0A=
>>>> * Patch 11 further simplifies the code of low level drivers by providi=
ng a=0A=
>>>>   generic implementation of zoned block device request queue zone bitm=
aps=0A=
>>>>   initialization and revalidation.=0A=
>>>>=0A=
>>>> Please consider the addition of these patches in 4.20.=0A=
>>>> Comments are as always welcome.=0A=
>>>=0A=
>>> How do we want to funnel this series? 1-3 look separate, so perhaps=0A=
>>> they should go through the scsi tree. Then I can take the rest. Or do=
=0A=
>>> some of the later ones depend on 1-3 being in, in terms of applying=0A=
>>> cleanly?  I can also take all of them, looks like only #3 needs a=0A=
>>> SCSI ack.=0A=
>>=0A=
>> Patch 10 and 11 will not apply cleanly for the scsi part without 1-3=0A=
>> in first.  1-3, 10 and 11 would need an ack/review from Martin (SCSI).=
=0A=
>> And 10-11 also probably need an ack/review from Mike for the DM=0A=
>> changes.=0A=
> =0A=
> Probably want to start pinging people, if you're targeting 4.20 with=0A=
> this...=0A=
=0A=
Could you please review or ack the parts relevant to SCSI and DM of this=0A=
series ?=0A=
=0A=
For DM, changes are in patches 10 and 11=0A=
For SCSI, patches 1-3, 10 and 11 introduce changes.=0A=
=0A=
Thank you.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
