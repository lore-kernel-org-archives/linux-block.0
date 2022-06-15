Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6964C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 06:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbiFOGsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 02:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241130AbiFOGsk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1577D45793
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 23:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655275717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vj7coqjOQU418lkmQhHr/ZFKyLd3AXnpf+KuHq61UvU=;
        b=Fuhty9F/6+QfHs9RQmd3SX5Y/nHBZanvxieRcd2pOop+utMtQWffASKZNiqyA6CfmHmbYK
        oxuLIG0Y6pSV93NLZ13wPG+ffIXwMnq61C86+pbuxzFPOheNNv8lvWOv39lvzYRd0fo0PZ
        XaajT30AVPOnbj7dpzzVNctiOmnSC+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-Z6npab6uMDa5DqxmCyonbw-1; Wed, 15 Jun 2022 02:48:33 -0400
X-MC-Unique: Z6npab6uMDa5DqxmCyonbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E85D6185A7B2;
        Wed, 15 Jun 2022 06:48:32 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1686840CF8E7;
        Wed, 15 Jun 2022 06:48:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/3] blk-mq: three misc patches
Date:   Wed, 15 Jun 2022 14:48:23 +0800
Message-Id: <20220615064826.773067-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

The 1st two patches make referring to q->elevator more reliable, and
avoid potential use-after-free on q->elevator in two code paths.

The 3rd patch improves boot time for scsi host with lots of hw queues.

V2:
	- follow Christoph's suggestion to set QUEUE_FLAG_SQ_SCHED inside
	mq-deadline and bfq directly

Ming Lei (3):
  blk-mq: protect q->elevator by ->sysfs_lock in blk_mq_elv_switch_none
  blk-mq: avoid to touch q->elevator without any protection
  blk-mq: don't clear flush_rq from tags->rqs[]

 block/bfq-iosched.c    |  3 +++
 block/blk-mq.c         | 27 ++++++++-------------------
 block/kyber-iosched.c  |  1 -
 block/mq-deadline.c    |  3 +++
 include/linux/blkdev.h |  4 ++--
 5 files changed, 16 insertions(+), 22 deletions(-)

-- 
2.31.1

