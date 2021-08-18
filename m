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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A32C432BE
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD54610A6
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhHRGHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238313AbhHRGGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:06:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140D3C061796
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:57 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r2so1143086pgl.10
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Df3M08ozQZ/wuG86+AN6C9MACPf6Ua4LnPIl1VqdGkQ=;
        b=fqfWH5xzacAnh0+miJhptMLYGLpJ+mJNVIq3l+0GgQRuX61t6lEOMMLw784SzCT4EH
         hqDzbMAVICROLXLXmTGWMOQDusnO33cZRylV/ECZsYPBru2294Qof+d9A7QOozMwfiYT
         FGCoqMsz/DE0l3g+EcW0C9GSHhIAPMlL8tEp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Df3M08ozQZ/wuG86+AN6C9MACPf6Ua4LnPIl1VqdGkQ=;
        b=j2JI+jMM4Trtbkfoxy7klfRGEyemDQsWitIjfRzENEgskrUIlMXBC0PxlUexcB1iTL
         KdfnJN1hdYTBbujMa+L1lN3xLxpUgbj5/Y4LqmrmDoV32kwouAbGoBbef6gwqLqG5sk1
         zJCY3QpKivkZu1ijfJwK0qLm3gvQ5CVhb3NXvGT25xLNdhjX8hjgklEI0est2dc0wgz7
         RpnE5pHSsL+zIv0egpSQSGnelUFpEg5ZLlVXXiZkdRh2Zby8+lrapohD4ias+/h3367+
         vnAz86YAv9VnIRq0U8d/wcFjTyoIC5YFfj2FmN06Z91GBieNNj12GzTCx2RXToMKg0nl
         sknA==
X-Gm-Message-State: AOAM533d1JGL5BGJG6zQ9vF3BdsGuE+sZjrjO6sioePCoVkwcmtvSqlQ
        ZwhBER+N0jeKIUTmlKDrzz1jLQ==
X-Google-Smtp-Source: ABdhPJzquXvqSXBuTCbj2eYrNtxehh2HuV6fs3AsulpduqmyMEsRD3xhPeevj3JhK8nYO8NCjxVrfQ==
X-Received: by 2002:aa7:8116:0:b029:346:8678:ce26 with SMTP id b22-20020aa781160000b02903468678ce26mr7642769pfi.15.1629266756663;
        Tue, 17 Aug 2021 23:05:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fh2sm3751402pjb.12.2021.08.17.23.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:05:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 07/63] skbuff: Switch structure bounds to struct_group()
Date:   Tue, 17 Aug 2021 23:04:37 -0700
Message-Id: <20210818060533.3569517-8-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4396; h=from:subject; bh=vIFaehJlmgaacelmPKMYZbSRddYmlAVC4AJuX8jcTLo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMfC5Mwg8GEVNb5CXtGiGtsK4FwOhKAw15TLI67 rTMBsEGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjHwAKCRCJcvTf3G3AJlkpD/ 9IW7rDFPZH4dI/1/P/uo+5nWHunuZP3664cpMwhwx+rHENSDLF5R/LmHEenMiL1vnoQ8J1iVu3EVgo 1xzQfV/jxCj8E9GdkDHFUogUHVaPjRb9CTVM6DHcTZ2/xkvhVi8nwdgd1lDfJe9XrMTuBkF8eEj6BO YWNUoNQdRGh2+IXaTCDDWCvkG5ZTfO0sXT/bDh9DMGodRIG/luglNHHLvts3knlgR8QM0WIzhsColC AHHcXV2gUexGt/UBGejzG1NRGAXDmkHZAIsMu7BsFDpweoRW6XGmOMOpo9rtP10ar9yPYp2+GFlioL 9tghS58ciKMcV1+v+6jX6Do4ybmYeDfU2rB6/Gpct6yVAs3pYpuFpRIew7WZItwzf2nCMt0ZEYduDJ Drj4jLrZUyIs6ixwydVuLC8Owg9cb/J4qXw4vk0tJ9evOSP/mJOQqUcFcIUdExIArnAVtXlgdzArhu 7hXpCD3qNAEHF+aWjVKGh8gTmrdYqhSN97k0I7jKrRx2kLtSrpcBS4ZQwjSaSERANnuDAk2of2H6Zb bUqvY5heKLllEOQg8ihTwR1efnbUnFXFFV5cpEUmN1YuS3na93hd4TS0rCXMIPIDmYPqG4ut0gh4rf LCZqI3HgwkGyN6BoC0cGob6w/hrvkXWGKt0s1vU5y2KdKmA62+teOpZ0qiVg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Replace the existing empty member position markers "headers_start" and
"headers_end" with a struct_group(). This will allow memcpy() and sizeof()
to more easily reason about sizes, and improve readability.

"pahole" shows no size nor member offset changes to struct sk_buff.
"objdump -d" shows no object code changes (outside of WARNs affected by
source line number changes).

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Alexander Lobakin <alobakin@pm.me>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Marco Elver <elver@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: wireguard@lists.zx2c4.com
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/lkml/20210728035006.GD35706@embeddedor
---
 drivers/net/wireguard/queueing.h |  4 +---
 include/linux/skbuff.h           |  9 ++++-----
 net/core/skbuff.c                | 14 +++++---------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 4ef2944a68bc..52da5e963003 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -79,9 +79,7 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 	u8 sw_hash = skb->sw_hash;
 	u32 hash = skb->hash;
 	skb_scrub_packet(skb, true);
-	memset(&skb->headers_start, 0,
-	       offsetof(struct sk_buff, headers_end) -
-		       offsetof(struct sk_buff, headers_start));
+	memset(&skb->headers, 0, sizeof(skb->headers));
 	if (encapsulating) {
 		skb->l4_hash = l4_hash;
 		skb->sw_hash = sw_hash;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6bdb0db3e825..fee9041aa402 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -801,11 +801,10 @@ struct sk_buff {
 	__u8			active_extensions;
 #endif
 
-	/* fields enclosed in headers_start/headers_end are copied
+	/* Fields enclosed in headers group are copied
 	 * using a single memcpy() in __copy_skb_header()
 	 */
-	/* private: */
-	__u32			headers_start[0];
+	struct_group(headers,
 	/* public: */
 
 /* if you move pkt_type around you also must adapt those constants */
@@ -922,8 +921,8 @@ struct sk_buff {
 	u64			kcov_handle;
 #endif
 
-	/* private: */
-	__u32			headers_end[0];
+	); /* end headers group */
+
 	/* public: */
 
 	/* These elements must be at the end, see alloc_skb() for details.  */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f9311762cc47..fd5ce57ccce6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -991,12 +991,10 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
 }
 EXPORT_SYMBOL(napi_consume_skb);
 
-/* Make sure a field is enclosed inside headers_start/headers_end section */
+/* Make sure a field is contained by headers group */
 #define CHECK_SKB_FIELD(field) \
-	BUILD_BUG_ON(offsetof(struct sk_buff, field) <		\
-		     offsetof(struct sk_buff, headers_start));	\
-	BUILD_BUG_ON(offsetof(struct sk_buff, field) >		\
-		     offsetof(struct sk_buff, headers_end));	\
+	BUILD_BUG_ON(offsetof(struct sk_buff, field) !=		\
+		     offsetof(struct sk_buff, headers.field));	\
 
 static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 {
@@ -1008,14 +1006,12 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 	__skb_ext_copy(new, old);
 	__nf_copy(new, old, false);
 
-	/* Note : this field could be in headers_start/headers_end section
+	/* Note : this field could be in the headers group.
 	 * It is not yet because we do not want to have a 16 bit hole
 	 */
 	new->queue_mapping = old->queue_mapping;
 
-	memcpy(&new->headers_start, &old->headers_start,
-	       offsetof(struct sk_buff, headers_end) -
-	       offsetof(struct sk_buff, headers_start));
+	memcpy(&new->headers, &old->headers, sizeof(new->headers));
 	CHECK_SKB_FIELD(protocol);
 	CHECK_SKB_FIELD(csum);
 	CHECK_SKB_FIELD(hash);
-- 
2.30.2

