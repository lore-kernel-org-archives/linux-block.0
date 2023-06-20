Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFFBEB64DA
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 01:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjFTBet (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jun 2023 21:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFTBet (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 21:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69551A7
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2023 18:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687224844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hnKE0nWEUjeGlqjsFGsu3Do4KMRWEFRQSaAwoffC8eg=;
        b=G4k8RFtGd82f2l453d/PBHm2A1hwqcRHn9hkJyIKyI1amSPRzEQ1HFTfQ2IFpzTQNGb825
        icyW00NjfVRx0vFuyM/M5DFxiVSgoue7ra+mCeqQXCf+CpRd/igt2n1byJbJmjOPW+j4IQ
        drbAGVmsT42V0BiBvuo5wYtyvwf3dKo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-6Q6a6IjnMyGE37_4pFG2UA-1; Mon, 19 Jun 2023 21:33:58 -0400
X-MC-Unique: 6Q6a6IjnMyGE37_4pFG2UA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E20F229ABA25;
        Tue, 20 Jun 2023 01:33:57 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7704C1603B;
        Tue, 20 Jun 2023 01:33:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Date:   Tue, 20 Jun 2023 09:33:45 +0800
Message-Id: <20230620013349.906601-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st three patch fixes io hang when controller removal interrupts error
recovery, then queue is left as frozen.

The 4th patch fixes io hang when controller is left as unquiesce.

V2:
	- don't unfreeze queue which isn't frozen for avoiding warning from
	percpu_ref_resurrect() 

Ming Lei (4):
  blk-mq: add API of blk_mq_unfreeze_queue_force
  nvme: add nvme_unfreeze_force()
  nvme: unfreeze queues before removing namespaces
  nvme: unquiesce io queues when removing namespaces

 block/blk-mq.c           | 28 +++++++++++++++++++++++++---
 block/blk.h              |  3 ++-
 block/genhd.c            |  2 +-
 drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h |  1 +
 include/linux/blk-mq.h   |  1 +
 6 files changed, 58 insertions(+), 11 deletions(-)

-- 
2.40.1

