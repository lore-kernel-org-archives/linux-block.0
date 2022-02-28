Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB2C433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 09:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiB1JFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiB1JFp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 04:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C139E36688
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 01:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646039104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GwV+MvK/zSZGPMXzfVDE8thEzuuq04VSOgxuZlV7PBc=;
        b=XJ3WHy32SmpjgydWpbySjRwNo75QttibmiMt0W/Z2PMAmoL5peO5rm73O55/jP6jWJjaz8
        IPrO0b+SA94fFw+Xph3ZcmCbJP8uiOcJc1mB4KQXGNYKev/eLUmD9hCYULcHp6e0MIE9aL
        Ft9iFnyi+XvjZVNnuEG8bEhrX2F6kgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-iskJ9kLePHSPEJhL7lsb_g-1; Mon, 28 Feb 2022 04:05:01 -0500
X-MC-Unique: iskJ9kLePHSPEJhL7lsb_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 204731006AA6;
        Mon, 28 Feb 2022 09:05:00 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E246C7FA36;
        Mon, 28 Feb 2022 09:04:41 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/6] blk-mq: update_nr_hw_queues related improvement & bugfix
Date:   Mon, 28 Feb 2022 17:04:24 +0800
Message-Id: <20220228090430.1064267-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch figures out correct numa node for each kind of hw queue.

The 2nd patch simplifies reallocation of q->queue_hw_ctx a bit.

The 3rd patch re-configures poll capability after queue map is changed.

The 4th patch changes mtip32xx to avoid to refer to q->queue_hw_ctx
directly.

The 5th & 6th patches fix use-after-free on q->queue_hw_ctx.


Ming Lei (6):
  blk-mq: figure out correct numa node for hw queue
  blk-mq: simplify reallocation of hw ctxs a bit
  blk-mq: re-config poll after queue map is changed
  block: mtip32xx: don't touch q->queue_hw_ctx
  blk-mq: add helper of blk_mq_get_hctx to retrieve hctx via its index
  blk-mq: manage hctx map via xarray

 block/blk-mq-sysfs.c              |   2 +-
 block/blk-mq-tag.c                |   2 +-
 block/blk-mq.c                    | 125 +++++++++++++++++-------------
 block/blk-mq.h                    |   2 +-
 drivers/block/mtip32xx/mtip32xx.c |   4 +-
 include/linux/blk-mq.h            |   8 +-
 include/linux/blkdev.h            |   2 +-
 7 files changed, 84 insertions(+), 61 deletions(-)

-- 
2.31.1

