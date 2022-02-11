Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C8AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 10:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348787AbiBKKMl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:12:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348745AbiBKKMl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 05:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59FDDAF
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 02:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644574359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zBLdvSurNU7oU27wupRTvMMPRGzbguxjCc0tCLUda0U=;
        b=Sv2hoOH5LV0l3TGOcTrxllCbkhHzX300KvebM5a4sDrSUs0viw6wsQxTt2SmKrRS7PSG0M
        t6xmn0oTdyeAQ38KbffaYgmM7/6y+A2a4Z1qAx3c0t1oxd85TaS5Rh/Ia7j27kvkMO0GMB
        y343Ofh6rIjmoBV2Sr6QAU78/7/gYTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-0tLM57z6PoW2Coxq6b6KPg-1; Fri, 11 Feb 2022 05:12:38 -0500
X-MC-Unique: 0tLM57z6PoW2Coxq6b6KPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E8761091DA2;
        Fri, 11 Feb 2022 10:12:36 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F30295E4A5;
        Fri, 11 Feb 2022 10:12:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] block: cleanup cgroup
Date:   Fri, 11 Feb 2022 18:11:46 +0800
Message-Id: <20220211101149.2368042-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st two patches cleans up blk-cgroup code a bit.

The 3rd patch moves block layer internal definition into one private
header of block/blk-cgroup.h, as suggested by Christoph, and the idea
is that just small amount of structures & functions need to be exported,
and most of them are block layer internal structures and functions.


Ming Lei (3):
  block: remove THROTL_IOPS_MAX
  block: move initialization of q->blkg_list into blkcg_init_queue
  block: partition include/linux/blk-cgroup.h

 block/bfq-iosched.h         |   1 -
 block/bio.c                 |   2 +-
 block/blk-cgroup-rwstat.h   |   2 +-
 block/blk-cgroup.c          |   4 +-
 block/blk-cgroup.h          | 477 ++++++++++++++++++++++++++++++++++++
 block/blk-core.c            |   5 +-
 block/blk-crypto-fallback.c |   2 +-
 block/blk-iocost.c          |   2 +-
 block/blk-iolatency.c       |   2 +-
 block/blk-ioprio.c          |   2 +-
 block/blk-sysfs.c           |   2 +-
 block/blk-throttle.c        |   1 -
 block/bounce.c              |   2 +-
 block/elevator.c            |   2 +-
 include/linux/blk-cgroup.h  | 461 +---------------------------------
 15 files changed, 495 insertions(+), 472 deletions(-)
 create mode 100644 block/blk-cgroup.h

-- 
2.31.1

