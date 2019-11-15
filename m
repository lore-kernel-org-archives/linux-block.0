Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27172C432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011E620748
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LT6CIKOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfKOKnR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:43:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727151AbfKOKnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 05:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573814595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9spnRhGRffTYFRmdJbv3gMbOyOJbQ9BooxBnq4poTrA=;
        b=LT6CIKOrhaAozqLfqJFj0IvAyanFUeK3LNow8+pLhxSVQh0QXZcwGFZheaEBrqTCTIwGzO
        bBzPQkrMapeLNAEyXe/G6h+1Cq/SkiDm1uf5u3u6tRpBr9lxDddGvt0mRJdUJTAbo+SSLL
        j3FNSn/Qt5crRHqbM2DJPfCpHcD0SYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-4CmJ8yvSM5CZU0u0l3VrmA-1; Fri, 15 Nov 2019 05:43:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A0E1802CE0;
        Fri, 15 Nov 2019 10:43:11 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 750FA5D6BE;
        Fri, 15 Nov 2019 10:43:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH RFC 3/3] blk-mq: kill blk_mq_alloc_request_hctx()
Date:   Fri, 15 Nov 2019 18:42:38 +0800
Message-Id: <20191115104238.15107-4-ming.lei@redhat.com>
In-Reply-To: <20191115104238.15107-1-ming.lei@redhat.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4CmJ8yvSM5CZU0u0l3VrmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq uses static queue mapping between sw queue and hw queue to
retrieve hw queue, then allocate request on the retrieved hw queue's
request pool.

blk_mq_alloc_request_hctx() requires to specify one hctx index and ask
blk-mq to allocate request from this hctx's request pool. This way
is quite ugly given the hctx can become inactive any time because of
CPU hotplug. Kernel oops on NVMe FC/LOOP/RDMA/TCP has been reported
several times because of CPU hotplug.

The only user is NVMe loop, FC, RDMA and TCP driver for submitting
connect command. All these drivers have been conveted to use generic
API of blk_mq_alloc_request() to allocate request for NVMe connect
command.

So kill it now.

Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 46 ------------------------------------------
 include/linux/blk-mq.h |  3 ---
 2 files changed, 49 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5c9adcaa27ac..a360fe70ec98 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -427,52 +427,6 @@ struct request *blk_mq_alloc_request(struct request_qu=
eue *q, unsigned int op,
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
=20
-struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
-=09unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
-{
-=09struct blk_mq_alloc_data alloc_data =3D { .flags =3D flags, .cmd_flags =
=3D op };
-=09struct request *rq;
-=09unsigned int cpu;
-=09int ret;
-
-=09/*
-=09 * If the tag allocator sleeps we could get an allocation for a
-=09 * different hardware context.  No need to complicate the low level
-=09 * allocator for this for the rare use case of a command tied to
-=09 * a specific queue.
-=09 */
-=09if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)))
-=09=09return ERR_PTR(-EINVAL);
-
-=09if (hctx_idx >=3D q->nr_hw_queues)
-=09=09return ERR_PTR(-EIO);
-
-=09ret =3D blk_queue_enter(q, flags);
-=09if (ret)
-=09=09return ERR_PTR(ret);
-
-=09/*
-=09 * Check if the hardware context is actually mapped to anything.
-=09 * If not tell the caller that it should skip this queue.
-=09 */
-=09alloc_data.hctx =3D q->queue_hw_ctx[hctx_idx];
-=09if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
-=09=09blk_queue_exit(q);
-=09=09return ERR_PTR(-EXDEV);
-=09}
-=09cpu =3D cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
-=09alloc_data.ctx =3D __blk_mq_get_ctx(q, cpu);
-
-=09rq =3D blk_mq_get_request(q, NULL, &alloc_data);
-=09blk_queue_exit(q);
-
-=09if (!rq)
-=09=09return ERR_PTR(-EWOULDBLOCK);
-
-=09return rq;
-}
-EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
-
 static void __blk_mq_free_request(struct request *rq)
 {
 =09struct request_queue *q =3D rq->q;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dc03e059fdff..a0c65de93e8c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -441,9 +441,6 @@ enum {
=20
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int=
 op,
 =09=09blk_mq_req_flags_t flags);
-struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
-=09=09unsigned int op, blk_mq_req_flags_t flags,
-=09=09unsigned int hctx_idx);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int ta=
g);
=20
 enum {
--=20
2.20.1

