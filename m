Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6524AC7618F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 20:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3558721900
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 20:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecUJKzI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfGVU3X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:29:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44026 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfGVU3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 16:29:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so18190966pgv.10;
        Mon, 22 Jul 2019 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nCZL8NW+CQJDJhz/9d6wrGsYH8X/ZdiJlsRqT5zJ18M=;
        b=ecUJKzI5CGYU2VRUOO4wPZGQIFrlFq5mcssQY8loS7b4ri7Qe1ZADcezUwC6rRVJQM
         6OcQd5eJ+/nhNQR8V/NrnmHBVc/3CsXte5tajITmvSn0qSuOdRBNXVwhOif2ic7wMMOa
         AxG1LfiTrSJ60ExfVKPoYI2n6IayQ99hzmmhw3EggUgB86WoNH99RTAJmeCpp2Gbbziv
         m569ffJb4oFVxs8PgmoLjP9k+90D21yWQfppvk90Xfs5w3BemdMTNLlO4GrSKWAUPh8j
         V0dyokeaiCg7yWCo33r4TV0OBIJr1DQD7wtz9RzPX1oQ3gHah0qHHm8a2wjrpGq6ZhZT
         Fe7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nCZL8NW+CQJDJhz/9d6wrGsYH8X/ZdiJlsRqT5zJ18M=;
        b=asTsYQDXjcpw9OCe3AfgBxYcogrPb0ZMjMM5SSsr6L1FBckmnh7KETnCP1DM2dCvlZ
         qeaeZ6ZzyMzy396ZQswBwBVG/adDacGpbm23LQgGNXUr9P12SmRGMZE1YecBirM72mSJ
         wYimZkwI8AW1CWV5JRO16CkWsIez7K3KeaUGmjYtgxVAjaJ/oj+1nEVRiqlrrlJMiUZv
         UghwJHX4+Z6EOaG58RkUloL5D2/Fu1YIbKGRB4yMBBZbWTPqlXBgNLYhbuttzN2niwsQ
         hQFUwoHOXuXiqClrqkuOb3ImTdQsTuxIh+LdAFMHZrxfv3hXeMyqUf0yaRB7IiQKnULp
         gqVA==
X-Gm-Message-State: APjAAAUCCxyF7mmAlVjGMp/KFVNjvsEQR2XcIKfT4TL1q5pKXhC768Fi
        oSa5UpSdBWWQar8gReRp3ylkZqQp
X-Google-Smtp-Source: APXvYqzp0Fk1CGr9xMouwqONLh91BN1ApqCJEeFJcR6Md3Sy2g7vsRebMcZQNFqdER3Vrv6DPGoJjQ==
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr77576503pjt.16.1563827362635;
        Mon, 22 Jul 2019 13:29:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18sm68596624pgm.9.2019.07.22.13.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 13:29:22 -0700 (PDT)
Date:   Mon, 22 Jul 2019 13:29:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] bfq: Check if bfqq is NULL in bfq_insert_request
Message-ID: <20190722202920.GA18431@roeck-us.net>
References: <1563816648-12057-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563816648-12057-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 22, 2019 at 10:30:48AM -0700, Guenter Roeck wrote:
> In bfq_insert_request(), bfqq is initialized with:
> 	bfqq = bfq_init_rq(rq);
> In bfq_init_rq(), we find:
> 	if (unlikely(!rq->elv.icq))
> 		return NULL;
> Indeed, rq->elv.icq can be NULL if the memory allocation in
> create_task_io_context() failed.
> 

The above function should have been ioc_create_icq(), sorry.

Guenter

> A comment in bfq_insert_request() suggests that bfqq is supposed to be
> non-NULL if 'at_head || blk_rq_is_passthrough(rq)' is false. Yet, as
> debugging and practical experience shows, this is not the case in the
> above situation.
> 
> This results in the following crash.
> 
> Unable to handle kernel NULL pointer dereference
> 	at virtual address 00000000000001b0
> ...
> Call trace:
>  bfq_setup_cooperator+0x44/0x134
>  bfq_insert_requests+0x10c/0x630
>  blk_mq_sched_insert_requests+0x60/0xb4
>  blk_mq_flush_plug_list+0x290/0x2d4
>  blk_flush_plug_list+0xe0/0x230
>  blk_finish_plug+0x30/0x40
>  generic_writepages+0x60/0x94
>  blkdev_writepages+0x24/0x30
>  do_writepages+0x74/0xac
>  __filemap_fdatawrite_range+0x94/0xc8
>  file_write_and_wait_range+0x44/0xa0
>  blkdev_fsync+0x38/0x68
>  vfs_fsync_range+0x68/0x80
>  do_fsync+0x44/0x80
> 
> The problem is relatively easy to reproduce by running an image with
> failslab enabled, such as with:
> 
> cd /sys/kernel/debug/failslab
> echo 10 > probability
> echo 300 > times
> 
> Avoid the problem by checking if bfqq is NULL before using it. With the
> NULL check in place, requests with missing io context are queued
> immediately, and the crash is no longer seen.
> 
> Fixes: 18e5a57d79878 ("block, bfq: postpone rq preparation to insert or merge")
> Reported-by: Hsin-Yi Wang  <hsinyi@google.com>
> Cc: Hsin-Yi Wang <hsinyi@google.com>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  block/bfq-iosched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 72860325245a..56f3f4227010 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5417,7 +5417,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	spin_lock_irq(&bfqd->lock);
>  	bfqq = bfq_init_rq(rq);
> -	if (at_head || blk_rq_is_passthrough(rq)) {
> +	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
>  		if (at_head)
>  			list_add(&rq->queuelist, &bfqd->dispatch);
>  		else
> -- 
> 2.7.4
> 
