Return-Path: <prvs=816489328=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>, Mike Snitzer <snitzer@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH v3 09/11] block: Expose queue nr_zones in sysfs
Date: Fri, 12 Oct 2018 07:55:17 +0000
Message-ID: 
 <BLUPR0401MB1636E66F2F7AA1F7D2529794E7E20@BLUPR0401MB1636.namprd04.prod.outlook.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-10-damien.lemoal@wdc.com>
 <c13f3820-9a69-6a74-e967-b561d7778bcf@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 2018/10/12 16:41, Hannes Reinecke wrote:=0A=
> On 10/12/18 4:30 AM, Damien Le Moal wrote:=0A=
>> Expose through sysfs the nr_zones field of struct request_queue.=0A=
>> Exposing this value helps in debugging disk issues as well as=0A=
>> facilitating scripts based use of the disk (e.g. blktests).=0A=
>>=0A=
>> For zoned block devices, the nr_zones field indicates the total number=
=0A=
>> of zones of the device calculated using the known disk capacity and=0A=
>> zone size. This number of zones is always 0 for regular block devices.=
=0A=
>>=0A=
>> Since nr_zones is defined conditionally with CONFIG_BLK_DEV_ZONED,=0A=
>> introduce the blk_queue_nr_zones() function to return the correct value=
=0A=
>> for any device, regardless if CONFIG_BLK_DEV_ZONED is set.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>   block/blk-sysfs.c      | 11 +++++++++++=0A=
>>   include/linux/blkdev.h | 10 ++++++++++=0A=
>>   2 files changed, 21 insertions(+)=0A=
>>=0A=
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
>> index 3772671cf2bc..92be8092ca4f 100644=0A=
>> --- a/block/blk-sysfs.c=0A=
>> +++ b/block/blk-sysfs.c=0A=
>> @@ -300,6 +300,11 @@ static ssize_t queue_zoned_show(struct request_queu=
e *q, char *page)=0A=
>>   	}=0A=
>>   }=0A=
>>   =0A=
>> +static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)=
=0A=
>> +{=0A=
>> +	return queue_var_show(blk_queue_nr_zones(q), page);=0A=
>> +}=0A=
>> +=0A=
>>   static ssize_t queue_nomerges_show(struct request_queue *q, char *page=
)=0A=
>>   {=0A=
>>   	return queue_var_show((blk_queue_nomerges(q) << 1) |=0A=
>> @@ -637,6 +642,11 @@ static struct queue_sysfs_entry queue_zoned_entry =
=3D {=0A=
>>   	.show =3D queue_zoned_show,=0A=
>>   };=0A=
>>   =0A=
>> +static struct queue_sysfs_entry queue_nr_zones_entry =3D {=0A=
>> +	.attr =3D {.name =3D "nr_zones", .mode =3D 0444 },=0A=
>> +	.show =3D queue_nr_zones_show,=0A=
>> +};=0A=
>> +=0A=
>>   static struct queue_sysfs_entry queue_nomerges_entry =3D {=0A=
>>   	.attr =3D {.name =3D "nomerges", .mode =3D 0644 },=0A=
>>   	.show =3D queue_nomerges_show,=0A=
>> @@ -727,6 +737,7 @@ static struct attribute *default_attrs[] =3D {=0A=
>>   	&queue_write_zeroes_max_entry.attr,=0A=
>>   	&queue_nonrot_entry.attr,=0A=
>>   	&queue_zoned_entry.attr,=0A=
>> +	&queue_nr_zones_entry.attr,=0A=
>>   	&queue_nomerges_entry.attr,=0A=
>>   	&queue_rq_affinity_entry.attr,=0A=
>>   	&queue_iostats_entry.attr,=0A=
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>> index c24969b1741b..879753b10263 100644=0A=
>> --- a/include/linux/blkdev.h=0A=
>> +++ b/include/linux/blkdev.h=0A=
>> @@ -804,6 +804,11 @@ static inline unsigned int blk_queue_zone_sectors(s=
truct request_queue *q)=0A=
>>   }=0A=
>>   =0A=
>>   #ifdef CONFIG_BLK_DEV_ZONED=0A=
>> +static inline unsigned int blk_queue_nr_zones(struct request_queue *q)=
=0A=
>> +{=0A=
>> +	return blk_queue_is_zoned(q) ? q->nr_zones : 0;=0A=
>> +}=0A=
>> +=0A=
>>   static inline unsigned int blk_queue_zone_no(struct request_queue *q,=
=0A=
>>   					     sector_t sector)=0A=
>>   {=0A=
>> @@ -819,6 +824,11 @@ static inline bool blk_queue_zone_is_seq(struct req=
uest_queue *q,=0A=
>>   		return false;=0A=
>>   	return test_bit(blk_queue_zone_no(q, sector), q->seq_zones_bitmap);=
=0A=
>>   }=0A=
>> +#else /* CONFIG_BLK_DEV_ZONED */=0A=
>> +static inline unsigned int blk_queue_nr_zones(struct request_queue *q)=
=0A=
>> +{=0A=
>> +	return 0;=0A=
>> +}=0A=
>>   #endif /* CONFIG_BLK_DEV_ZONED */=0A=
>>   =0A=
>>   static inline bool rq_is_sync(struct request *rq)=0A=
>>=0A=
> Actually, we should be checking whether we can't blank out this =0A=
> attribute via the is_visible mechanism; after all, not every block =0A=
> device is zoned, and those which are not have no need of the attribute...=
=0A=
=0A=
Yes we could. But it is somewhat the same as drives that do not support tri=
m:=0A=
they get max_discard_sectors to 0. The attribute says "not supported becaus=
e the=0A=
value is 0". I followed the same principle for nr_zones: value of 0 says "n=
o=0A=
zones", hopefully in sync with "zoned" saying "none". And if these 2 are no=
t in=0A=
sync as such, then we have a defective drive or a bug. So actually always h=
aving=0A=
nr_zones is useful I think.=0A=
=0A=
But I can make it invisible for regular disks if you insist :)=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
