Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55375 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbdHOJwc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:32 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: Centralize nvme controller reset, delete and fabrics periodic reconnects
Date: Tue, 15 Aug 2017 12:52:13 +0300
Message-Id: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is the third part of the attempt to centralize controller reset,
delete and fabrics error recovery in nvme core.

As a reminder, the motivation is to get as much of the duplicate logic
existing in the various nvme transports to coommon code as possible.
We strive to have nvme core and fabrics modules take care of nvme and
fabrics constructs and initialization procedures and have our transports
simply worry about the underlying medium and spec extensions/enhancements.

This set is a step in that direction in the sense that it places a generic
controller initialization flows in nvme core, and converts two transports
to use common code.

The set is gradually reshaping nvme-rdma code to be more generic and then
simply move it to nvme-core (controller reset and delete) and nvme-fabrics
(error recovery and periodic reconnects). Then, nvme-loop is converted to
use nvme-core in one shot (Simply rip out all the duplicated logic).

Note that this patch set shouldn't break any transport that still does not
use it (pci, fc). The next part would be to take a stab at these transports
and add whatever is still needed to common code.

I tested this set with controller resets, deletes and error recovery in
the presence of I/O load. I tested rdma and loop.

Note that this direction got some exposure [1] and I tried to incorporate
feedback so if no hard objections are raised I plan to land this in 4.14.

This set applies on nvme-4.14 plus 4.13 recent fixes.

[1]:
http://www.mail-archive.com/linux-block@vger.kernel.org/msg09923.html
https://lwn.net/Articles/725720/

Sagi Grimberg (12):
  nvme: move err and reconnect work to nvme ctrl
  nvme-rdma: move admin specific resources to alloc_queue
  nvme-rdma: split nvme_rdma_alloc_io_queues
  nvme-rdma: restructure create_ctrl a bit
  nvme-rdma: introduce nvme_rdma_alloc/stop/free_admin_queue
  nvme-rdma: plumb nvme ctrl to various routines
  nvme-rdma: split generic probe out of create_ctrl
  nvme: add some ctrl ops for centralizing control plane logic.
  nvme: move control plane handling to nvme core
  nvme-fabrics: handle reconnects in fabrics library
  nvme: add sed-opal ctrl manipulation in admin configuration
  nvme-loop: convert to nvme-core control plane management

 drivers/nvme/host/core.c    | 312 +++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.c | 103 +++++++++
 drivers/nvme/host/fabrics.h |   1 +
 drivers/nvme/host/nvme.h    |  27 +++
 drivers/nvme/host/rdma.c    | 515 +++++++++-----------------------------------
 drivers/nvme/target/loop.c  | 443 ++++++++++++++-----------------------
 6 files changed, 706 insertions(+), 695 deletions(-)

-- 
2.7.4
