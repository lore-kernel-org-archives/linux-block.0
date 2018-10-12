Return-Path: <prvs=816489328=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>, Mike Snitzer <snitzer@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH v4 03/11] scsi: sd_zbc: Fix sd_zbc_check_zones() error
 checks
Date: Fri, 12 Oct 2018 11:41:22 +0000
Message-ID: 
 <BN3PR0401MB164067E9169258F410D40614E7E20@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181012100850.23316-1-damien.lemoal@wdc.com>
 <20181012100850.23316-4-damien.lemoal@wdc.com>
 <ad9d7c12-f2df-a345-895c-f23b18b1ec29@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 2018/10/12 19:23, Hannes Reinecke wrote:=0A=
> On 10/12/18 12:08 PM, Damien Le Moal wrote:=0A=
>> The unsigned 32 bits overflow check for the zone size value is already=
=0A=
>> done within sd_zbc_check_zones() with the test:=0A=
>>=0A=
>> } else if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {=
=0A=
>>=0A=
>> so there is no need to check again for an out of range value in=0A=
>> sd_zbc_read_zones(). Simplify the code and fix sd_zbc_check_zones()=0A=
>> error return to -EFBIG instead of -ENODEV if the zone size is too large.=
=0A=
>> Change the return type of sd_zbc_check_zones() to an int for the error=
=0A=
>> code and return the zone size (zone_blocks) through a u32 pointer to=0A=
>> avoid overflowing the signed 32 return value.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>   drivers/scsi/sd_zbc.c | 19 ++++++++-----------=0A=
>>   1 file changed, 8 insertions(+), 11 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c=0A=
>> index ca73c46931c0..0678e1e108b0 100644=0A=
>> --- a/drivers/scsi/sd_zbc.c=0A=
>> +++ b/drivers/scsi/sd_zbc.c=0A=
>> @@ -373,7 +373,7 @@ static int sd_zbc_check_zoned_characteristics(struct=
 scsi_disk *sdkp,=0A=
>>    * Returns the zone size in number of blocks upon success or an error =
code=0A=
>>    * upon failure.=0A=
>>    */=0A=
>> -static s64 sd_zbc_check_zones(struct scsi_disk *sdkp)=0A=
>> +static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)=0A=
>>   {=0A=
>>   	u64 zone_blocks =3D 0;=0A=
>>   	sector_t max_lba, block =3D 0;=0A=
> =0A=
> Actually I thought to just change the 's32' to 'int', and not adding =0A=
> another parameter; but anyway.=0A=
=0A=
Yes, I understood that. But since chunk_sectors is unsigned int, zone_block=
s has=0A=
to be too and so returning that through an int would be asking for troubles=
. If=0A=
we ever have see a drive with a 2G LBA zone size that is :)=0A=
I thought it was cleaner this way.=0A=
=0A=
> =0A=
> Reviewed-by: Hannes Reinecke <hare@suse.com>=0A=
=0A=
Thanks !=0A=
=0A=
> =0A=
> Hannes=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
