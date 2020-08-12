Return-Path: <SRS0=wHaM=BW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42738C433DF
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 23:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A3420774
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 23:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="i127Eu4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHLXYu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 19:24:50 -0400
Received: from ale.deltatee.com ([204.191.154.188]:39546 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHLXYu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 19:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TPtqtUSHRpoKKZiX58w5ytMOwEvWGOTrGUOwe/e4iiY=; b=i127Eu4N9N115gMCTdogO/LVfO
        7QxtBWFUmort9VlkNV+exxmd1xE1ZaP0kCf1gjofUrVN6R05BJWKGrtW7zP6hnuama9rhlWWgOtWL
        a0Ri5ub5jmRUxYnAI4ILAzJkHzrnptFH/5ArdqY+9ru5BcI64P74VESR4+XvyU9wPHhkt9makbFu0
        sVNGYCYS4Ukh71soqyLX+eqN73q0LO2mv9xeILQh6gsF7GJAmKYI71o+xaSaxSYPusxDLN3q3gJHp
        Uf4dtou0F13mb1527a+VZxrnQAc9izoot8Jz1GpYo+T9ZXjIvpLEYfGkAO/udWRKlLWkUrJOWqNVQ
        vPS+DZnA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k606y-0006NP-2I; Wed, 12 Aug 2020 17:24:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k606w-0004m3-NI; Wed, 12 Aug 2020 17:24:46 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 12 Aug 2020 17:24:44 -0600
Message-Id: <20200812232444.18310-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, keith.busch@wdc.com, axboe@kernel.dk, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2] nvme: Use spin_lock_irq() when taking the ctrl->lock
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When locking the ctrl->lock spinlock IRQs need to be disabled to avoid a
dead lock. The new spin_lock() calls recently added produce the
following lockdep warning when running the blktest nvme/003:

    ================================
    WARNING: inconsistent lock state
    --------------------------------
    inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
    ksoftirqd/2/22 [HC0[0]:SC1[1]:HE0:SE0] takes:
    ffff888276a8c4c0 (&ctrl->lock){+.?.}-{2:2}, at: nvme_keep_alive_end_io+0x50/0xc0
    {SOFTIRQ-ON-W} state was registered at:
      lock_acquire+0x164/0x500
      _raw_spin_lock+0x28/0x40
      nvme_get_effects_log+0x37/0x1c0
      nvme_init_identify+0x9e4/0x14f0
      nvme_reset_work+0xadd/0x2360
      process_one_work+0x66b/0xb70
      worker_thread+0x6e/0x6c0
      kthread+0x1e7/0x210
      ret_from_fork+0x22/0x30
    irq event stamp: 1449221
    hardirqs last  enabled at (1449220): [<ffffffff81c58e69>] ktime_get+0xf9/0x140
    hardirqs last disabled at (1449221): [<ffffffff83129665>] _raw_spin_lock_irqsave+0x25/0x60
    softirqs last  enabled at (1449210): [<ffffffff83400447>] __do_softirq+0x447/0x595
    softirqs last disabled at (1449215): [<ffffffff81b489b5>] run_ksoftirqd+0x35/0x50

    other info that might help us debug this:
     Possible unsafe locking scenario:

           CPU0
           ----
      lock(&ctrl->lock);
      <Interrupt>
        lock(&ctrl->lock);

     *** DEADLOCK ***

    no locks held by ksoftirqd/2/22.

    stack backtrace:
    CPU: 2 PID: 22 Comm: ksoftirqd/2 Not tainted 5.8.0-rc4-eid-vmlocalyes-dbg-00157-g7236657c6b3a #1450
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
    Call Trace:
     dump_stack+0xc8/0x11a
     print_usage_bug.cold.63+0x235/0x23e
     mark_lock+0xa9c/0xcf0
     __lock_acquire+0xd9a/0x2b50
     lock_acquire+0x164/0x500
     _raw_spin_lock_irqsave+0x40/0x60
     nvme_keep_alive_end_io+0x50/0xc0
     blk_mq_end_request+0x158/0x210
     nvme_complete_rq+0x146/0x500
     nvme_loop_complete_rq+0x26/0x30 [nvme_loop]
     blk_done_softirq+0x187/0x1e0
     __do_softirq+0x118/0x595
     run_ksoftirqd+0x35/0x50
     smpboot_thread_fn+0x1d3/0x310
     kthread+0x1e7/0x210
     ret_from_fork+0x22/0x30

Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---

v2 uses spin_lock_irq() instead of spin_lock_irqsave() as these
functions should never be called in an interrupt disabled context.

 drivers/nvme/host/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 15abc00db3d3..5e23fe029140 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2972,14 +2972,14 @@ static struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
 {
 	struct nvme_cel *cel, *ret = NULL;

-	spin_lock(&ctrl->lock);
+	spin_lock_irq(&ctrl->lock);
 	list_for_each_entry(cel, &ctrl->cels, entry) {
 		if (cel->csi == csi) {
 			ret = cel;
 			break;
 		}
 	}
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irq(&ctrl->lock);

 	return ret;
 }
@@ -3006,9 +3006,9 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,

 	cel->csi = csi;

-	spin_lock(&ctrl->lock);
+	spin_lock_irq(&ctrl->lock);
 	list_add_tail(&cel->entry, &ctrl->cels);
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irq(&ctrl->lock);
 out:
 	*log = &cel->log;
 	return 0;
@@ -3179,7 +3179,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
-
+
 	ret = nvme_configure_timestamp(ctrl);
 	if (ret < 0)
 		return ret;

base-commit: 4d3c0eaf0d44a4f8f7d53b7835e670eafc96c450
--
2.20.1
