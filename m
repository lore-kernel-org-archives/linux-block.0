Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E18C433E0
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 03:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42CE224BD
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 03:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbhAKDHg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 22:07:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbhAKDHg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 22:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610334370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dpyAUfx1y/WBE/pPFlMa6aW60cCOxwnBfLepQ0zPleM=;
        b=cDvZJInfepnrAdRhBdIJ+qVrhgZnCMNyJ1BgpjliJniHM0WSHzmD7FMxoCEMpwWG3hu54y
        I483YHSweRt7qI2AT9rqVXxdcvvs92DWRYKI3TstyyoWslxPgQ1pR6b7ancqA5qtNYR7e3
        aKDuTrr2Zey3ct+/6F6f64OCUg3Xc7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-Xt9SUo4yO7S_YNb-Uv_YEA-1; Sun, 10 Jan 2021 22:06:08 -0500
X-MC-Unique: Xt9SUo4yO7S_YNb-Uv_YEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 581ED800D55;
        Mon, 11 Jan 2021 03:06:07 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 774B42CD5C;
        Mon, 11 Jan 2021 03:06:03 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/6] block: improvement on bioset & bvec allocation
Date:   Mon, 11 Jan 2021 11:05:51 +0800
Message-Id: <20210111030557.4154161-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

All are bioset / bvec improvement, and most of them are quite
straightforward.

V3:
	- share two line code via goto with one label, only patch 1 is
	  changed

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

 block/bio.c               | 122 +++++++++++++++++---------------------
 block/blk-core.c          |   2 +-
 block/blk.h               |   4 ++
 drivers/md/bcache/super.c |   2 +-
 include/linux/bio.h       |   4 +-
 5 files changed, 61 insertions(+), 73 deletions(-)

-- 
2.28.0

