Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500BDC43142
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D536501E
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhCLK4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhCLKzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:45 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07181C061763
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id x16so1522266wrn.4
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQunP1ZnGfw+bwS7V3Svy77qoJ9EJsTQfaA2Monbig8=;
        b=KP1AmmQ+NJSSU0KU2H+UpoBIZOhjYnpekFWd/hrndh4zSEqgIb7OuA0ekt5TYszzZD
         aFoY15Yo8rDQ6+wx/1o+HPMF+ZJT0qzpPd+tW4XDACr4HbacjI/aHUmdWEt7MO1HhQpP
         XNvYnWT8rj+9XYBYzSUIBJrbE2xPIpz7lPuarTNn5SdnlG+wyZSclkITgB1M3Ez4NDeO
         jubZngWDtl4YM30v8R5EmQZj6VXi4Wcn5qXTxUOSKHFyLUDABXqc2a56gARdjOCyNn6v
         lMkXW7S7cJEE4J5IXPkyTSi8n8bqG8qQD0ORpi1E8j2DBbT9CoNmQIn81bkFhFppCEDT
         h4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQunP1ZnGfw+bwS7V3Svy77qoJ9EJsTQfaA2Monbig8=;
        b=c2M693zqZCo1kFgEcRbVryw+jf6Idy6E53qhoICkopCpgTam2cdG8pQPagzk26VP4H
         4CWHs/nxlEP3C8f/as2R4JnYj4Me4J96b3MMXzjck4SN9Cr/2/8gX7iswflOxzrwVr+R
         Ehu0GqGkIpftgMKQxLQCNybLN++ChY/xOR0ByTtot0oWhhXYTbc57ysHAKTgHIkUyR+B
         ynx/bcoym1eZcG8Pylao+E0Qu8nXiU5gW8KSRp8PtwG6XfT8QTmupX20fLjqWdx55IPe
         Eh73inSf4782/6PIPS2bclHGvYbnNWmTFUBSwzjCuRSwZmnPcB2EtvX9zDBVn9p4Lfmv
         ZIGw==
X-Gm-Message-State: AOAM530L+Alou5srlNg+nH7E6uerExBx8zO5DoSMiQMQ1Z6gH+Ok1qk8
        2l7/F7LNGrTaofVFyJ07utYqGA==
X-Google-Smtp-Source: ABdhPJx1fA6N7m56sWMhlgXOLGDI5ePwmRDLwv9uAPX0L7j+xje182ndLf7sjHY94sTD0nZ6VeeR+A==
X-Received: by 2002:adf:f60b:: with SMTP id t11mr8137456wrp.269.1615546543715;
        Fri, 12 Mar 2021 02:55:43 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH 08/11] block: drbd: drbd_main: Fix a bunch of function documentation discrepancies
Date:   Fri, 12 Mar 2021 10:55:27 +0000
Message-Id: <20210312105530.2219008-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/block/drbd/drbd_main.c:278: warning: Function parameter or member 'connection' not described in 'tl_clear'
 drivers/block/drbd/drbd_main.c:278: warning: Excess function parameter 'device' description in 'tl_clear'
 drivers/block/drbd/drbd_main.c:489: warning: Function parameter or member 'cpu_mask' not described in 'drbd_calc_cpu_mask'
 drivers/block/drbd/drbd_main.c:528: warning: Excess function parameter 'device' description in 'drbd_thread_current_set_cpu'
 drivers/block/drbd/drbd_main.c:549: warning: Function parameter or member 'connection' not described in 'drbd_header_size'
 drivers/block/drbd/drbd_main.c:1204: warning: Function parameter or member 'device' not described in 'send_bitmap_rle_or_plain'
 drivers/block/drbd/drbd_main.c:1204: warning: Function parameter or member 'c' not described in 'send_bitmap_rle_or_plain'
 drivers/block/drbd/drbd_main.c:1335: warning: Function parameter or member 'peer_device' not described in '_drbd_send_ack'
 drivers/block/drbd/drbd_main.c:1335: warning: Excess function parameter 'device' description in '_drbd_send_ack'
 drivers/block/drbd/drbd_main.c:1379: warning: Function parameter or member 'peer_device' not described in 'drbd_send_ack'
 drivers/block/drbd/drbd_main.c:1379: warning: Excess function parameter 'device' description in 'drbd_send_ack'
 drivers/block/drbd/drbd_main.c:1892: warning: Function parameter or member 'connection' not described in 'drbd_send_all'
 drivers/block/drbd/drbd_main.c:1892: warning: Function parameter or member 'sock' not described in 'drbd_send_all'
 drivers/block/drbd/drbd_main.c:1892: warning: Function parameter or member 'buffer' not described in 'drbd_send_all'
 drivers/block/drbd/drbd_main.c:1892: warning: Function parameter or member 'size' not described in 'drbd_send_all'
 drivers/block/drbd/drbd_main.c:1892: warning: Function parameter or member 'msg_flags' not described in 'drbd_send_all'
 drivers/block/drbd/drbd_main.c:3525: warning: Function parameter or member 'flags' not described in 'drbd_queue_bitmap_io'
 drivers/block/drbd/drbd_main.c:3563: warning: Function parameter or member 'flags' not described in 'drbd_bitmap_io'

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_main.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 69c9640d407df..2ca126bbbc377 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -268,7 +268,7 @@ void tl_restart(struct drbd_connection *connection, enum drbd_req_event what)
 
 /**
  * tl_clear() - Clears all requests and &struct drbd_tl_epoch objects out of the TL
- * @device:	DRBD device.
+ * @connection:	DRBD connection.
  *
  * This is called after the connection to the peer was lost. The storage covered
  * by the requests on the transfer gets marked as our of sync. Called from the
@@ -479,7 +479,7 @@ int conn_lowest_minor(struct drbd_connection *connection)
 }
 
 #ifdef CONFIG_SMP
-/**
+/*
  * drbd_calc_cpu_mask() - Generate CPU masks, spread over all CPUs
  *
  * Forces all threads of a resource onto the same CPU. This is beneficial for
@@ -518,7 +518,6 @@ static void drbd_calc_cpu_mask(cpumask_var_t *cpu_mask)
 
 /**
  * drbd_thread_current_set_cpu() - modifies the cpu mask of the _current_ thread
- * @device:	DRBD device.
  * @thi:	drbd_thread object
  *
  * call in the "main loop" of _all_ threads, no need for any mutex, current won't die
@@ -538,7 +537,7 @@ void drbd_thread_current_set_cpu(struct drbd_thread *thi)
 #define drbd_calc_cpu_mask(A) ({})
 #endif
 
-/**
+/*
  * drbd_header_size  -  size of a packet header
  *
  * The header size is a multiple of 8, so any payload following the header is
@@ -1193,7 +1192,7 @@ static int fill_bitmap_rle_bits(struct drbd_device *device,
 	return len;
 }
 
-/**
+/*
  * send_bitmap_rle_or_plain
  *
  * Return 0 when done, 1 when another iteration is needed, and a negative error
@@ -1324,11 +1323,11 @@ void drbd_send_b_ack(struct drbd_connection *connection, u32 barrier_nr, u32 set
 
 /**
  * _drbd_send_ack() - Sends an ack packet
- * @device:	DRBD device.
- * @cmd:	Packet command code.
- * @sector:	sector, needs to be in big endian byte order
- * @blksize:	size in byte, needs to be in big endian byte order
- * @block_id:	Id, big endian byte order
+ * @peer_device:	DRBD peer device.
+ * @cmd:		Packet command code.
+ * @sector:		sector, needs to be in big endian byte order
+ * @blksize:		size in byte, needs to be in big endian byte order
+ * @block_id:		Id, big endian byte order
  */
 static int _drbd_send_ack(struct drbd_peer_device *peer_device, enum drbd_packet cmd,
 			  u64 sector, u32 blksize, u64 block_id)
@@ -1370,9 +1369,9 @@ void drbd_send_ack_rp(struct drbd_peer_device *peer_device, enum drbd_packet cmd
 
 /**
  * drbd_send_ack() - Sends an ack packet
- * @device:	DRBD device
- * @cmd:	packet command code
- * @peer_req:	peer request
+ * @peer_device:	DRBD peer device
+ * @cmd:		packet command code
+ * @peer_req:		peer request
  */
 int drbd_send_ack(struct drbd_peer_device *peer_device, enum drbd_packet cmd,
 		  struct drbd_peer_request *peer_req)
@@ -1882,7 +1881,7 @@ int drbd_send(struct drbd_connection *connection, struct socket *sock,
 	return sent;
 }
 
-/**
+/*
  * drbd_send_all  -  Send an entire buffer
  *
  * Returns 0 upon success and a negative error value otherwise.
@@ -3509,6 +3508,7 @@ static int w_bitmap_io(struct drbd_work *w, int unused)
  * @io_fn:	IO callback to be called when bitmap IO is possible
  * @done:	callback to be called after the bitmap IO was performed
  * @why:	Descriptive text of the reason for doing the IO
+ * @flags:	Bitmap flags
  *
  * While IO on the bitmap happens we freeze application IO thus we ensure
  * that drbd_set_out_of_sync() can not be called. This function MAY ONLY be
@@ -3554,6 +3554,7 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
  * @device:	DRBD device.
  * @io_fn:	IO callback to be called when bitmap IO is possible
  * @why:	Descriptive text of the reason for doing the IO
+ * @flags:	Bitmap flags
  *
  * freezes application IO while that the actual IO operations runs. This
  * functions MAY NOT be called from worker context.
-- 
2.27.0

