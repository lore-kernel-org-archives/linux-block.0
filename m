Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA130C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBC025972
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfEaABG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 20:01:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38374 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaABG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 20:01:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so4269021pfa.5
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 17:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=At7y9tpwmuqLFmWd0buLD3cE9YvDJstXP4wHxMpj1ao=;
        b=Nv2WBQaiFnpIv5sYSereVKbm07nsEsi7jNsaH63mVTLjqrnnv6C5NQGTY933uCMJK0
         3bUPl19D/FJNOgH2LIM2Xsvmj+Pw7pATm2CLv3TUca5DBpLDfLDFeiedaFWPLxhetQYq
         cG4lubc3YW3mGtz4vpAbrzS28B76mHlxf5e4t1zLiYjcZuXz8R9TeByinW3xD32J7agA
         C8S85hCJ8/B3Ks5czYqI8WJBTFcoT91cUeAEZmSnFLcRubhKe+YzNlr7qqOPbZUsNM3E
         7dqAJNmmamZDwJm4P4qbnGLeqlehETpW3yIpI+xQF9T0yMvg1HWwiu4jvFydghdPYPWu
         G0gQ==
X-Gm-Message-State: APjAAAU0NX0OCLy4oFrt6NcZYrHUCiURxYnX5+zYAZIMu+VyaMNFI7d8
        UzzIQAskABnnFkFCRUKoUNg=
X-Google-Smtp-Source: APXvYqwqGCsyn+rOX+gcg08qR8hZUPzDr/P0mIpY+psDE1wDY5umGIWeOQYwqX1deLiuIex2UOS3kg==
X-Received: by 2002:a65:664b:: with SMTP id z11mr2966555pgv.263.1559260865124;
        Thu, 30 May 2019 17:01:05 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g8sm3539851pjp.17.2019.05.30.17.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:01:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/8] block: Fix blk_mq_*_map_queues() kernel-doc headers
Date:   Thu, 30 May 2019 17:00:49 -0700
Message-Id: <20190531000053.64053-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190531000053.64053-1-bvanassche@acm.org>
References: <20190531000053.64053-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch avoids that the kernel-doc script complains about these
function headers when building with W=1.

Cc: Hannes Reinecke <hare@suse.com>
Cc: Keith Busch <keith.busch@intel.com>
Fixes: ed76e329d74a ("blk-mq: abstract out queue map") # v5.0.
Fixes: e42b3867de4b ("blk-mq-rdma: pass in queue map to blk_mq_rdma_map_queues") # v5.0.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-pci.c    | 2 +-
 block/blk-mq-rdma.c   | 4 ++--
 block/blk-mq-virtio.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index ad4545a2a98b..b595a94c4d16 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -13,7 +13,7 @@
 
 /**
  * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
- * @set:	tagset to provide the mapping for
+ * @qmap:	CPU to hardware queue map.
  * @pdev:	PCI device associated with @set.
  * @offset:	Offset to use for the pci irq vector
  *
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index cc921e6ba709..14f968e58b8f 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -8,8 +8,8 @@
 
 /**
  * blk_mq_rdma_map_queues - provide a default queue mapping for rdma device
- * @set:	tagset to provide the mapping for
- * @dev:	rdma device associated with @set.
+ * @map:	CPU to hardware queue map.
+ * @dev:	rdma device to provide a mapping for.
  * @first_vec:	first interrupt vectors to use for queues (usually 0)
  *
  * This function assumes the rdma device @dev has at least as many available
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 75a52c18a8f6..488341628256 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -11,8 +11,8 @@
 
 /**
  * blk_mq_virtio_map_queues - provide a default queue mapping for virtio device
- * @set:	tagset to provide the mapping for
- * @vdev:	virtio device associated with @set.
+ * @qmap:	CPU to hardware queue map.
+ * @vdev:	virtio device to provide a mapping for.
  * @first_vec:	first interrupt vectors to use for queues (usually 0)
  *
  * This function assumes the virtio device @vdev has at least as many available
-- 
2.22.0.rc1

