Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACCFC43461
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 10:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F90421582
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 10:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaZhbIMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIIKlf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgIIKld (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Sep 2020 06:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599648092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=99190LL3bPLK3LeppyJXssmf524H27/Vvj3Duzsfngc=;
        b=JaZhbIMX1pcKPKytW4WfbD+Kj9mahXmDePDHqM4KKG6rU0Yavua4qjo0tVspXsDshKUb5c
        gXG66SwPXxqnbQOSbRODZNhLxRMQoyNU9pg4uTUOstp+vdmuQ18NcJAIfbwQH+c6sR5XQ4
        0EFXBYz6+islWNNpPu3j2TBoQ/2pDE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-dww-nDZDNKeHIfs1E1Gn0Q-1; Wed, 09 Sep 2020 06:41:28 -0400
X-MC-Unique: dww-nDZDNKeHIfs1E1Gn0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BC6B1017DC4;
        Wed,  9 Sep 2020 10:41:26 +0000 (UTC)
Received: from localhost (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F1CF78439;
        Wed,  9 Sep 2020 10:41:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
Subject: [PATCH V4 0/4] blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
Date:   Wed,  9 Sep 2020 18:41:12 +0800
Message-Id: <20200909104116.1674592-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

V4:
	- remove .mq_quiesce_mutex, and switch to test_and_[set|clear] for
	avoiding duplicated quiesce action
	- pass blktests(block, nvme)

V3:
	- add tagset quiesce interface
	- apply tagset quiesce interface for NVMe
	- pass blktests(block, nvme)

V2:
	- add .mq_quiesce_lock
	- add comment on patch 2 wrt. handling hctx_lock() failure
	- trivial patch style change


Ming Lei (3):
  block: use test_and_{clear|test}_bit to set/clear QUEUE_FLAG_QUIESCED
  blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
  blk-mq: add tagset quiesce interface

Sagi Grimberg (1):
  nvme: use blk_mq_[un]quiesce_tagset

 block/blk-core.c         |  13 +++
 block/blk-mq-sysfs.c     |   2 -
 block/blk-mq.c           | 173 +++++++++++++++++++++++++--------------
 block/blk-sysfs.c        |   6 +-
 block/blk.h              |   2 +
 drivers/nvme/host/core.c |  19 ++---
 include/linux/blk-mq.h   |  10 +--
 include/linux/blkdev.h   |   4 +
 8 files changed, 146 insertions(+), 83 deletions(-)

Cc: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>
-- 
2.25.2

