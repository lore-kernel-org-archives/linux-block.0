Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE2CC433E7
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 12:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFF121D7F
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 12:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqazOy3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgJMMJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 08:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbgJMMJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 08:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602590968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eKVmCw1kHnfx4gduFW3WCGxcMJ80P3Nn7Z7r5s6Z16k=;
        b=VqazOy3z1gJgVaDgD0glWnGPCZB8a6o9ZuYTe8fFtiQC7MhSx4qqR5Yfp+dX+l6TQTBock
        3IuiyvHmncJwx0bg8+HMVZ5BXDBR9ZubcrJRPw9HHrWga9DBLkVkGKvEOKXwgCryB/qlMZ
        9w4ZFGr0M6OHy3PoYaOnY6c91J4rYbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-iEMmMz0gOLWlVBYYQTm6tQ-1; Tue, 13 Oct 2020 08:09:26 -0400
X-MC-Unique: iEMmMz0gOLWlVBYYQTm6tQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8F861084C82;
        Tue, 13 Oct 2020 12:09:23 +0000 (UTC)
Received: from T590 (ovpn-12-121.pek2.redhat.com [10.72.12.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A55AD5D9CD;
        Tue, 13 Oct 2020 12:09:17 +0000 (UTC)
Date:   Tue, 13 Oct 2020 20:09:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com
Subject: Re: [PATCH] block: set NOWAIT for sync polling
Message-ID: <20201013120913.GA614668@T590>
References: <20201013084051.27255-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013084051.27255-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 13, 2020 at 04:40:51PM +0800, Jeffle Xu wrote:
> Sync polling also needs REQ_NOWAIT flag. One sync read/write may be
> split into several bios (and thus several requests), and can used up the
> queue depth sometimes. Thus the following bio in the same sync
> read/write will wait for usable request if REQ_NOWAIT flag not set, in
> which case the following sync polling will cause a deadlock.
> 
> One case (maybe the only case) for above situation is preadv2/pwritev2
> + direct + highpri. Two conditions need to be satisfied to trigger the
> deadlock.
> 
> 1. HIPRI IO in sync routine. Normal read(2)/pread(2)/readv(2)/preadv(2)
> and corresponding write family syscalls don't support high-priority IO and
> thus won't trigger polling routine. Only preadv2(2)/pwritev2(2) supports
> high-priority IO by RWF_HIPRI flag of @flags parameter.
> 
> 2. Polling support in sync routine. Currently both the blkdev and
> iomap-based fs (ext4/xfs, etc) support polling in direct IO routine. The
> general routine is described as follows.
> 
> submit_bio
>   wait for blk_mq_get_tag(), waiting for requests completion, which
>   should be done by the following polling, thus causing a deadlock.

Another blocking point is rq_qos_throttle(), so I guess falling back to
REQ_NOWAIT may not fix the issue completely.

Given iopoll isn't supposed to in case of big IO, another solution
may be to disable iopoll when bio splitting is needed, something
like the following change:

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bcf5e4580603..8e762215660b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -279,6 +279,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return NULL;
 split:
 	*segs = nsegs;
+
+	/*
+	 * bio splitting may cause more trouble for iopoll which isn't supposed
+	 * to be used in case of big IO
+	 */
+	bio->bi_opf &= ~REQ_HIPRI;
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 


Thanks, 
Ming

