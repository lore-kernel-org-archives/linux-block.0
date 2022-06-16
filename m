Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6515C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 01:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347575AbiFPBjr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350742AbiFPBjj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 21:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCF48580CE
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 18:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655343578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pD6o2hXiYeT/41I5TBvddbFzasCuH/7330K9NaQrqcw=;
        b=CEeqBMep2JP8WYEO+Jd7SXgdXplS77ADoB3mg2n2vF1m1kOhXsManjkX12KIHKJGF/qty5
        ycWeJ0BGUWjpfq72zOVwPrqrcN036eZiDFY1IVls5L/nwpzEIhVLhBfNaFapSNAxVNA5xS
        Nn8GQcJwz1WIivhWN/NLwEmqcTljYz0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-_ljmQDHdMcKLwSXgKhPuRg-1; Wed, 15 Jun 2022 21:39:34 -0400
X-MC-Unique: _ljmQDHdMcKLwSXgKhPuRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80BE81C0F689;
        Thu, 16 Jun 2022 01:39:34 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 184E91121314;
        Thu, 16 Jun 2022 01:39:30 +0000 (UTC)
Date:   Thu, 16 Jun 2022 09:39:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Fix handling of offline queues in
 blk_mq_alloc_request_hctx()
Message-ID: <YqqJzTAdgJbYYol4@T590>
References: <20220615210004.1031820-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615210004.1031820-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 15, 2022 at 02:00:04PM -0700, Bart Van Assche wrote:
> This patch prevents that test nvme/004 triggers the following:
> 
> UBSAN: array-index-out-of-bounds in block/blk-mq.h:135:9
> index 512 is out of range for type 'long unsigned int [512]'
> Call Trace:
>  show_stack+0x52/0x58
>  dump_stack_lvl+0x49/0x5e
>  dump_stack+0x10/0x12
>  ubsan_epilogue+0x9/0x3b
>  __ubsan_handle_out_of_bounds.cold+0x44/0x49
>  blk_mq_alloc_request_hctx+0x304/0x310
>  __nvme_submit_sync_cmd+0x70/0x200 [nvme_core]
>  nvmf_connect_io_queue+0x23e/0x2a0 [nvme_fabrics]
>  nvme_loop_connect_io_queues+0x8d/0xb0 [nvme_loop]
>  nvme_loop_create_ctrl+0x58e/0x7d0 [nvme_loop]
>  nvmf_create_ctrl+0x1d7/0x4d0 [nvme_fabrics]
>  nvmf_dev_write+0xae/0x111 [nvme_fabrics]
>  vfs_write+0x144/0x560
>  ksys_write+0xb7/0x140
>  __x64_sys_write+0x42/0x50
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Fixes: 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7a5558bbc7f6..1c09c6017ea9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -579,6 +579,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	if (!blk_mq_hw_queue_mapped(data.hctx))
>  		goto out_queue_exit;
>  	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> +	if (cpu >= nr_cpu_ids)
> +		goto out_queue_exit;
>  	data.ctx = __blk_mq_get_ctx(q, cpu);
>  
>  	if (!q->elevator)
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

