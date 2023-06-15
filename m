Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92466EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 14:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbjFOOeW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245753AbjFOOeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 10:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C2310F6
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686839622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h5d1NP02bgpdQQCGG5YAFlCNf21xW9kSqLa8sb85qyw=;
        b=E2wDiZTp0Mev0WUiRBP97mOZaxqO5h/AYkMr/l5snH/f/8s70Ar7KLW+RWoayLBuH2Wh9v
        kIezLLwxu6ZlDIq73n3YfJxGDlH3Ee2TfWRIic+CzuM/MfP2ztpseRv533tYOzRk04UzTG
        lNKGPEYn053oA/83EaWpiH5XnU2kvYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-oxPPJgZxN-CmCEL-dB6wXg-1; Thu, 15 Jun 2023 10:33:38 -0400
X-MC-Unique: oxPPJgZxN-CmCEL-dB6wXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 848918030B0;
        Thu, 15 Jun 2023 14:32:44 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84109140E952;
        Thu, 15 Jun 2023 14:32:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] nvme: fix two kinds of IO hang from removing NSs
Date:   Thu, 15 Jun 2023 22:32:32 +0800
Message-Id: <20230615143236.297456-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st three patch fixes io hang when controller removal interrupts error
recovery, then queue is left as frozen.

The 4th patch fixes io hang when controller is left as unquiesce.

Ming Lei (4):
  blk-mq: add API of blk_mq_unfreeze_queue_force
  nvme: add nvme_unfreeze_force()
  nvme: unfreeze queues before removing namespaces
  nvme: unquiesce io queues when removing namespaces

 block/blk-mq.c           | 25 ++++++++++++++++++++++---
 block/blk.h              |  3 ++-
 block/genhd.c            |  2 +-
 drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h |  1 +
 include/linux/blk-mq.h   |  1 +
 6 files changed, 55 insertions(+), 11 deletions(-)

-- 
2.40.1

