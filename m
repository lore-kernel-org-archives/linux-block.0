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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235FCC432BE
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117326108E
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbhHRGIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbhHRGHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:07:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866E7C061148
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r2so1143141pgl.10
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3QYmodiWkXXXHnLZdw/pUaRbLmOUogtqxubemJOUWA=;
        b=USSHyqJVpQWy8ZMzwl4EbGadTiH3HWAD5GKcye1LyreXSczSehLAnTCXNNAfVEOX6u
         dbx790aQ5KW7gPDgQoMYSPQsAV043/8VAoFfABDnVXFQLnG8rP3OolrjSWEo9TPmmYPs
         NckpHz6JjgIw87sGZSzScnstmZ3DWQOuxHRNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3QYmodiWkXXXHnLZdw/pUaRbLmOUogtqxubemJOUWA=;
        b=sOwDECJm96WdH+QVT/Grou3yipUDdwL7FFdhjiD0jJyYfV3P5ENbU68K2O+OIamRM6
         al5hAzhJJZ9ZQUVsslHjV8A7aZc5GGMh+8oOpPcLaukObr6017AqlbaSm3+BL4Hn4Xen
         QbMchfBMiVzuvsS2qPjHOSOTVXP8aZ/0f6N5/9Q/5Vt9jf4Y/FEO/o1pixTAQpCdsBNZ
         ny4VmoXhx8rYtT5sm4vPpinLYm56eWrXwH+MRcDqfcMoZi+Hn3hU+dDzePZHKh9DHb/i
         OCdRNfsIYbBYNDFjGv8sVE5j1sIA9+mjijBBHbmsp9EOQm/h5PX9HI6APzUWDziI0+Xi
         g9Cg==
X-Gm-Message-State: AOAM532CLQ2iNLWk9XkPHaU94RYdCV4kYYLw1db90bwAOo/++WW2QyEt
        GjGOpeB5GiTHLYsLMxhnM6YDoA==
X-Google-Smtp-Source: ABdhPJywRH9jCkWB+sdI8LV/t2Ou1DJCL47kcdyq5rETJ8QPkKXpqliLW+MKQDbreOWicfFnlLn7Kg==
X-Received: by 2002:a63:ef12:: with SMTP id u18mr7200850pgh.331.1629266758150;
        Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c24sm5560285pgj.11.2021.08.17.23.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:05:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 13/63] iommu/amd: Use struct_group() for memcpy() region
Date:   Tue, 17 Aug 2021 23:04:43 -0700
Message-Id: <20210818060533.3569517-14-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; h=from:subject; bh=20A/+PUHWtthTe8z3o3iWDN4Pea8VoPXFbZDABJx3xk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMgAqqlbIpZIBPs4khRtZS/Nl/a6SaswUJcEQdW lSBIpT+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjIAAKCRCJcvTf3G3AJjFlD/ 9d5SSKFk/Byob7i8UcCVOb7iPk8Hi2YrJmknzLO1KIxaNkvuyEARZbq6e4B+T+TPepPhntcPKBfOXP FzeN5FXWJBzVyGoIzNGiCPh2WjsSRI106tmAJhcdyZYmVBcyeyjdu/N1w4oKdYAk4K9v7zjJqZe47b FRaeQAjBKc+4h21NGRtTPZDzSgeXabFrYbQBwUnsITGiIKiRbOWCcDGh1aIZNv6BQVD4Fgpe9isZog 0BCF6kfGofFSR3+EdUSEAaJY5GtmJoPQ5dltBc0m7OGIWYQaf0gwiedtUQd1gVD70DjbjWh3AlITFT Vf7P1sH6jk2mKWV2rZKVWibtUzQcLIXbdByJB+gXLflqIxjrUioE82UZxpX/cMIXbUJ+LVuXzllnFo 8nL/lrsLyasmOQKMZ7Hfx+H9y1Qtsx4Yi9Gf/d+PO5Yq2sV2urkcsqTblr1O674nNzPnTn3PqKHyZd OXFfw5XKgJ15ZpYPMmqOBTwA+1lyh2ypbwGLGTnQJZurT9iDDKnxhukSUEE4UmEgYep9iej5UlVsg1 cUbGoY51vQpCifPn0TF/vQv4ai8qMbObKYv7Xb/rqwe3jqgkYO7Xj97gKJUlXnAJ4bWiRMOFBvJI19 zdGfqZsTlEqTMGHOWNFvVFBQcZYVfy0VfPzdZMvR916KpKjQPu9DSR2qCvyw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct ivhd_entry around members ext and hidh, so
they can be referenced together. This will allow memcpy() and sizeof()
to more easily reason about sizes, improve readability, and avoid future
warnings about writing beyond the end of ext.

"pahole" shows no size nor member offset changes to struct ivhd_entry.
"objdump -d" shows no object code changes.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iommu/amd/init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index bdcf167b4afe..70506d6175e9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -121,8 +121,10 @@ struct ivhd_entry {
 	u8 type;
 	u16 devid;
 	u8 flags;
-	u32 ext;
-	u32 hidh;
+	struct_group(ext_hid,
+		u32 ext;
+		u32 hidh;
+	);
 	u64 cid;
 	u8 uidf;
 	u8 uidl;
@@ -1377,7 +1379,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			}
 
-			memcpy(hid, (u8 *)(&e->ext), ACPIHID_HID_LEN - 1);
+			BUILD_BUG_ON(sizeof(e->ext_hid) != ACPIHID_HID_LEN - 1);
+			memcpy(hid, &e->ext_hid, ACPIHID_HID_LEN - 1);
 			hid[ACPIHID_HID_LEN - 1] = '\0';
 
 			if (!(*hid)) {
-- 
2.30.2

