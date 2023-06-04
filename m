Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2313FC7EE24
	for <linux-block@archiver.kernel.org>; Sun,  4 Jun 2023 00:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjFDAsd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Jun 2023 20:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjFDAsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Jun 2023 20:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F81A5
        for <linux-block@vger.kernel.org>; Sat,  3 Jun 2023 17:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685839658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XL9m4/QrEyoU43AAPUnZxDdKBE2GdTGoILFW1/x9cuo=;
        b=dekco/RjQGSXt6udNlOUyyRf2IVYXuCeogxObJBi7grwerZnx19Rxl1fF3pPaXqQVZ2LYu
        dZRnOVE0wGqP0cgd0D1VcTPyfl2jXkoWEySTyD/gFAAjqvpzufXmsX9QNYatXTQTmGRPAj
        nUN19AAJoHSjNTYRV9vT7D0JHdUIiHc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-MhiJLfrENMunlBSWq1YHXg-1; Sat, 03 Jun 2023 20:47:35 -0400
X-MC-Unique: MhiJLfrENMunlBSWq1YHXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4250380673B;
        Sun,  4 Jun 2023 00:47:34 +0000 (UTC)
Received: from ovpn-8-19.pek2.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C5052166B25;
        Sun,  4 Jun 2023 00:47:28 +0000 (UTC)
Date:   Sun, 4 Jun 2023 08:47:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tian Lan <tilan7663@gmail.com>
Cc:     axboe@kernel.dk, horms@kernel.org, linux-block@vger.kernel.org,
        lkp@intel.com, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com, Hannes Reinecke <hare@suse.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix blk_mq_hw_ctx active request accounting
Message-ID: <ZHvfHPC1veSs0w4r@ovpn-8-19.pek2.redhat.com>
References: <da0ae57e-71c2-9ad5-1134-c12309032402@kernel.dk>
 <20230603223912.827913-1-tilan7663@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603223912.827913-1-tilan7663@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jun 03, 2023 at 06:39:12PM -0400, Tian Lan wrote:
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
>   task:inboundIORe state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
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
>   320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0
>          b'__blk_mq_free_request+0x1 [kernel]'
>          b'bt_iter+0x50 [kernel]'
>          b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
>          b'blk_mq_timeout_work+0x7c [kernel]'
>          b'process_one_work+0x1c4 [kernel]'
>          b'worker_thread+0x4d [kernel]'
>          b'kthread+0xe6 [kernel]'
>          b'ret_from_fork+0x1f [kernel]'
> 
> This issue arises when both bt_iter() and blk_mq_end_request_batch()
> are iterating on the same request. The leak happens when
> blk_mq_find_and_get_req() is executed(from bt_iter) before
> req_ref_put_and_test() gets called by blk_mq_end_request_batch().
> And because non-flush request freed by blk_mq_put_rq_ref() bypasses the
> active request tracking, the counter would slowly leak overtime.
> 
> Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")

f794f3351f26 is merged to v5.16, and the leak starts.

> Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter")

2e315dc07df0 is merged to v5.14, when everything is just fine.

Both two aren't marked as -stable, so 'Fixes: 2e315dc07df0' is actually
not correct.


thanks,
Ming

