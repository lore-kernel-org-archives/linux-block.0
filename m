Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D0C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 13:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352188AbhLCNTO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:19:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238833AbhLCNTN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Dec 2021 08:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638537349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZhbP32VA9eLPO+HuJQYYJRIBAXDq6kVxKeUC/vfl88w=;
        b=ZvwnDWkdrO1hL7FTkWxMywJ/Hnng0cKVzUSJnTw+AUwSLLVR5K7XoNKb2ympQhUqCkW3wl
        KUdA7tdKDFv9CVAjkQ5VypToNiXZMY2D/l7gfJnZDfeo/FEoMwqiyotWaMYNvhK4W67orJ
        ILoBAjW/Qfa5KZ3rCpmLsRixin9BzgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-ueKZx0dWPv2w0Xk-w-GOcw-1; Fri, 03 Dec 2021 08:15:46 -0500
X-MC-Unique: ueKZx0dWPv2w0Xk-w-GOcw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EEED81EE62;
        Fri,  3 Dec 2021 13:15:45 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 858BC50D3F;
        Fri,  3 Dec 2021 13:15:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] blk-mq: improve dispatch lock & quiesce implementation
Date:   Fri,  3 Dec 2021 21:15:30 +0800
Message-Id: <20211203131534.3668411-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch replaces hctx_lock/hctx_unlock with
blk_mq_run_dispatch_ops(), so that the fast dispatch code path gets
optimized a bit.

The 2nd patch moves srcu from hctx into request queue.

The last two patches call blk_mq_run_dispatch_ops once in case of
issuing directly from list.


Ming Lei (4):
  blk-mq: remove hctx_lock and hctx_unlock
  blk-mq: move srcu from blk_mq_hw_ctx to request_queue
  blk-mq: pass request queue to blk_mq_run_dispatch_ops
  blk-mq: run dispatch lock once in case of issuing from list

 block/blk-core.c       |  27 +++++++++--
 block/blk-mq-sched.c   |   3 +-
 block/blk-mq-sysfs.c   |   2 -
 block/blk-mq.c         | 105 +++++++++--------------------------------
 block/blk-mq.h         |  16 +++++++
 block/blk-sysfs.c      |   3 +-
 block/blk.h            |  10 +++-
 block/genhd.c          |   2 +-
 include/linux/blk-mq.h |   8 ----
 include/linux/blkdev.h |   9 ++++
 10 files changed, 84 insertions(+), 101 deletions(-)

-- 
2.31.1

