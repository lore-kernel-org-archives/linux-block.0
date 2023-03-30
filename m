Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C8DC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 10:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjC3K17 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 06:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjC3K14 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 06:27:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D11383E8
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 03:27:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r29so18503709wra.13
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1680172071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoJeiknRTpDZAZF33zT2p5PA1V+wX2CIb8shJ1yvL6A=;
        b=A/tmhlvPWF4xZ66HWcCboXl61FO7IevBvozsUg60oNkpXjuS3ZrLcsPEK8Wv4slWyW
         a8TG5HTpUh0P9CCf09By78KthLvs+A3FBtzf4HP2gtHwiteDRhfoMnZowLpdhyvjoqAM
         qRWRLCJNUZ7Yo6VYVJ+Ftq9BWqwusOWRMBdBj+6pxI1nctWZqYoLB7UJLbDGNNCMAfAb
         0jFtKEWiM83z29KQCEbgrJY5VVYmX2KLfThltCB4xeJveLY+0TyD8zkob/n6K3DE11RB
         zknbsvrb2QnnXuO37jTbLh/EG7wY2dDm2I4PddYU1kz2V0w2gbqTjBjm+MR/gwtYsTut
         9g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoJeiknRTpDZAZF33zT2p5PA1V+wX2CIb8shJ1yvL6A=;
        b=AofZ81fHoX4L2Ps+6bjJNGlwCUMXMe78xvTJ7ARbtzTIYpsXEjAX9SbOT754bNatEB
         XxtcJydXEg8YAquql5cx2RDlHanGE6XAQH+5+aRlIXM2Nt+xPEfaPL5Jg76NMSx3ljHE
         +/43P9SvA7Un0fE6oq2iMy1G8Hz67yE8TnRI1fsy+5XJR54PKBK5K1Y/DNqVbKUb2caA
         lXr4P/zqZhaHi+crFgkdk7kYil/q6I76hQZr1tO3pkyfbgrGWfkZnjTtUJwPkFtK4May
         5cby5h4M9pdV2Y/p+g81lkKHFx8JEqCDpLqKbZ2IpOy+ihIU+2zCoAj5r7MJbeOcWfTK
         hx4A==
X-Gm-Message-State: AAQBX9f+4QL1jpkVGpXifBm6ceddTgRIJvJKPH9xlQ71VLBArL5b8r/r
        dwpJVf2IT6tq/amR6qEGGf2D+g==
X-Google-Smtp-Source: AKy350a/copb0VGaGVi93ghOe96BLsMismgm9CZNzw3/HLdH/1NCeyGEz451qN9iaMsPIscWo6uhbw==
X-Received: by 2002:a5d:6585:0:b0:2c8:c667:1bb4 with SMTP id q5-20020a5d6585000000b002c8c6671bb4mr16886265wru.48.1680172071284;
        Thu, 30 Mar 2023 03:27:51 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm26352514wrp.42.2023.03.30.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:27:50 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 4/7] drbd: INFO_bm_xfer_stats(): Pass a peer device argument
Date:   Thu, 30 Mar 2023 12:27:41 +0200
Message-Id: <20230330102744.2128122-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
References: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h      | 4 ++--
 drivers/block/drbd/drbd_main.c     | 2 +-
 drivers/block/drbd/drbd_receiver.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 7bd10089bfc9..97c091990bf6 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -127,8 +127,8 @@ struct bm_xfer_ctx {
 	unsigned bytes[2];
 };
 
-extern void INFO_bm_xfer_stats(struct drbd_device *device,
-		const char *direction, struct bm_xfer_ctx *c);
+extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
+			       const char *direction, struct bm_xfer_ctx *c);
 
 static inline void bm_xfer_ctx_bit_to_word_offset(struct bm_xfer_ctx *c)
 {
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 178a7ae40af8..6647f84f3879 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1247,7 +1247,7 @@ send_bitmap_rle_or_plain(struct drbd_peer_device *peer_device, struct bm_xfer_ct
 	}
 	if (!err) {
 		if (len == 0) {
-			INFO_bm_xfer_stats(device, "send", c);
+			INFO_bm_xfer_stats(peer_device, "send", c);
 			return 0;
 		} else
 			return 1;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e70076fe1f2e..c6f93a9087b1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4766,11 +4766,11 @@ decode_bitmap_c(struct drbd_peer_device *peer_device,
 	return -EIO;
 }
 
-void INFO_bm_xfer_stats(struct drbd_device *device,
+void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
 		const char *direction, struct bm_xfer_ctx *c)
 {
 	/* what would it take to transfer it "plaintext" */
-	unsigned int header_size = drbd_header_size(first_peer_device(device)->connection);
+	unsigned int header_size = drbd_header_size(peer_device->connection);
 	unsigned int data_size = DRBD_SOCKET_BUFFER_SIZE - header_size;
 	unsigned int plain =
 		header_size * (DIV_ROUND_UP(c->bm_words, data_size) + 1) +
@@ -4794,7 +4794,7 @@ void INFO_bm_xfer_stats(struct drbd_device *device,
 		r = 1000;
 
 	r = 1000 - r;
-	drbd_info(device, "%s bitmap stats [Bytes(packets)]: plain %u(%u), RLE %u(%u), "
+	drbd_info(peer_device, "%s bitmap stats [Bytes(packets)]: plain %u(%u), RLE %u(%u), "
 	     "total %u; compression: %u.%u%%\n",
 			direction,
 			c->bytes[1], c->packets[1],
@@ -4872,7 +4872,7 @@ static int receive_bitmap(struct drbd_connection *connection, struct packet_info
 			goto out;
 	}
 
-	INFO_bm_xfer_stats(device, "receive", &c);
+	INFO_bm_xfer_stats(peer_device, "receive", &c);
 
 	if (device->state.conn == C_WF_BITMAP_T) {
 		enum drbd_state_rv rv;
-- 
2.39.2

