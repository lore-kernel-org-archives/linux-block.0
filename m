Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A1BC433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 03:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353BA64EB2
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 03:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhCADuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Feb 2021 22:50:35 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:44115 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhCADue (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 22:50:34 -0500
Received: by mail-pl1-f172.google.com with SMTP id a24so9021138plm.11
        for <linux-block@vger.kernel.org>; Sun, 28 Feb 2021 19:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yMWVVjFkCg6xvNlRsf6sBEmdPdTbzAhLRqkuZIGa2jg=;
        b=rtbbvVTX43F94cKdx74Ks1rYlozHkjkf9ZdLIkP27qbUaOYpW7/jCHyuWdL087lgRC
         JxCaSuZGLmOaxpIcKgw1oFH3lw2RW2gr4bRO3IL1GmOEjk+pQR3jYxr0eXH1yoLfByDA
         dR6dvkiXhZnGncx7Razl6sxB7xMUKjKkY4jC7vpMRnq9Cspx/bZupAD5AaLWxPt25nPX
         28si3b4F+yBi3s8IGbZj2eEl5AyCCfXHRun5opcXlu80vMqjLD/rHyJkyi+mi8APYtb7
         VTd481lV8nBNLqP5aQeqyANYZPRKUevuMQNXYJ/H/1Jcu9aAiC5Zx5dnXEOeHE1rLq7s
         dehQ==
X-Gm-Message-State: AOAM5315hdxQoE5eXq4QMg2OOFusmDl4VgJYyoiYEAQSn9Mt1rVHqbtF
        mOLsdiMRjG17IPLePPckAAI=
X-Google-Smtp-Source: ABdhPJwzug7R7lZ98QhzVijeB23lL+qhp3kOzUY1KoAlbPmsz+qtcY6TKJE0ojHRtjQFBt5OCVHqpg==
X-Received: by 2002:a17:90a:34cc:: with SMTP id m12mr15208288pjf.232.1614570593358;
        Sun, 28 Feb 2021 19:49:53 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:4f3d:dd5a:d38b:3f76? ([2601:647:4000:d7:4f3d:dd5a:d38b:3f76])
        by smtp.gmail.com with ESMTPSA id g7sm13865015pgb.10.2021.02.28.19.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 19:49:52 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] blk-mq: test tags bitmap before get request
To:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, ming.lei@redhat.com, hch@lst.de
References: <20210301021444.4134047-1-yuyufen@huawei.com>
 <20210301021444.4134047-2-yuyufen@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e364502d-a00a-d079-edc2-c99a1ae6936e@acm.org>
Date:   Sun, 28 Feb 2021 19:49:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301021444.4134047-2-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/21 6:14 PM, Yufen Yu wrote:
> For now, we set hctx->tags->rqs[i] when get driver tag successfully.
> The request either comes from sched_tags->static_rqs[] with scheduler,
> or comes from tags->static_rqs[] with no scheduler. But, the value won't
> be clear when put driver tag. Thus, tags->rqs[i] still remain old request.
> 
> We can free these sched_tags->static_rqs[] requests when switch elevator,
> update nr_requests or update nr_hw_queues. After that, unexpected access
> of tags->rqs[i] may cause use-after-free crash.
> 
> For example, we reported use-after-free of request in nbd device
> by syzkaller:
> 
> BUG: KASAN: use-after-free in blk_mq_request_started+0x24/0x40 block/blk-mq.c:644
> Read of size 4 at addr ffff80036b77f9d4 by task kworker/u9:0/10086
> Call trace:
>  dump_backtrace+0x0/0x310 arch/arm64/kernel/time.c:78
>  show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x144/0x1b4 lib/dump_stack.c:118
>  print_address_description+0x68/0x2d0 mm/kasan/report.c:253
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x134/0x2f0 mm/kasan/report.c:409
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  __asan_load4+0x88/0xb0 mm/kasan/kasan.c:699
>  __read_once_size include/linux/compiler.h:193 [inline]
>  blk_mq_rq_state block/blk-mq.h:106 [inline]
>  blk_mq_request_started+0x24/0x40 block/blk-mq.c:644
>  nbd_read_stat drivers/block/nbd.c:670 [inline]
>  recv_work+0x1bc/0x890 drivers/block/nbd.c:749
>  process_one_work+0x3ec/0x9e0 kernel/workqueue.c:2156
>  worker_thread+0x80/0x9d0 kernel/workqueue.c:2311
>  kthread+0x1d8/0x1e0 kernel/kthread.c:255
>  ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1174
> 
> The syzkaller test program sended a reply package to client
> without client sending request. After receiving the package,
> recv_work() try to get the remained request in tags->rqs[]
> by tag, which have been free.
> 
> To avoid this type of problem, we may need to ensure the request
> valid when get it by tag.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  block/blk-mq.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d4d7c1caa439..5362a7958b74 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -836,9 +836,17 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q,
>  }
>  EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
>  
> +static int blk_mq_test_tag_bit(struct blk_mq_tags *tags, unsigned int tag)
> +{
> +	if (!blk_mq_tag_is_reserved(tags, tag))
> +		return sbitmap_test_bit(&tags->bitmap_tags->sb, tag);
> +	else
> +		return sbitmap_test_bit(&tags->breserved_tags->sb, tag);
> +}
> +
>  struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
>  {
> -	if (tag < tags->nr_tags) {
> +	if (tag < tags->nr_tags && blk_mq_test_tag_bit(tags, tag)) {
>  		prefetch(tags->rqs[tag]);
>  		return tags->rqs[tag];
>  	}

Please do not slow down the hot path by inserting additional code in the
hot path. I am convinced that the race described in the patch
description can be fixed without changing the hot path. See also the
conversation I had recently with John Garry on linux-block.

Thanks,

Bart.

Bart.
