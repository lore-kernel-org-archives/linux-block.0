Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151E2C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 15:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D318D218C3
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 15:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FuYa0IVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbeLTPzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:55:22 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43623 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeLTPzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 10:55:22 -0500
Received: by mail-io1-f65.google.com with SMTP id g17so1165328ioc.10
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oB+0q7Lt2osTwYPEl0P7d/WPaYr05Cl62XCYWW8dKTA=;
        b=FuYa0IVd707cKSQ/yEIrXHZEhd1qlTjs+twhuZoqxIOQpZhdXEMnX7lKgyYwekD+Ep
         dtwxWQ7DMQRrZ72mm9fGPFbXuoPiY9aj+r1NN+llkwBeQNadvtTGmqf1Dao6umEzU7xB
         otN+k1PAefN/P7s9lA9z09bZHpVYn2OOC0TGLVbAauwSf8BYFlV0Cd15LdCj5NiTdMU2
         niX5S8MIfH+l6DeYQhbrzGOUrIr0ZEsmsOho2uDB5F65Er/Jj/rTB5GwkwYqD4YfFr8i
         qBmVFMXRSmUJJGhDGoOo0povaRcRjx9her2t10hGtkkf3s7Lnhn8zrHmxXrXaluOBGIi
         tdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oB+0q7Lt2osTwYPEl0P7d/WPaYr05Cl62XCYWW8dKTA=;
        b=mnrLiS2Qyv+ddyJlsWvRFxyR2e0gTTDZrihjw/XpmrH7D3jQSyNld6LeceE5lu4ZJb
         aOovvEJbn4fhvIFXv3V9pQXn3q4YrfJQ6fPIGBQZeI4WTAYKDVKKoRfH9lFj7psC/jEc
         Dl4fA0Bm2MQNjj0GOGjIrBc+cbMCvwfVlvAC3IiK3wNFj9pfI/0BDUcDsxi/A3v/v2uJ
         pzl31IjZ9q2rKEYPfPSAhdIcs9xRRqjpR1IAo3vBHX/XufWVM70Qsk8SJFHDWG8PoNnF
         tzqiIIRWAD9k0KLvKp0WmUoM9tN/BFM20ljF9O5oWzJHAtA4lrECtIzBOOIT9pp8AAWx
         U9TQ==
X-Gm-Message-State: AA+aEWYm0zkPOZcQoV0OhbKrVOkwV0ynNgNNaGJUEEv7HUGppNK7Uh+2
        oGUd8/ihBYxfjUvZHf90XyD+34piLY6cqw==
X-Google-Smtp-Source: AFSGD/XN44iWOWZKYCMcpA5GUTDcEeaepYh3XJigTBtyYoscUXQ0lJRqhVToxk+wjOXL8Twl0CMQgw==
X-Received: by 2002:a6b:c948:: with SMTP id z69mr23398912iof.161.1545321320909;
        Thu, 20 Dec 2018 07:55:20 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 18sm4987896itk.28.2018.12.20.07.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 07:55:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     ming.lei@redhat.com, osandov@osandov.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] sbitmap: add helpers for add/del wait queue handling
Date:   Thu, 20 Dec 2018 08:55:14 -0700
Message-Id: <20181220155515.31202-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220155515.31202-1-axboe@kernel.dk>
References: <20181220155515.31202-1-axboe@kernel.dk>
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

