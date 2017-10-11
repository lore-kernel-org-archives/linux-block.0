Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:37739 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdJKJxM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2017 05:53:12 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/3] Move tagset reinit to its only current consumer, nvme-core
Date: Wed, 11 Oct 2017 12:53:05 +0300
Message-Id: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

As suggested by Bart Van Assche, get rid of
blk_mq_reinit_tagset and move it to nvme-core (its
only current consumer).

Instead, introduce a more generic tagset iterator helper.

Changes from v1:
- pass tagset to nvme_reinit_tagset (Bart)

Sagi Grimberg (3):
  block: introduce blk_mq_tagset_iter
  nvme: introduce nvme_reinit_tagset
  block: remove blk_mq_reinit_tagset

 block/blk-mq-tag.c       | 11 +++++------
 drivers/nvme/host/core.c | 10 ++++++++++
 drivers/nvme/host/fc.c   |  3 ++-
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/rdma.c |  7 +++----
 include/linux/blk-mq.h   |  4 ++--
 6 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.7.4
