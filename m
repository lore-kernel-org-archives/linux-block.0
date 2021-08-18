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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A67C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF5A610C7
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbhHRGYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbhHRGYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:24:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792CDC0613CF
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:24:13 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q2so1183224pgt.6
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sw/Jd50933MgMDKcslseqtGFSA6d20C1365G+gy2Cx4=;
        b=lkb90SqGpvhafiRjISSgB0a2FrYdpBXG9CDn9kyMEGK8G+C6mKoqovQIKPmXFTd6fX
         KhJkX9Egylj1mwlSIMLNcs5ZBl52s9MtlmYUhK0Xdyehqw1A6JTalUf7LXgHvquVhuiB
         vdvmLxRGM0/kjfEaChvj3QOfSe7n54uv/XChU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sw/Jd50933MgMDKcslseqtGFSA6d20C1365G+gy2Cx4=;
        b=SrbJhg65AdoLa+A285ydJR0N8JAJgARfzFQmm8fe5ZEMXyUKNqEJ0OZVukxIeDRnC5
         INbMbNwwfG+zo/Y620NPPUvLUqOcbmqs8/2hszsBz0RnREC8Ii+oYHOVRcobfxYADUer
         k+3bQCTgiLSfnELwsfpOhsvvZiSyZqtDmEYCppol/6ehU6G7r9Vh7mnhPiO+EWIDEBO2
         JoGNgxmPwrisFJlwkF/heayyxedQeutNFU4jtWykrLQF0bTuZ7DX2J3GI25k2aqX3Q1q
         DKweUDuVJDTXk1hZhC4AdqWDtEws9HgWSrMuUVoYbt+stmmMjrEC9uBHPSwfWIa/Y+u5
         bV/g==
X-Gm-Message-State: AOAM531T4Sf+Dhgr0yj4NJh9hLRDTO6gtHtz6N8KHKDeToPsDUOimR5o
        WrYHudJUE6fEowYwgrOGEPlRkA==
X-Google-Smtp-Source: ABdhPJy9CLfg35oDbbdeQsU7HbtEw7JEEvFjjstjJ1u7tRCnU3ll7bgG1jvkDuiyrvoW+GnkiwkfjA==
X-Received: by 2002:a63:fb08:: with SMTP id o8mr7314165pgh.72.1629267853126;
        Tue, 17 Aug 2021 23:24:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n13sm4501409pff.164.2021.08.17.23.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:24:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Harald Welte <laforge@gnumonks.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 52/63] cm4000_cs: Use struct_group() to zero struct cm4000_dev region
Date:   Tue, 17 Aug 2021 23:05:22 -0700
Message-Id: <20210818060533.3569517-53-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; h=from:subject; bh=J4NGkJQCgahZv2zewL/wYUO+MpNSkAZfZF2EdzgyTRQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMplIHvWiwQENOF2c7XlC/x85JbSdFgE5kqsWuK 0OxdRfuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjKQAKCRCJcvTf3G3AJtHPD/ 9w1C3xZTkrQOl8qCphP1NuYb6Zzm4m2uWKaotV03HQ6T9nZ1pYcDMMaHhAraQDtG/+gMBjur6kCewv ayrtSdcUPKzKabKpDYkkQQGEE9qhvOYR4et5WymZDf+eN80rUG6e4eGkoBaSg8aVufvzlEbWGGJI1g tqDg4cuv/AswW6J0SfIjA0LGvOcP86foOnbG0fLo1CjkuPmC73qAisdtYqZ728UwCF73xtFOwOcz58 eqjKu4Hpj2sUaNV2ghIn1t2tsXH9VMc5RRvDzUnjKE8WQiYMXT1GnQMQC30RP8X5s0vnTZZK9COqg4 oewq2GoOKKBWejZCZnIt2PWaHfLpUYE3cXHVsUUrUzVwgg/Sk3purVXNGauBM7zNDyMu+OqTX4ib/A +HNqKaO/5WxWULHr6ttMgZKJiYQpCIvqqVqyHlMArxKxGWwiOSShxbeoadhVmd0SxeqdGPdNCiAuk6 FFaKdGvO/XR7rdo2FnWbhYIs1bjRjMoCnyn4vUMe6sRx6ESs8Bvvf+nu0uOBDONLatp0KRkgfFUvYM i85g6GvFHJOXM2duu8wB+SxG0oCcvOTXiLpU3c5ok266H6TYTMs6yQQ6fEkcPZU/wwc56QrWbNdrgO Cwck+Q8ubdcpIlRqgjAb6NEZ7diJsEGXAyIkWnhUKNVIgROWsl4C+tImakjQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct cm4000_dev that should be
initialized to zero.

Cc: Harald Welte <laforge@gnumonks.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/lkml/YQDvxAofJlI1JoGZ@kroah.com
---
 drivers/char/pcmcia/cm4000_cs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 8f1bce0b4fe5..2f43e7088e16 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -116,8 +116,9 @@ struct cm4000_dev {
 	wait_queue_head_t atrq;		/* wait for ATR valid */
 	wait_queue_head_t readq;	/* used by write to wake blk.read */
 
-	/* warning: do not move this fields.
+	/* warning: do not move this struct group.
 	 * initialising to zero depends on it - see ZERO_DEV below.  */
+	struct_group(init,
 	unsigned char atr_csum;
 	unsigned char atr_len_retry;
 	unsigned short atr_len;
@@ -140,12 +141,10 @@ struct cm4000_dev {
 
 	struct timer_list timer;	/* used to keep monitor running */
 	int monitor_running;
+	);
 };
 
-#define	ZERO_DEV(dev)  						\
-	memset(&dev->atr_csum,0,				\
-		sizeof(struct cm4000_dev) - 			\
-		offsetof(struct cm4000_dev, atr_csum))
+#define	ZERO_DEV(dev)	memset(&dev->init, 0, sizeof(dev->init))
 
 static struct pcmcia_device *dev_table[CM4000_MAX_DEV];
 static struct class *cmm_class;
-- 
2.30.2

