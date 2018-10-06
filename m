Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:40983 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJFI0X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Oct 2018 04:26:23 -0400
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Mike Snitzer <snitzer@redhat.com>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: dm: Fix report zone remapping
Date: Sat, 6 Oct 2018 01:24:43 +0000
Message-ID: <BN3PR0401MB1640B2763051334D011B0111E7E40@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181005103452.7134-1-damien.lemoal@wdc.com>
 <20181005182948.GA5628@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Mike,=0A=
=0A=
On 2018/10/06 3:29, Mike Snitzer wrote:=0A=
> On Fri, Oct 05 2018 at  6:34am -0400,=0A=
> Damien Le Moal <damien.lemoal@wdc.com> wrote:=0A=
> =0A=
>> If dm-linear or dm-flakey have targets on top of a partition of a zoned=
=0A=
>> block device, remapping of the start sector and write pointer position=
=0A=
>> of the zones reported by a report zones BIO must be modified to not=0A=
>> only account for the target table entry mapping, but also to account=0A=
>> for the partition first sector. This start sector must be substracted=0A=
>> to the start sector of all zones reported. The write pointer position=0A=
>> of sequential zones must also be reduced by this offset.=0A=
>>=0A=
>> Since there is no easy way to access the underlying bdev of the target=
=0A=
>> table entry from the dm_target or dm_target_io pointers, modify the=0A=
>> interface of the function dm_remap_zone_report() to allow a target to=0A=
>> pass the partition block device starting sector (offset).=0A=
>>=0A=
>> Fixes: 10999307c14e ("dm: introduce dm_remap_zone_report()")=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Cc: <stable@vger.kernel.org>=0A=
> =0A=
> [dropping the actual stable cc from the mail, please don't cc stable in=
=0A=
> the mail header, could be that git-send-email just pulled it in but...]=
=0A=
=0A=
My apologies about that. It was indeed git-send-email. Will fix that.=0A=
=0A=
> This needs a different fix.  There should be absolutely no need to pass=
=0A=
> in a start offset for a device that is already supposed to be described=
=0A=
> within the 'struct bio' passed to dm_remap_zone_report().=0A=
> =0A=
> Why can't you just use the bio->bi_bdev ?  Err, since commit=0A=
> 74d46992e0d9d, I mean bio->bi_disk to get the start sector?=0A=
> =0A=
> You should be able to get it from:=0A=
> =0A=
> struct hd_struct *part =3D disk_get_part(bio->bi_disk, bio->bi_partno);=
=0A=
> part->start_sect;=0A=
> disk_put_part(part);=0A=
> =0A=
> or:=0A=
> =0A=
> struct block_device *bdev =3D bdget_disk(bio->bi_disk, bio->bi_partno);=
=0A=
> get_start_sect(fc->dev->bdev);=0A=
> bdput(bdev);=0A=
=0A=
I am afraid this does not work. The original bio disk is of course /dev/dm-=
xx so=0A=
not the partition (partno =3D=3D 0), and the mapped bio passed as argument =
to the=0A=
remap zone function (clone of the orig bio) is pointing to the entire under=
lying=0A=
disk, not the partition disk used in dmsetup. bi_partno is 0 for both BIOs.=
=0A=
Which seems weird, __bio_clone_fast() does copy the disk and part number as=
 is.=0A=
The disk is of course correctly changed from the orig dm disk to the actual=
=0A=
physical disk in the clone, but the partition number stays the same. In the=
 end,=0A=
only the target has the correct bdev (disk+partno) information it seems.=0A=
=0A=
It looks like the partno gets lost, which does not seem correct. I must be=
=0A=
missing something, but I fail to see what it is. Any suggestion ?=0A=
=0A=
=0A=
> =0A=
> Mike=0A=
> =0A=
> =0A=
>> ---=0A=
>>  drivers/md/dm-flakey.c        |  3 ++-=0A=
>>  drivers/md/dm-linear.c        |  3 ++-=0A=
>>  drivers/md/dm.c               | 16 ++++++++++++----=0A=
>>  include/linux/device-mapper.h |  2 +-=0A=
>>  4 files changed, 17 insertions(+), 7 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c=0A=
>> index 21d126a5078c..c68c2e9cde6b 100644=0A=
>> --- a/drivers/md/dm-flakey.c=0A=
>> +++ b/drivers/md/dm-flakey.c=0A=
>> @@ -381,7 +381,8 @@ static int flakey_end_io(struct dm_target *ti, struc=
t bio *bio,=0A=
>>  		return DM_ENDIO_DONE;=0A=
>>  =0A=
>>  	if (bio_op(bio) =3D=3D REQ_OP_ZONE_REPORT) {=0A=
>> -		dm_remap_zone_report(ti, bio, fc->start);=0A=
>> +		dm_remap_zone_report(ti, bio, get_start_sect(fc->dev->bdev),=0A=
>> +				     fc->start);=0A=
>>  		return DM_ENDIO_DONE;=0A=
>>  	}=0A=
>>  =0A=
>> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c=0A=
>> index d10964d41fd7..f8cd367abbf6 100644=0A=
>> --- a/drivers/md/dm-linear.c=0A=
>> +++ b/drivers/md/dm-linear.c=0A=
>> @@ -108,7 +108,8 @@ static int linear_end_io(struct dm_target *ti, struc=
t bio *bio,=0A=
>>  	struct linear_c *lc =3D ti->private;=0A=
>>  =0A=
>>  	if (!*error && bio_op(bio) =3D=3D REQ_OP_ZONE_REPORT)=0A=
>> -		dm_remap_zone_report(ti, bio, lc->start);=0A=
>> +		dm_remap_zone_report(ti, bio, get_start_sect(lc->dev->bdev),=0A=
>> +				     lc->start);=0A=
>>  =0A=
>>  	return DM_ENDIO_DONE;=0A=
>>  }=0A=
>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c=0A=
>> index 20f7e4ef5342..ffd8544eedd8 100644=0A=
>> --- a/drivers/md/dm.c=0A=
>> +++ b/drivers/md/dm.c=0A=
>> @@ -1162,7 +1162,8 @@ EXPORT_SYMBOL_GPL(dm_accept_partial_bio);=0A=
>>   * REQ_OP_ZONE_REPORT bio to remap the zone descriptors obtained=0A=
>>   * from the target device mapping to the dm device.=0A=
>>   */=0A=
>> -void dm_remap_zone_report(struct dm_target *ti, struct bio *bio, sector=
_t start)=0A=
>> +void dm_remap_zone_report(struct dm_target *ti, struct bio *bio,=0A=
>> +			  sector_t dev_offset, sector_t start)=0A=
>>  {=0A=
>>  #ifdef CONFIG_BLK_DEV_ZONED=0A=
>>  	struct dm_target_io *tio =3D container_of(bio, struct dm_target_io, cl=
one);=0A=
>> @@ -1195,18 +1196,25 @@ void dm_remap_zone_report(struct dm_target *ti, =
struct bio *bio, sector_t start)=0A=
>>  		/* Set zones start sector */=0A=
>>  		while (hdr->nr_zones && ofst < bvec.bv_len) {=0A=
>>  			zone =3D addr + ofst;=0A=
>> +			zone->start -=3D dev_offset;=0A=
>>  			if (zone->start >=3D start + ti->len) {=0A=
>>  				hdr->nr_zones =3D 0;=0A=
>>  				break;=0A=
>>  			}=0A=
>>  			zone->start =3D zone->start + ti->begin - start;=0A=
>>  			if (zone->type !=3D BLK_ZONE_TYPE_CONVENTIONAL) {=0A=
>> -				if (zone->cond =3D=3D BLK_ZONE_COND_FULL)=0A=
>> +				switch (zone->cond) {=0A=
>> +				case BLK_ZONE_COND_FULL:=0A=
>>  					zone->wp =3D zone->start + zone->len;=0A=
>> -				else if (zone->cond =3D=3D BLK_ZONE_COND_EMPTY)=0A=
>> +					break;=0A=
>> +				case BLK_ZONE_COND_EMPTY:=0A=
>>  					zone->wp =3D zone->start;=0A=
>> -				else=0A=
>> +					break;=0A=
>> +				default:=0A=
>> +					zone->wp -=3D dev_offset;=0A=
>>  					zone->wp =3D zone->wp + ti->begin - start;=0A=
>> +					break;=0A=
>> +				}=0A=
>>  			}=0A=
>>  			ofst +=3D sizeof(struct blk_zone);=0A=
>>  			hdr->nr_zones--;=0A=
>> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper=
.h=0A=
>> index 6fb0808e87c8..22c1924c0ee8 100644=0A=
>> --- a/include/linux/device-mapper.h=0A=
>> +++ b/include/linux/device-mapper.h=0A=
>> @@ -421,7 +421,7 @@ int dm_suspended(struct dm_target *ti);=0A=
>>  int dm_noflush_suspending(struct dm_target *ti);=0A=
>>  void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors);=0A=
>>  void dm_remap_zone_report(struct dm_target *ti, struct bio *bio,=0A=
>> -			  sector_t start);=0A=
>> +			  sector_t dev_offset, sector_t start);=0A=
>>  union map_info *dm_get_rq_mapinfo(struct request *rq);=0A=
>>  =0A=
>>  struct queue_limits *dm_get_queue_limits(struct mapped_device *md);=0A=
>> -- =0A=
>> 2.17.1=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
