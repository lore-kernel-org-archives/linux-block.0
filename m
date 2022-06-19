Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F877C43334
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 23:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiFSX3E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 19:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiFSX3D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 19:29:03 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCAA64E8
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655681343; x=1687217343;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=R77Z1INZbgegEybw3H9mfdkXN5pI6YjTvkHpvWXBTVc=;
  b=XOty2/6GhV8/4fAbVdew5JJFPIhVyJx4Acprzs26j2G+tjyMuXDuupCb
   xCCRLl1c/w+JqzMnPszFihK+0N9iuZAw6BBnxcVt6sdfDb4E6yMQvTgcv
   1jNQUfE0u4S8IQNy3TgImV+XdXh6v+q4UUKNpOa4ZI8kVE4Lu8nqxuaYN
   Nbb8AHy8Jesu8Pe36Ps2atqgAH1LRhne4iPAoRNPNGImQHyz7SmI4KMKR
   SSXr/1Qw/STv+DVpeJZB7g9lDo6RZtyffRqkFnhp5iT1V8DT7tX4Uztjv
   J0Q6v6cRxB/W5CY7viCnyslVDPQGlNzFIRfZGqBz+4wnacOhTGZLPm7iH
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307888062"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 07:29:02 +0800
IronPort-SDR: cp1a9WghzJ9BNDIDjTomOXlFB1OtSLSmjNvZLFWnFz5vs3MMM81Tf9pZ2GowT/+8e+Sg2KZqmO
 acLErEgDbSEgVwwg0Zv5BMLABUPxG0suR7Zt8jnmJrH9i8YpU6aCKbk63gTgrvrNewW3x/wekz
 7iNvhxey85k6Wvia6ScuB96y2frxMCpSsWK8u0Orn50W5qUWYWhaDhLH/+8vAw6NpSzDZik2kq
 zXeUtZLVwkvJRXNRTC51xT2opPmuJPm2+fCQ4edL+4tCyinJ8u7UJn60GM94XZH6p6JgZA6/D7
 Zd+PEN69v1cgrVpUPuj1gAQv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 15:51:34 -0700
IronPort-SDR: +xbI54FSXw+yd/ii38ZbaZBaRz9VlE4mj+UA/GcDPQZPu0+m2yQfNaajJ4Qp1CEdyESfcY3g2p
 L34NstDrS3WAJyVNZjAQh0GCZtGPS6PWBIBul9VtSViQr4gw7dXop6BqmhJrcpL+ZvfYgi+3d/
 o1WF4kwQl8kFCQvH+j6xKgr+dVdh1HtIFxWi3MriN6j9ttGPGnm7mX9ja+qIDQoEfRUaT1BbLn
 ZeR8xzxytQ8D3g0QkzxBngZG4xaJXkXn8/YjQQgfmMe3C40o3ljICbuE1eclKieEnuJ+aH018n
 qr0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 16:29:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LR89p3Gryz1Rwrw
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 16:29:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655681342; x=1658273343; bh=R77Z1INZbgegEybw3H9mfdkXN5pI6YjTvkH
        pvWXBTVc=; b=sLkMVGVkTbFwkYvlwPE5IySgpcqpoKaOqgWAiwusIH/8dAhPTyo
        CQ3Rq8hH/ymofKm+33wmMUYJlAsM9gQkR0MNkPgXfvq7ZO8ff1TyiRWlSYN3J0Tn
        UOXaNnpzzTkcogslewGh/R0eX5Ogp9FtfsRbYIl+HiUSdk8qiLEMtrFs2tXq/4KR
        VuKm/5fEjzz5DptFvoED0eNTPN3ht4r/doJJEE5IDrCWfR5pnHn4vuwT911YLC2U
        pU1a6lX+5m9cf8UGK2NRlK4N+BFeQvOr7qCM0nM581zskaafG1MI2BC4pjPc0Nfv
        WYK0S0KHgOaUscp90G5XAphfRJqC9Zmc+cA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZbUbMUAwHDcf for <linux-block@vger.kernel.org>;
        Sun, 19 Jun 2022 16:29:02 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LR89n35fZz1Rvlc;
        Sun, 19 Jun 2022 16:29:01 -0700 (PDT)
Message-ID: <3680d9fd-7543-7eba-6da4-04b92e49a45d@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 08:29:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] block: remove queue from struct
 blk_independent_access_range
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220603053529.76405-1-damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220603053529.76405-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/3/22 14:35, Damien Le Moal wrote:
> The request queue pointer in struct blk_independent_access_range is
> unused. Remove it.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Jens,

Ping ?

This now can have also:

Fixes: 41e46b3c2aa2 ("block: Fix potential deadlock in
blk_ia_range_sysfs_show()")

> ---
>  block/blk-ia-ranges.c  | 1 -
>  include/linux/blkdev.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
> index 56ed48d2954e..47c89e65b57f 100644
> --- a/block/blk-ia-ranges.c
> +++ b/block/blk-ia-ranges.c
> @@ -144,7 +144,6 @@ int disk_register_independent_access_ranges(struct gendisk *disk,
>  	}
>  
>  	for (i = 0; i < iars->nr_ia_ranges; i++) {
> -		iars->ia_range[i].queue = q;
>  		ret = kobject_init_and_add(&iars->ia_range[i].kobj,
>  					   &blk_ia_range_ktype, &iars->kobj,
>  					   "%d", i);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1b24c1fb3bb1..62633619146e 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -341,7 +341,6 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
>   */
>  struct blk_independent_access_range {
>  	struct kobject		kobj;
> -	struct request_queue	*queue;
>  	sector_t		sector;
>  	sector_t		nr_sectors;
>  };


-- 
Damien Le Moal
Western Digital Research
