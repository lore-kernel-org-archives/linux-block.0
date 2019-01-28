Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4296AC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A80B2175B
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfA1VNR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:13:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfA1VNR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:13:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E555C08734C;
        Mon, 28 Jan 2019 21:13:17 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71DA916D22;
        Mon, 28 Jan 2019 21:13:16 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, avi@scylladb.com
Subject: Re: [PATCH 09/13] io_uring: add submission polling
References: <20190123153536.7081-1-axboe@kernel.dk>
        <20190123153536.7081-12-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 28 Jan 2019 16:13:15 -0500
In-Reply-To: <20190123153536.7081-12-axboe@kernel.dk> (Jens Axboe's message of
        "Wed, 23 Jan 2019 08:35:22 -0700")
Message-ID: <x49r2cwwkno.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 28 Jan 2019 21:13:17 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> @@ -1270,6 +1445,27 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
>  	if (!ctx->sqo_files)
>  		goto err;
>  
> +	if (ctx->flags & IORING_SETUP_SQPOLL) {
> +		if (p->flags & IORING_SETUP_SQ_AFF) {
> +			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
> +							ctx, p->sq_thread_cpu,
> +							"io_uring-sq");

sq_thread_cpu looks like another candidate for array_index_nospec.
Following the macros, kthread_create_on_cpu calls cpu_to_node, which
does:
        return per_cpu(x86_cpu_to_node_map, cpu);

#define per_cpu(var, cpu)       (*per_cpu_ptr(&(var), cpu))
#define per_cpu_ptr(ptr, cpu)                                           \
({                                                                      \
        __verify_pcpu_ptr(ptr);                                         \
        SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));                 \
})
#define per_cpu_offset(x) (__per_cpu_offset[x])
                           ^^^^^^^^^^^^^^^^^^^

It also looks like there's no bounds checking there, so we probably want
to make sure sq_thread_cpu can't overflow the __per_cpu_offset array
(NR_CPUS).

-Jeff
