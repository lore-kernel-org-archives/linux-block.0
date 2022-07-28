Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A1EC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 03:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiG1DJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 23:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbiG1DJp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 23:09:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E32A5B7B9
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658977784; x=1690513784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nqijlvS6KaE4GXf3iVMG7xf3y9RZd23p19tnc3ApLbI=;
  b=j9OsQ/NEcEmlYmKFFlRbm3Rg1HUyTOe5uqSawvpmWxL/QQMgxhV8Rgp7
   QXlx4fGulVY3uy3wtY5CyRW3x9tBx/F3zOM6IZbDKASfu3LPCxIuSDzlQ
   Ml0cKCkcJekzfzM5IEc+0iUA2GQaiUKzyZz2nMgIMGF6+6B3ueBURDxVX
   yPgaSMel/Lo6XeYL5uf0f9F0+OUDkJadcB3VfX9ZIyck/NpGKm4v/GVml
   fj2G2/ynfoBisiLyXuUxKyx4NpZ5VtUoBWUCBXa42jyqo3X6ckWAKa6T2
   XRD93Z/MjyvwAypDWHDvSCPd5bPxe2s59XC/E8y1Uoclx/YvF5L6ZPqtO
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="319201608"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:09:42 +0800
IronPort-SDR: 338IfP5pw11lAeYcjb9ogJtzDxN3SzORs3kQ1p96URfnLP7+ZKNw/DR0TQO1ZphK8Aj3dsXMfk
 jHW+VWBg7mP1K6YcMSr/CF9uI6FqyO+5ne5ierhE0DzzWz4aWCCG2FbBtzJmy52vQF7LqNDY7H
 6zTdVv7JqS3cshx0QfivrSftDK/kfSz+yMfWz8d/gxvDkVcmToksOcU2EceEWvzAGg6wI+DKG3
 o5prl7l5e+qxSRDxAn5dkLYjtJc8c+M7/BENEuSa+0X+Ejxui4ANeOXB7+CQSSyN/Mp+gIuoXM
 /dbqRQPEqUsAaOsb5FdIfqxC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:30:54 -0700
IronPort-SDR: bHeFVw7scuGXCSHSzFEp1cF5DAMqYTxUeQXmFl8dmEyx5bBf9H480Ny67SXXJ+j8LqxYiuZvVy
 0Aqq+SxKtaJeQNJlGJ9QiJpLuHlUKxVDYRrJMC94sXubj5OZH3RQ+t+cbft/7EvUW54SlB2rSh
 308xJMP3erCqGp8636iUVFHv4pktCBlThFiCGmdvhyXUDvBsR8oanwIuqjdbC9KzAcOzuOmllH
 u2T4ymiC6+4Fl3D34p6DhgetNMLUzhi+cf/quHZ12/BM1CaHt2nKB0mFFaH/nDBDMdIXHxiz2G
 J/A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:09:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbGs3ry5z1Rws6
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:09:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658977780; x=1661569781; bh=nqijlvS6KaE4GXf3iVMG7xf3y9RZd23p19t
        nc3ApLbI=; b=oc9CDihBx7buzRKUoSXFQyWp75MA8Dc8QpAYlEk9hQvUsBAy436
        HfjAMgEBhEjPykStP9IUZNCjt5Cv85QeXUcksLXEolRvParZ8thNQtO/CuYQQY5S
        ZUUpezITIbIkVxpCCD3TO7CSJtFvj4yEvhMn0VhKY2wDh3bRQ1ztlpDa6CuzFQX9
        iIEFx78nv8BH0XASa09ugNN28hAAL7QuYQXIkjQGSKfCIrN1BfsGDX2RmBFw0+jF
        SMwQS2+tu5KkmxDe8OofnBw0KnpbCCsrtkIi3Ep7YhLHTjipAPz1KewZOtERHWn2
        pBr4VsWwFmps3RDzhsHRgR2hBddEwflJ0FA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id axf3o7qF1b2y for <linux-block@vger.kernel.org>;
        Wed, 27 Jul 2022 20:09:40 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbGp0d8bz1RtVk;
        Wed, 27 Jul 2022 20:09:37 -0700 (PDT)
Message-ID: <137b8772-a2cc-f195-1c0d-476214fabd52@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:09:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 04/11] nvmet: Allow ZNS target to support
 non-power_of_2 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162250eucas1p133e8a814fee934f7161866122ef93273@eucas1p1.samsung.com>
 <20220727162245.209794-5-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/22 01:22, Pankaj Raghav wrote:
> A generic bdev_zone_no() helper is added to calculate zone number for a
> given sector in a block device. This helper internally uses disk_zone_no()
> to find the zone number.
> 
> Use the helper bdev_zone_no() to calculate nr of zones. This let's us
> make modifications to the math if needed in one place and adds now
> support for npo2 zone devices.
> 
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/target/zns.c | 3 +--
>  include/linux/blkdev.h    | 5 +++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index c7ef69f29fe4..662f1a92f39b 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -241,8 +241,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
>  {
>  	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>  
> -	return bdev_nr_zones(req->ns->bdev) -
> -		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
> +	return bdev_nr_zones(req->ns->bdev) - bdev_zone_no(req->ns->bdev, sect);
>  }

This change should go into patch 3. Otherwise, adding patch 3 only will
break the nvme target zone code.

>  
>  static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1be805223026..d1ef9b9552ed 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1350,6 +1350,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  	return BLK_ZONED_NONE;
>  }
>  
> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
> +{
> +	return disk_zone_no(bdev->bd_disk, sec);
> +}
> +

This should go into a prep patch before patch 3.

>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;


-- 
Damien Le Moal
Western Digital Research
