Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A8CC4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 01:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4293D61019
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 01:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhHCB5f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 21:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233178AbhHCB5f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Aug 2021 21:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627955844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbOF+mNZOqgnrXh/vdXFZt/qzGL3DM+vGqqV5hBIlqo=;
        b=XiHSo5NeWRnQgtxUsGYrhjPWu1S+E3YyS6h0+IJPK3ygSmy6zy/eUc5ARciXrtTkEMggvA
        VHwlvuu6V7vDVK/O07KkJ30nS8M7f/h0/mRg6B3FOWxEFVDKWpomJpcRDURggefOJAi1by
        UoJ8vyAgUNpZOgkMwaDQpAWodv2BKcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-9mzpqw7zPQCmj-eSiYGPRA-1; Mon, 02 Aug 2021 21:57:21 -0400
X-MC-Unique: 9mzpqw7zPQCmj-eSiYGPRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A964E1006C80;
        Tue,  3 Aug 2021 01:57:19 +0000 (UTC)
Received: from T590 (ovpn-13-136.pek2.redhat.com [10.72.13.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3496B60CC4;
        Tue,  3 Aug 2021 01:57:11 +0000 (UTC)
Date:   Tue, 3 Aug 2021 09:57:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH 2/2] loop: Add the default_queue_depth kernel module
 parameter
Message-ID: <YQiif6/X28R7jC0V@T590>
References: <20210803000200.4125318-1-bvanassche@acm.org>
 <20210803000200.4125318-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803000200.4125318-3-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 02, 2021 at 05:02:00PM -0700, Bart Van Assche wrote:
> Recent versions of Android use the zram driver on top of the loop driver.
> There is a mismatch between the default loop driver queue depth (128) and
> the queue depth of the storage device in my test setup (32). That mismatch
> results in write latencies that are higher than necessary. Address this
> issue by making the default loop driver queue depth configurable. Compared
> to configuring the queue depth by writing into the nr_requests sysfs
> attribute, this approach does not involve calling synchronize_rcu() to
> modify the queue depth.
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/loop.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 9fca3ab3988d..0f1f1ecd941a 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2098,6 +2098,9 @@ module_param(max_loop, int, 0444);
>  MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
>  module_param(max_part, int, 0444);
>  MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
> +static uint32_t default_queue_depth = 128;
> +module_param(default_queue_depth, uint, 0644);
> +MODULE_PARM_DESC(default_queue_depth, "Default loop device queue depth");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
>  
> @@ -2330,7 +2333,7 @@ static int loop_add(int i)
>  	err = -ENOMEM;
>  	lo->tag_set.ops = &loop_mq_ops;
>  	lo->tag_set.nr_hw_queues = 1;
> -	lo->tag_set.queue_depth = 128;
> +	lo->tag_set.queue_depth = max(default_queue_depth, 2U);
>  	lo->tag_set.numa_node = NUMA_NO_NODE;
>  	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
>  	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

