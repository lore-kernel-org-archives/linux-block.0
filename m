Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CAEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 15:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjFUPvC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjFUPvB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 11:51:01 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7CEC3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 08:50:59 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1b512309d18so31707445ad.3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 08:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362659; x=1689954659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFzHtRz8FzfXXhOIzDAbSHLVbmii7TwVMd57YZVhgw4=;
        b=K1/Ytcf5Cobfhp7fcwS8fNZ1Bu5dgvM6B/7KZFqJvEQURI+W7Z3tZG/aMdByNAv2TB
         68MOqTLd8hsPru1L5Zr0YLANVKshsUSYCDsyWZcSeANd9oiBiOUnQNEmbuM2aBvehBGy
         QfJQdY3fwOJCslLzGLrquGRAxiFydLMTM3tcT2c4NeEk+20i4i0MKxDOv7egKeeH7C0+
         1kiPxNeL3+A5UMI5VSkJn733u8ufF8U2ivSzydFObvgJZZZeAqDCJFsSQHAFSIZB5q4t
         oa/VcQ1nlIrmMH00jLlrUFoyl1TKQE1+38DBwwq0pjGr5KuoKtq8kfZfTerWe7uYQi5i
         Pz2g==
X-Gm-Message-State: AC+VfDzw6BnKws8TeGVuJmzb1IV/oC1PPa1l0x4KbRUh61wmbpGK68ab
        o7N6x/ep9LJjXkKIxcbtxni1tlpMAXI=
X-Google-Smtp-Source: ACHHUZ78ISuhCa5OHossELhMAcIf+GHDnVdfN55mgzLjW9wsP95DyV6xeojYSwXIhq2cJS1GtVdlag==
X-Received: by 2002:a17:903:190:b0:1b1:9968:53be with SMTP id z16-20020a170903019000b001b1996853bemr10898647plg.64.1687362658668;
        Wed, 21 Jun 2023 08:50:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9bb2:be1e:34e3:7c45? ([2620:15c:211:201:9bb2:be1e:34e3:7c45])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090274cc00b001b211283294sm3704934plt.163.2023.06.21.08.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 08:50:58 -0700 (PDT)
Message-ID: <feeee82b-56da-061a-2ac0-9fcfbc4ccda2@acm.org>
Date:   Wed, 21 Jun 2023 08:50:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] blk-mq: don't insert passthrough request into sw queue
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>
References: <20230621132208.1142318-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230621132208.1142318-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/23 06:22, Ming Lei wrote:
>   	percpu_ref_get(&this_hctx->queue->q_usage_counter);
>   	/* passthrough requests should never be issued to the I/O scheduler */
> -	if (this_hctx->queue->elevator && !is_passthrough) {
> +	if (is_passthrough) {
> +		spin_lock(&this_hctx->lock);
> +		list_splice_tail_init(&list, &this_hctx->dispatch);
> +		spin_unlock(&this_hctx->lock);
> +		blk_mq_run_hw_queue(this_hctx, from_sched);
> +	} else if (this_hctx->queue->elevator) {
>   		this_hctx->queue->elevator->type->ops.insert_requests(this_hctx,
>   				&list, 0);
>   		blk_mq_run_hw_queue(this_hctx, from_sched);

The code change in this patch looks fine to me. However, with this patch 
applied the code and the source code comment just above the modified are 
now out of sync :-(

Bart.
