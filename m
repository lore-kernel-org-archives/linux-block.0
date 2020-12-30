Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775ECC433E6
	for <linux-block@archiver.kernel.org>; Wed, 30 Dec 2020 00:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3882521D94
	for <linux-block@archiver.kernel.org>; Wed, 30 Dec 2020 00:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgL3Aef (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 19:34:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgL3Aef (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 19:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609288389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NmupsEaehELCNl+LJ5gdEjpzSuneBdbUDg6O7unuKxg=;
        b=KnOG1oAMMheXx2VxVgtLYmrVH5l4ufQbjJlOj6+oSEr8h19U1pxex+QUA/t45HGpzoqp7d
        kS9CdcxAaHYFOsZTBtZ4xcV4gCEhSK7hHiFBPmaV1YWPIcjDO4ZLiIOgIBXskJTMtAbv+j
        L3W6aj4Gxlrq5q8CzgNrr2DAJZn89iY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-rOeLKygIMKm7H7CyPhQUHQ-1; Tue, 29 Dec 2020 19:33:06 -0500
X-MC-Unique: rOeLKygIMKm7H7CyPhQUHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2395180A08A;
        Wed, 30 Dec 2020 00:33:05 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8789A27C2C;
        Wed, 30 Dec 2020 00:33:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/6] block: improvement on bioset & bvec allocation
Date:   Wed, 30 Dec 2020 08:32:49 +0800
Message-Id: <20201230003255.3450874-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

All are bioset / bvec improvement, and most of them are quite
straightforward.


Ming Lei (6):
  block: manage bio slab cache by xarray
  block: don't pass BIOSET_NEED_BVECS for q->bio_split
  block: don't allocate inline bvecs if this bioset needn't bvecs
  block: set .bi_max_vecs as actual allocated vector number
  block: move three bvec helpers declaration into private helper
  bcache: don't pass BIOSET_NEED_BVECS for the 'bio_set' embedded in
    'cache_set'

 block/bio.c               | 116 ++++++++++++++++----------------------
 block/blk-core.c          |   2 +-
 block/blk.h               |   4 ++
 drivers/md/bcache/super.c |   2 +-
 include/linux/bio.h       |   4 +-
 5 files changed, 57 insertions(+), 71 deletions(-)

-- 
2.28.0

