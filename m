Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A50DC433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 13:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiDFN5Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiDFN5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 09:57:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837262173AC
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 02:09:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so2867325ejd.9
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wB8UMmxJgv5LvDfeLDltY32XYTo3n5XcwQ+iaIyF/Og=;
        b=WXm7syME4XdRB4NJGS4GQb5Ax36M1AlMT49VPwWxN+ZXxTMx8CRhOYeB0lRJxT8brq
         pnkxL/5FhxWQg3xeUJYqtDY/m6WYSw7oYJceeeULLalxUjm3+cdBAn+ui7mqF9rRTXuL
         2k3SJhuFtj1UuevWdUM1LjH45bWzsVou59a8PfuTsFMZxK2cf91uLo3colj2PfNfMziH
         ManeoUZnjK/m9d7Z26M1Cl9KC1T1c2D+u4BYg+n4nlmQbK7hkCXTZodRbAOqWrU6yOMN
         W4uV+4q5icDeOh9eWCFiomSibo6GEPqr0Q0J2pmoyDtgUdEckwuGzu6W4VQJZdtpI4dW
         oDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wB8UMmxJgv5LvDfeLDltY32XYTo3n5XcwQ+iaIyF/Og=;
        b=coOYrnAqqRgWEBeqY04TYaRE7aPUNEYLVcBBskHuN1HBfv3pzgS/4hS6FMH1e1CTIf
         ykh31mVBz9qisS+4BWNrRqEhM/NkIzx6cFaFXssm8H3M6WPdEDPElTt77B1MG/A5xa64
         zBlqMo9vD53Og0f29ZuchfJ7Eeq23I3ZeDUlMn5AspkELn9sQ+zMq3QlrnNg10gw1wfn
         05xCOBR6SvQsUHlRGBAH88Ef1ZyNZWVLo/S0riucBrMAQxc/o6qGBJlwFty8P24ll2q0
         CkD/+qaTRyV9mNd+9rRonhIiBWGXcGVi5GzqobFI8cCz1oUxXYz0fjA2NL8Xo//ZpC/a
         oQdA==
X-Gm-Message-State: AOAM532rGOQwj9BzpETqLrlqIsEheB+f3YdkX67xExoDcOcuNLxMsrke
        n2GrxrNzb8AZ+YvGbNOpX/zW7Wff4CqKc129pME=
X-Google-Smtp-Source: ABdhPJyIdk1UwYDrlq6+n4T7hvAK7lZsJilf9jybv8rdA9wBUUKHTLlxaOsDN5nk9M5bR3LdK0kbsQ==
X-Received: by 2002:a17:906:8301:b0:6e4:896d:59b1 with SMTP id j1-20020a170906830100b006e4896d59b1mr7152842ejx.396.1649236165020;
        Wed, 06 Apr 2022 02:09:25 -0700 (PDT)
Received: from [192.168.178.55] (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090679c300b006cf9ce53354sm6352697ejo.190.2022.04.06.02.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 02:09:24 -0700 (PDT)
Message-ID: <d2626d2f-d348-49a1-e36b-a3eb598ac327@linbit.com>
Date:   Wed, 6 Apr 2022 11:09:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Drbd-dev] [PATCH 04/27] drbd: remove assign_p_sizes_qlim
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-5-hch@lst.de>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406060516.409838-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 06.04.22 um 08:04 schrieb Christoph Hellwig:
> Fold each branch into its only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_main.c | 50 ++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 9676a1d214bc5..74b1b2424efff 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -903,31 +903,6 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
>  	}
>  }
>  
> -/* communicated if (agreed_features & DRBD_FF_WSAME) */
> -static void
> -assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p,
> -					struct request_queue *q)
> -{
> -	if (q) {
> -		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
> -		p->qlim->logical_block_size = cpu_to_be32(queue_logical_block_size(q));
> -		p->qlim->alignment_offset = cpu_to_be32(queue_alignment_offset(q));
> -		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> -		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> -		p->qlim->discard_enabled = blk_queue_discard(q);
> -		p->qlim->write_same_capable = 0;
> -	} else {
> -		q = device->rq_queue;
> -		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
> -		p->qlim->logical_block_size = cpu_to_be32(queue_logical_block_size(q));
> -		p->qlim->alignment_offset = 0;
> -		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> -		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> -		p->qlim->discard_enabled = 0;
> -		p->qlim->write_same_capable = 0;
> -	}
> -}
> -
>  int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enum dds_flags flags)
>  {
>  	struct drbd_device *device = peer_device->device;
> @@ -957,14 +932,35 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
>  		q_order_type = drbd_queue_order_type(device);
>  		max_bio_size = queue_max_hw_sectors(q) << 9;
>  		max_bio_size = min(max_bio_size, DRBD_MAX_BIO_SIZE);
> -		assign_p_sizes_qlim(device, p, q);
> +		p->qlim->physical_block_size =
> +			cpu_to_be32(queue_physical_block_size(q));
> +		p->qlim->logical_block_size =
> +			cpu_to_be32(queue_logical_block_size(q));
> +		p->qlim->alignment_offset =
> +			cpu_to_be32(queue_alignment_offset(q));
> +		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> +		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> +		p->qlim->discard_enabled = blk_queue_discard(q);
> +		p->qlim->write_same_capable =
> +			!!q->limits.max_write_same_sectors;

queue_limits.max_write_same_sectors was removed in 73bd66d9c834, so this
does not compile. It's removed in the next patch, so the big picture is
fine, just this one commit is broken.

>  		put_ldev(device);
>  	} else {
> +		struct request_queue *q = device->rq_queue;
> +
> +		p->qlim->physical_block_size =
> +			cpu_to_be32(queue_physical_block_size(q));
> +		p->qlim->logical_block_size =
> +			cpu_to_be32(queue_logical_block_size(q));
> +		p->qlim->alignment_offset = 0;
> +		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> +		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> +		p->qlim->discard_enabled = 0;
> +		p->qlim->write_same_capable = 0;
> +
>  		d_size = 0;
>  		u_size = 0;
>  		q_order_type = QUEUE_ORDERED_NONE;
>  		max_bio_size = DRBD_MAX_BIO_SIZE; /* ... multiple BIOs per peer_request */
> -		assign_p_sizes_qlim(device, p, NULL);
>  	}
>  
>  	if (peer_device->connection->agreed_pro_version <= 94)
