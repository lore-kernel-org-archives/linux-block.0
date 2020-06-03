Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D66C433EB
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 23:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2619207D3
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 23:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oLglV2NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgFCXd4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgFCXcR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 19:32:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE15C008637
        for <linux-block@vger.kernel.org>; Wed,  3 Jun 2020 16:32:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so2470319pfa.12
        for <linux-block@vger.kernel.org>; Wed, 03 Jun 2020 16:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z79mte9tXyXKJqcwg2to640Wx2Eg5qdbPrxISPqquNw=;
        b=oLglV2NFfWcYacYEWd+TtydM20VTgwWe1gq21Fthy+SgsdpnjxFQ4Ga6u1Qy8QOuhq
         1+c/7ALdx0vchA5G8glRAPu5IZRrjlpO6MXFnSd1l4xnQge821R1YpyaThNWtUXXRQkZ
         BdWautw1YEzJ6ceFFpGiknqeHem+S3a8xUfFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z79mte9tXyXKJqcwg2to640Wx2Eg5qdbPrxISPqquNw=;
        b=JyW9XNsc2weH8jMpSTsovXVFPbg2FycBrZTWljbOg11Adp2RFL/kqUJt8KQ8vLa3SN
         hzNlbq8XdmgJTyHudEElhzdRJFxuqZ21wE+iS6HZ1krXfLGC8pWLDWu6CSAo6oOU4XAp
         3vSAXzsQIX1pe1gOIGyLpvdfJZAAad3BpOcCKhdrDBvVCWdgIu4FRLupbCwLnKv58odg
         ueANDK44Gh+qk4UbBKv2Q9/xA6V1Lt5SYwHnrtIPrieMs56lILbbL9LSz1KgxieNk2eO
         zb0wm13Fo7ebWMCKcYMeERkepvtt857/z8eonsowCJtrRg1PW9kNAcrN3kvGVDnWPokK
         I5Zw==
X-Gm-Message-State: AOAM531aMLnnWLRIq6hczsqsKose6m9tG6xN0GSbjG/4Q4N4ANXHUY2P
        YCdhtKNCWGS3Z+ph3ZEOSAGmWw==
X-Google-Smtp-Source: ABdhPJzEnF0voBtIhVxbXIY3ed6bQ+lYw39TPSGZER6ztQVM7GNLumS6Ixq11iEOXvbkyysEKAiNmA==
X-Received: by 2002:aa7:9a93:: with SMTP id w19mr1488633pfi.155.1591227136432;
        Wed, 03 Jun 2020 16:32:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j8sm3442213pjw.11.2020.06.03.16.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:32:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: [PATCH 03/10] b43: Remove uninitialized_var() usage
Date:   Wed,  3 Jun 2020 16:31:56 -0700
Message-Id: <20200603233203.1695403-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603233203.1695403-1-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], just initialize this variable to NULL,
and make the (unreachable!) code do a conditional test.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/broadcom/b43/phy_n.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
index d3c001fa8eb4..88cdcea10d61 100644
--- a/drivers/net/wireless/broadcom/b43/phy_n.c
+++ b/drivers/net/wireless/broadcom/b43/phy_n.c
@@ -4222,7 +4222,7 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
 	u32 rfpwr_offset;
 	u8 pga_gain, pad_gain;
 	int i;
-	const s16 *uninitialized_var(rf_pwr_offset_table);
+	const s16 *rf_pwr_offset_table = NULL;
 
 	table = b43_nphy_get_tx_gain_table(dev);
 	if (!table)
@@ -4256,9 +4256,13 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
 			pga_gain = (table[i] >> 24) & 0xf;
 			pad_gain = (table[i] >> 19) & 0x1f;
 			if (b43_current_band(dev->wl) == NL80211_BAND_2GHZ)
-				rfpwr_offset = rf_pwr_offset_table[pad_gain];
+				rfpwr_offset = rf_pwr_offset_table
+						? rf_pwr_offset_table[pad_gain]
+						: 0;
 			else
-				rfpwr_offset = rf_pwr_offset_table[pga_gain];
+				rfpwr_offset = rf_pwr_offset_table
+						? rf_pwr_offset_table[pga_gain]
+						: 0;
 		} else {
 			pga_gain = (table[i] >> 24) & 0xF;
 			if (b43_current_band(dev->wl) == NL80211_BAND_2GHZ)
-- 
2.25.1

