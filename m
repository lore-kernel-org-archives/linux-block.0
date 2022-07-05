Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4792FC43334
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 02:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiGECnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 22:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiGECnK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 22:43:10 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15C1277D
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988989; x=1688524989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7LA9SQImgeYrqqDEiYiBB+QWxnWC2bVZYdvpTVv3KnI=;
  b=rh54uLrQ21QOYTuGXN6HcjGw5A28ek99C3xugICs/uiXLWClimNsQLlG
   yfke1hinCcdYhl+v5Ia8A6Kqk7KXRFOBDk3HT0wbPZ5va+s9Y3UJbFoFl
   pmbLiu24NSfS5BYg7YmVduFMG1Z9cnorjnxKJcrvuvCIyEuiD1POGlSij
   APwisTi+/U7E0gWDzMhnVRonD4k6Zbn9ZPTGEepcnhQp78hcFUZfc7L9c
   KpHh2zDB6EeOQylW4z7k1Ozm6jImtROl11T5Xzqde1IGznABQoQOG1T8C
   yqfwbvN+Q0+NItY3KAKL87SxcoVO7mMweN4r6RAik+2KLH8UcOlI4hNUx
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="205520310"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:43:08 +0800
IronPort-SDR: wgI6Aaohhmo2AmKvwMililtY2uAOxAQznZ97vUf19l4IIpQtBj8NULnxPnq4w4Q3kV4XsBveVh
 irU6Q5RRiOLXrKUsyOvwydd4WtHKjUWTkBnQ+1Uz37HCwaqMdE43eT3BEYNi8njHAeDea1JQVy
 Ap5Bq0daC26TJpnhWUaD+MKagcll8eyMyTiLp1Oak7PHJTYsdhX9230/rlem4+tTYDKEHovidX
 y+6nApDUNc70gfhXlmd4gy4ut71T3tEDGMUn8C9Xe+F6/jx0wO0+Gmun66EVxX/w1GDA8r7oWP
 2nJ4mbrnFFX0I+dquMm7YtMT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:05:00 -0700
IronPort-SDR: 7ElAb8FIGgXzaduTDVG/QkTFOx4jIwJPan3sFjpVzvxeSb+Zakqx1th4CV9QrdM1BpFgi7m60g
 KwJxrFjssmefX8WRzon5XnD9dGeP29/iugYX8uKyyEYsR4XiluoJzS8qMeptZZbPqZXR+5MFhZ
 IxgJ099hiWL8pqN+PAWEFeb2Sh8+uleW6nqKxR9reh0L3igOriPHfjI4/lHDKw7gdM4CyeQ2SR
 haRPw6TGjZ5uz7CWjBc9JhF6Kd1CXVEQSKsV8glDrYmr29N/yEnbTY8BDlBQtPEpqJrrBlQ4Ft
 HZk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:43:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRmr5H4jz1Rwnl
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:43:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656988988; x=1659580989; bh=7LA9SQImgeYrqqDEiYiBB+QWxnWC2bVZYdv
        pTVv3KnI=; b=a+QizpO/JOniekL0zkhYaUKKg2JzJkuBuEsVuklvHfyJ5LPxDlL
        rHO5CeFx+nzK2UkFmSpLX+IJKTSBALvwSYxQsXB+B73v04PLPpekm1+lrpwKuwJy
        38v88BUd8yxIwJyM96Ornr0z3ziZTsB43FDUb9RZule4IU8YfpCl9l5uUVkUQVd2
        PqTZ8RZppuqN1+xIGy6Xl24CjojBD3gIPOX/5YIllqINM+YPVYlMifLZMoUk/CYv
        zIjH/LcGCueZaW0hVKHz6X/6oE5CWLUqqWjQkHsO1MBOxJT1vAv+uWP4QIGlP1Yp
        YKlN3v79AL+lLZAkd1esA/eecOgqvoNKOeg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GRSRBt2chDTs for <linux-block@vger.kernel.org>;
        Mon,  4 Jul 2022 19:43:08 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRmq1bd3z1RtVk;
        Mon,  4 Jul 2022 19:43:07 -0700 (PDT)
Message-ID: <c8f470fd-be57-8d04-cce3-30c4701f8864@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:43:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 11/17] block: remove queue_max_open_zones and
 queue_max_active_zones
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-12-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> Always use the bdev based helpers instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


> ---
>  block/blk-sysfs.c      |  4 ++--
>  include/linux/blkdev.h | 37 ++++++++++---------------------------
>  2 files changed, 12 insertions(+), 29 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 7590810cf13fc..5ce72345ac666 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -330,12 +330,12 @@ static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
>  
>  static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
>  {
> -	return queue_var_show(queue_max_open_zones(q), page);
> +	return queue_var_show(bdev_max_open_zones(q->disk->part0), page);
>  }
>  
>  static ssize_t queue_max_active_zones_show(struct request_queue *q, char *page)
>  {
> -	return queue_var_show(queue_max_active_zones(q), page);
> +	return queue_var_show(bdev_max_active_zones(q->disk->part0), page);
>  }
>  
>  static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ddf8353488fc8..a14cc3e46e6ad 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -704,21 +704,22 @@ static inline void blk_queue_max_open_zones(struct request_queue *q,
>  	q->max_open_zones = max_open_zones;
>  }
>  
> -static inline unsigned int queue_max_open_zones(const struct request_queue *q)
> -{
> -	return q->max_open_zones;
> -}
> -
>  static inline void blk_queue_max_active_zones(struct request_queue *q,
>  		unsigned int max_active_zones)
>  {
>  	q->max_active_zones = max_active_zones;
>  }
>  
> -static inline unsigned int queue_max_active_zones(const struct request_queue *q)
> +static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
> +{
> +	return bdev->bd_disk->queue->max_open_zones;
> +}
> +
> +static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
>  {
> -	return q->max_active_zones;
> +	return bdev->bd_disk->queue->max_active_zones;
>  }
> +
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>  {
> @@ -734,11 +735,11 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>  {
>  	return 0;
>  }
> -static inline unsigned int queue_max_open_zones(const struct request_queue *q)
> +static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>  {
>  	return 0;
>  }
> -static inline unsigned int queue_max_active_zones(const struct request_queue *q)
> +static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
>  {
>  	return 0;
>  }
> @@ -1316,24 +1317,6 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
>  	return 0;
>  }
>  
> -static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return queue_max_open_zones(q);
> -	return 0;
> -}
> -
> -static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return queue_max_active_zones(q);
> -	return 0;
> -}
> -
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;


-- 
Damien Le Moal
Western Digital Research
