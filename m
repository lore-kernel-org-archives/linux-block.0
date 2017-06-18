Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52066 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbdFRPWP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:15 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 00/30] centralize nvme controller reset, delete and periodic reconnects
Date: Sun, 18 Jun 2017 18:21:34 +0300
Message-Id: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We know for a some time now that ever since NVMe grew additional
transports, we should really look into centralizing lots of code
around controller resets, removals, and periodic reconnects for fabrics.

This series is the first attempt to move shared logic to nvme core.
Controller probe, reset and removal flows are completely driven
from nvme core while the various transports simply implement hooks
for alloc/free/start/stop queues, alloc/free tagsets, and some
sanity post-init checks. Similarly, nvme-fabrics lib drives periodic
reconnects and fabric error recovery.

In this set, rdma and loop drivers are fully converted to delegate
these flows to the nvme core. The implementation is incremental in
the sense that it adds the logic to nvme core but does not obligate
drivers to use it, so pci and fc drivers are left intact.

I tested rdma and loop stress reset, delete and fabric errors
during live IO and they seem to work (on poor vms though, thanks
Johannes for fixing up rxe ;)).

I've started looking into converting pci and fc, but I don't have
much time to make real progress at the moment. Assuming that the
scheme looks fine for everyone (big IFF), I'd like to ask the
community if it will be acceptable to merge this and incrementally
enhance it to accommodate pci and fc (pci is more of a challenge in
my PoV).

About the patch set itself, I sorta worked my way up from rdma.c to
make the relevant flows and routines generic by slowly removing
transport dependancies, then made the some routines controller ops,
and then moved some chunks of the code as-is to core.c and fabrics.c
respectively, this was mainly for debugging purposes. Each patch of it's
own, might not make perfect sense (and probably I didn't put too much
effort in their change logs). when we get closer to inclusion, we can
squash lots of these together if desired. 

Feedback is appreciated and highly needed!

As a side note, I also had a go with adding queues representation to the
nvme core (with proper states), but it seemed to be too far out there for
now... I'll consider proposing it as a follow up series.

Sagi Grimberg (30):
  nvme: Add admin connect request queue
  nvme-rdma: Don't alloc/free the tagset on reset
  nvme-rdma: reuse configure/destroy admin queue
  nvme-rdma: introduce configure/destroy io queues
  nvme-rdma: introduce nvme_rdma_start_queue
  nvme-rdma: rename nvme_rdma_init_queue to nvme_rdma_alloc_queue
  nvme-rdma: make stop/free queue receive a ctrl and qid struct
  nvme-rdma: cleanup error path in controller reset
  nvme: Move queue_count to the nvme_ctrl
  nvme: Add admin_tagset pointer to nvme_ctrl
  nvme: move controller cap to struct nvme_ctrl
  nvme-rdma: disable controller in reset instead of shutdown
  nvme-rdma: move queue LIVE/DELETING flags settings to queue routines
  nvme-rdma: stop queues instead of simply flipping their state
  nvme-rdma: don't check queue state for shutdown/disable
  nvme-rdma: move tagset allocation to a dedicated routine
  nvme-rdma: move admin specific resources to alloc_queue
  nvme-rdma: limit max_queues to rdma device number of completion
    vectors
  nvme-rdma: call ops->reg_read64 instead of nvmf_reg_read64
  nvme: add err, reconnect and delete work items to nvme core
  nvme-rdma: plumb nvme_ctrl down the calls tack
  nvme-rdma: Split create_ctrl to transport specific and generic parts
  nvme: add low level queue and tagset controller ops
  nvme-pci: rename to nvme_pci_configure_admin_queue
  nvme: move control plane handling to nvme core
  nvme-fabrics: handle reconnects in fabrics library
  nvme-loop: convert to nvme-core control plane management
  nvme: update tagset nr_hw_queues when reallocating io queues
  nvme: add sed-opal ctrl manipulation in admin configuration
  nvme: Add queue freeze/unfreeze handling on controller resets

 drivers/nvme/host/core.c    | 415 +++++++++++++++++++++++++
 drivers/nvme/host/fabrics.c | 104 ++++++-
 drivers/nvme/host/fabrics.h |   1 +
 drivers/nvme/host/fc.c      |  11 +-
 drivers/nvme/host/nvme.h    |  31 ++
 drivers/nvme/host/pci.c     |   4 +-
 drivers/nvme/host/rdma.c    | 741 ++++++++++----------------------------------
 drivers/nvme/target/loop.c  | 415 +++++++------------------
 8 files changed, 840 insertions(+), 882 deletions(-)

-- 
2.7.4
