Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1528C433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 17:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbiAERF1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:05:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40256 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbiAERF0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jan 2022 12:05:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A949D617C9
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 17:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAD1C36AE9;
        Wed,  5 Jan 2022 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641402325;
        bh=WC9QR45b9hMLbj6d6HxZ8ypkwBnGddX9RlV4N19YuXs=;
        h=From:To:Cc:Subject:Date:From;
        b=X5zo9rSHRZkW+2OBJ/lxCHzmmzG8R21+rDn96plb9ETPb2CJS0KDyknFy7vDWwNce
         D0bhNXtZi/nZFSR499r6OwZpLBoV9oIu7bG0gZnBr+P1gtPZ8Vum8RQ8tGJvvixPpa
         IUMMtJLLH/8vLIzNTcT3i0SR51AHsE7vgQXIebk3ARLcLtyFk+YjSHgjaamWgDeiar
         jwwHPGQxllzvK6TdyYzv1ctFYZqzYbnyBvBxIHb2n3ggSL0wqMMsdnu3IXprG3O7H1
         R5vhgFGVSDM/jzkOC89KPyV9umH7KKompzwuq/WydwMr3JWw/F4HvL22Iy/viQA9Ef
         PsGNzRw/ZKlMA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/4] queue_rqs error handling
Date:   Wed,  5 Jan 2022 09:05:14 -0800
Message-Id: <20220105170518.3181469-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only real change since v2 is a prep patch that relocates the rq list
macros to blk-mq.h since that's where 'struct request' is defined.

Patch 3 removes the 'next' parameter since it is trivially obtainable
via 'rq->rq_next' anyway.

Otherwise, the series is the same as v2 and tested with lots of random
error injection in the prep path. The same errors would have lost
requests in the current driver, but is successful with this series.

Keith Busch (4):
  block: move rq_list macros to blk-mq.h
  block: introduce rq_list_for_each_safe macro
  block: introduce rq_list_move
  nvme-pci: fix queue_rqs list splitting

 drivers/nvme/host/pci.c | 28 +++++++++++------------
 fs/io_uring.c           |  2 +-
 include/linux/blk-mq.h  | 50 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h  | 29 ------------------------
 4 files changed, 65 insertions(+), 44 deletions(-)

-- 
2.25.4

