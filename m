Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FE0C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 04:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiCIEKa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 23:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCIEK2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 23:10:28 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF21127D6F
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 20:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646798970; x=1678334970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sO8N4mRhgHE+gZXvdKOFxkmAXZWQT6s9WfztoXW0OE4=;
  b=aYQEDhpUShTG5BhQRTGlm5hyFjU8/QDiv+D9qnVJFaKfQnHCc21Y2qZV
   Xco+ZmrkvUSUAGfsDTg0fnJDyIyyMZOe4uMIcgJK15gcBd3ZS7vvqatr0
   ged3BZT0BYd3dKHhFmtzPYMu8bQ9Gmf4by0RbwytlJrmMudjj0eSx4ysz
   JlQKMY9/4wbCrWphkwKNax2mxUb/X5XoQO2KJ04s/x+LPjG5CLa55++0z
   DXCc40PE3akQ5jwDl3y1ecBxVOy7axOkU16did4OGOpVAN2X8f6HpCtTE
   fHR+3kocm3Gz7LH9i4zVuBqAPmeBAKzSj0KKF6ZRdEFK2euLbNfGsV4gR
   A==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643644800"; 
   d="scan'208";a="195776069"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 12:09:29 +0800
IronPort-SDR: umSDFIZFeag9s0fGYTuB5bAXaK3GThVhdleG8k3btPiRDV83ZcFR7CMnmIbljsaFyIcE0ia+/E
 l1DDvEq5aNQlUgWrd5+X9cu5ygE2imyQEJN5LB/bbVxQ0CXOVTjkCAVRmi4LB8yawL1ku5A2v6
 h++FNf14piPhYp/2MALeeL3675BqZkYhszjRTjclimcZzS7PhMkRIoNOG1GOcEM26XKDOdMZpu
 wKknoGpMKgvcs4cFEBV+S/1afBZsucjkhpUn+PhgbWB9OBEYi2h0W1FLux+ILOwXumqgGTcG3X
 mKSm8F82f+qJUPYsoHcfsVcf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:40:43 -0800
IronPort-SDR: NDmDuiJI2LWGdxTy+uWAkhnxcH/kSPBBr51OntwNDiR8TxU8JicNSK5Z3fY+KN68LjVUet1tmP
 /FyNSSpn8nx4CemBdA5fpTzxrvgamkKUD87TM9jWVybtNG79i1k6+1rtk3qmFGuUFFprjQaevZ
 An7V8w5CZeeJ3qcVRc/JOTIQlQOar3ZRGE98UJbzKEvIczba97B9KOqusGDEGIw4LVp1qH9s7R
 g/AUKjDk9jKp41Rf+3MrMmI+xfxWMgPm5gntFKCYLIF2oxWWAeKCmp5L33hSv7+XoLVc+jDWr8
 HAk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 20:09:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KCzGw2tB4z1SVp4
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 20:09:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646798965; x=1649390966; bh=sO8N4mRhgHE+gZXvdKOFxkmAXZWQT6s9Wfz
        toXW0OE4=; b=mKm3b5NcKgu4dbMb29xg0sRQCdJGwuNfeVoRYFX6WSFES6y3NqG
        DIf2IfJW+UP3zQcCWKEu32RHNvbmtNwHhFe5HAiLPJ1CxCf/DYZPZ4YwPSA0ZILm
        lcQVjgQaLckJ5Zkc9ZubRVtKJbtaPIfzUuRV4TCzwJi70NqYfiNIqFb81GHcimYV
        OJ+z5I3S5WbjLCGiuig54Gp6ha1Llh13nvMRAC4XKDL0MXOhsh4ZvvWosVOxNrHI
        KpDZBVMEdwW9Rn7IsjBT0RcRYonEK/Yl7xW0OUds61BF4NHWra/d3W4XXLgJN7Ae
        KlBMBNV7y8NlaJCzDTUSdCYMbriT83vNl6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nblpBZKOUC9l for <linux-block@vger.kernel.org>;
        Tue,  8 Mar 2022 20:09:25 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KCzGp5JGGz1Rvlx;
        Tue,  8 Mar 2022 20:09:22 -0800 (PST)
Message-ID: <91d1f4c8-946d-c6b2-d30e-f9af4424221f@opensource.wdc.com>
Date:   Wed, 9 Mar 2022 13:09:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/6] null_blk: Add support for power_of_2 emulation to the
 null blk device
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165448eucas1p12c7c302a4b239db64b49d54cc3c1f0ac@eucas1p1.samsung.com>
 <20220308165349.231320-7-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220308165349.231320-7-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/22 01:53, Pankaj Raghav wrote:
> power_of_2(PO2) emulation support is added to the null blk device to
> measure performance.
> 
> Callbacks are added in the hotpaths that require PO2 emulation specific
> behaviour to reduce the impact on exisiting path.
> 
> The power_of_2 emulation support is wired up for both the request and
> the bio queue mode and it is automatically enabled when the given zone
> size is non-power_of_2.

This does not make any sense. Why would you want to add power of 2 zone
size emulation to nullblk ? Just set the zone size to be a power of 2...

If this is for test purpose, then use QEMU. These changes make no sense
to me here.

A change that would make sense in the context of this series is to allow
for setting a zoned null_blk device zone size to a non power of 2 size.
But this series does not actually deal with that. So do not touch this
driver please.

> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/block/null_blk/main.c     |   8 +-
>  drivers/block/null_blk/null_blk.h |  12 ++
>  drivers/block/null_blk/zoned.c    | 203 ++++++++++++++++++++++++++----
>  3 files changed, 196 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 625a06bfa5ad..c926b59f2b17 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -210,7 +210,7 @@ MODULE_PARM_DESC(zoned, "Make device as a host-managed zoned block device. Defau
>  
>  static unsigned long g_zone_size = 256;
>  module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
> -MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256");
> +MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Default: 256");
>  
>  static unsigned long g_zone_capacity;
>  module_param_named(zone_capacity, g_zone_capacity, ulong, 0444);
> @@ -1772,11 +1772,13 @@ static const struct block_device_operations null_bio_ops = {
>  	.owner		= THIS_MODULE,
>  	.submit_bio	= null_submit_bio,
>  	.report_zones	= null_report_zones,
> +	.npo2_zone_setup = null_po2_zone_emu_setup,
>  };
>  
>  static const struct block_device_operations null_rq_ops = {
>  	.owner		= THIS_MODULE,
>  	.report_zones	= null_report_zones,
> +	.npo2_zone_setup = null_po2_zone_emu_setup,
>  };
>  
>  static int setup_commands(struct nullb_queue *nq)
> @@ -1929,8 +1931,8 @@ static int null_validate_conf(struct nullb_device *dev)
>  		dev->mbps = 0;
>  
>  	if (dev->zoned &&
> -	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
> -		pr_err("zone_size must be power-of-two\n");
> +	    (!dev->zone_size)) {
> +		pr_err("zone_size must be zero\n");
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 78eb56b0ca55..34c1b7b2546b 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -74,6 +74,16 @@ struct nullb_device {
>  	unsigned int imp_close_zone_no;
>  	struct nullb_zone *zones;
>  	sector_t zone_size_sects;
> +	sector_t zone_size_po2_sects;
> +	sector_t zone_size_diff_sects;
> +	/* The callbacks below are used as hook to perform po2 emulation for a
> +	 * zoned device.
> +	 */
> +	unsigned int (*zone_no)(struct nullb_device *dev,
> +				sector_t sect);
> +	sector_t (*zone_update_sector)(struct nullb_device *dev, sector_t sect);
> +	sector_t (*zone_update_sector_append)(struct nullb_device *dev,
> +					      sector_t sect);
>  	bool need_zone_res_mgmt;
>  	spinlock_t zone_res_lock;
>  
> @@ -137,6 +147,7 @@ int null_register_zoned_dev(struct nullb *nullb);
>  void null_free_zoned_dev(struct nullb_device *dev);
>  int null_report_zones(struct gendisk *disk, sector_t sector,
>  		      unsigned int nr_zones, report_zones_cb cb, void *data);
> +void null_po2_zone_emu_setup(struct gendisk *disk);
>  blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd,
>  				    enum req_opf op, sector_t sector,
>  				    sector_t nr_sectors);
> @@ -166,5 +177,6 @@ static inline size_t null_zone_valid_read_len(struct nullb *nullb,
>  	return len;
>  }
>  #define null_report_zones	NULL
> +#define null_po2_zone_emu_setup	NULL
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  #endif /* __NULL_BLK_H */
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index dae54dd1aeac..3bb63c170149 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -16,6 +16,44 @@ static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
>  	return sect >> ilog2(dev->zone_size_sects);
>  }
>  
> +static inline unsigned int null_npo2_zone_no(struct nullb_device *dev,
> +					     sector_t sect)
> +{
> +	return sect / dev->zone_size_sects;
> +}
> +
> +static inline bool null_is_po2_zone_emu(struct nullb_device *dev)
> +{
> +	return !!dev->zone_size_diff_sects;
> +}
> +
> +static inline sector_t null_zone_update_sector_noop(struct nullb_device *dev,
> +						    sector_t sect)
> +{
> +	return sect;
> +}
> +
> +static inline sector_t null_zone_update_sector_po2_emu(struct nullb_device *dev,
> +						       sector_t sect)
> +{
> +	sector_t zsze_po2 = dev->zone_size_po2_sects;
> +	sector_t zsze_diff = dev->zone_size_diff_sects;
> +	u32 zone_idx = sect >> ilog2(zsze_po2);
> +
> +	sect = sect - (zone_idx * zsze_diff);
> +	return sect;
> +}
> +
> +static inline sector_t
> +null_zone_update_sector_append_po2_emu(struct nullb_device *dev, sector_t sect)
> +{
> +	/* Need to readjust the sector if po2 emulation is used. */
> +	u32 zone_no = dev->zone_no(dev, sect);
> +
> +	sect += dev->zone_size_diff_sects * zone_no;
> +	return sect;
> +}
> +
>  static inline void null_lock_zone_res(struct nullb_device *dev)
>  {
>  	if (dev->need_zone_res_mgmt)
> @@ -62,15 +100,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  	sector_t sector = 0;
>  	unsigned int i;
>  
> -	if (!is_power_of_2(dev->zone_size)) {
> -		pr_err("zone_size must be power-of-two\n");
> -		return -EINVAL;
> -	}
>  	if (dev->zone_size > dev->size) {
>  		pr_err("Zone size larger than device capacity\n");
>  		return -EINVAL;
>  	}
>  
> +	if (!is_power_of_2(dev->zone_size))
> +		pr_info("zone_size is not power-of-two. power-of-two emulation is enabled");
> +
>  	if (!dev->zone_capacity)
>  		dev->zone_capacity = dev->zone_size;
>  
> @@ -83,8 +120,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
>  	dev_capacity_sects = mb_to_sects(dev->size);
>  	dev->zone_size_sects = mb_to_sects(dev->zone_size);
> -	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
> -		>> ilog2(dev->zone_size_sects);
> +
> +	dev->nr_zones = roundup(dev_capacity_sects, dev->zone_size_sects) /
> +			dev->zone_size_sects;
> +
> +	dev->zone_no = null_zone_no;
> +	dev->zone_update_sector = null_zone_update_sector_noop;
> +	dev->zone_update_sector_append = null_zone_update_sector_noop;
> +
>  
>  	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
>  				    GFP_KERNEL | __GFP_ZERO);
> @@ -166,7 +209,13 @@ int null_register_zoned_dev(struct nullb *nullb)
>  		if (ret)
>  			return ret;
>  	} else {
> -		blk_queue_chunk_sectors(q, dev->zone_size_sects);
> +		nullb->disk->fops->npo2_zone_setup(nullb->disk);
> +
> +		if (null_is_po2_zone_emu(dev))
> +			blk_queue_chunk_sectors(q, dev->zone_size_po2_sects);
> +		else
> +			blk_queue_chunk_sectors(q, dev->zone_size_sects);
> +
>  		q->nr_zones = blkdev_nr_zones(nullb->disk);
>  	}
>  
> @@ -183,17 +232,49 @@ void null_free_zoned_dev(struct nullb_device *dev)
>  	dev->zones = NULL;
>  }
>  
> +static void null_update_zone_info(struct nullb *nullb, struct blk_zone *blkz,
> +				  struct nullb_zone *zone)
> +{
> +	unsigned int zone_idx;
> +	u64 zone_gap;
> +	struct nullb_device *dev = nullb->dev;
> +
> +	if (null_is_po2_zone_emu(dev)) {
> +		zone_idx = zone->start / zone->len;
> +		zone_gap = zone_idx * dev->zone_size_diff_sects;
> +
> +		blkz->start = zone->start + zone_gap;
> +		blkz->len = dev->zone_size_po2_sects;
> +		blkz->wp = zone->wp + zone_gap;
> +	} else {
> +		blkz->start = zone->start;
> +		blkz->len = zone->len;
> +		blkz->wp = zone->wp;
> +	}
> +
> +	blkz->type = zone->type;
> +	blkz->cond = zone->cond;
> +	blkz->capacity = zone->capacity;
> +}
> +
>  int null_report_zones(struct gendisk *disk, sector_t sector,
>  		unsigned int nr_zones, report_zones_cb cb, void *data)
>  {
>  	struct nullb *nullb = disk->private_data;
>  	struct nullb_device *dev = nullb->dev;
>  	unsigned int first_zone, i;
> +	sector_t zone_size;
>  	struct nullb_zone *zone;
>  	struct blk_zone blkz;
>  	int error;
>  
> -	first_zone = null_zone_no(dev, sector);
> +	if (null_is_po2_zone_emu(dev))
> +		zone_size = dev->zone_size_po2_sects;
> +	else
> +		zone_size = dev->zone_size_sects;
> +
> +	first_zone = sector / zone_size;
> +
>  	if (first_zone >= dev->nr_zones)
>  		return 0;
>  
> @@ -210,12 +291,7 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
>  		 * array.
>  		 */
>  		null_lock_zone(dev, zone);
> -		blkz.start = zone->start;
> -		blkz.len = zone->len;
> -		blkz.wp = zone->wp;
> -		blkz.type = zone->type;
> -		blkz.cond = zone->cond;
> -		blkz.capacity = zone->capacity;
> +		null_update_zone_info(nullb, &blkz, zone);
>  		null_unlock_zone(dev, zone);
>  
>  		error = cb(&blkz, i, data);
> @@ -226,6 +302,35 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
>  	return nr_zones;
>  }
>  
> +void null_po2_zone_emu_setup(struct gendisk *disk)
> +{
> +	struct nullb *nullb = disk->private_data;
> +	struct nullb_device *dev = nullb->dev;
> +	sector_t capacity;
> +
> +	if (is_power_of_2(dev->zone_size_sects))
> +		return;
> +
> +	if (!get_capacity(disk))
> +		return;
> +
> +	blk_mq_freeze_queue(disk->queue);
> +
> +	blk_queue_po2_zone_emu(disk->queue, 1);
> +	dev->zone_size_po2_sects =
> +		1 << get_count_order_long(dev->zone_size_sects);
> +	dev->zone_size_diff_sects =
> +		dev->zone_size_po2_sects - dev->zone_size_sects;
> +	dev->zone_no = null_npo2_zone_no;
> +	dev->zone_update_sector = null_zone_update_sector_po2_emu;
> +	dev->zone_update_sector_append = null_zone_update_sector_append_po2_emu;
> +
> +	capacity = dev->nr_zones * dev->zone_size_po2_sects;
> +	set_capacity(disk, capacity);
> +
> +	blk_mq_unfreeze_queue(disk->queue);
> +}
> +
>  /*
>   * This is called in the case of memory backing from null_process_cmd()
>   * with the target zone already locked.
> @@ -234,7 +339,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
>  				sector_t sector, unsigned int len)
>  {
>  	struct nullb_device *dev = nullb->dev;
> -	struct nullb_zone *zone = &dev->zones[null_zone_no(dev, sector)];
> +	struct nullb_zone *zone = &dev->zones[dev->zone_no(dev, sector)];
>  	unsigned int nr_sectors = len >> SECTOR_SHIFT;
>  
>  	/* Read must be below the write pointer position */
> @@ -363,11 +468,24 @@ static blk_status_t null_check_zone_resources(struct nullb_device *dev,
>  	}
>  }
>  
> +static void null_update_sector_append(struct nullb_cmd *cmd, sector_t sector)
> +{
> +	struct nullb_device *dev = cmd->nq->dev;
> +
> +	sector = dev->zone_update_sector_append(dev, sector);
> +
> +	if (cmd->bio) {
> +		cmd->bio->bi_iter.bi_sector = sector;
> +	} else {
> +		cmd->rq->__sector = sector;
> +	}
> +}
> +
>  static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>  				    unsigned int nr_sectors, bool append)
>  {
>  	struct nullb_device *dev = cmd->nq->dev;
> -	unsigned int zno = null_zone_no(dev, sector);
> +	unsigned int zno = dev->zone_no(dev, sector);
>  	struct nullb_zone *zone = &dev->zones[zno];
>  	blk_status_t ret;
>  
> @@ -395,10 +513,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>  	 */
>  	if (append) {
>  		sector = zone->wp;
> -		if (cmd->bio)
> -			cmd->bio->bi_iter.bi_sector = sector;
> -		else
> -			cmd->rq->__sector = sector;
> +		null_update_sector_append(cmd, sector);
>  	} else if (sector != zone->wp) {
>  		ret = BLK_STS_IOERR;
>  		goto unlock;
> @@ -619,7 +734,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
>  		return BLK_STS_OK;
>  	}
>  
> -	zone_no = null_zone_no(dev, sector);
> +	zone_no = dev->zone_no(dev, sector);
>  	zone = &dev->zones[zone_no];
>  
>  	null_lock_zone(dev, zone);
> @@ -650,13 +765,54 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
>  	return ret;
>  }
>  
> +static blk_status_t null_handle_po2_zone_emu_violation(struct nullb_cmd *cmd,
> +						       enum req_opf op)
> +{
> +	if (op == REQ_OP_READ) {
> +		if (cmd->bio)
> +			zero_fill_bio(cmd->bio);
> +		else
> +			zero_fill_bio(cmd->rq->bio);
> +
> +		return BLK_STS_OK;
> +	} else {
> +		return BLK_STS_IOERR;
> +	}
> +}
> +
> +static bool null_verify_sector_violation(struct nullb_device *dev,
> +					 sector_t sector)
> +{
> +	if (unlikely(null_is_po2_zone_emu(dev))) {
> +		/* The zone idx should be calculated based on the emulated
> +		 * layout
> +		 */
> +		u32 zone_idx = sector >> ilog2(dev->zone_size_po2_sects);
> +		sector_t zsze = dev->zone_size_sects;
> +		sector_t sect = null_zone_update_sector_po2_emu(dev, sector);
> +
> +		if (sect - (zone_idx * zsze) > zsze)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
>  				    sector_t sector, sector_t nr_sectors)
>  {
> -	struct nullb_device *dev;
> +	struct nullb_device *dev = cmd->nq->dev;
>  	struct nullb_zone *zone;
>  	blk_status_t sts;
>  
> +	/* Handle when the sector falls in the emulated area */
> +	if (unlikely(null_verify_sector_violation(dev, sector)))
> +		return null_handle_po2_zone_emu_violation(cmd, op);
> +
> +	/* The sector value is updated if po2 emulation is enabled, else it
> +	 * will have no effect on the value
> +	 */
> +	sector = dev->zone_update_sector(dev, sector);
> +
>  	switch (op) {
>  	case REQ_OP_WRITE:
>  		return null_zone_write(cmd, sector, nr_sectors, false);
> @@ -669,8 +825,7 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
>  	case REQ_OP_ZONE_FINISH:
>  		return null_zone_mgmt(cmd, op, sector);
>  	default:
> -		dev = cmd->nq->dev;
> -		zone = &dev->zones[null_zone_no(dev, sector)];
> +		zone = &dev->zones[dev->zone_no(dev, sector)];
>  
>  		null_lock_zone(dev, zone);
>  		sts = null_process_cmd(cmd, op, sector, nr_sectors);


-- 
Damien Le Moal
Western Digital Research
