Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1251DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 16:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbhKZQbR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 11:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239200AbhKZQ3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 11:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637943963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/Bls/Z9SllhxVc+L2vI8snOWy5+HK1l2H7LEdHdi3c=;
        b=dCHgZUEtDbLFmamrAIYL4TC1BSQ4oH7sB3ZlQF66Tx9oQu1v8tnjAH71j4DIxumUdubF/h
        1MC81waPkl7W59mQU73iwK8hEUi/etGgSlG750qkao/cInyr+jZ0R2j7lzMu7Cqt+44BG4
        agTGGNzMJfa0YU5ifATewAlk/pBQaxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-aMWYqcR7NfKOLe4UwN3MLw-1; Fri, 26 Nov 2021 11:26:02 -0500
X-MC-Unique: aMWYqcR7NfKOLe4UwN3MLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 790541F2DB
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 16:25:49 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C91CE7E645;
        Fri, 26 Nov 2021 16:25:02 +0000 (UTC)
Date:   Sat, 27 Nov 2021 00:24:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] WARNING at block/mq-deadline.c:600
 dd_exit_sched+0x1c6/0x260 triggered with blktests block/031
Message-ID: <YaEKWPlAmDJYV6Si@T590>
References: <CAHj4cs8=xDxBZF62-OekAGtHDtP6ynALKXm7fK2D2ChpNXnGAw@mail.gmail.com>
 <YaBGI7bR/9ot514F@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaBGI7bR/9ot514F@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 26, 2021 at 10:27:47AM +0800, Ming Lei wrote:
> Hi Yi,
> 
> On Thu, Nov 25, 2021 at 07:02:43PM +0800, Yi Zhang wrote:
> > Hello
> > 
> > blktests block/031 triggered below WARNING with latest
> > linux-block/for-next[1], pls check it.
> > 
> > [1]
> > f0afafc21027 (HEAD, origin/for-next) Merge branch 'for-5.17/io_uring'
> > into for-next
> 
> After running block/031 for several times in today's linus tree, not
> reproduce the issue:

Yi, it should be one for-5.17/block only issue, please test the
following patch:


From 13b6abb5545f08bbe7dfea34a1bfc186e04932ac Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 27 Nov 2021 00:19:43 +0800
Subject: [PATCH] blk-mq: use bio->bi_opf after bio is checked

bio->bi_opf isn't finalized before checking the bio, so use it after
submit_bio_checks() returns.

Fixes: f1880d26e517 ("blk-mq: cleanup request allocation")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 82491ab676fb..b57c4373e59b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2712,7 +2712,6 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.nr_tags	= 1,
-		.cmd_flags	= bio->bi_opf,
 	};
 	struct request *rq;
 
@@ -2725,6 +2724,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 
 	rq_qos_throttle(q, bio);
 
+	/* ->bi_opf is finalized after submit_bio_checks() returns */
+	data.cmd_flags	= bio->bi_opf;
 	if (plug) {
 		data.nr_tags = plug->nr_ios;
 		plug->nr_ios = 1;
-- 
2.31.1



Thanks, 
Ming

