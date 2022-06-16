Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3A3C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 01:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347366AbiFPBoa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245496AbiFPBoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 21:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1322C27FC7
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 18:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655343850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TOoPgyWD9fg/Wm2nui9RyMQFJUIIc4rg9sp1CPo2K0c=;
        b=PPdENAqjJDUNjB8j5OUR+GpZ34VUHcIszCKhKkgkku8VrZPWySE7FlnwFTnt9W3RA/wUNS
        Hf2h8Vz7eLJ09sGxiN/LDW/HZIFlssoTYChQmQInvhqMEq0IMvNRTENJQq0ZV74Dra+7Lk
        zENhol4TFWCHCL5zjfdgN2wKXsxuPts=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-HhfhQF18NLCVC0kzj8keTw-1; Wed, 15 Jun 2022 21:44:07 -0400
X-MC-Unique: HhfhQF18NLCVC0kzj8keTw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73DDD1C0F682;
        Thu, 16 Jun 2022 01:44:07 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98D03492CA5;
        Thu, 16 Jun 2022 01:44:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/3] blk-mq: three misc patches
Date:   Thu, 16 Jun 2022 09:43:58 +0800
Message-Id: <20220616014401.817001-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

The 1st two patches make referring to q->elevator more reliable, and
avoid potential use-after-free on q->elevator in two code paths.

The 3rd patch improves boot time for scsi host with lots of hw queues.

V3:
	- clear QUEUE_FLAG_SQ_SCHED for none & kyber explicitly

V2:
	- follow Christoph's suggestion to set QUEUE_FLAG_SQ_SCHED inside
	mq-deadline and bfq directly


Ming Lei (3):
  blk-mq: protect q->elevator by ->sysfs_lock in blk_mq_elv_switch_none
  blk-mq: avoid to touch q->elevator without any protection
  blk-mq: don't clear flush_rq from tags->rqs[]

 block/bfq-iosched.c    |  3 +++
 block/blk-mq-sched.c   |  1 +
 block/blk-mq.c         | 27 ++++++++-------------------
 block/kyber-iosched.c  |  3 ++-
 block/mq-deadline.c    |  3 +++
 include/linux/blkdev.h |  4 ++--
 6 files changed, 19 insertions(+), 22 deletions(-)

-- 
2.31.1

