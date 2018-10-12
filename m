Return-Path: <prvs=816489328=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>, Mike Snitzer <snitzer@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH v3 03/11] scsi: sd_zbc: Fix sd_zbc_check_zones() error
 checks
Date: Fri, 12 Oct 2018 07:50:11 +0000
Message-ID: 
 <BLUPR0401MB163638186F1243B1C22674EFE7E20@BLUPR0401MB1636.namprd04.prod.outlook.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-4-damien.lemoal@wdc.com>
 <e45aba21-baf3-caab-de83-0c36925ebfdb@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 2018/10/12 16:35, Hannes Reinecke wrote:=0A=
> On 10/12/18 4:30 AM, Damien Le Moal wrote:=0A=
>> The 32 bits overflow check for the zone size value is already done=0A=
>> within sd_zbc_check_zones() with the test:=0A=
>>=0A=
>> } else if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {=
=0A=
>>=0A=
>> so there is no need to check again for an out of range value in=0A=
>> sd_zbc_read_zones(). Simplify the code and fix sd_zbc_check_zones()=0A=
>> error return to -EFBIG instead of -ENODEV if the zone size is too large.=
=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
>> ---=0A=
>>   drivers/scsi/sd_zbc.c | 15 ++++++---------=0A=
>>   1 file changed, 6 insertions(+), 9 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c=0A=
>> index ca73c46931c0..44b64b4a922a 100644=0A=
>> --- a/drivers/scsi/sd_zbc.c=0A=
>> +++ b/drivers/scsi/sd_zbc.c=0A=
>> @@ -373,7 +373,7 @@ static int sd_zbc_check_zoned_characteristics(struct=
 scsi_disk *sdkp,=0A=
>>    * Returns the zone size in number of blocks upon success or an error =
code=0A=
>>    * upon failure.=0A=
>>    */=0A=
>> -static s64 sd_zbc_check_zones(struct scsi_disk *sdkp)=0A=
>> +static s32 sd_zbc_check_zones(struct scsi_disk *sdkp)=0A=
>>   {=0A=
>>   	u64 zone_blocks =3D 0;=0A=
>>   	sector_t max_lba, block =3D 0;=0A=
> Does this have to be an 's32' ?=0A=
> Seeing that it's overloaded with an error code, and never sent to any =0A=
> hardware, can't we just make it a simple 'int' ?=0A=
=0A=
OK. Will do.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
