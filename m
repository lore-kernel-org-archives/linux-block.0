Return-Path: <SRS0=mNKb=VZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7DFC7618B
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C63C2075E
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 15:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCZ4/XvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfG1PTe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:19:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40008 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfG1PTe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jul 2019 11:19:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so26710302pfp.7;
        Sun, 28 Jul 2019 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zC+eHzdf8hhsaPyyiK2zg/tZEjENQIF8MncCCS04hoE=;
        b=vCZ4/XvWCb3QBAMC+5Re3UXPmj5tgPid5AiHYRrnPJ6/iWM4GgyHJyaUiT2AXhnzte
         ZxrZYJ6T7yNY0vZwdm+9HancWCXjiArMrjo7aqds7ULBGABrPavGcDQhjBPrfuK6DcHJ
         RfVcEjamNYaSsaS32UNoykImfArJLLBiWjPja3wFiBoo+dwq7zvLuLy5LDBVzUXIvz02
         f3oyem/By5ScuawfF8r0TRbLsSaoXD9OezeF+oN/NfXXiXRS3cJ5wRg6aIrJNPgG2o2h
         gcWY3v9d7HvYEv6GfDE/PlW2tCsNGkdNdU2x+swtOgKI/Ooxb0nspaD/l3tfXY4wsHV9
         CIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zC+eHzdf8hhsaPyyiK2zg/tZEjENQIF8MncCCS04hoE=;
        b=FX7i9kRgmv2rpCHYyLcYHLQI1CnntR65oZj1nK7ErC+PQcCXmMrPeuQP58X66MRU+3
         HpyCGjlOL0iAH76mgdLN6qJVDkTcWtzzlCxunuf9dX2fngkXIfNP2ChHNymz3hoepYPV
         kHOcGg/QBjwO7qeXlteC7OWBiN26RAE5iV3AkrKV7RpnEY6F29twRM8WIqp1+LLweTSH
         VjS4w1r4B5L0zOIdbY1YyebyT9E11PEoRrZxvdFqs0BT8A9JAuoni/V+IUVP1eOXphSW
         GBsEzjON1esZPakzpZClA/he4gKvqSGZbcBJTOru2ipM8Rmxse7JJnchSikq+71OARG5
         Ze/A==
X-Gm-Message-State: APjAAAXwdLlekqYfMDCtyeFlKNzfW3reboAtP8afVKjEa8T2nuSgnLnI
        QWyETi0z/G8dix7x44EiG5k=
X-Google-Smtp-Source: APXvYqxPlAECzEXnA/gRj3/dEMUpxo3Qf4tQF3UOodMs2deD8JTJOAcqNwV9lE7xaEnTTomG9fqIQA==
X-Received: by 2002:a63:f857:: with SMTP id v23mr75251344pgj.228.1564327173930;
        Sun, 28 Jul 2019 08:19:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l4sm59616033pff.50.2019.07.28.08.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 08:19:32 -0700 (PDT)
Date:   Sun, 28 Jul 2019 08:19:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] bfq: Check if bfqq is NULL in bfq_insert_request
Message-ID: <20190728151931.GA29181@roeck-us.net>
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

ping ... just in case this patch got lost in Paolo's queue.

Guenter

On Mon, Jul 22, 2019 at 10:30:48AM -0700, Guenter Roeck wrote:
> In bfq_insert_request(), bfqq is initialized with:
> 	bfqq = bfq_init_rq(rq);
> In bfq_init_rq(), we find:
> 	if (unlikely(!rq->elv.icq))
> 		return NULL;
> Indeed, rq->elv.icq can be NULL if the memory allocation in
> create_task_io_context() failed.
> 
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
