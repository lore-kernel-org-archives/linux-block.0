Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A66C10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB012067C
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 09:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VW3i0BLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCLJQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:16:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21381 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbgCLJQG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 05:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584004565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3GkK7t0+d6Sj4rPL5ziLufqu/UVvk6GXojFRROEGZQw=;
        b=VW3i0BLHe6I68S4o8HzJ16wzGJ2TcZkl+1xEMV60EqDufwf14tVeUfiBx6Ox0HViSi6WoN
        zTS9fEViMsjnCx7/r65iyTkJRBNCSP3Vpv6OHILkiXNYPbxJMCnX1IjPEr6wh6Dt3hIYIq
        b54CSU7vHlKn4H4f/GjfO6a/n9BfnBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-nkuf7gMUO1ihsxgp5lUuAw-1; Thu, 12 Mar 2020 05:16:03 -0400
X-MC-Unique: nkuf7gMUO1ihsxgp5lUuAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0FCB800D50;
        Thu, 12 Mar 2020 09:16:02 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 516EF5C1C3;
        Thu, 12 Mar 2020 09:15:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] blk-mq: insert flush request to the front of dispatch queue
Date:   Thu, 12 Mar 2020 17:15:48 +0800
Message-Id: <20200312091548.25237-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit 01e99aeca397 ("blk-mq: insert passthrough request into
hctx->dispatch directly") may change to add flush request to the tail
of dispatch by applying the 'add_head' parameter of
blk_mq_sched_insert_request.

Turns out this way causes performance regression on NCQ controller becaus=
e
flush is non-NCQ command, which can't be queued when there is any in-flig=
ht
NCQ command. When adding flush rq to the front of hctx->dispatch, it is
easier to introduce extra time to flush rq's latency compared with adding
to the tail of dispatch queue because of S_SCHED_RESTART, then chance of
flush merge is increased, and less flush requests may be issued to
controller.

So always insert flush request to the front of dispatch queue just like
before applying commit 01e99aeca397 ("blk-mq: insert passthrough request
into hctx->dispatch directly").

Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 01e99aeca397 ("blk-mq: insert passthrough request into hctx->dispa=
tch directly")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 856356b1619e..74cedea56034 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -398,6 +398,28 @@ void blk_mq_sched_insert_request(struct request *rq,=
 bool at_head,
 	WARN_ON(e && (rq->tag !=3D -1));
=20
 	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
+		/*
+		 * Firstly normal IO request is inserted to scheduler queue or
+		 * sw queue, meantime we add flush request to dispatch queue(
+		 * hctx->dispatch) directly and there is at most one in-flight
+		 * flush request for each hw queue, so it doesn't matter to add
+		 * flush request to tail or front of the dispatch queue.
+		 *
+		 * Secondly in case of NCQ, flush request belongs to non-NCQ
+		 * command, and queueing it will fail when there is any
+		 * in-flight normal IO request(NCQ command). When adding flush
+		 * rq to the front of hctx->dispatch, it is easier to introduce
+		 * extra time to flush rq's latency because of S_SCHED_RESTART
+		 * compared with adding to the tail of dispatch queue, then
+		 * chance of flush merge is increased, and less flush requests
+		 * will be issued to controller. It is observed that ~10% time
+		 * is saved in blktests block/004 on disk attached to AHCI/NCQ
+		 * drive when adding flush rq to the front of hctx->dispatch.
+		 *
+		 * Simply queue flush rq to the front of hctx->dispatch so that
+		 * intensive flush workloads can benefit in case of NCQ HW.
+		 */
+		at_head =3D (rq->rq_flags & RQF_FLUSH_SEQ) ? true : at_head;
 		blk_mq_request_bypass_insert(rq, at_head, false);
 		goto run;
 	}
--=20
2.20.1

