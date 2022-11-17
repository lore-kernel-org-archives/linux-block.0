Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B677C433FE
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 02:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiKQCUe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 21:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKQCUd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 21:20:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1CD1DDF9
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 18:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668651575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNXRjfGWHtf056PxKy/nhE6XOdH7jJkWEFyb4eexLLs=;
        b=fu+KEi/XBn6JBLJIwLHXSPUxoNJN0BtDjAVSCe/0C1ZFtFhQJaSFEK7iXnqAsI5QMPcI9g
        m1S+HtRO8lZEl9vNYoGkkbpJQWFDzd8kdh5XwtnQpG5esdA5fYSyeHK/riGiFzq8Ys67u0
        Jn/E7EFaP/Dpb3nawrGx5msAIEoKgck=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-paSkCR7wM_G3uugvkUxemQ-1; Wed, 16 Nov 2022 21:19:34 -0500
X-MC-Unique: paSkCR7wM_G3uugvkUxemQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECC6A380673E;
        Thu, 17 Nov 2022 02:19:33 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45FDD40C83D9;
        Thu, 17 Nov 2022 02:19:29 +0000 (UTC)
Date:   Thu, 17 Nov 2022 10:19:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] blk-mq: fix possible memleak when register 'hctx' failed
Message-ID: <Y3WaLGd28v8ofWLG@T590>
References: <20221117022940.873959-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117022940.873959-1-yebin@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 17, 2022 at 10:29:40AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows when do fault injection test:
> unreferenced object 0xffff888132a9f400 (size 512):
>   comm "insmod", pid 308021, jiffies 4324277909 (age 509.733s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 08 f4 a9 32 81 88 ff ff  ...........2....
>     08 f4 a9 32 81 88 ff ff 00 00 00 00 00 00 00 00  ...2............
>   backtrace:
>     [<00000000e8952bb4>] kmalloc_node_trace+0x22/0xa0
>     [<00000000f9980e0f>] blk_mq_alloc_and_init_hctx+0x3f1/0x7e0
>     [<000000002e719efa>] blk_mq_realloc_hw_ctxs+0x1e6/0x230
>     [<000000004f1fda40>] blk_mq_init_allocated_queue+0x27e/0x910
>     [<00000000287123ec>] __blk_mq_alloc_disk+0x67/0xf0
>     [<00000000a2a34657>] 0xffffffffa2ad310f
>     [<00000000b173f718>] 0xffffffffa2af824a
>     [<0000000095a1dabb>] do_one_initcall+0x87/0x2a0
>     [<00000000f32fdf93>] do_init_module+0xdf/0x320
>     [<00000000cbe8541e>] load_module+0x3006/0x3390
>     [<0000000069ed1bdb>] __do_sys_finit_module+0x113/0x1b0
>     [<00000000a1a29ae8>] do_syscall_64+0x35/0x80
>     [<000000009cd878b0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Fault injection context as follows:
>  kobject_add
>  blk_mq_register_hctx
>  blk_mq_sysfs_register
>  blk_register_queue
>  device_add_disk
>  null_add_dev.part.0 [null_blk]
> 
> As 'blk_mq_register_hctx' may already add some objects when failed halfway,
> but there isn't do fallback, caller don't know which objects add failed.
> To solve above issue just do fallback when add objects failed halfway in
> 'blk_mq_register_hctx'.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

