Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26ECC48BE5
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 21:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D891613BF
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 21:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFOVXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhFOVXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 17:23:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B094EC061574
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 14:21:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h1so27497plt.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83yPG0EbFVr3SVh9NOBRiR0LGkMMFjPnxGPwEf0h9WU=;
        b=SJfhMTgBKkNck0DLHiyFQAMGBQiYJl9bmikbn+3Lp/t4d1oeBHwObQNlzZ0dOjAe0+
         RC5UWlZgE81S6saO0a2ztgFpvOJz1wFIl8BtV5rtghxD6cl081EJbKw9nJ6EEfQQt/o6
         DWerWeabH6YkpA3e0shmR+s/i9A8w39jLF7Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83yPG0EbFVr3SVh9NOBRiR0LGkMMFjPnxGPwEf0h9WU=;
        b=hV+QJysr1G+bTopmBFq82mh8IfOcmDwEEQxKtbJSiDSvupebOLdjSmoyQgQ3pF489r
         NbS5aaZ6pMsvM9RqFI+kkQx30K5Rh6FJuLLgNQG/M67ukKldhS0+/Udhv3KNEZke0iUq
         NmA9SLTRCNOz/T/YFqLcof+S+iZPnRm71hCL+cflXZyvaW5NAgGNtdvJ58IuBeR3DcDV
         YKyjUu0RrG6zuviShd+OsgKiMa4Rt5kDM/ym/vicdjiDRin354spenQ+MBJ9YlnUUHDN
         imO5takUbDON/jyIfDgE7c+41uIOn6qE8OQacJ9c8vCTYghDRoOQREJjjeUE02wgUtJR
         lh3g==
X-Gm-Message-State: AOAM533LPybGkCPGqQU9tIKrxP2wekTVtlYezNU/FT5IEaPPtubcJ/vm
        rQbyOo//pWhTUKTH3H0ide9x7Q==
X-Google-Smtp-Source: ABdhPJyOHvKXPd88U7Ng3kUR5Pe6gtsxiOBZKK/gSe0WnsnJvTx8JUA7RX5Hc+uDNGQLtnT3Xgv0Dg==
X-Received: by 2002:a17:90a:d483:: with SMTP id s3mr6958605pju.61.1623792086887;
        Tue, 15 Jun 2021 14:21:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm98105pfa.2.2021.06.15.14.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:21:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/4] pstore/blk: Improve failure reporting
Date:   Tue, 15 Jun 2021 14:21:18 -0700
Message-Id: <20210615212121.1200820-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615212121.1200820-1-keescook@chromium.org>
References: <20210615212121.1200820-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=782d384d6486fe89f671933d300cdcc0b58915de; i=x+eth6WIY3ZV3RikljpGvsEDOkHC4+JR/D6VkOL4MwM=; m=KWKLltarrgCHVaChKkiXTTMXR+nWhEDb2yQ+7Fx0dy0=; p=Tg76lnQ+eXJOmzqDWYbfNJALp24lTAKgJm1/vS8S8JE=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDJGdAACgkQiXL039xtwCaQmhAAhER rf9rrrOC5Ufm5tSBzRs8WRgIklq6gyVFRzdiqk/xEzIN7j/qlXR56KeI6dCfskYhf8JGky/FBdnoX 5YRfXX/ANRiZ/pA69pClLA2fYxM37EX7gqxYA6XmwgeIPGO+3w7mlZ9rxstLmg/7msVicK7+aDVsx tv3ufAl9Yp1pECdZ90FaFNWEdTw6+lmHYzmMqGiRfxr8Vg0cClO7kkAy6DObfCXqCsUaCp8tsjCFa P1ieQ+PGW3vNIxZci3zADPFWQz6/t8VkT3gFl9vUqHrtYtwpgBK0hcdlu0tHrPunU1bhkvR9J5aJA i3x5psdyNaV2E2KKXeq78irRPceNdQxbxpxrOpWqJrKa3kxyEHFlZe//HT2QfyXjrVI5uAAl1M5mu D189qXiSeS6UDh/Kr78HbJE9o0S1xAXaA9/mtRHLcZNC28dcTkzoqi4JRQKRGugZynGJyynWTsfUu 4ajxovmObroq2UPfcj56fgIfOavfUmxiWWqfI21SIZ1WbrepKrcsD4YYLfMv9t/8kUpGanhyxTkVg xvVVyCOfA+ReUVgFidq/mFPM8xHPEkXa+zo0weOncXhAyBYO25ugYR6EgHkkukrrak0yoFgyZdkUe +4ZOhtYaDtANnr+eyj8qcSmr8FaC2gcxt+aR/NGq9ekIlbOqfNABgjj6aN93VczE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There was no feedback on bad registration attempts. Add details on the
failure cause.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/blk.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 4bb8a344957a..91d7a848c85b 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -114,8 +114,19 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 
 	lockdep_assert_held(&pstore_blk_lock);
 
-	if (!dev || !dev->total_size || !dev->read || !dev->write)
+	if (!dev || !dev->total_size || !dev->read || !dev->write) {
+		if (!dev)
+			pr_err("NULL device info\n");
+		else {
+			if (!dev->total_size)
+				pr_err("zero sized device\n");
+			if (!dev->read)
+				pr_err("no read handler for device\n");
+			if (!dev->write)
+				pr_err("no write handler for device\n");
+		}
 		return -EINVAL;
+	}
 
 	/* someone already registered before */
 	if (pstore_zone_info)
-- 
2.25.1

