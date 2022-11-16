Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147F3C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 01:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiKPB7r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Nov 2022 20:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiKPB7k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 20:59:40 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B8C2B611
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 17:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668563979; x=1700099979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FDV8pNoSSaddeGfIOabHZ5QOpezKkOpbjEAOtTSfJ6Q=;
  b=e7wzKCd1JMDpd2jxjyd05+nixLxDKWuaX8RoEYkXJNqrgy1bIfooUthB
   n9OwB1ETLylew2nNf6qCdpCQtXYAQ6+pP2dR1OLn5yqLnXsWhN+bTucro
   gblJtaqFIZNAOKby77LYeGp+LlHbKdliX4uUpLKTtbUYXde1SCzBZF/HL
   fri37JzUYu3o11Ez06Q02e/hW2QSjquPzcEzpNejTSq08mfPcZ4t6GH6S
   HLHCA+wM+WgdJV9wmVu8QgldaR3mDAZA8360zXO/6JRl/i1qSgbrcSWXN
   5WuW78wKhGq5qLLertj4XazVEOkZ8vLUV9FBsENwxayr86aqLZrN5QFew
   A==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665417600"; 
   d="scan'208";a="320711339"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2022 09:59:38 +0800
IronPort-SDR: E5hmKltExF8jGHMMxIAYmbWcU+EFH4LZEk9h0yJVkEBEElaDfE+bYRsPW62EZQ7PgpOf9z5TJm
 ZrjNSGYtWqEyIz07+I0w0c5Jfcjr9sxOGoGbt2bufMfpqAYLXXdh8sQZnoE3Rt9HY7a8GqF8Og
 1aVYhicZ9pbdBV05OmYgNhXobQ5XTSB2ZdRWmfSXYjiHyMG4PANCfCD2RKYv0QkPbHirNgrgs7
 rOebENa9B4lIcTMpi6yCjWom/p4U38g1gSIucMzkCY+CaUzMMEeKTGGLQ13JpGSjpXoO0FiSn2
 0Rg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2022 17:12:50 -0800
IronPort-SDR: OtWrKfozcFpRL01iBjHegTE26UkqXrraBtalxaIWexuH9WtGU5xhEz/gl7NiRDGAFA/mQGGeDV
 HJ9ziDmHwZkLxM11BllyJaix5aTpwjNJoeTwtN89b8ttSLM517vns0OyFyamvviKU6+rxF8lpa
 AcY5Oe1Wubum6uT+6sK2SrOGFEmfxxklJ6gZsxAIjyCs+sLHQL8DXAIHQwazxlpBsgvxBegwVs
 YogXs9TvKskDtr1Sp8oKUY6TTZJqz9r+wX7GjIXZZb3m+mvv1grg450tFXaIVO29vfwyYdRnU8
 XBc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2022 17:59:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NBmSp3GLWz1Rwrq
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 17:59:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668563977; x=1671155978; bh=FDV8pNoSSaddeGfIOabHZ5QOpezKkOpbjEA
        OtTSfJ6Q=; b=BZCE3Yc18trav7exrpu5nFyhpZVTBV2GV2nkQRvmiY+n8Iq6dKI
        JJOp8t3Tcdm6GL06DRWel6tzOf2h0AT0n0SkC2cNG/oxlofZXdVNF3TrkKDCpiDU
        1GRBqmLdMrZggqgxGtXlAhqg1kgbjAVPjlEuIdmxLS3Zt43cwKEI+ZacGG4CYMMp
        QRppBcXqcafk4lM5qyel4XAylEav7dtTKPyVh1QGxb9ia3okn252fyff5YuUfMc4
        9zR+pog97rN1E3l14IqWVI3xVluT9/2MLthvquQiWcQEVzIopNwm4UHmM4g+0Cia
        sxObDuCqYCRkpTliVFIpGdbubA8B/iZ9WXw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id II0SxQaJwbVD for <linux-block@vger.kernel.org>;
        Tue, 15 Nov 2022 17:59:37 -0800 (PST)
Received: from [10.89.82.19] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.19])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NBmSn1SJDz1RvLy;
        Tue, 15 Nov 2022 17:59:37 -0800 (PST)
Message-ID: <ee9d908b-6516-77ce-65fc-6d45042aafa3@opensource.wdc.com>
Date:   Wed, 16 Nov 2022 10:59:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH V3] null-blk: allow REQ_OP_ZONE_RESET_ALL to configure
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, vincent.fu@samsung.com
References: <20221115034834.44142-1-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221115034834.44142-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/11/15 12:48, Chaitanya Kulkarni wrote:
> For a Zoned Block Device zone reset all is emulated if underlaying
> device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
> Zoned mode there is no way to test zone reset all emulation present in
> the block layer since we enable it by default :-
> 
> blkdev_zone_mgmt()
>  blkdev_zone_reset_all_emulation() <---
>  blkdev_zone_reset_all()
> 
> Add a module parameter zone_reset_all to enable or disable
> REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
> behaviour.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> v2->v3:-
> 
> Update the string in memb_group_features_show() with zone_reset_all.
> 
> v1->v2:-
> 
> Add configfs parameter to set the zone reset all.
> 
>  drivers/block/null_blk/main.c     | 9 ++++++++-
>  drivers/block/null_blk/null_blk.h | 1 +
>  drivers/block/null_blk/zoned.c    | 3 ++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 8b7f42024f14..5dc69f42b46c 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -260,6 +260,10 @@ static unsigned int g_zone_max_active;
>  module_param_named(zone_max_active, g_zone_max_active, uint, 0444);
>  MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when block device is zoned. Default: 0 (no limit)");
>  
> +static bool g_zone_reset_all = true;
> +module_param_named(zone_reset_all, g_zone_reset_all, bool, 0444);
> +MODULE_PARM_DESC(zone_reset_all, "Allow REQ_OP_ZONE_RESET_ALL. Default: true");
> +
>  static struct nullb_device *null_alloc_dev(void);
>  static void null_free_dev(struct nullb_device *dev);
>  static void null_del_dev(struct nullb *nullb);
> @@ -446,6 +450,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
>  NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
>  NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
>  NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
> +NULLB_DEVICE_ATTR(zone_reset_all, bool, NULL);
>  NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
>  NULLB_DEVICE_ATTR(no_sched, bool, NULL);
>  NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
> @@ -574,6 +579,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>  	&nullb_device_attr_zone_nr_conv,
>  	&nullb_device_attr_zone_max_open,
>  	&nullb_device_attr_zone_max_active,
> +	&nullb_device_attr_zone_reset_all,
>  	&nullb_device_attr_virt_boundary,
>  	&nullb_device_attr_no_sched,
>  	&nullb_device_attr_shared_tag_bitmap,
> @@ -639,7 +645,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
>  			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
>  			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
>  			"zone_capacity,zone_max_active,zone_max_open,"
> -			"zone_nr_conv,zone_size,write_zeroes\n");
> +			"zone_nr_conv,zone_size,zone_reset_all,write_zeroes\n");

Looks like this patch goes on top of your other series for write zereos, no ?
As is, it does no apply to current Linus tree nor to Jens for-6.2/block branch.

Anyway, with that problem sorted, it looks ok to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


>  }
>  
>  CONFIGFS_ATTR_RO(memb_group_, features);
> @@ -715,6 +721,7 @@ static struct nullb_device *null_alloc_dev(void)
>  	dev->zone_nr_conv = g_zone_nr_conv;
>  	dev->zone_max_open = g_zone_max_open;
>  	dev->zone_max_active = g_zone_max_active;
> +	dev->zone_reset_all = g_zone_reset_all;
>  	dev->virt_boundary = g_virt_boundary;
>  	dev->no_sched = g_no_sched;
>  	dev->shared_tag_bitmap = g_shared_tag_bitmap;
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index e692c2a7369e..e7efe8de4ebf 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -115,6 +115,7 @@ struct nullb_device {
>  	bool discard; /* if support discard */
>  	bool write_zeroes; /* if support write_zeroes */
>  	bool zoned; /* if device is zoned */
> +	bool zone_reset_all; /* if support REQ_OP_ZONE_RESET_ALL */
>  	bool virt_boundary; /* virtual boundary on/off for the device */
>  	bool no_sched; /* no IO scheduler for the device */
>  	bool shared_tag_bitmap; /* use hostwide shared tags */
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 55a69e48ef8b..7310d1c3f9ec 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -160,7 +160,8 @@ int null_register_zoned_dev(struct nullb *nullb)
>  	struct request_queue *q = nullb->q;
>  
>  	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
> -	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> +	if (dev->zone_reset_all)
> +		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>  
>  	if (queue_is_mq(q)) {

-- 
Damien Le Moal
Western Digital Research

