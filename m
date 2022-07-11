Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F33C433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Jul 2022 17:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiGKRUo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGKRUo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jul 2022 13:20:44 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAE812763
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 10:20:43 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so9006147pjr.4
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 10:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x4P9VeOPYLY9QFo86l4yvV2oTsVEIgH/Es/I3gcXiBY=;
        b=eKUSz5L4KPmINqNvhwNwTFjBIZVzL5Fwz7LSIlWtNtiwZNSl/3hSPNoR0eH9NPeUfE
         FHbV4gbJniK3s1X89n/MfVTvEWvcGUGsyoAklZJgqF/ZqeOPVDiNP0F3kZvYcRQCHVub
         R8Xwou4YrKfugRS6K3DjNXslmVz8/y8NiVg4zl9DzeKpJ6zxF0wpbHaXpKzeeFxqH3VT
         ESaQHUWm81SxH4tW1ShD/58cbmdMtOJKKUpFa8yVPjKZ1yh1jTTGcEl0xSwRBIabx1X7
         KlrzuLo4wU6IJ6dtREpsLn2Qyecf89cMYwF8xDmkA0HAGS68JxMJ8pOkIR0uZy/OpmtI
         4zZw==
X-Gm-Message-State: AJIora/S5fM/aZs3/XFkSsLPHd3Y4WRYG6Lni5A/DCcaA/PinCraNobl
        o8KKBgZLstNB0uK+n+LuR4MTJXMpDZ0=
X-Google-Smtp-Source: AGRyM1uK80yZ17f6r15tUkip2hZomPDy5X9esVJoiHxi54sU73/jnTRq87wwQeurB/eK22lqH8Yfew==
X-Received: by 2002:a17:90b:1e4f:b0:1ef:aa42:f196 with SMTP id pi15-20020a17090b1e4f00b001efaa42f196mr18428693pjb.228.1657560042711;
        Mon, 11 Jul 2022 10:20:42 -0700 (PDT)
Received: from [172.16.225.97] ([99.0.87.44])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b0016befcc142csm4987434ple.293.2022.07.11.10.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 10:20:41 -0700 (PDT)
Message-ID: <4c5f332f-ccd4-5d0e-14d4-bccf57bcd7cc@acm.org>
Date:   Mon, 11 Jul 2022 10:20:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] blk-mq: don't create hctx debugfs dir until
 q->debugfs_dir is created
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
References: <20220711090808.259682-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220711090808.259682-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/22 02:08, Ming Lei wrote:
> blk_mq_debugfs_register_hctx() can be called by blk_mq_update_nr_hw_queues
> when gendisk isn't added yet, such as nvme tcp.
> 
> Fixes the warning of 'debugfs: Directory 'hctx0' with parent '/' already present!'
> which can be observed reliably when running blktests nvme/005.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index b80fae7ab1d9..28adb01f6441 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -728,6 +728,9 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
>   	char name[20];
>   	int i;
>   
> +	if (!q->debugfs_dir)
> +		return;
> +
>   	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
>   	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
>   

Does this patch need a Fixes: tag?

Additionally, as one can see here, I reported this bug before Yi: 
https://bugzilla.kernel.org/show_bug.cgi?id=216191

Thanks,

Bart.
