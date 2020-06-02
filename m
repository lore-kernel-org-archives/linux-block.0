Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899E5C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 06:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645552072F
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 06:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPHf2+o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgFBGqz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:46:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37213 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbgFBGqz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 02:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591080414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5U94FJdYK9plgkjd/rs2xCbqvAEoMXUciGGTL+Z60/U=;
        b=dPHf2+o8pTrTSn4yHseOMG/dRl5U1pIr0ap6hwWbqs5Qbosw7RCYjuqdf5N9vBk0xkYEAv
        yhtiyxhoVBcDYKwpUnTrGtAOZF0Q7sTOS4vTTE16c6mZHXo/eFUhHFlfoCUoZzUUm3rLuc
        Pt3Y9DJ8XsTylPR47aVf6Z8ILL6Nmzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-Fhw00SVqOWmZSw2KpdQ23w-1; Tue, 02 Jun 2020 02:46:50 -0400
X-MC-Unique: Fhw00SVqOWmZSw2KpdQ23w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCAB61800D42;
        Tue,  2 Jun 2020 06:46:48 +0000 (UTC)
Received: from T590 (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FF331002390;
        Tue,  2 Jun 2020 06:46:42 +0000 (UTC)
Date:   Tue, 2 Jun 2020 14:46:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hare@suse.de,
        dwagner@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] blk-mq: get ctx in order to handle BLK_MQ_S_INACTIVE
 in blk_mq_get_tag()
Message-ID: <20200602064638.GA1384911@T590>
References: <20200602061749.32029-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602061749.32029-1-dongli.zhang@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 01, 2020 at 11:17:49PM -0700, Dongli Zhang wrote:
> When scheduler is set, we hit below page fault when we offline cpu.
> 
> [ 1061.007725] BUG: kernel NULL pointer dereference, address: 0000000000000040
> [ 1061.008710] #PF: supervisor read access in kernel mode
> [ 1061.009492] #PF: error_code(0x0000) - not-present page
> [ 1061.010241] PGD 0 P4D 0
> [ 1061.010614] Oops: 0000 [#1] SMP PTI
> [ 1061.011130] CPU: 0 PID: 122 Comm: kworker/0:1H Not tainted 5.7.0-rc7+ #2'
> ... ...
> [ 1061.013760] Workqueue: kblockd blk_mq_run_work_fn
> [ 1061.014446] RIP: 0010:blk_mq_put_tag+0xf/0x30
> ... ...
> [ 1061.017726] RSP: 0018:ffffa5c18037fc70 EFLAGS: 00010287
> [ 1061.018475] RAX: 0000000000000000 RBX: ffffa5c18037fcf0 RCX: 0000000000000004
> [ 1061.019507] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff911535dc1180
> ... ...
> [ 1061.028454] Call Trace:
> [ 1061.029307]  blk_mq_get_tag+0x26e/0x280
> [ 1061.029866]  ? wait_woken+0x80/0x80
> [ 1061.030378]  blk_mq_get_driver_tag+0x99/0x110
> [ 1061.031009]  blk_mq_dispatch_rq_list+0x107/0x5e0
> [ 1061.031672]  ? elv_rb_del+0x1a/0x30
> [ 1061.032178]  blk_mq_do_dispatch_sched+0xe2/0x130
> [ 1061.032844]  __blk_mq_sched_dispatch_requests+0xcc/0x150
> [ 1061.033638]  blk_mq_sched_dispatch_requests+0x2b/0x50
> [ 1061.034239]  __blk_mq_run_hw_queue+0x75/0x110
> [ 1061.034867]  process_one_work+0x15c/0x370
> [ 1061.035450]  worker_thread+0x44/0x3d0
> [ 1061.035980]  kthread+0xf3/0x130
> [ 1061.036440]  ? max_active_store+0x80/0x80
> [ 1061.037018]  ? kthread_bind+0x10/0x10
> [ 1061.037554]  ret_from_fork+0x35/0x40
> [ 1061.038073] Modules linked in:
> [ 1061.038543] CR2: 0000000000000040
> [ 1061.038962] ---[ end trace d20e1df7d028e69f ]---
> 
> This is because blk_mq_get_driver_tag() would be used to allocate tag once
> scheduler (e.g., mq-deadline) is set. However, in order to handle
> BLK_MQ_S_INACTIVE in blk_mq_get_tag(), we need to set data->ctx for
> blk_mq_put_tag().
> 
> Fixes: bf0beec0607db3c6 ("blk-mq: drain I/O when all CPUs in a hctx are offline")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> This is based on for-next because currently the pull request for v5.8 is
> not picked by mainline.
> 
>  block/blk-mq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9a36ac1c1fa1..8bf6c06a86c1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1056,6 +1056,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
>  {
>  	struct blk_mq_alloc_data data = {
>  		.q = rq->q,
> +		.ctx = rq->mq_ctx,
>  		.hctx = rq->mq_hctx,
>  		.flags = BLK_MQ_REQ_NOWAIT,
>  		.cmd_flags = rq->cmd_flags,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

