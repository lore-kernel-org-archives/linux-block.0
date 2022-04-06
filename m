Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D65C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 13:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiDFNEl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiDFNDy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 09:03:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9002DF667
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 02:32:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r10so1909313eda.1
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=HPMmkcw3ad6froN4Uu8+fNEoD64IPnc5ZGiMrl26DPM=;
        b=fTpJjsBLJ/+L6EP7MX9IxjIh8OJGxonHiounyuu38lvEMIBMhAPvWT37Ne1LeByA3G
         af7pWhKfAU0bGt/HLhAb1mcrO7G6SXlZ9GksLDrjLrIhuPHpSE/DHn2cWpyhxmICNKmV
         AvqKGqvQgcj+WzHPGqzEabJbXRFjk2Rhw9p4evOhLkmhlSxsIB4xvv7bRglhTmhWtAyk
         VAOp2XIf8H6DDRAF5YFXaLcpD8KnsJGWrm23qMGnvj3XjVRx8PtSR9nhBYrHRCveBIhL
         m/rTRI/M1se+T1jh+c6P53VvM6n8Sth3KvZ2jHrKP/jEtEbn2FvOU7Rs59Pm3Q13ylP4
         mBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=HPMmkcw3ad6froN4Uu8+fNEoD64IPnc5ZGiMrl26DPM=;
        b=Ja1ibMt1IeK5toPlmYbfHVQkuRhtHwh6mGDqGUrm3oX141VbtUssu65j9kRUhQ3JVp
         rkg+ceK4uapOVohUI6JTAjEGPWwL1lhHLMlgdJLFqXLDI0B0t7Abdd84Ap2QF0SwcQFb
         RmOG7aObwqKN1lKCXAneou9N0qo2FYFqY/Brw2Tv4T9xJm+qhzqe+68PhBcyYXJKqzAY
         4QYJSlI+sSc5zYnyjG5ili0tQWn8d2fHdgJRAx/659zUVKpJKWepkkivZmPsCrAVHoL3
         nOUQuzGqOTDY8bt15hfXsUKJzJYogFQr3Duyr+bfzKMgbu/ceEzRI00yESlyOIudf+0y
         RV0w==
X-Gm-Message-State: AOAM532zK7u/NXEoF9dutPLyyanTSxJOogEGB5qF1/67H3yoAvl9boD0
        RdrXPOeyHHAoRGLMxZP1BAfVRg==
X-Google-Smtp-Source: ABdhPJxEZipVSp/jLRjgfkTXOza1SLmWA+gBYr7e8P6WbfE06/HkOUuOCsPtCg+3bkoBdxmqnQQMJg==
X-Received: by 2002:a50:a408:0:b0:41c:cdc7:88bd with SMTP id u8-20020a50a408000000b0041ccdc788bdmr7735003edb.399.1649237531719;
        Wed, 06 Apr 2022 02:32:11 -0700 (PDT)
Received: from [192.168.178.55] (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id n27-20020a1709062bdb00b006da975173bfsm6475424ejg.170.2022.04.06.02.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 02:32:11 -0700 (PDT)
Message-ID: <b6d79d64-dbea-4fbf-be91-d80bd3b9cd22@linbit.com>
Date:   Wed, 6 Apr 2022 11:32:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Drbd-dev] [PATCH 16/27] drbd: use bdev_alignment_offset instead
 of queue_alignment_offset
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-17-hch@lst.de>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406060516.409838-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 06.04.22 um 08:05 schrieb Christoph Hellwig:
> The bdev version does the right thing for partitions, so use that.
> 
> Fixes: 9104d31a759f ("drbd: introduce WRITE_SAME support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index d20d84ee7a88e..9d43aadde19ad 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -939,7 +939,7 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
>  		p->qlim->logical_block_size =
>  			cpu_to_be32(bdev_logical_block_size(bdev));
>  		p->qlim->alignment_offset =
> -			cpu_to_be32(queue_alignment_offset(q));
> +			cpu_to_be32(bdev_alignment_offset(bdev));
>  		p->qlim->io_min = cpu_to_be32(bdev_io_min(bdev));
>  		p->qlim->io_opt = cpu_to_be32(bdev_io_opt(bdev));
>  		p->qlim->discard_enabled = blk_queue_discard(q);

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
