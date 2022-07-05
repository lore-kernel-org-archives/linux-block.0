Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03993CCA479
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 02:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiGECyV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 22:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiGECyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 22:54:16 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72BACC8
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656989655; x=1688525655;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DgyUmRlHS/Rk0yqEUio5fJI7r/pAqiGKnmFyxkXId7g=;
  b=Hh+Eb07M9pzOdfdlStolW9CkmcuqLYxT3Ng27aRfvxiZODM8fxBZ7+lM
   DZJXHwuYNozzVyWAj30KX/663dAFe+KXAtEnfbSLe8sECgFtEjn9zhdNJ
   /vTWZAqAqXX6cl/FJjIjnlcAzd6I74IMzEWRSBDu06EMi5v02zvb8Y1NC
   HXhjuZmNrqrzNT6zpb8ZAqpPzHaBRakva/RAO9F+HEy7SW5Skg6XGmwNv
   /Gn+YJ+hnLLjET0yW/otXePc4rKTuIeq0gYny94y+5wUfhvMQtAfNYxsH
   bxygTaVBD1Oq2l39xfPspbICV4tGj6D+8GSkHKvI299w78Khi08Y9mAIx
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="316926909"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:54:15 +0800
IronPort-SDR: EtepoPpXxUy34oRVW5xFTxey552Cj3uuF4/iF7VaUW0lnyZZjoNnwEvYPi55irWWa1I2UJoJ8w
 MSIstn3dwdCbyNe0RdW25zZ3n+ioiJdTO0OAfZWfyQ1Nh46XhQ+2clQcFO2YHvCwcBPtANzGw3
 YZ41MJH2PkrZY/VpHQ613T8dU6guhY++qSatkT3vFAmKX9rgn/JMSX6Ku9zzbwbYH3VCMEcB35
 fJuJ83OBXUyIKdKWm9z3W1d5rQnedNAgubN9SnA+uP0xoa7YoOPCc1nsA949DzfxeJB5F+aja9
 f4G0Z5QzJ32OAwG/k5wBtsDK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:11:34 -0700
IronPort-SDR: brVc405QK/C0eePHnj0TNJxuln47DBCVeN9pszqIKJ+UgLhk0vvP9dFsD+HHAr4c7gX01W/9Ty
 jKEHuDfWveFs2gLliUg+UCzcgUcNq3AXsH/vNh5ACzN5B6uGyWacGd372OkvRbufyN/RBnQi90
 ry2ISQDaO3YJfCCzLnOuSUm0lxtDrGI2GzXjInnLPtDlyCQaofk3oc2mlhz2ddUQWui/iaHiQJ
 ZPfMyvmT61ZBpW2ltZ9bb2ccBZzK3zkrYLNLIHNQSrOZG1SqxUGe5H6/jK1J6gCi1eBWDPc8Nc
 jpA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:54:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcS1f5sJQz1Rwnx
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:54:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656989654; x=1659581655; bh=DgyUmRlHS/Rk0yqEUio5fJI7r/pAqiGKnmF
        yxkXId7g=; b=ssZPPrKfdI3B1LfXHffYuj+M/OzJTWGgAj+yXV7CgWBCe4Vd8QW
        NmimtYJGUb6NMvBmAhWOcPPLx5IdEN4g1sXCyrq8gdpejaspZRFr3UIDe6aV9zGj
        EnFmL+QLdrq1qgpe/SL1scm5nTRiM86IgDxHV7TcUp7Cd6bTdIB2ZmZxKNohIQQP
        6XE512Ms43V2EE+RVs1M0If4Mp7cB9Bzmn7KoxhyK15KeP4t7QXUEWfSaAsI22D3
        bZybmwOKVfX9aaqVVnWc9cdAggHv6GuFn5pUpklufGxO/5upoGeilNcuHtvyC5Yl
        HDFHCQuBOFHqxHlukt3K2L/0oQAO9qphoyw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6MplZV_hKdMh for <linux-block@vger.kernel.org>;
        Mon,  4 Jul 2022 19:54:14 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcS1d2xSKz1RtVk;
        Mon,  4 Jul 2022 19:54:13 -0700 (PDT)
Message-ID: <95cab434-b11c-fd49-5b4e-5e80b5850030@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:54:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 14/17] block: use bdev based helpers in blkdev_zone_mgmt /
 blkdev_zone_mgmt_all
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-15-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> Use the bdev based helpers instead of the queue based ones to clean up
> the code a bit and prepare for storing all zone related fields in
> struct gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-zoned.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 836b96ebfdc04..ee8752f083a94 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -190,8 +190,8 @@ int blkdev_zone_mgmt_all(struct block_device *bdev, unsigned int op,
>  			 gfp_t gfp_mask)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
> -	sector_t capacity = get_capacity(bdev->bd_disk);
> -	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +	sector_t capacity = bdev_nr_sectors(bdev);
> +	sector_t zone_sectors = bdev_zone_sectors(bdev);
>  	unsigned long *need_reset;
>  	struct bio *bio = NULL;
>  	sector_t sector = 0;
> @@ -262,8 +262,8 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  		     gfp_t gfp_mask)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
> -	sector_t zone_sectors = blk_queue_zone_sectors(q);
> -	sector_t capacity = get_capacity(bdev->bd_disk);
> +	sector_t zone_sectors = bdev_zone_sectors(bdev);
> +	sector_t capacity = bdev_nr_sectors(bdev);
>  	sector_t end_sector = sector + nr_sectors;
>  	struct bio *bio = NULL;
>  	int ret = 0;


-- 
Damien Le Moal
Western Digital Research
