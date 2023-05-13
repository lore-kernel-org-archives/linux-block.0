Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F56AC7EE2A
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 16:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjEMQwk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjEMQwj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 12:52:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6577A30C6
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 09:52:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-645c4a0079dso1531155b3a.1
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683996758; x=1686588758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhwLwTECiV1/entSMoRz9GUGcPg/2oAHETdHa2sY66c=;
        b=nLAUlfOViq4DUhb/u9Up/r0Z/Xno6UZmf4VCXFDGADL96tgYFAaSsXGrPPtfOE0juY
         yRhd2fwbdke3H39MQn0CnIFRBwgBS7Dq/G4FZhQ9r9T4XLDVYSlUPteePqXi93gB7arl
         dh7zjVe3uyOdTbcWxJhd7Ifif0yRc0mn8B3IMyBfhkqHY1ni7jqx5aqLtx74HYILxDHt
         p1Cg7H25V/17V9ATXU/QArQLxdyQb/xhjIPA6r4NWIxTGvzmpEYXBMJHE3nuG/N/zORU
         k4LA76Aec3juyS6plSG2p+APxzjpvsVBYz4FoxXbVZQGskIZz8/wUPMe0EdZEJ7ZAcZO
         F+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683996758; x=1686588758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhwLwTECiV1/entSMoRz9GUGcPg/2oAHETdHa2sY66c=;
        b=G0RzzjQRYfBNivhRhVB4GTXVzLsTrHZl19vmYILO38DwFaVMnTR0bIIMSlJQJwYQIl
         x5YAC7sJgVnF2WdLdXKZDG3Adc2Yt+b10nh8aBRmWXlULHNeWpZzGgGEak1vYCaQ+u1p
         65nIxDU35JFgGEYnaYdF9anOvB1NoRIcDOEna4DHplOSae89hE761lWoPv7amDg6aTvy
         SJm5DwLSuyTp3+u4hzmLxU6a8g9bmAmkimijHzuRJgc2Rq9ea6c4lXYlkt21hJtCsJ20
         pTxYE3PgKoak0KBAWYhEi4BaEMnFO3ZeWvxGx51sPbS86p9TeYDE6Lw0Vu5qv2Gy/eZe
         mvmw==
X-Gm-Message-State: AC+VfDx2K+W1RAr0NR2GBHOD7BuOOn8B26a6gc6KEgLKRLpEcXPZuOKa
        E4FXzHFsaN0bQqKyLQxz7lryjw==
X-Google-Smtp-Source: ACHHUZ5m7hR0zAceJJQ8HXs9bvju15JXUqYxEE0xigXem2ZL1C541twvCV0VQbs86r3ugzUR7VINTw==
X-Received: by 2002:a05:6a00:1d0e:b0:643:a903:f1b8 with SMTP id a14-20020a056a001d0e00b00643a903f1b8mr27052490pfx.1.1683996757822;
        Sat, 13 May 2023 09:52:37 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78058000000b00640d80c8a2bsm8883642pfm.50.2023.05.13.09.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 09:52:37 -0700 (PDT)
Message-ID: <28f559f9-3954-bdb9-8956-8a688aa62b0f@kernel.dk>
Date:   Sat, 13 May 2023 10:52:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Content-Language: en-US
To:     Tian Lan <tilan7663@gmail.com>, linux-block@vger.kernel.org
Cc:     Tian Lan <tian.lan@twosigma.com>
References: <20230513141234.8395-1-tilan7663@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230513141234.8395-1-tilan7663@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/23 8:12 AM, Tian Lan wrote:
> From: Tian Lan <tian.lan@twosigma.com>
> 
> The nr_active counter continues to increase over time which causes the
> blk_mq_get_tag to hang until the thread is rescheduled to a different
> core despite there are still tags available.
> 
> kernel-stack
> 
>   INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
>   Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:inboundIOReacto state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
>     Call Trace:
>     <TASK>
>     __schedule+0x351/0xa20
>     scheduler+0x5d/0xe0
>     io_schedule+0x42/0x70
>     blk_mq_get_tag+0x11a/0x2a0
>     ? dequeue_task_stop+0x70/0x70
>     __blk_mq_alloc_requests+0x191/0x2e0
> 
> kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
> __blk_mq_free_request being called.
> 
>   320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0 in-flight 1
>          b'__blk_mq_free_request+0x1 [kernel]'
>          b'bt_iter+0x50 [kernel]'
>          b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
>          b'blk_mq_timeout_work+0x7c [kernel]'
>          b'process_one_work+0x1c4 [kernel]'
>          b'worker_thread+0x4d [kernel]'
>          b'kthread+0xe6 [kernel]'
>          b'ret_from_fork+0x1f [kernel]'
> 
> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
> ---
>  block/blk-mq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9c8dc70020bc..5b374fab169c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1593,6 +1593,9 @@ void blk_mq_put_rq_ref(struct request *rq)
>  		if (rq->end_io(rq, 0) == RQ_END_IO_FREE)
>  			blk_mq_free_request(rq);
>  	} else if (req_ref_put_and_test(rq)) {
> +		if (rq->rq_flags & RQF_MQ_INFLIGHT)
> +			__blk_mq_dec_active_requests(rq->mq_hctx)
> +
>  		__blk_mq_free_request(rq);
>  	}
>  }

The fact that you didn't even compile this not withstanding, why
not just move the existing check from blk_mq_free_request() to
__blk_mq_free_request()?

-- 
Jens Axboe


