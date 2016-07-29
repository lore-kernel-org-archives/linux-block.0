Return-Path: <krisman@linux.vnet.ibm.com>
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Brian King <brking@linux.vnet.ibm.com>,
        Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH v2] blk-mq: Allow timeouts to run while queue is freezing
References: <1469767356-25193-1-git-send-email-krisman@linux.vnet.ibm.com>
	<81fa2a75-1da8-aeb6-dcce-3ae245810234@kernel.dk>
Date: Fri, 29 Jul 2016 14:52:14 -0300
In-Reply-To: <81fa2a75-1da8-aeb6-dcce-3ae245810234@kernel.dk> (Jens Axboe's
	message of "Fri, 29 Jul 2016 08:43:50 -0600")
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760rogwmp.fsf_-_@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

> I can see that is an issue. Did you consider the case where
> blk_mq_timeout_work() is entered, but we don't have any requests
> allocated that currently hold a reference? This could happen if
> completion races with a timeout.

Hi Jens,

That shouldn't be an issue, I think.  The only functional difference
should be during queue freezes, and in this case, if the request was
already completed by the time we touch it, we`ll only hold the queue
freeze for a little longer, until we release the reference by the end of
the timeout path.  should the final request be released before
blk_mq_timeout_work acquire it's reference, q_usage_counter will reach
zero, and the call to percpu_ref_tryget will fail the same way
percpu_ref_tryget_live would.

> In any case, this warrants a big comment explaining why it's open
> coded. Or, better yet, have an internal __blk_queue_enter() or something
> that at least shows it's related, and with a comment on why it's
> different and where it's allowed to be used.

Absolutely.  Below is a v2 which includes the comment.  I didn't create
a new internal function because I don't see other places where it would
be useful, and we should discourage it's use unless strictly necessary.
If you find it useful, I can resend with that change.

Thanks,

-- >8 --
Subject: [PATCH v2] blk-mq: Allow timeouts to run while queue is freezing

In case a submitted request gets stuck for some reason, the block layer
can prevent the request starvation by starting the scheduled timeout work.
If this stuck request occurs at the same time another thread has started
a queue freeze, the blk_mq_timeout_work will not be able to acquire the
queue reference and will return silently, thus not issuing the timeout.
But since the request is already holding a q_usage_counter reference and
is unable to complete, it will never release its reference, preventing
the queue from completing the freeze started by first thread.  This puts
the request_queue in a hung state, forever waiting for the freeze
completion.

This was observed while running IO to a NVMe device at the same time we
toggled the CPU hotplug code. Eventually, once a request got stuck
requiring a timeout during a queue freeze, we saw the CPU Hotplug
notification code get stuck inside blk_mq_freeze_queue_wait, as shown in
the trace below.

[c000000deaf13690] [c000000deaf13738] 0xc000000deaf13738 (unreliable)
[c000000deaf13860] [c000000000015ce8] __switch_to+0x1f8/0x350
[c000000deaf138b0] [c000000000ade0e4] __schedule+0x314/0x990
[c000000deaf13940] [c000000000ade7a8] schedule+0x48/0xc0
[c000000deaf13970] [c0000000005492a4] blk_mq_freeze_queue_wait+0x74/0x110
[c000000deaf139e0] [c00000000054b6a8] blk_mq_queue_reinit_notify+0x1a8/0x2e0
[c000000deaf13a40] [c0000000000e7878] notifier_call_chain+0x98/0x100
[c000000deaf13a90] [c0000000000b8e08] cpu_notify_nofail+0x48/0xa0
[c000000deaf13ac0] [c0000000000b92f0] _cpu_down+0x2a0/0x400
[c000000deaf13b90] [c0000000000b94a8] cpu_down+0x58/0xa0
[c000000deaf13bc0] [c0000000006d5dcc] cpu_subsys_offline+0x2c/0x50
[c000000deaf13bf0] [c0000000006cd244] device_offline+0x104/0x140
[c000000deaf13c30] [c0000000006cd40c] online_store+0x6c/0xc0
[c000000deaf13c80] [c0000000006c8c78] dev_attr_store+0x68/0xa0
[c000000deaf13cc0] [c0000000003974d0] sysfs_kf_write+0x80/0xb0
[c000000deaf13d00] [c0000000003963e8] kernfs_fop_write+0x188/0x200
[c000000deaf13d50] [c0000000002e0f6c] __vfs_write+0x6c/0xe0
[c000000deaf13d90] [c0000000002e1ca0] vfs_write+0xc0/0x230
[c000000deaf13de0] [c0000000002e2cdc] SyS_write+0x6c/0x110
[c000000deaf13e30] [c000000000009204] system_call+0x38/0xb4

The fix is to allow the timeout work to execute in the window between
dropping the initial refcount reference and the release of the last
reference, which actually marks the freeze completion.  This can be
achieved with percpu_refcount_tryget, which does not require the counter
to be alive.  This way the timeout work can do it's job and terminate a
stuck request even during a freeze, returning its reference and avoiding
the deadlock.

Allowing the timeout to run is just a part of the fix, since for some
devices, we might get stuck again inside the device driver's timeout
handler, should it attempt to allocate a new request in that path -
which is a quite common action for Abort commands, which need to be sent
after a timeout.  In NVMe, for instance, we call blk_mq_alloc_request
from inside the timeout handler, which will fail during a freeze, since
it also tries to acquire a queue reference.

I considered a similar change to blk_mq_alloc_request as a generic
solution for further device driver hangs, but we can't do that, since it
would allow new requests to disturb the freeze process.  I thought about
creating a new function in the block layer to support unfreezable
requests for these occasions, but after working on it for a while, I
feel like this should be handled in a per-driver basis.  I'm now
experimenting with changes to the NVMe timeout path, but I'm open to
suggestions of ways to make this generic.

Signed-off-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org
---
 block/blk-mq.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e22a0f4..2cc5b82 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -672,7 +672,20 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	};
 	int i;
 
-	if (blk_queue_enter(q, true))
+	/* A deadlock might occur if a request is stuck requiring a
+	 * timeout at the same time a queue freeze is waiting
+	 * completion, since the timeout code would not be able to
+	 * acquire the queue reference here.
+	 *
+	 * That's why we don't use blk_queue_enter here; instead, we use
+	 * percpu_ref_tryget directly, because we need to be able to
+	 * obtain a reference even in the short window between the queue
+	 * starting to freeze, by dropping the first reference in
+	 * blk_mq_freeze_queue_start, and the moment the last request is
+	 * consumed, marked by the instant q_usage_counter reaches
+	 * zero.
+	 */
+	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
-- 
2.7.4
