Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59744FA3741
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 14:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiJaOJF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiJaOJA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 10:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FF610B47
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667225282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ssV5tIbeaDdUb05cqYH6611+3Ll1a3abXRc3rHIdohQ=;
        b=DAShlfJd0Xg+nVaCHd7v+1XsFDfum5L92IzMH3ONOoMuRVLObEaB3KdVmo2w15zi6x/A3f
        22tK81Tx0REVoLH75rWyoR5/rk1DibBX3U0TbY6TqySx4aJCahj12NTaWGnk1MlD2vtdK/
        N88iRwhz3CEv9BmOZTslWVYYiRuydZc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-Z08Maf4fOTmFY7vF07KYhQ-1; Mon, 31 Oct 2022 10:07:58 -0400
X-MC-Unique: Z08Maf4fOTmFY7vF07KYhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 600063C0D84B;
        Mon, 31 Oct 2022 14:07:55 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22B5A40C2066;
        Mon, 31 Oct 2022 14:07:50 +0000 (UTC)
Date:   Mon, 31 Oct 2022 22:07:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, will@kernel.org, xuqiang36@huawei.com
Subject: Re: [PATCH] blk-mq: Fix kmemleak in blk_mq_init_allocated_queue
Message-ID: <Y1/Wsfo0f5csRhsr@T590>
References: <20221031031242.94107-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031031242.94107-1-chenjun102@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 31, 2022 at 03:12:42AM +0000, Chen Jun wrote:
> There is a kmemleak caused by modprobe null_blk.ko
> 
> unreferenced object 0xffff8881acb1f000 (size 1024):
>   comm "modprobe", pid 836, jiffies 4294971190 (age 27.068s)
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff 00 53 99 9e ff ff ff ff  .........S......
>   backtrace:
>     [<000000004a10c249>] kmalloc_node_trace+0x22/0x60
>     [<00000000648f7950>] blk_mq_alloc_and_init_hctx+0x289/0x350
>     [<00000000af06de0e>] blk_mq_realloc_hw_ctxs+0x2fe/0x3d0
>     [<00000000e00c1872>] blk_mq_init_allocated_queue+0x48c/0x1440
>     [<00000000d16b4e68>] __blk_mq_alloc_disk+0xc8/0x1c0
>     [<00000000d10c98c3>] 0xffffffffc450d69d
>     [<00000000b9299f48>] 0xffffffffc4538392
>     [<0000000061c39ed6>] do_one_initcall+0xd0/0x4f0
>     [<00000000b389383b>] do_init_module+0x1a4/0x680
>     [<0000000087cf3542>] load_module+0x6249/0x7110
>     [<00000000beba61b8>] __do_sys_finit_module+0x140/0x200
>     [<00000000fdcfff51>] do_syscall_64+0x35/0x80
>     [<000000003c0f1f71>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> That is because q->ma_ops is set to NULL before blk_release_queue is
> called.
> 
> blk_mq_init_queue_data
>   blk_mq_init_allocated_queue
>     blk_mq_realloc_hw_ctxs
>       for (i = 0; i < set->nr_hw_queues; i++) {
>         old_hctx = xa_load(&q->hctx_table, i);
>         if (!blk_mq_alloc_and_init_hctx(.., i, ..))		[1]
>           if (!old_hctx)
> 	    break;
> 
>       xa_for_each_start(&q->hctx_table, j, hctx, j)
>         blk_mq_exit_hctx(q, set, hctx, j); 			[2]
> 
>     if (!q->nr_hw_queues)					[3]
>       goto err_hctxs;
> 
>   err_exit:
>       q->mq_ops = NULL;			  			[4]
> 
>   blk_put_queue
>     blk_release_queue
>       if (queue_is_mq(q))					[5]
>         blk_mq_release(q);
> 
> [1]: blk_mq_alloc_and_init_hctx failed at i != 0.
> [2]: The hctxs allocated by [1] are moved to q->unused_hctx_list and
> will be cleaned up in blk_mq_release.
> [3]: q->nr_hw_queues is 0.
> [4]: Set q->mq_ops to NULL.
> [5]: queue_is_mq returns false due to [4]. And blk_mq_release
> will not be called. The hctxs in q->unused_hctx_list are leaked.
> 
> To fix it, call blk_release_queue in exception path.
> 
> Fixes: 2f8f1336a48b ("blk-mq: always free hctx after request queue is freed")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> Signed-off-by: Chen Jun <chenjun102@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

