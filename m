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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33B7C4320A
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD4160FC4
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhG0VIA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhG0VG5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 17:06:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54740C0617A2
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:06:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q2so1823395plr.11
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPGlu1gG6API/iCexVdVFLvP4yi8HHonlHYke9K7UR0=;
        b=m3xmCqlfQQl6y88gzGHqm2N3UvKEnCdok/BJyDNoduQEklW/A7rLG1ArcEbIa4sNpg
         gyE4VCnVWyScIlaG1xhcD8qrQj5NdPxQkhHLzIIQou5A0leQoAsnAyLU3S12xLMU/Hpr
         6bYRGbAjxTPd/EtMM4GpfIh0ws6if/8UYqIYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPGlu1gG6API/iCexVdVFLvP4yi8HHonlHYke9K7UR0=;
        b=HsBmrA3Gi0wGeYFiNzMjpr4T0KbCLVNtu7AVEy4f3QGP4rMaq+kxOumgdwvgPkXzPg
         eg93wvmfL2lcZ4m4RflvCcfdgWFIFAjOGLZsUfhr+79O1xd7fGLwVKT2SQLhCxu7AVdm
         qK8wOyeYPPOtYI3uLrPRZBXwpds3f/3j121JK3+nl/EEaugCu4k/C4G2QhH6+XGdCE00
         7FqbzL6t6ReMC7r0ePXXM1KNDA6bH7xGX7Up3xtbAsr2anQZ8kBtL0ZHtKJJFy9VySLc
         X7iLW/QK3RdVUR3cZ5Hzd9IoO63lYwuB5UUGPR8A66RF9+p8oFnUpPU0SQjiucov7IU9
         NkmQ==
X-Gm-Message-State: AOAM532ok+v7BY/uL1zY4SBCT9knhn/wkrKoeQOQg7tSJo9fw08FRSeX
        3f2QMFTvJ+7+7ORHmyGWu/NQog==
X-Google-Smtp-Source: ABdhPJyRr41WjbyJq9nCLCxMpkCCFYsX51CfWKd4/S2P+UzJSAsEt1kW141ndTqkUOB7pGW66MCilA==
X-Received: by 2002:aa7:9546:0:b029:32e:5fdf:9576 with SMTP id w6-20020aa795460000b029032e5fdf9576mr25063139pfq.5.1627420015943;
        Tue, 27 Jul 2021 14:06:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d29sm4704061pfq.193.2021.07.27.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:06:54 -0700 (PDT)
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
Subject: [PATCH 17/64] iommu/amd: Use struct_group() for memcpy() region
Date:   Tue, 27 Jul 2021 13:58:08 -0700
Message-Id: <20210727205855.411487-18-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; h=from:subject; bh=3pnVXRScRiXcKlAzWmxtHjgtqdCSr5x9f+6aO5KQ5qc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHODYV9h07PQ3v5RAvzij9k85T7DPu/8sNSs65Q4 0y0UliiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzgwAKCRCJcvTf3G3AJiW2D/ 4nEDA70nGUYhVyf7oYOlQgzyry3f6d0tKPbEYWNkte1rIRW3O2InK76AVJyf0Q/BtnVYPXNStIrzaO SUDw2yOwXO4oq2+xlKHbSpDQcYZna36Xqovo10kVGY112L7kOGbUfQZZPm+9ZCxh9fprwP+ezpdrPw 5RhPSv0UwMiQYY/cih9csRF3Y0cUslbWzBAlMAKY4vV665FdBYm4Cd1UbBRiX7n5X6rkASp/R5KUJO gT9lqJlutTZcY84HhE2e7nVfUM1tK/zoQ1ZeRZ2l14KFhykcFSW9gTHS3VJa2Fr3ta26jaAzpIQzRI I1VZSdlxpEUPAljbEi8ms11eBPC5N8+yPox2bH9yz8bPLwwHOwyP+yRXagJSrsB0JY9elrri4Jr0d4 L0spfyNNFhXi1pYLN/VwHLWk0qCJ6U6H1/1yJ5fkSANbabpn+M+34UuJ87NhDZnoboRjX68s2N9xUp Ztc8gb6cNuq1OK7yjw+/s+IPxRe2Xrjyj6xMHQ75Nmq+kDqedEV8h/okfZHv9FN6eZGw8+d+79qrHr /MdSe/HI+xPECZcwJiIqojDU9hyrQ75Slj1hn65lXR2jBuZkuxOB9VWtjVZyPGXbccWBvdccl0Sthp x+6FisSerA0XyrnefqEYTnx+5XYfaYWhfusWvoUDsVRDlD5XjnXe/NKxjhWQ==
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

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iommu/amd/init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 46280e6e1535..2df84737417b 100644
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
@@ -1378,7 +1380,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			}
 
-			memcpy(hid, (u8 *)(&e->ext), ACPIHID_HID_LEN - 1);
+			BUILD_BUG_ON(sizeof(e->ext_hid) != ACPIHID_HID_LEN - 1);
+			memcpy(hid, &e->ext_hid, ACPIHID_HID_LEN - 1);
 			hid[ACPIHID_HID_LEN - 1] = '\0';
 
 			if (!(*hid)) {
-- 
2.30.2

