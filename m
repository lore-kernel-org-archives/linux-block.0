Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D6EC43612
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFF220645
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Sf/re0i2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbeLTQBz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:01:55 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51910 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbeLTQBz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:01:55 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so2710794ite.1
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oB+0q7Lt2osTwYPEl0P7d/WPaYr05Cl62XCYWW8dKTA=;
        b=Sf/re0i2hroaycGGP6A4x+ImVc1oRT4WMza6G9ZX2ArpLS3z6+ZJPXEwB1c8ruJSyu
         p2FB94BW0hSrNTEpuXViT1Qp7zbmWRSw3+TYLfVn+JdqpQk25iOWvW7iaT4tN2ZBqqPF
         cFsqvE09r+7cLSn51Txeu4yia2hpFgOePK/dT0x4waJCO5BqdFPTc+ML1yY0VYZ/On/4
         RXPi2WDGt67iUQEKtzhZ4qqepLu3oTJDeYUk1AaOUYw8R6Zo6Xe6AI0BMe5eE0mOmqAj
         TSsRDjsEcYSxLrETu+o7Mg5JypAaXvYJpkZkXUDpx93V2oPkd7mAJxvXOXFqocaBdQgl
         5V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oB+0q7Lt2osTwYPEl0P7d/WPaYr05Cl62XCYWW8dKTA=;
        b=iY+/QxEoMxUrP8TOYAgTfJ07Z9cLZ9iK2rax6k8V1j6uN3m1dXDCMPF63Pepf9pH2a
         OiU/Koyn/4LrSgzWjVPxY59RikPDC1fdxhpqmjVKsMl1rzKe72QOlfOatpWm/USx9ZRT
         q5UZ3W00ijJUS8Rr1svYC8KPpSvTgm+mC9eUzzEXkL9Xp/s7MWrKt9ibt82/Q7hrYun8
         6AF3Qj0HQ1tQ/5L3yvvjD8VzqiLwLnekZMePNojg+4kLNrD0Ra63JqeC5yFV8nSUVNN9
         MigKdhIxE7ahBLypS2mzRFAlxf1WZvnfNjU2BDFU0R1C7IJ1Z4O3h5xv023x0qpVCXZb
         nwzA==
X-Gm-Message-State: AA+aEWbYCKu7l8RvYvTunyWnS7cZdyAwe3W1I0tuei/hoNcroIaSRVMX
        vEoCLthyN6+cVtsXmye89ceZSLEFQV0LSA==
X-Google-Smtp-Source: AFSGD/XvoMuGtg20yp3M+6DosoEN2TbbYnSKUMTGkHWsqzmjuPHX/nF8ZNdemmj0DI/NjuRmCKmJRA==
X-Received: by 2002:a02:8527:: with SMTP id g36mr21696205jai.135.1545321713663;
        Thu, 20 Dec 2018 08:01:53 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x99sm4974365ita.23.2018.12.20.08.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 08:01:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     ming.lei@redhat.com, osandov@osandov.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] sbitmap: add helpers for add/del wait queue handling
Date:   Thu, 20 Dec 2018 09:01:48 -0700
Message-Id: <20181220160149.4042-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220160149.4042-1-axboe@kernel.dk>
References: <20181220160149.4042-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After commit 5d2ee7122c73, users of sbitmap that need wait queue
handling must use the provided helpers. But we only added
prepare_to_wait()/finish_wait() style helpers, add the equivalent
add_wait_queue/list_del wrappers as we..

This is needed to ensure kyber plays by the sbitmap waitqueue
rules.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/sbitmap.h | 16 ++++++++++++++--
 lib/sbitmap.c           | 30 ++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 03f50fcedc79..14d558146aea 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -560,13 +560,13 @@ void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
 void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
 
 struct sbq_wait {
-	int accounted;
+	struct sbitmap_queue *sbq;	/* if set, sbq_wait is accounted */
 	struct wait_queue_entry wait;
 };
 
 #define DEFINE_SBQ_WAIT(name)							\
 	struct sbq_wait name = {						\
-		.accounted = 0,							\
+		.sbq = NULL,							\
 		.wait = {							\
 			.private	= current,				\
 			.func		= autoremove_wake_function,		\
@@ -588,4 +588,16 @@ void sbitmap_prepare_to_wait(struct sbitmap_queue *sbq,
 void sbitmap_finish_wait(struct sbitmap_queue *sbq, struct sbq_wait_state *ws,
 				struct sbq_wait *sbq_wait);
 
+/*
+ * Wrapper around add_wait_queue(), which maintains some extra internal state
+ */
+void sbitmap_add_wait_queue(struct sbitmap_queue *sbq,
+			    struct sbq_wait_state *ws,
+			    struct sbq_wait *sbq_wait);
+
+/*
+ * Must be paired with sbitmap_add_wait_queue()
+ */
+void sbitmap_del_wait_queue(struct sbq_wait *sbq_wait);
+
 #endif /* __LINUX_SCALE_BITMAP_H */
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 5b3e56d68dab..65c2d06250a6 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -671,13 +671,35 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_show);
 
+void sbitmap_add_wait_queue(struct sbitmap_queue *sbq,
+			    struct sbq_wait_state *ws,
+			    struct sbq_wait *sbq_wait)
+{
+	if (!sbq_wait->sbq) {
+		sbq_wait->sbq = sbq;
+		atomic_inc(&sbq->ws_active);
+	}
+	add_wait_queue(&ws->wait, &sbq_wait->wait);
+}
+EXPORT_SYMBOL_GPL(sbitmap_add_wait_queue);
+
+void sbitmap_del_wait_queue(struct sbq_wait *sbq_wait)
+{
+	list_del_init(&sbq_wait->wait.entry);
+	if (sbq_wait->sbq) {
+		atomic_dec(&sbq_wait->sbq->ws_active);
+		sbq_wait->sbq = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(sbitmap_del_wait_queue);
+
 void sbitmap_prepare_to_wait(struct sbitmap_queue *sbq,
 			     struct sbq_wait_state *ws,
 			     struct sbq_wait *sbq_wait, int state)
 {
-	if (!sbq_wait->accounted) {
+	if (!sbq_wait->sbq) {
 		atomic_inc(&sbq->ws_active);
-		sbq_wait->accounted = 1;
+		sbq_wait->sbq = sbq;
 	}
 	prepare_to_wait_exclusive(&ws->wait, &sbq_wait->wait, state);
 }
@@ -687,9 +709,9 @@ void sbitmap_finish_wait(struct sbitmap_queue *sbq, struct sbq_wait_state *ws,
 			 struct sbq_wait *sbq_wait)
 {
 	finish_wait(&ws->wait, &sbq_wait->wait);
-	if (sbq_wait->accounted) {
+	if (sbq_wait->sbq) {
 		atomic_dec(&sbq->ws_active);
-		sbq_wait->accounted = 0;
+		sbq_wait->sbq = NULL;
 	}
 }
 EXPORT_SYMBOL_GPL(sbitmap_finish_wait);
-- 
2.17.1

