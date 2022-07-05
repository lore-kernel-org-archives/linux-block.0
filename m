Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6E1C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 02:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiGECcE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 22:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiGECcD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 22:32:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E1024E
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988322; x=1688524322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ro+fI82nD1IGiNFuAK6LUHDwCz2uvuI1Aih9ZqsmmTw=;
  b=DidzLw8TIyZXMUerkWrmdl3+S313+LBoyri8MYv1NzQQiLiAU61zbD2O
   2GY/fEgNvVk/jNdB2YbF6A1edzZqKLFdjUjtUrYoZDilZnEw0tE1eBaEt
   K7RQLm7dJ5b3SFdiybVmQFIWvUREY8rISgSTjCnrpKWI+5Cfz8tdFet6u
   ikHODzhyOraJ/bVAlrPihbjiR4UBvYNob4REJrm6eWeaPuuz9DRXSr/PK
   acM6iRE+W6ByMJ7CkYcu1uI9qjeVmk6MCwrvhLPFIYCEpjeHkDNKWd2mH
   RsxFkmta75k2PfEdhBWzyaHfFuG40MiVjxs4HmKpryJD9hb4klOH3mFAV
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="203465757"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:32:01 +0800
IronPort-SDR: Ys/O162habi1N/pDHK8JI0pn6Vi3+G8mlsmwoGCZlvLUijzVvd3G+rmcSKO1ZYF8Xe1u0X6A1F
 /7ks5cjXrLUreNpHx5LFu3OuaRFwJ+dg7zFOolfognY66VYGXVd3muDoeRWFw8D+DPRYsEwLrE
 UdHbwksdJ3F0AcF697bppnm8M5vDrD4G5bKoD3ew/Dj0tIDJ36qx2iq92PDYBGSOF2H3ak48O9
 Mg6z/q/qbMUbEzGjDemfkX0DLRrfecceZuI0LIuBzmS1UlSJUB9TMTr18DVtIvJZ4vJZSvw9X5
 nRbAVjTA1Sq7AYyoW7wGQb5P
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 18:49:20 -0700
IronPort-SDR: dBYNfrxwLNQhZh4sVZEOyJnJezGusx0/aw5X/8VyIz8kxopXdrYAbs80hfj4LARDQhqQSWwYKG
 UKCU9ZJSyfoZXuwpD7KeXcMqsCt5u+g2bi8F213Eub5JyPoKejlR4IzxVsIFEpZSdtL9KQ9B0i
 ikMJJlD6N5b11turs005GMvG4H4o/IJMejlwOee6SlLod6uCO+Y2XTVfdn6HHHAuyH4E1WWz7b
 BGAiBP5kwWzUshuZVNXZSuA5+oaprNRjbh0jTbg7RQgtl5TQ6K4XQFR9IEbKuatDcMK5nMwsFl
 8i4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:32:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRX052Kmz1Rwnm
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:32:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656988320; x=1659580321; bh=Ro+fI82nD1IGiNFuAK6LUHDwCz2uvuI1Aih
        9ZqsmmTw=; b=E5si8k2AyrL9p+0u2wPVEH9uM3pJyLDKNMYvqS466EiGZ7b8VQB
        Gb7Iy6h91Um4fbaue0VXVzRShIykbnYeMZvnb0bxB8zYCtpzUrAjwtYgn7KT4mmq
        w2zTI8JvTz+HT4F0gPIrfPyrHTbIGKHiVf5t31RyJvGffCAOhmbdeeyf1o0kTdLj
        lJ4Fh/bBLjt4LSpdng5pQRsC8rebZ3TnSbPRmIizfLfBp3vLt503L0IQAg7BryG3
        tCYgfcbvIbno2pSFTz0V4SYjsIt5ctML2m4WttC3NQ5aT85/DsjznkS0LsLpru2v
        7MWgNzCTA7jMlsE8ue0OR8OyDB8cIgKXfqw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9a_feJW0DjVQ for <linux-block@vger.kernel.org>;
        Mon,  4 Jul 2022 19:32:00 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRWz1GBQz1RtVk;
        Mon,  4 Jul 2022 19:31:58 -0700 (PDT)
Message-ID: <9e815a0b-0d60-730a-51f8-6ba749b5c60e@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:31:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/17] block: export blkdev_zone_mgmt_all
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-6-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> Export blkdev_zone_mgmt_all so that the nvme target can use it instead
> of duplicating the functionality.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-zoned.c      | 10 +++++-----
>  include/linux/blkdev.h |  2 ++
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 90a5c9cc80ab3..7fbe395fa51fc 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -185,8 +185,8 @@ static int blk_zone_need_reset_cb(struct blk_zone *zone, unsigned int idx,
>  	}
>  }
>  
> -static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
> -					  gfp_t gfp_mask)
> +int blkdev_zone_mgmt_all(struct block_device *bdev, unsigned int op,
> +			 gfp_t gfp_mask)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
>  	sector_t capacity = get_capacity(bdev->bd_disk);
> @@ -213,8 +213,7 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
>  			continue;
>  		}
>  
> -		bio = blk_next_bio(bio, bdev, 0, REQ_OP_ZONE_RESET | REQ_SYNC,
> -				   gfp_mask);
> +		bio = blk_next_bio(bio, bdev, 0, op | REQ_SYNC, gfp_mask);
>  		bio->bi_iter.bi_sector = sector;
>  		sector += zone_sectors;
>  
> @@ -231,6 +230,7 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
>  	kfree(need_reset);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(blkdev_zone_mgmt_all);
>  
>  static int blkdev_zone_reset_all(struct block_device *bdev, gfp_t gfp_mask)
>  {
> @@ -295,7 +295,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  	 */
>  	if (op == REQ_OP_ZONE_RESET && sector == 0 && nr_sectors == capacity) {
>  		if (!blk_queue_zone_resetall(q))
> -			return blkdev_zone_reset_all_emulated(bdev, gfp_mask);
> +			return blkdev_zone_mgmt_all(bdev, op, gfp_mask);
>  		return blkdev_zone_reset_all(bdev, gfp_mask);
>  	}
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 270cd0c552924..b9baee910b825 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -302,6 +302,8 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);
>  extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  			    sector_t sectors, sector_t nr_sectors,
>  			    gfp_t gfp_mask);
> +int blkdev_zone_mgmt_all(struct block_device *bdev, unsigned int op,
> +			 gfp_t gfp_mask);
>  int blk_revalidate_disk_zones(struct gendisk *disk,
>  			      void (*update_driver_data)(struct gendisk *disk));
>  


-- 
Damien Le Moal
Western Digital Research
