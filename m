Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCFCC433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 19:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854BF206D4
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 19:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="SmB7UulX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG2TgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:36:23 -0400
Received: from ale.deltatee.com ([204.191.154.188]:53514 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgG2TgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 15:36:23 -0400
X-Greylist: delayed 1185 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2020 15:36:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DMu/9cwtHmi0bix+JDlgrcS0fN7h/PuWcrGpUj9X+KI=; b=SmB7UulXmX8eWXCcTcGcEqgK70
        7ZRvPLKAbaAmUq6OCoufsd7b4Z3BNjxqSiPIx9de+Gt3qGhK8O/nN6S0jJUVvkQoRZbOVMCDavoXy
        51z1uz7oLa1tX4P0NZRXYJn3O5eb8lepOBB1OuSiC2eBqYNIXYNFHNaL7E+XuEPWd1F71cdwfDqlH
        zUrZtKvJ2dlY7W9em0MgkSrvpAfPshaSXLGNoftFRozjiSrFi2EhYnLVNLl40ZnyagxrcAzd+0pjI
        3nUsyggzIbGsLicD6HtMPnAsHYRWeJ/qft9rWRfltVIjisHmo2req3bPjVsz3b6WCpXFcE/jHrEtZ
        YKm2Q7Xg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k0rZ6-0007cQ-Ke; Wed, 29 Jul 2020 13:16:37 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k0rZ3-0001FC-94; Wed, 29 Jul 2020 13:16:33 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Daniel Wagner <dwagner@suse.de>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 29 Jul 2020 13:16:28 -0600
Message-Id: <20200729191628.4741-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, martin.petersen@oracle.com, javier.gonz@samsung.com, hare@suse.de, dwagner@suse.de, keith.busch@wdc.com, johannes.thumshirn@wdc.com, matias.bjorling@wdc.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] nvme: Use spin_lock_irqsave() when taking the ctrl->lock
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

Note: this patch may be squashed with the patch noted in the fixes
tag, currently in nvme-5.9.

 drivers/nvme/host/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..ed8872022219 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2971,15 +2971,16 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 static struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
 {
 	struct nvme_cel *cel, *ret = NULL;
+	unsigned long flags;

-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	list_for_each_entry(cel, &ctrl->cels, entry) {
 		if (cel->csi == csi) {
 			ret = cel;
 			break;
 		}
 	}
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);

 	return ret;
 }
@@ -2988,6 +2989,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
 	struct nvme_cel *cel = nvme_find_cel(ctrl, csi);
+	unsigned long flags;
 	int ret;

 	if (cel)
@@ -3006,9 +3008,9 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,

 	cel->csi = csi;

-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	list_add_tail(&cel->entry, &ctrl->cels);
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 out:
 	*log = &cel->log;
 	return 0;

base-commit: b6cec06d19d90db5dbcc50034fb33983f6259b8b
--
2.20.1
