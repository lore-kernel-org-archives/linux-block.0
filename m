Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E4C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 09:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiBIJlo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:41:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiBIJho (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 04:37:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF720C1DC14D
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQwllhgZRdNdMcvbmvS4eyJeOm965Txsg/g3O5y6cHU=;
        b=YQJfrVf+4c2M+9RFygZyCGI8vwClmromrDtvIsLZbG8SqQSYDkIKkJ6WgOMDgYoTB9iyiT
        kAe5FlMACEqasTCGlYXWTHNq+GgH5/b+aOlAa2MDpqj/Ycmt+5EYmit4aj1cs2jEYtUI7Q
        sUD2auQJFqsdZjpqgD2NgYcdkP4RjfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-QNYPqEYhM6OIl0g2TORXHA-1; Wed, 09 Feb 2022 04:15:20 -0500
X-MC-Unique: QNYPqEYhM6OIl0g2TORXHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E063E107B0F5;
        Wed,  9 Feb 2022 09:15:18 +0000 (UTC)
Received: from localhost (ovpn-8-35.pek2.redhat.com [10.72.8.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C52177AB76;
        Wed,  9 Feb 2022 09:15:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/7] block: don't declare submit_bio_checks in local header
Date:   Wed,  9 Feb 2022 17:14:25 +0800
Message-Id: <20220209091429.1929728-4-ming.lei@redhat.com>
In-Reply-To: <20220209091429.1929728-1-ming.lei@redhat.com>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

submit_bio_checks() won't be called outside of block/blk-core.c any more
since commit 9d497e2941c3 ("block: don't protect submit_bio_checks by
q_usage_counter").

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index abb663a2a147..b2516cb4f98e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -46,7 +46,6 @@ void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
-bool submit_bio_checks(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {
-- 
2.31.1

