Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD0DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA3961373
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTOGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhJTOGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:06:47 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA6DC061746
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:04:33 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r17so3057494qtx.10
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SZMJhhiQz+NRZi0eMiHg38L7kd1NzgPBA278SGVX3+Y=;
        b=yxguSYDfLQQ3SS9aPBzrUZ1lDm2byWO0nzzc7os3i1rPHBdvzWJz7wsjfGRK330n2x
         Eb/LNUOpk6DiMm+SzyrJ0HhiiINR4Lfk71lj1vDeoqKM+dblTHY4dBbjdzt9zBfdMIAy
         bdUPC3ssXAZPW3yqg8KsOy/XMfMR+qdblUrOfcvRJY4sgO4muAoFDe4Xnw82CiA2wX0y
         +oyiwVw/lTL6i0MTr5vY5FJaryPjx/BXcFIJYJl9rdAR7FtA2X6nS1sdiikghULu3Izr
         7942mb1vGYgGa5+P8hLtQJmRD2PHUrw7tn8VKfhUBBxdyFR0ankIAw2P30RJrHAfc7jQ
         c2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SZMJhhiQz+NRZi0eMiHg38L7kd1NzgPBA278SGVX3+Y=;
        b=INthLU6D7sypBgxr0KExJj7wBPlZBoidnNY31s3oqZxraTx35PAnZGUkEROpLPn+Kp
         CU7AYD2K2UH3XItZgwA5legl8C8ban+YOJfpMFnICvWHvkIyubq50hUxOJ8X2Itypb6k
         zdp+WkJD3kh2XrWzuR3H+21yzLxa9GQuzMXg/nznN/qpbpVO3CtZOsvv+5qhY2Je2Ydq
         xSXYwHXXtlfo8WeswWWe4xhaXQs0SQ8Owd29Bp0vmq+hI2KfAWhj/f4XJcd8wFz6gOGL
         fswVxL/sLb4B/k+HsorQfIAZhGmUSvMO/9YraMTrK3mCfDFVrr9dLGaigK9YYvwOZSWo
         B9wA==
X-Gm-Message-State: AOAM533OZUDxH45AYrKMNUagE+0/LcOkwV4vxZXPB55q4HM09Jtjbm3g
        b/g0ykpICQmorMXLsOjkJa2OWoBqdEkvjQ==
X-Google-Smtp-Source: ABdhPJy8OAJs2POuzgUUGc0Wlz/bkXOf2bkiD8VYzIf6XOR2Bx7TzbYlJJOdOVJ1xujfEop1aLP+7A==
X-Received: by 2002:ac8:5990:: with SMTP id e16mr145206qte.38.1634738672032;
        Wed, 20 Oct 2021 07:04:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c26sm993404qtm.21.2021.10.20.07.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:04:31 -0700 (PDT)
Date:   Wed, 20 Oct 2021 10:04:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nbd: Fix hungtask when nbd_config_put
Message-ID: <YXAh7tWFbpukMi6+@localhost.localdomain>
References: <20211020094830.3056325-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020094830.3056325-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 05:48:30PM +0800, Ye Bin wrote:
> I got follow issue:
> [  247.381177] INFO: task kworker/u10:0:47 blocked for more than 120 seconds.
> [  247.382644]       Not tainted 4.19.90-dirty #140
> [  247.383502] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  247.385027] Call Trace:
> [  247.388384]  schedule+0xb8/0x3c0
> [  247.388966]  schedule_timeout+0x2b4/0x380
> [  247.392815]  wait_for_completion+0x367/0x510
> [  247.397713]  flush_workqueue+0x32b/0x1340
> [  247.402700]  drain_workqueue+0xda/0x3c0
> [  247.403442]  destroy_workqueue+0x7b/0x690
> [  247.405014]  nbd_config_put.cold+0x2f9/0x5b6
> [  247.405823]  recv_work+0x1fd/0x2b0
> [  247.406485]  process_one_work+0x70b/0x1610
> [  247.407262]  worker_thread+0x5a9/0x1060
> [  247.408699]  kthread+0x35e/0x430
> [  247.410918]  ret_from_fork+0x1f/0x30
> 
> We can reprodeuce issue as follows:
> 1. Inject memory fault in nbd_start_device
> @@ -1244,10 +1248,18 @@ static int nbd_start_device(struct nbd_device *nbd)
>         nbd_dev_dbg_init(nbd);
>         for (i = 0; i < num_connections; i++) {
>                 struct recv_thread_args *args;
> -
> -               args = kzalloc(sizeof(*args), GFP_KERNEL);
> +
> +               if (i == 1) {
> +                       args = NULL;
> +                       printk("%s: inject malloc error\n", __func__);
> +               }
> +               else
> +                       args = kzalloc(sizeof(*args), GFP_KERNEL);
> 2. Inject delay in recv_work
> @@ -757,6 +760,8 @@ static void recv_work(struct work_struct *work)
> 
>                 blk_mq_complete_request(blk_mq_rq_from_pdu(cmd));
>         }
> +       printk("%s: comm=%s pid=%d\n", __func__, current->comm, current->pid);
> +       mdelay(5 * 1000);
>         nbd_config_put(nbd);
>         atomic_dec(&config->recv_threads);
>         wake_up(&config->recv_wq);
> 3. Create nbd server
> nbd-server 8000 /tmp/disk
> 4. Create nbd client
> nbd-client localhost 8000 /dev/nbd1
> Then will trigger above issue.
> 
> Reason is when add delay in recv_work, lead to relase the last reference
> of 'nbd->config_refs'. nbd_config_put will call flush_workqueue to make
> all work finish. Obviously, it will lead to deadloop.
> To solve this issue, we must ensure 'recv_work' all exit before release
> the last 'nbd->config_refs' reference count.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

This isn't the way to fix this.  The crux of the problem is the fact that we
destroy the recv_workq at config time anyway, since it is tied to the nbd
device.

Fix this instead by getting rid of that, and have the nbd device teardown the
recv_workq when we destory the nbd device.  Alloc it on device allocation and
stop alloc'ing it with the config.  That way we don't have this weird thing
where we need recv threads to drop their config before the last thing.

And while you're at it would you fix recv_work() so it doesn't modify config
after it drops it's reference?  Thanks,

Josef
