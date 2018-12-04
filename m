Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237C3C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DA620850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kjFVKuX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DA620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeLDXh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:37:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38699 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeLDXh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:37:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so8094688pgc.5
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fw/O4zwzIPzN/w4BqDNf+gyUsaBSdiYM1Ss+7FBryao=;
        b=kjFVKuX27kUtJSUMX2coC/c20FfIZx9y/OTxfRiLxLm13H+dnDhuSfmoo/EiDXoORz
         xkDZh8kCC/vnqsqZp9mxQ5pmmuBdMw6reTtXaatWtGPepolGdzS53Tez4fcCS1Hm9fKb
         1MG7Bv5EYsYBGjP9U84pnrn8QK+4hE3zphmo4JuKEFOmn37D4HD3lhy1hjk9NzxmogdH
         kN2EERERbGLbJNheu5Kk+K3dlJjCBdGg4XuD3be41hVDVj8siKBZI/K8V4hu/T93l5Dz
         rfdMGifSJl84vHut0x+o3fPrC4v9HCZZZXdp/W8qAoTydFdMJXoAjbe7UDhnVG+uCgh4
         XPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fw/O4zwzIPzN/w4BqDNf+gyUsaBSdiYM1Ss+7FBryao=;
        b=kENQrqNiFlM3LSEavho03ChS4Y5Yw6PTELsIM5iZxtyoU9qzUNnIa+fhxi8C7y55Ve
         VU4AeZxOU6DYTuJVY5G9uUZDo5vBbUdH+5yy+PruXbwyso5gtNWbfU65F+tGkFchMB1Y
         FX3EH84U1ObfxdOzNR2zMyGB+ShLhwW2/3o1T9eL85ghSjM23/x841wvGZ7Qufmy3v/E
         OW5Fg6tGKfAvXVsbtsCaNTFgngPgroN0iiGTeJTBvmzuovddFBjBoxGrZeYpAIVO4MBF
         379vn3E3Uzn5eToChejIk9m5kjjmpWgPyDNwAWI4WtyiDRXcCSQv9cTMM6HVlOoekoJz
         wffw==
X-Gm-Message-State: AA+aEWYJ1uQWSC+VDhUpuz90RmZOEewi8+NlU5KI90AHXk9hjUWqnrRS
        oZjfbcxaKPsrPy1ACNQmM2Vd+/jzETE=
X-Google-Smtp-Source: AFSGD/UvjaxhgXDJ1caBF/2wLeHQTob+emaAQr4xJ6WKznvV+7A1k3WWCt9NPbBbFHJj+dyAnTr6kA==
X-Received: by 2002:a62:1212:: with SMTP id a18mr22779095pfj.217.1543966677020;
        Tue, 04 Dec 2018 15:37:57 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:37:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/26] aio: only use blk plugs for > 2 depth submissions
Date:   Tue,  4 Dec 2018 16:37:12 -0700
Message-Id: <20181204233729.26776-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Plugging is meant to optimize submission of a string of IOs, if we don't
have more than 2 being submitted, don't bother setting up a plug.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 522c04864d82..ed6c3914477a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -69,6 +69,12 @@ struct aio_ring {
 	struct io_event		io_events[0];
 }; /* 128 bytes + ring size */
 
+/*
+ * Plugging is meant to work with larger batches of IOs. If we don't
+ * have more than the below, then don't bother setting up a plug.
+ */
+#define AIO_PLUG_THRESHOLD	2
+
 #define AIO_RING_PAGES	8
 
 struct kioctx_table {
@@ -1919,7 +1925,8 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
-	blk_start_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_start_plug(&plug);
 	for (i = 0; i < nr; i++) {
 		struct iocb __user *user_iocb;
 
@@ -1932,7 +1939,8 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		if (ret)
 			break;
 	}
-	blk_finish_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_finish_plug(&plug);
 
 	percpu_ref_put(&ctx->users);
 	return i ? i : ret;
@@ -1959,7 +1967,8 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
-	blk_start_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_start_plug(&plug);
 	for (i = 0; i < nr; i++) {
 		compat_uptr_t user_iocb;
 
@@ -1972,7 +1981,8 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 		if (ret)
 			break;
 	}
-	blk_finish_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_finish_plug(&plug);
 
 	percpu_ref_put(&ctx->users);
 	return i ? i : ret;
-- 
2.17.1

