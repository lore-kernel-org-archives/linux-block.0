Return-Path: <prvs=828ad2984=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH v4 00/11] Zoned block device support improvements
Date: Wed, 24 Oct 2018 08:04:53 +0000
Message-ID: 
 <BN3PR0401MB1640DDD064340B0C074055AFE7F60@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181012100850.23316-1-damien.lemoal@wdc.com>
 <78778e22-9c5e-99d0-ef5c-85e04d03a4b7@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Jens,=0A=
=0A=
On 2018/10/23 16:59, Jens Axboe wrote:=0A=
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
>>   generic implementation of zoned block device reuest queue zone bitmaps=
=0A=
>>   initialization and revalidation.=0A=
> =0A=
> I've applied this, but I have two complaints:=0A=
> =0A=
> 1) Two had to be hand applied, it wasn't against the block tree.=0A=
=0A=
My apologies for that. I had to rebase against the latest RC because of a=
=0A=
conflict with late fixes in DM. I should have checked more carefully agains=
t the=0A=
block tree after that. Sorry about this, I will be more careful going forwa=
rd.=0A=
=0A=
> 2) The ordering of the signed-off-by. Someone told me that this is=0A=
>    patchwork, but I absolutely hate it. SOB should go last, not before=0A=
>    the reviewed-by. I fixed that up too.=0A=
=0A=
Thank you. I think this was me rather than patchwork when I a manually adde=
d the=0A=
reviewed-by tags with new versions of the series. I will remember this and =
tag=0A=
in you preferred order.=0A=
=0A=
Thank you.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
