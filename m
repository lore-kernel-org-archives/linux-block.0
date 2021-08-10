Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9B0C4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 03:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B2E60FE6
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 03:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhHJDF7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 23:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233892AbhHJDF6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Aug 2021 23:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628564736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNAD9HvPLL20RnA7Fm9EynMKwbGxKPvS4YW5JmvO4X8=;
        b=aTQKRcVlu3h39rfRnxSo4jghn3CBn34dqIhm7nWrTAGhY77OTE0TjVmyfPIlsXA2Y8qWIt
        p2dQMA1nfrYbeJXq4ivrfBEsX9vHiBg0op/bXQkfWniclK2RKh+y/V3PZ7GS0Hkj163X7k
        gJjMn2X91iJ9Go+wnQLjd1ZgVdG0vxc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-sUzF0DMLP5OaC_AhTZhkiQ-1; Mon, 09 Aug 2021 23:05:35 -0400
X-MC-Unique: sUzF0DMLP5OaC_AhTZhkiQ-1
Received: by mail-pl1-f198.google.com with SMTP id z1-20020a1709030181b029012c775d35e1so9536712plg.20
        for <linux-block@vger.kernel.org>; Mon, 09 Aug 2021 20:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FNAD9HvPLL20RnA7Fm9EynMKwbGxKPvS4YW5JmvO4X8=;
        b=VgIJPcs2eskhscoNO0XPIzeQukRDq9fvdl9p6JAt0n++Xg55iGI7PPMILbP9YlGG6S
         wLrvkhVNlq6ce0nKbIHE53d8y5naqnr/ixHlZb0ADOoCy3JP7RL8HL1DWluGwxOhGrtP
         3RAF1Nr+jV5YgtnWkpcE0sDVClCgrFbtVuu9XLuTvINLAuxuMijkULywP6N1dlF2oj1w
         YEjc+Q7Byeg1BcitqjUNepEtBZJTWgNOlspTRPIPpOM72yPFLEHGeV9UrdbpwB5loYJk
         vbBRlatYXzpler4bT3xXPfTODBMig+nJLLNVOtxCm8eoY/m5aUejKzSwaMWY1oK0LvNp
         fLzQ==
X-Gm-Message-State: AOAM532VtRtDfNFDS+VsCiQs3oH9EV1JaA9OcC+KKkGrp1jT+h0j9ou8
        ci1oiSPLDFy9zQoa6Qzv0fbtxM7NoYpNRV4nDma4LuLYytMRyxuEwENWBui61TxsMh9oGuOtefO
        X4gxamy/KJ9qXXnCyWj3VO4w=
X-Received: by 2002:a63:2585:: with SMTP id l127mr303525pgl.318.1628564734408;
        Mon, 09 Aug 2021 20:05:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXfNDEqGz8UY7V4AUjb+V6s581Q/QII16jDbubwX4LuBoC0RVi6HBrqCF4aijatpedgi9vtg==
X-Received: by 2002:a63:2585:: with SMTP id l127mr303496pgl.318.1628564734150;
        Mon, 09 Aug 2021 20:05:34 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s5sm16264880pji.56.2021.08.09.20.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 20:05:33 -0700 (PDT)
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210809101609.148-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <08366773-76b5-be73-7e32-d9ce6f6799bf@redhat.com>
Date:   Tue, 10 Aug 2021 11:05:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809101609.148-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


ÔÚ 2021/8/9 ÏÂÎç6:16, Xie Yongji Ð´µÀ:
> An untrusted device might presents an invalid block size
> in configuration space. This tries to add validation for it
> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> feature bit if the value is out of the supported range.
>
> And we also double check the value in virtblk_probe() in
> case that it's changed after the validation.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4b49df2dfd23..afb37aac09e8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
>   static unsigned int virtblk_queue_depth;
>   module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>   
> +static int virtblk_validate(struct virtio_device *vdev)
> +{
> +	u32 blk_size;
> +
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> +		return 0;
> +
> +	blk_size = virtio_cread32(vdev,
> +			offsetof(struct virtio_blk_config, blk_size));
> +
> +	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> +		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);


I wonder if it's better to just fail here as what we did for probe().

Thanks


> +
> +	return 0;
> +}
> +
>   static int virtblk_probe(struct virtio_device *vdev)
>   {
>   	struct virtio_blk *vblk;
> @@ -703,12 +725,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	u8 physical_block_exp, alignment_offset;
>   	unsigned int queue_depth;
>   
> -	if (!vdev->config->get) {
> -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -			__func__);
> -		return -EINVAL;
> -	}
> -
>   	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
>   			     GFP_KERNEL);
>   	if (err < 0)
> @@ -823,6 +839,14 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	else
>   		blk_size = queue_logical_block_size(q);
>   
> +	if (unlikely(blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)) {
> +		dev_err(&vdev->dev,
> +			"block size is changed unexpectedly, now is %u\n",
> +			blk_size);
> +		err = -EINVAL;
> +		goto err_cleanup_disk;
> +	}
> +
>   	/* Use topology information if available */
>   	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
>   				   struct virtio_blk_config, physical_block_exp,
> @@ -881,6 +905,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>   	return 0;
>   
> +err_cleanup_disk:
> +	blk_cleanup_disk(vblk->disk);
>   out_free_tags:
>   	blk_mq_free_tag_set(&vblk->tag_set);
>   out_free_vq:
> @@ -983,6 +1009,7 @@ static struct virtio_driver virtio_blk = {
>   	.driver.name			= KBUILD_MODNAME,
>   	.driver.owner			= THIS_MODULE,
>   	.id_table			= id_table,
> +	.validate			= virtblk_validate,
>   	.probe				= virtblk_probe,
>   	.remove				= virtblk_remove,
>   	.config_changed			= virtblk_config_changed,

