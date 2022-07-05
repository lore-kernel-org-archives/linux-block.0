Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8425C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 02:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiGECzC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 22:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiGECzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 22:55:01 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D97CC8
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656989700; x=1688525700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1y6wAypb2e7pXog7C7mFRuD3grgqGrQRog8SU6seADI=;
  b=k4nW7oGv/KV/0JUcOVKjl+6sgyYhVu9dfc6twZ+evwwf2ExJFq6Hse3T
   dWZpcKMwmECZNhuBUHBVBrXEIJAZCvwFw0Q7MzzdNGrj8JVYEqh4hpbpf
   qjHamgzGGsusZtTCFmJsH4Js62yTFgoA9Mdoao5S6CTuG5eAff5Q4PcEF
   G4iXN6vWD8fnuBHASsCug8wu6YbIEmqNsl9zj7Vd0pTmD9ZBWua61yb7l
   eBsmMczK6UIUWJH8EHn4o9j/kb75HRpds05pOihUEXam/QGjyGvX697Ar
   W+lWYyCLYndj+fICXnJBPl1Rg3apGDsxn/U3NfjPCMJDJ7LXBcDdCvq9A
   w==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="205520952"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:55:00 +0800
IronPort-SDR: Pa9TF3ifpfgi4hN2mAKlSrjJMn8nbbNEapCu/InpTSrXQL1I4N2rDwEhCfhihAmcSQn6O8rrII
 DRdNmIUSkS6u0cYQVtIU5utuWn9ed755T9wqR0MfymmKfKVAxlGfN/zsT0LGb6V0XR8ZRpmp+K
 PJamsZv2+E1kYGLjL028mXuEwkK1I+79lY7IXHxDF730Rp6dBSe4GfFgY4UA3c3ySFqBl9qnhk
 dG2w7Qf1cY9JZADTeSr/G3kkTSZ2YRSUIvHoEn/YlEdLboNQo5TtIu0/HYA4gL3dWS5IRpSc8b
 huWpb0B2Uth0KGpAzg0oSzdN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:16:51 -0700
IronPort-SDR: 7zGPuKt6dmGLJDQKOdrysqcaf13oZ0FSSB+rZIoSHkZZzAy/czHcNwPyEfKe1Oy9DI2V04TGeQ
 mUsd8BNQGzd2RuR/Rxl23bQtnmlC9r2/fZuG733i2eRWVv4MIaarI2gx1lS5ohhYE1nSwubFvy
 MXgOgDf7068VTnQ3RolqQdpCfvm6zvHBzBSjufxWnylW28r8dTrNz4m+9FawESYmtzOIM67Z+i
 vO36AhQJyAcUJ34K8leJTb0TBogfVgdP0MtPd9xVHalKOdRz1L4jyd2ply/qOz4yEnkYBKRdzp
 AWM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:55:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcS2W6bPqz1RwqM
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:54:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656989699; x=1659581700; bh=1y6wAypb2e7pXog7C7mFRuD3grgqGrQRog8
        SU6seADI=; b=ajSE4pQESPSpjDj92KGRa6Ue0IELvkjnqKFeY7hE9S1kmQo1tW0
        LyBdWz0Kh9uY5d1m/VdR5V4c2ZHSZRz54+LP8bbt4v51rYCV2xMboLtELOMO1FZW
        CFmOrLE/GSeukmUDozhBMlM5lpTcXWy0nFgn+asMpFwupUTet5EvQk4L0XZlxBQ5
        5rhGgHRdDhYE/1zCdfin8lQGBxr2BdOezRRYrDFAmta/inoTT5/cHdu3yOf8+G3G
        Tz4VEGLAP9YUs8Dza8UjPuHpHY0t3rBHpXAUXiDEhF2pgDf088hoiO/4iAZbkPWx
        tYtGJlBkF44FcfsY1xFjy8ynO+hT6RL24yA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 28S5xU12CFWo for <linux-block@vger.kernel.org>;
        Mon,  4 Jul 2022 19:54:59 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcS2V2zgZz1RtVk;
        Mon,  4 Jul 2022 19:54:58 -0700 (PDT)
Message-ID: <535739b6-ee61-eccb-1dfc-3c57eab21cea@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:54:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 15/17] dm-zoned: cleanup dmz_fixup_devices
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-16-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> Use the bdev based helpers where applicable and move the zoned_dev
> into the scope where it is actually used.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-zoned-target.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index 6ba6ef44b00e2..95b132b52f332 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -764,8 +764,7 @@ static void dmz_put_zoned_device(struct dm_target *ti)
>  static int dmz_fixup_devices(struct dm_target *ti)
>  {
>  	struct dmz_target *dmz = ti->private;
> -	struct dmz_dev *reg_dev, *zoned_dev;
> -	struct request_queue *q;
> +	struct dmz_dev *reg_dev = NULL;
>  	sector_t zone_nr_sectors = 0;
>  	int i;
>  
> @@ -780,31 +779,32 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  			return -EINVAL;
>  		}
>  		for (i = 1; i < dmz->nr_ddevs; i++) {
> -			zoned_dev = &dmz->dev[i];
> +			struct dmz_dev *zoned_dev = &dmz->dev[i];
> +			struct block_device *bdev = zoned_dev->bdev;
> +
>  			if (zoned_dev->flags & DMZ_BDEV_REGULAR) {
>  				ti->error = "Secondary disk is not a zoned device";
>  				return -EINVAL;
>  			}
> -			q = bdev_get_queue(zoned_dev->bdev);
>  			if (zone_nr_sectors &&
> -			    zone_nr_sectors != blk_queue_zone_sectors(q)) {
> +			    zone_nr_sectors != bdev_zone_sectors(bdev)) {
>  				ti->error = "Zone nr sectors mismatch";
>  				return -EINVAL;
>  			}
> -			zone_nr_sectors = blk_queue_zone_sectors(q);
> +			zone_nr_sectors = bdev_zone_sectors(bdev);
>  			zoned_dev->zone_nr_sectors = zone_nr_sectors;
> -			zoned_dev->nr_zones = bdev_nr_zones(zoned_dev->bdev);
> +			zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  		}
>  	} else {
> -		reg_dev = NULL;
> -		zoned_dev = &dmz->dev[0];
> +		struct dmz_dev *zoned_dev = &dmz->dev[0];
> +		struct block_device *bdev = zoned_dev->bdev;
> +
>  		if (zoned_dev->flags & DMZ_BDEV_REGULAR) {
>  			ti->error = "Disk is not a zoned device";
>  			return -EINVAL;
>  		}
> -		q = bdev_get_queue(zoned_dev->bdev);
> -		zoned_dev->zone_nr_sectors = blk_queue_zone_sectors(q);
> -		zoned_dev->nr_zones = bdev_nr_zones(zoned_dev->bdev);
> +		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
> +		zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  	}
>  
>  	if (reg_dev) {


-- 
Damien Le Moal
Western Digital Research
