Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8E8C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 14:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiFXOOu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiFXOOh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 10:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCA374F9D0
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656080075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wun/GSFLFa2MllMAlT3CgPopruEFA/LDbTAl01uyokY=;
        b=cJGNlKkUHaJJobvoCiDy6/GKpQ7T8sNWlfTGGAWN+4ijFMLxAlBpm2J71kIXUELpObjmEh
        0hwSBPNLFdUrhWPEAb0gnYq3MWU3kw2rAVXQ7OeJI50OrrkB94bMoovCf3czr1+pflaQM6
        4KESmv8pM464Txq1K6FwcPa2TO4xcKU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-FXdgQMLoNjm_eYR0phKfIA-1; Fri, 24 Jun 2022 10:14:32 -0400
X-MC-Unique: FXdgQMLoNjm_eYR0phKfIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 386691C0513D;
        Fri, 24 Jun 2022 14:14:32 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CE6CC15D42;
        Fri, 24 Jun 2022 14:14:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5.20 0/4] block/dm: add bio_rewind for improving dm requeue
Date:   Fri, 24 Jun 2022 22:12:51 +0800
Message-Id: <20220624141255.2461148-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

The 1st patch adds bio_rewind which can restore bio to original position
by recording sectors between the original position to bio's end sector
if the bio's end sector won't change, which should be very common to
see.

The 2nd and 3rd patch cleans up dm code for handling requeue &
completion.

The last patch implements 2 stage dm io requeue for avoiding to allocate
one bio beforehand for just handling requeue which is one unusual event.
The 1st stage requeue is added for cloning & restoring original bio in wq
context, then 2nd stage requeue will use that as original bio for
handling requeue.


Ming Lei (4):
  block: add bio_rewind() API
  dm: add new helper for handling dm_io requeue
  dm: improve handling for DM_REQUEUE and AGAIN
  dm: add two stage requeue

 block/bio-integrity.c       |  19 ++++
 block/bio.c                 |  19 ++++
 block/blk-crypto-internal.h |   7 ++
 block/blk-crypto.c          |  23 +++++
 drivers/md/dm-core.h        |  11 ++-
 drivers/md/dm.c             | 180 ++++++++++++++++++++++++++++--------
 include/linux/bio.h         |  21 +++++
 include/linux/bvec.h        |  33 +++++++
 8 files changed, 271 insertions(+), 42 deletions(-)

-- 
2.31.1

