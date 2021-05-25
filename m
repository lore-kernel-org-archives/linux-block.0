Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E23C2B9F7
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 00:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F2F6141E
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 00:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhEYAbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 20:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhEYAbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 20:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621902580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Z7UbDZyMl/Qo6U1QF1YyOwntqJKyBsFeG9yBtgLF3E=;
        b=bYCN4kEYKK/iACu0wwawI42seGUdzLfNjxZvdBZLCUiYF32yhJqMeODwkejRi0q5lhjDdW
        e0ucz50iIfqH/UVAdzjnPD9rlxXC+Rf81ztBtp5C0fA+OsqxXpTSj/2NXTZMiEclu3T918
        s/h8yBvL5RMRt3a9eqPIk4lfnx223Rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-m2e2-1LnPMKCrPEcZPcoWQ-1; Mon, 24 May 2021 20:29:38 -0400
X-MC-Unique: m2e2-1LnPMKCrPEcZPcoWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E297E801817;
        Tue, 25 May 2021 00:29:36 +0000 (UTC)
Received: from T590 (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 425695D767;
        Tue, 25 May 2021 00:29:29 +0000 (UTC)
Date:   Tue, 25 May 2021 08:29:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 2/2] blk: Fix lock inversion between ioc lock and bfqd
 lock
Message-ID: <YKxE5efsGCD49NaB@T590>
References: <20210524100416.3578-1-jack@suse.cz>
 <20210524100416.3578-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524100416.3578-3-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 24, 2021 at 12:04:16PM +0200, Jan Kara wrote:
> Lockdep complains about lock inversion between ioc->lock and bfqd->lock:
> 
> bfqd -> ioc:
>  put_io_context+0x33/0x90 -> ioc->lock grabbed
>  blk_mq_free_request+0x51/0x140
>  blk_put_request+0xe/0x10
>  blk_attempt_req_merge+0x1d/0x30
>  elv_attempt_insert_merge+0x56/0xa0
>  blk_mq_sched_try_insert_merge+0x4b/0x60
>  bfq_insert_requests+0x9e/0x18c0 -> bfqd->lock grabbed
>  blk_mq_sched_insert_requests+0xd6/0x2b0
>  blk_mq_flush_plug_list+0x154/0x280
>  blk_finish_plug+0x40/0x60
>  ext4_writepages+0x696/0x1320
>  do_writepages+0x1c/0x80
>  __filemap_fdatawrite_range+0xd7/0x120
>  sync_file_range+0xac/0xf0
> 
> ioc->bfqd:
>  bfq_exit_icq+0xa3/0xe0 -> bfqd->lock grabbed
>  put_io_context_active+0x78/0xb0 -> ioc->lock grabbed
>  exit_io_context+0x48/0x50
>  do_exit+0x7e9/0xdd0
>  do_group_exit+0x54/0xc0
> 
> To avoid this inversion we change blk_mq_sched_try_insert_merge() to not
> free the merged request but rather leave that upto the caller similarly
> to blk_mq_sched_try_merge(). And in bfq_insert_requests() we make sure
> to free all the merged requests after dropping bfqd->lock.
> 
> Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, 
Ming

