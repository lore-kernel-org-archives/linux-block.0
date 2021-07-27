Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B8C19F3B
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 20:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B5160FE3
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 20:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhG0U7e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhG0U7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 16:59:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CA3C0619C2
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 13:59:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso987912pjf.4
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6/OQGnZJO2xpqz0lPpmxFO5LpaD7fJ1BCkxwNv3dNoc=;
        b=bWmVc1ATo6Bdi0x0gVcLqTFuEn50oNeK5vOPamlyDMwCoxN4KczP2P/Q3olsoZArK2
         oEaDqH5Lv44TlCNNV6a3EqDf979ldwBgudTOGYLK7q2bv+90PyeluNnxQuKEn2ueMuVk
         n5ftFZNLEHzMkRrYO1NorsNdCtRC6MlyGNC0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6/OQGnZJO2xpqz0lPpmxFO5LpaD7fJ1BCkxwNv3dNoc=;
        b=Cxok3PmMkqt81ubBMYKhRoEMfrLqcBgv+4eBIpsQQ81hYXBzyjzyhgCLeUGEFKNuv9
         AUnB/+SxspSnjbohDUj8CuldAzfQHlBrQno/m2/1xc9Zus3x1rYnJ/9xTEWCMfx84BYe
         HGJGU+pzTCIBLiR9O789HC3IeJXjP7TDpno4lFCLy9iWypVGJfNr04BZzv4qXfu7Vd26
         pzxpiEgHTZejzAhSBbXkPHCqHHW1DIxarCbRv5NPULbtbk6V5C3tJmdFmrlcIe5H7yUP
         60HToS3riPbxL8u0B7pqz+0s6/cv9YguNiGJRajAO9VNuflb+uJX7OP9TIZs/X3jppNx
         iZLg==
X-Gm-Message-State: AOAM533XkXwDASlFnYXHZ1Yoqg+RGarzADSsjr53MjeHmejgSvrZZpbf
        CyKBld5b3TwpvATAf38YT2vpqg==
X-Google-Smtp-Source: ABdhPJzmdxeLSGew7Gw5QIRcplfSenLeqID4spMec/HF12Fb71cU2BA7Mx95mpmUvDPT9kgYaNoUaA==
X-Received: by 2002:a17:902:b692:b029:12b:e0b8:3415 with SMTP id c18-20020a170902b692b029012be0b83415mr16685504pls.32.1627419551650;
        Tue, 27 Jul 2021 13:59:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e4sm5075904pgi.94.2021.07.27.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:59:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 18/64] cxgb3: Use struct_group() for memcpy() region
Date:   Tue, 27 Jul 2021 13:58:09 -0700
Message-Id: <20210727205855.411487-19-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; h=from:subject; bh=QhhwuNDqwvCqZzGgtIdcelj8gelXre9JSKqa+rdI4Ks=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOE+3A+NvAr12M3pvmHg5gBS+BMuzVkps12U6r6 oUWT/KOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzhAAKCRCJcvTf3G3AJnYSD/ 9pCe8EneuIHsFG7O1h9Et9FPdQ4sf78aWG201MY4PkmUZ0eDhPiloiEL0ylEGfsAWVozXDrhIHytSc WDmiUNbkrIdxewQswK1NMMFNJ9Jg6zM/c8zAUNt/MzTm6UhPLvszd3txXLKTOrLOyhBueGBQ5hn+C1 5nEhLlbkW2lrfXHI6MECRZNC7n9ca6OXMeCF2+PxwSe96LQt65zkiu9DRp+JebzmgYrVRe3KCZA4++ 9s5AGSX4owqhIkXUVKuL5t+3moxKtTYBRIpDJFhv8IVHDuIXnjWcdqFudBLh0yEwuN7ojftkvan2dB BsuTkhZeg0acZ/dH0dqsbAQmWtVEBbr7DAfLSqRFyp6TZIID6Ixvj8fo5wG5smHK8Xlyl/GjlKxroY WDoUvKOW/J9slWszjune87PA91amTGSpQPBJ30fHEtl6pxwc2hvREl0rjOYopDh4fQVnlM/hG2RFL4 fodpvMq+aZajblMJTpkucy8wpuq+xzQmfu3HLPrOCeSb4MEvdRHmJz7i9ClO+p78cHY164Izuv0iXN dR11BddC3Oi//XeEhgFN90I/5ttFIoVhVZJPXT22XfeYrGSbMWnh7i8X2JPcxj3s6VhYSciaPqqxze NGd+nEE/9Bey/+V/7KcUxYiUZfNz7HPdVbAcPyXWIctj6leKTFSYkijFcf7g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct rss_hdr around members imm_data and intr_gen,
so they can be referenced together. This will allow memcpy() and sizeof()
to more easily reason about sizes, improve readability, and avoid future
warnings about writing beyond the end of imm_data.

"pahole" shows no size nor member offset changes to struct rss_hdr.
"objdump -d" shows no object code changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb3/sge.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index cb5c79c43bc9..1ab1bd86a3a6 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -126,8 +126,10 @@ struct rsp_desc {		/* response queue descriptor */
 	struct rss_header rss_hdr;
 	__be32 flags;
 	__be32 len_cq;
-	u8 imm_data[47];
-	u8 intr_gen;
+	struct_group(immediate,
+		u8 imm_data[47];
+		u8 intr_gen;
+	);
 };
 
 /*
@@ -929,7 +931,8 @@ static inline struct sk_buff *get_imm_packet(const struct rsp_desc *resp)
 
 	if (skb) {
 		__skb_put(skb, IMMED_PKT_SIZE);
-		skb_copy_to_linear_data(skb, resp->imm_data, IMMED_PKT_SIZE);
+		BUILD_BUG_ON(IMMED_PKT_SIZE != sizeof(resp->immediate));
+		skb_copy_to_linear_data(skb, &resp->immediate, IMMED_PKT_SIZE);
 	}
 	return skb;
 }
-- 
2.30.2

