Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB6BC6FA8E
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 12:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCBMzf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 07:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCBMzd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 07:55:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E54DE1E
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 04:55:31 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i34so67140641eda.7
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2023 04:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1677761729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auAYDTnqMksP1wMx0yJS7PzTopkqCdoZrZ0FhOZKDi0=;
        b=FN4J47y0MmAZSZ/+MyhiIwdUL7qSPuoeC1/JJcWdXtH1H9IAqUUAtGcE5hhU+TZrva
         /bmav/to85jpijxlJxMv3hBqJKQGL8+PtQBq5lIzl90nbp708Bn3ncEYntXYUgVfengG
         /BchF+rqEJ00ft8mr25Q3BNQEIp7ch8FF7S/UFJmyDHwsEpA91Dwonc43dOxuxNQYdPS
         86jYzV0fWtGNo/cJOuCPXhcaGcdlHzZAOg5PdKXWKDI2PS0LgXP21hRvhpnl3ZX9ycFe
         NHndQ611Yp/bvq98zkaHBfMhZoKYEZqA3t60qGoqyqo17Riz/CbdJRXXt0AJ6XJ4QPfa
         iWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677761729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auAYDTnqMksP1wMx0yJS7PzTopkqCdoZrZ0FhOZKDi0=;
        b=tlIq5ZIi6NX84C1+WGelkubt+dxUP0RQUSFwc0vJ/oHpVDp+B9VhMdrAQ4C/Lf9oDk
         uL0gmd8ydsRe86pEMkyXt4Xh80IiY0e4+mN+37lzcQCj3wWXrwFg7AxjVB2DS41tMhah
         Fuz/iVKyV+SirE6QlRtw/6Wq+xyzhWLFjiGiqLTgP3KXD9PQcAhRMFwF0FY11/TAPRPO
         FTYyES87oPLQST3iqFYFb4DB00Fbk+zLmZoHq5uP7nIfPaEVSY1L15/YZDas1yhfqAUx
         8ywzCWw6jZ2LG26qHuuvLyPJ40K+6g9ksiMHRJe3BfyPPH+Bi//7Iy2GUjX4STyHCAdE
         IGcQ==
X-Gm-Message-State: AO0yUKWEka8lsizFLOXtVVjIoqwSWd+MqQWCfATBErq+WiY49QD+Pqsy
        h0QM71iqMwJu70ppIVJSB19xwg==
X-Google-Smtp-Source: AK7set/nkU5jrcwMqRiuiL6ckgWBwz0ltSIEvUXgwQxvUMO6kJJSK2AujWKmxYX3PLum2DZFrkL5KA==
X-Received: by 2002:a17:906:6601:b0:88a:724:244c with SMTP id b1-20020a170906660100b0088a0724244cmr10538676ejp.71.1677761729415;
        Thu, 02 Mar 2023 04:55:29 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id a98-20020a509eeb000000b004ad601533a3sm6955034edf.55.2023.03.02.04.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:55:28 -0800 (PST)
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
Subject: [PATCH v2 4/7] drbd: INFO_bm_xfer_stats(): Pass a peer device argument
Date:   Thu,  2 Mar 2023 13:54:42 +0100
Message-Id: <20230302125445.2653493-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
References: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
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
2.39.1

