Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71437C433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 02:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E9C22C9F
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 02:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbhAYCa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 21:30:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbhAYCay (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 21:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611541768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AOuU4aoZe3XAk5NNKrDSxzniU8JOGIrqcGwrT5kPdrw=;
        b=eTL+woIJuY5WzYQp5a73XYjulVtp+LppAekN8pf1wMvioxQtv52X6ZpStuCjDi+Wnx1nWV
        0q0YeLkVzSbeFF95ptbdRQ2uvfakkUBEw780tos96yDEtISQGz/ZIH4nnC3jsEbqOjrhou
        tbzYenFj/idCjpvpSGbye9S6Xp4PeAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-R_tCgWKFPNmioSSjl2Z_5w-1; Sun, 24 Jan 2021 21:29:26 -0500
X-MC-Unique: R_tCgWKFPNmioSSjl2Z_5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EA2E801AC2;
        Mon, 25 Jan 2021 02:29:25 +0000 (UTC)
Received: from T590 (ovpn-12-140.pek2.redhat.com [10.72.12.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8D475D9D7;
        Mon, 25 Jan 2021 02:29:19 +0000 (UTC)
Date:   Mon, 25 Jan 2021 10:29:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH] blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared
 in hctx_may_queue
Message-ID: <20210125022915.GC984849@T590>
References: <20201227113458.3289082-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227113458.3289082-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 27, 2020 at 07:34:58PM +0800, Ming Lei wrote:
> In case of blk_mq_is_sbitmap_shared(), we should test QUEUE_FLAG_HCTX_ACTIVE against
> q->queue_flags instead of BLK_MQ_S_TAG_ACTIVE.
> 
> So fix it.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Fixes: f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for when using shared sbitmap")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello Jens,

This one fixes one v5.11 issue, can you queue it?


Thanks, 
Ming

