Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1858C43461
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 08:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C0D21D47
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 08:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvfNA9+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgIHIQA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:16:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729466AbgIHIP7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Sep 2020 04:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599552958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v/qoO+cW63IFyXyKdkhTXirdCmiDWixghNnIQtyM35A=;
        b=KvfNA9+8hTIv8aUkqdCJPaguxoGAXFWZ32FuEYnALNRU+3kMDztFiFaKDVtKCsGHcrK7mn
        sfesra9x1VZ/KH6XOuv+2DUN0JKtTp59joThqW51+4zgdsVU04omdpMjoZjvtCUw6WHA0B
        iMMkjT/OJQy+YRDXDh/2ZdL/QvRbr1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-5Rjh-0qAOM-QTqaL-GuGvA-1; Tue, 08 Sep 2020 04:15:54 -0400
X-MC-Unique: 5Rjh-0qAOM-QTqaL-GuGvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B094393B4;
        Tue,  8 Sep 2020 08:15:53 +0000 (UTC)
Received: from localhost (ovpn-12-217.pek2.redhat.com [10.72.12.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16DF071775;
        Tue,  8 Sep 2020 08:15:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
Subject: [PATCH V3 0/4] blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
Date:   Tue,  8 Sep 2020 16:15:34 +0800
Message-Id: <20200908081538.1434936-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
and prepares for replacing srcu with percpu_ref.

The 2nd patch replaces srcu with percpu_ref.

The 3rd patch adds tagset quiesce interface.

The 4th patch applies tagset quiesce interface for NVMe subsystem.


V3:
	- add tagset quiesce interface
	- apply tagset quiesce interface for NVMe
	- pass blktests(block, nvme)

V2:
	- add .mq_quiesce_lock
	- add comment on patch 2 wrt. handling hctx_lock() failure
	- trivial patch style change



Ming Lei (3):
  blk-mq: serialize queue quiesce and unquiesce by mutex
  blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
  blk-mq: add tagset quiesce interface

Sagi Grimberg (1):
  nvme: use blk_mq_[un]quiesce_tagset

 block/blk-core.c         |   2 +
 block/blk-mq-sysfs.c     |   2 -
 block/blk-mq.c           | 177 +++++++++++++++++++++++++--------------
 block/blk-sysfs.c        |   6 +-
 drivers/nvme/host/core.c |  19 ++---
 include/linux/blk-mq.h   |  10 +--
 include/linux/blkdev.h   |   6 ++
 7 files changed, 140 insertions(+), 82 deletions(-)

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>
-- 
2.25.2

