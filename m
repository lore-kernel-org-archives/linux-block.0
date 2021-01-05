Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FDDC43603
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 12:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAD0229C5
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 12:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbhAEMnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:43:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728532AbhAEMnn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jan 2021 07:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609850537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3Hx/LONoaEHqsxynBWhs2Xu6Nio11K6EwWFZLliGnCk=;
        b=JrQdni1h5/JrQzCLpz3O7WJ8SZTX8dVfoE/N750Y5xwAONi+oKcNmwPZm8gKI6mc2TmIFz
        Zj/KmH3L2luE28wm7GKOOVK2t8gNErjjODfelyl3FREjCcJ9aVbOzp9nClAnsprJgbw3wu
        q+obCBg09aBoGO/I6jJ7M0kK9Jl+JsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-cGej1wOnMqS1_2J_-0X4NQ-1; Tue, 05 Jan 2021 07:42:16 -0500
X-MC-Unique: cGej1wOnMqS1_2J_-0X4NQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AC388049D9;
        Tue,  5 Jan 2021 12:42:15 +0000 (UTC)
Received: from localhost (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6683260BFA;
        Tue,  5 Jan 2021 12:42:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/6] block: improvement on bioset & bvec allocation
Date:   Tue,  5 Jan 2021 20:41:57 +0800
Message-Id: <20210105124203.3726599-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

All are bioset / bvec improvement, and most of them are quite
straightforward.

V2:
	- patch style change, most is in patch 1
	- commit log change

Ming Lei (6):
  block: manage bio slab cache by xarray
  block: don't pass BIOSET_NEED_BVECS for q->bio_split
  block: don't allocate inline bvecs if this bioset needn't bvecs
  block: set .bi_max_vecs as actual allocated vector number
  block: move three bvec helpers declaration into private helper
  bcache: don't pass BIOSET_NEED_BVECS for the 'bio_set' embedded in
    'cache_set'

 block/bio.c               | 120 +++++++++++++++++---------------------
 block/blk-core.c          |   2 +-
 block/blk.h               |   4 ++
 drivers/md/bcache/super.c |   2 +-
 include/linux/bio.h       |   4 +-
 5 files changed, 60 insertions(+), 72 deletions(-)

-- 
2.28.0

