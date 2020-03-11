Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB53C10F27
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 10:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1DE21655
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 10:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UjW07GOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCKKiF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:38:05 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47359 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbgCKKiF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 06:38:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583923084; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=sybUymT2tahVIh0Sofyvb7j/sJL1ubpg84loPZROPYM=; b=UjW07GOLLAyW68rue0mru+yitglEXWTBkXypRydEuVIWWsw7swhijFQ/KmOhWIDMuxSmSOqG
 ebGacGA3J+TXpdHPdNFbrCswOujYoXBzG6IPy+crAazunlbJtqJXD15kktjsijT7fzKjNDK9
 tmOXBV/r8qsg37KkiIKn2QtYoOY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e68bf8b.7fe380132340-smtp-out-n02;
 Wed, 11 Mar 2020 10:38:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2DE3DC433BA; Wed, 11 Mar 2020 10:38:03 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E3B3C433CB;
        Wed, 11 Mar 2020 10:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E3B3C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH] block: Fix use-after-free issue accessing struct io_cq
Date:   Wed, 11 Mar 2020 16:07:50 +0530
Message-Id: <1583923070-22245-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a potential race between ioc_release_fn() and
ioc_clear_queue() as shown below, due to which below kernel
crash is observed. It also can result into use-after-free
issue.

context#1:				context#2:
ioc_release_fn()			__ioc_clear_queue() gets the same icq
->spin_lock(&ioc->lock);		->spin_lock(&ioc->lock);
->ioc_destroy_icq(icq);
  ->list_del_init(&icq->q_node);
  ->call_rcu(&icq->__rcu_head,
  	icq_free_icq_rcu);
->spin_unlock(&ioc->lock);
					->ioc_destroy_icq(icq);
					  ->hlist_del_init(&icq->ioc_node);
					  This results into below crash as this memory
					  is now used by icq->__rcu_head in context#1.
					  There is a chance that icq could be free'd
					  as well.

22150.386550:   <6> Unable to handle kernel write to read-only memory
at virtual address ffffffaa8d31ca50
...
Call trace:
22150.607350:   <2>  ioc_destroy_icq+0x44/0x110
22150.611202:   <2>  ioc_clear_queue+0xac/0x148
22150.615056:   <2>  blk_cleanup_queue+0x11c/0x1a0
22150.619174:   <2>  __scsi_remove_device+0xdc/0x128
22150.623465:   <2>  scsi_forget_host+0x2c/0x78
22150.627315:   <2>  scsi_remove_host+0x7c/0x2a0
22150.631257:   <2>  usb_stor_disconnect+0x74/0xc8
22150.635371:   <2>  usb_unbind_interface+0xc8/0x278
22150.639665:   <2>  device_release_driver_internal+0x198/0x250
22150.644897:   <2>  device_release_driver+0x24/0x30
22150.649176:   <2>  bus_remove_device+0xec/0x140
22150.653204:   <2>  device_del+0x270/0x460
22150.656712:   <2>  usb_disable_device+0x120/0x390
22150.660918:   <2>  usb_disconnect+0xf4/0x2e0
22150.664684:   <2>  hub_event+0xd70/0x17e8
22150.668197:   <2>  process_one_work+0x210/0x480
22150.672222:   <2>  worker_thread+0x32c/0x4c8

Fix this by adding a new ICQ_DESTROYED flag in ioc_destroy_icq() to
indicate this icq is once marked as destroyed. Also, ensure
__ioc_clear_queue() is accessing icq within rcu_read_lock/unlock so
that icq doesn't get free'd up while it is still using it.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Co-developed-by: Pradeep P V K <ppvk@codeaurora.org>
Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 block/blk-ioc.c           | 7 +++++++
 include/linux/iocontext.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 5ed59ac..9df50fb 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -84,6 +84,7 @@ static void ioc_destroy_icq(struct io_cq *icq)
 	 * making it impossible to determine icq_cache.  Record it in @icq.
 	 */
 	icq->__rcu_icq_cache = et->icq_cache;
+	icq->flags |= ICQ_DESTROYED;
 	call_rcu(&icq->__rcu_head, icq_free_icq_rcu);
 }
 
@@ -212,15 +213,21 @@ static void __ioc_clear_queue(struct list_head *icq_list)
 {
 	unsigned long flags;
 
+	rcu_read_lock();
 	while (!list_empty(icq_list)) {
 		struct io_cq *icq = list_entry(icq_list->next,
 						struct io_cq, q_node);
 		struct io_context *ioc = icq->ioc;
 
 		spin_lock_irqsave(&ioc->lock, flags);
+		if (icq->flags & ICQ_DESTROYED) {
+			spin_unlock_irqrestore(&ioc->lock, flags);
+			continue;
+		}
 		ioc_destroy_icq(icq);
 		spin_unlock_irqrestore(&ioc->lock, flags);
 	}
+	rcu_read_unlock();
 }
 
 /**
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index dba15ca..1dcd919 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -8,6 +8,7 @@
 
 enum {
 	ICQ_EXITED		= 1 << 2,
+	ICQ_DESTROYED		= 1 << 3,
 };
 
 /*
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
