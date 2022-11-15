Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D28C4332F
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 02:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKOCUk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 21:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKOCUi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 21:20:38 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F2CE22
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 18:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668478836; x=1700014836;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BGpQIhDsc1KecL0l6tDYRdmVJ56XqWOiTYUKSZ/7hus=;
  b=JmfmX39kixHOidCmIF1H1ERKR+rykpKEN01adKxK0yQS1m5R9dJdKZkk
   b6ZL3SWgDJZo0lp7ofnZDZT2m0pI2pcBqGX+W9xJQ9LWVlbh50/EscLzy
   xjZa3sC6wGMbbgoYI0M13POgDd+L2VdHOVcm8vqyJuP/NDtIEv4cXa3xd
   TdLmnPYxi8Q3EQ2st6+ahxihvSoDIB2xYQEInkO3LOP4LSHZfq/Jp34GP
   r15NyIwNU/DeAZ7yafHwdQ3eLWraHTLQnCOjvMHEdk50MagxWYJciYi/X
   zvbjdlHXKoKxfXkYGGhELxbbI1/0tXOF+8JuKibWPjJvl1Ngl/khoNsah
   g==;
X-IronPort-AV: E=Sophos;i="5.96,164,1665417600"; 
   d="scan'208";a="216274025"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 10:20:35 +0800
IronPort-SDR: eW6ZgIYITsSNKgGuwpf1qXrrGNKcFr/EVVMGu1eQ6/gNi9T0W0dmocL8dcG3zNeijt4FK4lWaF
 urgGXRa+wxYRBpLG5UOFUgzQS05sKSJtWIahr0QwU5vuuK/4cEpskMCl+1aG0jG9bjZJDpWMGU
 4MN8c/iQGx9OBK1R6mLr/mbJFghi50+pZWFfXA+sqst6d98oPe8ZygLfV3YqVCdk0BsmeLsVRB
 hUYRHOzriDN2iQjyfjO3jM/iJ81s/z8lkSCaqAfp4JSSJjRGEa/WUlfM/08rEO8rkZ7M8w/yWk
 pz8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 17:33:49 -0800
IronPort-SDR: 9dISre6XxMzXGmjneNmH+/5i9gDDQftKhaqHU0CVqSTQCjo08KU2Hhvwo/0IJ5zWwz37+Q+dNC
 2A16ZO3aCiL7Ms0YMUBfmh9kbvPVulNT8j9yOjKm5y+dSKxSLKi3nV3yHMJoybDZcLkaMKTnZm
 vKY+RnYHWiMw2dOZbIu4HTORlW/oF2uU31mpNBIB3sIDX699fg3ImU7tXaMyfhudK5xpPlQRnV
 nUaHEVWRGwor8cTOsqZWzq0kpbQd4mlnNXxuFbTD82Tjm5nW41LeLwNnmHubHI8OpQbkGnW8kG
 hjQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 18:20:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NB8zR3TWZz1RvTr
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 18:20:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668478834; x=1671070835; bh=BGpQIhDsc1KecL0l6tDYRdmVJ56XqWOiTYU
        KSZ/7hus=; b=Ku67P/EuwxnOiWTDZtBm1rImv/FySlKnkHTmcsfZ43Lh3HUqV2Y
        HZiGxoaQoNb+/7PkpXL1rnsq5PlCs+gFzrovybwkVQO5H9LgN0SdyktKkN+lBECk
        CRKTZKav/ulKcMF9O6DiPAxtLSmfRCr/SKIArjRDclcD0t0Fcpt3EOeSNTTTGfhQ
        ucKbgOU2P1328T+v7rUwADG/dnyHXCGmUN/23Oe4DEpqlfOhXpMkO9b5/Z2I3Pj1
        KnaCePwD4WEKT2uefiSdxGwlcPYeXbkk67sqKDs0T6B8mFOs4c+Lv2VwyYxlaDW7
        fP4xmDbZBuKTOTpHgXfrOfsntK3ZRSXrNqw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QHGjTfQLn-jo for <linux-block@vger.kernel.org>;
        Mon, 14 Nov 2022 18:20:34 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NB8zQ1k1Zz1RvLy;
        Mon, 14 Nov 2022 18:20:34 -0800 (PST)
Message-ID: <1abd54f0-cb49-05d5-46ee-c8b3586545be@opensource.wdc.com>
Date:   Tue, 15 Nov 2022 11:20:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH V2] null-blk: allow REQ_OP_ZONE_RESET_ALL to configure
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, vincent.fu@samsung.com
References: <20221115011039.5365-1-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221115011039.5365-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/22 10:10, Chaitanya Kulkarni wrote:
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
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> v1-v2:-
> 
> Add configfs parameter to set the zone reset all.
> 
> ---
>  drivers/block/null_blk/main.c     | 7 +++++++
>  drivers/block/null_blk/null_blk.h | 1 +
>  drivers/block/null_blk/zoned.c    | 3 ++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 8b7f42024f14..995449919d5e 100644
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

I think you forgot to list this new parameter in
memb_group_features_show(), no ?

>  	&nullb_device_attr_virt_boundary,
>  	&nullb_device_attr_no_sched,
>  	&nullb_device_attr_shared_tag_bitmap,
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

