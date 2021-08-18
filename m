Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6883C4320E
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BF6610A6
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbhHRGI7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbhHRGIP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:08:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD52C061159
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id n18so1138687pgm.12
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfvkDY5kt3lyAiNJVhXK5tG8hqr4QIBOkdIIoSIpZoY=;
        b=NMAt3Z+vmc63UdPMMnwK22vzULAc39jN3JAUQfpgdeIAJMtmklwONc6o056nFTTKqQ
         15r5+5EbazY7YogCaFZRnOHkqjDRrGOzUYaDbBnGvccHMzLb6JoTxWRZKrIsqn73HlCD
         K6mCD7EQ6HELD+OoUJLp32Sp173giXgQxK8Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfvkDY5kt3lyAiNJVhXK5tG8hqr4QIBOkdIIoSIpZoY=;
        b=i8sMZUwSDkMX4CE6Zf6Ur0nMJc0pZaek6GsUFiLpxzhXQgV1PEAFB6ZQS7jNqZOFs9
         KDIlL3CYERTO2HHGOW5N+H4CnRNlDOZIsgwFBgshoY3NX/wegnKzn61GzlOctHc3tdJj
         Kzi06eWvU66FdGPHCXwSwAgJ6N4ySD1PbCjuRUUznvC9zjkIPoVKNlJecQ9h1aoaE00u
         +exjC493AEsc9SOb1cztbNxEFglaWuoYSDqgkZeVdqtwX4aK8GL2cAMOhLdv0BK3Ycp+
         TuQ+Pz2HI8LwqNYJuy+Ze+1AvneStGZQ7Dpx4az1tnxzqixz2CKzv3Vc5c+kP4Ol8Yrj
         66qA==
X-Gm-Message-State: AOAM533TuCpQIIPn+mSJ0Oe9DxrUjMq09l+hz83Ibx5S0xDvj/WnkVh7
        ZChAzqWaS5pzE5kxA8tW/SwtbQ==
X-Google-Smtp-Source: ABdhPJxL+5LyS8fmfRDtLXE+jtdGJ+XmKClZl6r+/zYSaT9tS3pyhibmNGixNDmN2KDGG5wbevjKhA==
X-Received: by 2002:aa7:9096:0:b0:3e1:72fd:a614 with SMTP id i22-20020aa79096000000b003e172fda614mr7502384pfa.56.1629266759093;
        Tue, 17 Aug 2021 23:05:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g20sm4492489pfo.20.2021.08.17.23.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:05:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 11/63] libertas_tf: Use struct_group() for memcpy() region
Date:   Tue, 17 Aug 2021 23:04:41 -0700
Message-Id: <20210818060533.3569517-12-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2738; h=from:subject; bh=wd3681c0+x5eRHaVMU46XJm1dPQ+sYC85SAqAjsrf0g=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMgFu3aRs9ISQmN5Vt9YdvAypRlzexF9VxkmlTL fBYs8H2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjIAAKCRCJcvTf3G3AJgbSD/ 9VvmG/dIP8wflkmUIV/4I63+sFI42prOwmcCJ7/QC6arAbd++55apbMaEbvsVv1TYzcOupBj3FJ3jn MzrscJSZO6s9qr6X/i4VQc63Y14g5kv5CMWrO127GRXfb/qRlMqNk8E3sr4Gp13yNGDXsonEASy26M ZAsvPOSnn3IaytMY+n8JweOfoB7i5WZ5mEBm2GjyQ2YRO4gqCZXxuJ4pufJR7SAmOVTyrGq4p/oSac nq2SUsVtaOo047ZAR3x2asWFV+3jHU6DuILOEhWF5H9pjXxVYfxtRc7tyP4pcjgqF5OB6To3eKp7TU lNEhWQQSE/GKR/8rUE5oYBrd5CyVJ352RemeAF3dhy9iSYllDDF8Dt7qDNFEHixdkgUBPY4YeRlcqV cP9/7P5xH3gI/UR4HG4sGw72lm/9sRvLbnPDbA+s8lzYlz6efPKiMJTBfV/Vo3YcsuR1mcrJygzkmu QQnYzrz9BtQfHFbe4OzkMKHaUCe9cJWWQqQbGjfGwqQFNttWU3Coo38o1FpdbJuhHvJyRDK47q3vNE Dc9vwC1o71BLG1c6D1ISVRzPUG2b7cEcd90GSkp7YejithdY+NvnSmZWTad+d2K15xdz2UNXL4hMRq fqBE0lJmxcxuhqVKSMuG8DKaxKopqiFzybGwsuT6xwpq9DI+1gph4HfAMHSA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field array bounds checking for memcpy(), memmove(), and memset(),
avoid intentionally writing across neighboring fields.

Use struct_group() in struct txpd around members tx_dest_addr_high
and tx_dest_addr_low so they can be referenced together. This will
allow memcpy() and sizeof() to more easily reason about sizes, improve
readability, and avoid future warnings about writing beyond the end
of tx_dest_addr_high.

"pahole" shows no size nor member offset changes to struct txpd.
"objdump -d" shows no object code changes.

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/marvell/libertas_tf/libertas_tf.h | 10 ++++++----
 drivers/net/wireless/marvell/libertas_tf/main.c        |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h b/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
index 5d726545d987..b2af2ddb6bc4 100644
--- a/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
+++ b/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
@@ -268,10 +268,12 @@ struct txpd {
 	__le32 tx_packet_location;
 	/* Tx packet length */
 	__le16 tx_packet_length;
-	/* First 2 byte of destination MAC address */
-	u8 tx_dest_addr_high[2];
-	/* Last 4 byte of destination MAC address */
-	u8 tx_dest_addr_low[4];
+	struct_group(tx_dest_addr,
+		/* First 2 byte of destination MAC address */
+		u8 tx_dest_addr_high[2];
+		/* Last 4 byte of destination MAC address */
+		u8 tx_dest_addr_low[4];
+	);
 	/* Pkt Priority */
 	u8 priority;
 	/* Pkt Trasnit Power control */
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 71492211904b..02a1e1f547d8 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -232,7 +232,8 @@ static void lbtf_tx_work(struct work_struct *work)
 			     ieee80211_get_tx_rate(priv->hw, info)->hw_value);
 
 	/* copy destination address from 802.11 header */
-	memcpy(txpd->tx_dest_addr_high, skb->data + sizeof(struct txpd) + 4,
+	BUILD_BUG_ON(sizeof(txpd->tx_dest_addr) != ETH_ALEN);
+	memcpy(&txpd->tx_dest_addr, skb->data + sizeof(struct txpd) + 4,
 		ETH_ALEN);
 	txpd->tx_packet_length = cpu_to_le16(len);
 	txpd->tx_packet_location = cpu_to_le32(sizeof(struct txpd));
-- 
2.30.2

