Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845B9C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615EC60F58
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhKBPjJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231543AbhKBPjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 11:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635867393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wf68Cej9KTrSkuWS4mPD25BSDtFObj9Mx2MunITE9Nc=;
        b=htm0MXQa5R5s+1mZf8lrOGAXz7pFXX9+zalsQHdKJek4X269LyGCQuonCdVvwWqmC8HBja
        NdYiAkMgXh3rQeG2/A+PnJcteRA70t/Lhyt9AaXfKp+4JL3sBBCRax8IrTBR8mSR7UJuKn
        2M64mKB7TBJYOgm1044AB6yxq2UhgfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-A3YRcZEHNT-ipp5DVR17MA-1; Tue, 02 Nov 2021 11:36:32 -0400
X-MC-Unique: A3YRcZEHNT-ipp5DVR17MA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2B0E802B61;
        Tue,  2 Nov 2021 15:36:31 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B1C95D9D3;
        Tue,  2 Nov 2021 15:36:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/3] blk-mq: misc fixes
Date:   Tue,  2 Nov 2021 23:36:16 +0800
Message-Id: <20211102153619.3627505-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Here are 3 small fixes against latest linus tree.

V2:
	- move batched update into blk_mq_flush_tag_batch() as suggested by
	  Jens, 3/3

Ming Lei (3):
  blk-mq: only try to run plug merge if request has same queue with
    incoming bio
  blk-mq: add RQF_ELV debug entry
  blk-mq: update hctx->nr_active in blk_mq_end_request_batch()

 block/blk-merge.c      |  6 ++++--
 block/blk-mq-debugfs.c |  1 +
 block/blk-mq.c         |  7 +++++++
 block/blk-mq.h         | 12 +++++++++---
 4 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.31.1

