Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B16C433DF
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBC52076C
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 14:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKD/k0jS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHYORw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:17:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40986 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgHYORu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 10:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598365069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2njhZJDHANmUjQozxqnnDkGvErdIxf7e72SOXU4WCYc=;
        b=IKD/k0jSCMdG3lMYXRpz5wyDAXemNCizrzvF1UPiPpY4N2xsop/zYT71L+gz+JueOTRWWY
        SmXWHUXK7fLmYrKQllEsoYJGorvkKWoHInLzNGyFi5t6diKriNKSvR9HPF8spbXd4bDdEp
        2npiO0saFijCTynxHOnqSeTw7qsXst8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-Qm8GgjqPO4GmCqfOStLGkw-1; Tue, 25 Aug 2020 10:17:45 -0400
X-MC-Unique: Qm8GgjqPO4GmCqfOStLGkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86A141007470;
        Tue, 25 Aug 2020 14:17:43 +0000 (UTC)
Received: from localhost (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AA4B709D2;
        Tue, 25 Aug 2020 14:17:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 0/2] blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
Date:   Tue, 25 Aug 2020 22:17:32 +0800
Message-Id: <20200825141734.115879-1-ming.lei@redhat.com>
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

V2:
	- add .mq_quiesce_lock
	- add comment on patch 2 wrt. handling hctx_lock() failure
	- trivial patch style change


Ming Lei (2):
  blk-mq: serialize queue quiesce and unquiesce by mutex
  blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING

 block/blk-core.c       |   2 +
 block/blk-mq-sysfs.c   |   2 -
 block/blk-mq.c         | 125 +++++++++++++++++++++++------------------
 block/blk-sysfs.c      |   6 +-
 include/linux/blk-mq.h |   7 ---
 include/linux/blkdev.h |   6 ++
 6 files changed, 82 insertions(+), 66 deletions(-)

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>
-- 
2.25.2

