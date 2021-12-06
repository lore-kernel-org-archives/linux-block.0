Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B18C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 03:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhLFDmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Dec 2021 22:42:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236463AbhLFDmE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Dec 2021 22:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638761916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5dvCaQrQz2ByXpjMb88t7szWKPnwff9zNofOCekpTA=;
        b=LzP9iHeU2A27lKeIYfLtA2AvxhJ02Fb/xXFouaZJqp1huMdGeXcCdFCMScaSWI7c5sHJqY
        dsbw3VXe4gjhv8rQcwUwqonCkb7mImj538qHTMNM+/c+xLDp1bx8OQYSwSkYVvvsd1KDCu
        MJpfPnDsaPAEVwzWdT0UuQ0uLmkkp0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-420-By5L26oqMIK03qPhovNlOQ-1; Sun, 05 Dec 2021 22:38:33 -0500
X-MC-Unique: By5L26oqMIK03qPhovNlOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A4F9190A7A1;
        Mon,  6 Dec 2021 03:38:32 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB02E60C81;
        Mon,  6 Dec 2021 03:38:12 +0000 (UTC)
Date:   Mon, 6 Dec 2021 11:38:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [bug report] BUG kernel BULL pointer at
 blk_mq_flush_plug_list+0x2c4/0x320 observed with blktests on latest
 linux-block/for-next
Message-ID: <Ya2Fn4oNKDgjhO3T@T590>
References: <CAHj4cs-w_ypfFdiR=YDYZptcBUDh4=Qrc3-+ATpuDOng4PFbQA@mail.gmail.com>
 <CAHj4cs85h_Cs-yf0U=5eckaBifvciX1FNPEterBnGRc8rbKmuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs85h_Cs-yf0U=5eckaBifvciX1FNPEterBnGRc8rbKmuA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Yi,

Thanks for the report!

On Mon, Dec 06, 2021 at 09:38:35AM +0800, Yi Zhang wrote:
> This is the first commit that observed this issue.
>        Kernel repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>             Commit: c7d61010b991 - Merge branch 'for-5.17/block' into for-next

The issue should be fixed by the following patch:

From 8d30d9a46d4ede16c61ad48c2a1ceaf2ec29d044 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 6 Dec 2021 11:33:50 +0800
Subject: [PATCH] blk-mq: don't use plug->mq_list->q directly in
 blk_mq_run_dispatch_ops()

blk_mq_run_dispatch_ops() is defined as one macro, and plug->mq_list
will be changed when running 'dispatch_ops', so add one local variable
for holding request queue.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: 4cafe86c9267 ("blk-mq: run dispatch lock once in case of issuing from list")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 22ec21aa0c22..537295f6e0e9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2521,7 +2521,9 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
-		blk_mq_run_dispatch_ops(plug->mq_list->q,
+		struct request_queue *q = rq_list_peek(&plug->mq_list)->q;
+
+		blk_mq_run_dispatch_ops(q,
 				blk_mq_plug_issue_direct(plug, false));
 		if (rq_list_empty(plug->mq_list))
 			return;
-- 
2.31.1


Thanks, 
Ming

