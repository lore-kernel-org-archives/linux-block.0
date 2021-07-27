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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BD8C4320A
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A3460FA0
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhG0VH4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbhG0VHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 17:07:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296BFC061764
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:07:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso1090922pjo.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRl4QwGFVHrrGOIPdMRW7d1sxZ/z0xnxJ3QgfuV7q+Y=;
        b=VLdolfVHCXSWi55Yx/uNOx2x9gNCjcm8fAuonyRhF6lka+9tJjMC+ljSDw1I2hhSPl
         IPeW06Di2elnxoPtiM8a7tbufyY5DIpbj0wKJi28F7I97+I2C7r+CBhjZpWfsMqRUJOq
         uPrEwdOtDaUl+C26xZmgSdL3xsdhOztQ/ekno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRl4QwGFVHrrGOIPdMRW7d1sxZ/z0xnxJ3QgfuV7q+Y=;
        b=qgBDW1RHa9JmN8kXARmlIE72S9atgWl056C1auReRsNr660iLTyhYS1uXZZxzY06Bf
         8tNh2I7qoDWRA85gb0zsMzmuEuEqS/qaADYFqQdZIWt7jDF8ItiqKtUz9es3N4drS5Uw
         Pvxz6q1oZhwJHvw66qFyFqIdyNzef6uh2RPqnCMWlnxDSeWZ5ijcYI1n3p+79rAHhRvh
         PPDMdHAPa4vhINzIc7KMcb37gH7DVdi/tn/gytQEav4kD/OLlh5ARNsIBYA6VaA9ZdH6
         jnbicuvQrF2TVshCOjLlfraLxY7MamSffx+0tHPK76Goa66oNjfd+itJNQECd9GeEq2W
         8BUg==
X-Gm-Message-State: AOAM5329EhMWSW0aPzF8MRYI6nSEgXZxxAnQKUb1zLZZplvjeJEp7U0j
        lMde4H+z6bGn5mYiBThJQs+4ZA==
X-Google-Smtp-Source: ABdhPJz1O0RCaY6YxEHXQjrBeBf6WlvQVtA9lzuclsJxgu0ny8IwFRemKEhaTqFBHWHY+58Ad0sxsg==
X-Received: by 2002:a17:90b:1097:: with SMTP id gj23mr24623197pjb.65.1627420020773;
        Tue, 27 Jul 2021 14:07:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k4sm1283492pgh.9.2021.07.27.14.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:06:55 -0700 (PDT)
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
Subject: [PATCH 53/64] HID: roccat: Use struct_group() to zero kone_mouse_event
Date:   Tue, 27 Jul 2021 13:58:44 -0700
Message-Id: <20210727205855.411487-54-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; h=from:subject; bh=EUTv4O0nvngYWbdXtF9deGR2fwqq+6xUthh2+Rv4aLw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOMI/KVhJIquCmbVDokB41QtN0+bK1f1n8H1BjO /vI3XCGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzjAAKCRCJcvTf3G3AJigBD/ 4xOpohWQjjZHlbRQQB4Xc96JEF9UrR/87ufDJ/LQCR9f7bpU5HN4prxvGPl+Gh14S3nTWDhs7tQLV8 lgvttBveo3P3wp1AEgc84pleIWnY19RV8DcusmvreDhDG62N4MMW91V+yoqBuqB34xAxKaVJ0z6h4X tMH1NjPo77yLscB15GrJ4m3R/aS/iaccGcVUCwTR/CdCDoI/vLaImBCCH5YwQovtUmT1k04HUparAv jTs0fwcc1LfmJGkpT/YOIJnJ2shh0qAzEBKxdHgAIYE1pJJ59NQ6IfNzbMcQzEeapQ0p+kJRjODNpd oBpl+VAcjcyG71c3NBYs64mHgmd7xQgqxrKHeTTPI73krFkwv0sjaz1tYf6t3wGr+MJBryeUc/XLef bBUhQQ+U2nmjxMpH5biZuX8R5fJd8K2A6iOdS4OCIgCexMIqdOf47mtYSGy6w/OqX0D0HulkNM6Ak5 /kO3TY/+btKVuq9e6QW5DQLMbCfCbRrCJHmWxOFI5GVH3bchbtyGtVnd5VCwHQJhG28UCjTcKMLd10 3FKyVUcll/fy3asrDwz923cHSGawsRdwuUUF+B/1A93hUfh8ZPHnbv0X2Rh95SGmSNd9p793a13Ftn 6BVstROxT8kaLKdvZkdDDu6WqpqQxHglko/wXhuVc2rwuMX8jO3UGuzQBK9A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct kone_mouse_event that should
be initialized to zero.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/hid/hid-roccat-kone.c |  2 +-
 drivers/hid/hid-roccat-kone.h | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 1ca64481145e..ea17abc7ad52 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -857,7 +857,7 @@ static int kone_raw_event(struct hid_device *hdev, struct hid_report *report,
 		memcpy(&kone->last_mouse_event, event,
 				sizeof(struct kone_mouse_event));
 	else
-		memset(&event->tilt, 0, 5);
+		memset(&event->wipe, 0, sizeof(event->wipe));
 
 	kone_keep_values_up_to_date(kone, event);
 
diff --git a/drivers/hid/hid-roccat-kone.h b/drivers/hid/hid-roccat-kone.h
index 4a1a9cb76b08..65c800e3addc 100644
--- a/drivers/hid/hid-roccat-kone.h
+++ b/drivers/hid/hid-roccat-kone.h
@@ -152,11 +152,13 @@ struct kone_mouse_event {
 	uint16_t x;
 	uint16_t y;
 	uint8_t wheel; /* up = 1, down = -1 */
-	uint8_t tilt; /* right = 1, left = -1 */
-	uint8_t unknown;
-	uint8_t event;
-	uint8_t value; /* press = 0, release = 1 */
-	uint8_t macro_key; /* 0 to 8 */
+	struct_group(wipe,
+		uint8_t tilt; /* right = 1, left = -1 */
+		uint8_t unknown;
+		uint8_t event;
+		uint8_t value; /* press = 0, release = 1 */
+		uint8_t macro_key; /* 0 to 8 */
+	);
 } __attribute__ ((__packed__));
 
 enum kone_mouse_events {
-- 
2.30.2

