Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39811C4332F
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 00:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiLBAgW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLBAgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 19:36:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E3293
        for <linux-block@vger.kernel.org>; Thu,  1 Dec 2022 16:36:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so5365403wma.1
        for <linux-block@vger.kernel.org>; Thu, 01 Dec 2022 16:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9ekcnDHDEQ3l22MuceDJz0T2U7LgcQrhIH0jnfs5LQ=;
        b=k2DH+qNkPV5FZgyE+lmOrXGV6IdKSZFdud1/CrIcdl2WbxyededXjKUw/zI21zKTIN
         1SkQWNZJBqM+SAWtR1w0YhdozviE9D8xJw5jPGusaKUABpv7lKmBsRFh/ze5VohRP0o9
         jNCba7VUZBxzamWcrNgxMpJ89WWJ/dsbkY2Ye8tO1fjuVLPcPJJkj2KKOlfNpbEB2Nel
         VjM79LxvR5JJUne5+FNjmiIwpaXrKqjOn17qWkXSQQL8GwNTKt/XitnPuAom3Wbgv/0/
         c3hgANvPvgiTcpr2l5UNYg2qsOIhDg1hju8nY6hr/iWgwOree4Lluhmzbjwq6Tz/MeKl
         F4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9ekcnDHDEQ3l22MuceDJz0T2U7LgcQrhIH0jnfs5LQ=;
        b=d4R1VIX8TEsln9eFvAWM6p4NmFplznLVTr+Eviv4EQ7ZBBwplNjTEhZ3wmXiqGuipK
         fSPFMG6lL9Vn58Y1iUniyZlJB1ZDVQOX/GTB6I4z0Z4uPZhC3wlv0l8KGx42DCPQbfCd
         Tw8WO0hMsyCYGm5Cz1Q/wE2FG7QR04ZcfgexVHj2pzyPDBCeU+nFMvQqj9ux36LPxJCb
         sDL/oFZVQ3TXsubbbKBqCz0xD6f6CibDUovkEAkPoS5D1Kr/R2xE35Zqq5bt2zmK0xNu
         uLB/ZzjPtIGyl4RX4mXWsmsTORpDfCNBudOPZ8/hSVuqTC36Pf8PGDjeGyU+zg+wl8es
         ggrw==
X-Gm-Message-State: ANoB5pmSpddGqSrWZNVSbfo6dIwLZvceFQ+NhDjrec+yXilnH7HLBOJE
        e50PPyikeumMVliqmpRNd9PU4UDRuBLlqg==
X-Google-Smtp-Source: AA0mqf6bMRQ5LfZdDO4ix7mtaZSlnDngXoDvZbC5omQLvXlgUTs/fWogK2h8VwGXeNBT5XxgBJN4WQ==
X-Received: by 2002:a1c:7909:0:b0:3c6:f83e:d1b3 with SMTP id l9-20020a1c7909000000b003c6f83ed1b3mr37790209wme.190.1669941378532;
        Thu, 01 Dec 2022 16:36:18 -0800 (PST)
Received: from localhost ([2a01:4b00:d307:1000:6f15:7230:d519:3286])
        by smtp.gmail.com with ESMTPSA id dn13-20020a05600c654d00b003c6bd12ac27sm6642176wmb.37.2022.12.01.16.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:36:17 -0800 (PST)
From:   luca.boccassi@gmail.com
To:     linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev, gmazyland@gmail.com, axboe@kernel.dk,
        brauner@kernel.org, stepan.horacek@gmail.com
Subject: [PATCH] sed-opal: if key is available from IOC_OPAL_SAVE use it when locking
Date:   Fri,  2 Dec 2022 00:36:10 +0000
Message-Id: <20221202003610.100024-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luca Boccassi <bluca@debian.org>

Usually when closing a crypto device (eg: dm-crypt with LUKS) the
volume key is not required, as it requires root privileges anyway, and
root can deny access to a disk in many ways regardless. Requiring the
volume key to lock the device is a peculiarity of the OPAL
specification.

Given we might already have saved the key if the user requested it via
the 'IOC_OPAL_SAVE' ioctl, we can use that key to lock the device if no
key was provided here and the locking range matches. This allows
integrating OPAL with tools and libraries that are used to the common
behaviour and do not ask for the volume key when closing a device.

If the caller provides a key on the other hand it will still be used as
before, no changes in that case.

Suggested-by: Štěpán Horáček <stepan.horacek@gmail.com>
Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 block/sed-opal.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9bdb833e5817..b54bb76e4484 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2470,6 +2470,35 @@ static int opal_lock_unlock(struct opal_dev *dev,
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
+
+	/*
+	 * Usually when closing a crypto device (eg: dm-crypt with LUKS) the volume key
+	 * is not required, as it requires root privileges anyway, and root can deny
+	 * access to a disk in many ways regardless. Requiring the volume key to lock
+	 * the device is a peculiarity of the OPAL specification.
+	 * Given we might already have saved the key if the user requested it via the
+	 * 'IOC_OPAL_SAVE' ioctl, we can use that key to lock the device if no key was
+	 * provided here and the locking range matches. This allows integrating OPAL
+	 * with tools and libraries that are used to the common behaviour and do not
+	 * ask for the volume key when closing a device.
+	 */
+	if (lk_unlk->l_state == OPAL_LK && lk_unlk->session.opal_key.key_len == 0) {
+		struct opal_suspend_data *iter;
+
+		setup_opal_dev(dev);
+		list_for_each_entry(iter, &dev->unlk_lst, node) {
+			if (iter->lr == lk_unlk->session.opal_key.lr &&
+					iter->unlk.session.opal_key.key_len > 0) {
+				lk_unlk->session.opal_key.key_len =
+					iter->unlk.session.opal_key.key_len;
+				memcpy(lk_unlk->session.opal_key.key,
+					iter->unlk.session.opal_key.key,
+					iter->unlk.session.opal_key.key_len);
+				break;
+			}
+		}
+	}
+
 	ret = __opal_lock_unlock(dev, lk_unlk);
 	mutex_unlock(&dev->dev_lock);
 
-- 
2.35.1

