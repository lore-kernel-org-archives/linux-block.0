Return-Path: <keith.busch@linux.intel.com>
Date: Mon, 21 May 2018 08:04:13 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] nvme: Sync request queues on reset
Message-ID: <20180521140413.GA5528@localhost.localdomain>
References: <20180518163823.27820-1-keith.busch@intel.com>
 <20180518223210.GB18334@ming.t460p>
 <20180518234408.GA31749@localhost.localdomain>
 <20180519000141.GB19799@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180519000141.GB19799@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Sat, May 19, 2018 at 08:01:42AM +0800, Ming Lei wrote:
> > You keep saying that, but the controller state is global to the
> > controller. It doesn't matter which namespace request_queue started the
> > reset: every namespaces request queue sees the RESETTING controller state
> 
> When timeouts come, the global state of RESETTING may not be updated
> yet, so all the timeouts may not observe the state.

Even prior to the RESETING state, every single command, no matter
which namespace or request_queue it came on, is reclaimed by the driver.
There *should* be no requests to timeout after nvme_dev_disable is called
because the nvme driver returned control of all requests in the tagset
to blk-mq.

In any case, if blk-mq decides it won't complete those requests, we
can just swap the order in the reset_work: sync first, uncondintionally
disable. Does the following snippet look more okay?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17a0190bd88f..42af077ee07a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2307,11 +2307,14 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 
 	/*
-	 * If we're called to reset a live controller first shut it down before
-	 * moving on.
+	 * Ensure there are no timeout work in progress prior to forcefully
+	 * disabling the queue. There is no harm in disabling the device even
+	 * when it was already disabled, as this will forcefully reclaim any
+	 * IOs that are stuck due to blk-mq's timeout handling that prevents
+	 * timed out requests from completing.
 	 */
-	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
-		nvme_dev_disable(dev, false);
+	nvme_sync_queues(&dev->ctrl);
+	nvme_dev_disable(dev, false);
 
 	/*
 	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
--
