Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237B5C4CEC4
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 20:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A31207FD
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 20:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njkIaQHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502462AbfIWUKJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:10:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41557 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502454AbfIWUKI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 16:10:08 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so36584918ioh.8;
        Mon, 23 Sep 2019 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O4biPIS8QtKs0W4x755+TgKPEkw6EcSzOJulQCgOdjc=;
        b=njkIaQHgxTxbxvCQR+vWZUivpNX+akdE2x1/MQJw6UKmijwTx7tDcioLHiCWPOR1As
         2ezrnErR4qB8uh5MPY9oEv+uSM+Yzw/FRYBhw8dUYeyi36bRn1esr9cA/moDArP0sFZO
         LGNq6sY8q+rH4eZD8M9rBBLYCIA63O53qsuJg3l4L71c0iViJsYoVlmixUSG9VxlEIL9
         C3EhOLUS41GYEj5FzzL8m5OW+2FjNCBFan5Rp0exvo2AFgkvJbI1M5+zlSAjo9oBDfMA
         880tkUs8fWGcC0yy1IzZjl/jqMc0dUMUbOBiRvEH3wl02pg2sacrZ15uiGq8kAeBlwgi
         5zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O4biPIS8QtKs0W4x755+TgKPEkw6EcSzOJulQCgOdjc=;
        b=rW2nbo+pDSkLeS5ng6kdDtZM5TuPRXOOBzLAeCX/Y/DAmsiYkvm8npK+lW3KhqGDY0
         3m3CKFlK4HMjoSOLq6tsl05SdgZRa5jDgKVu0XmgnpdR1e/PJTYnVIAzVB9YJOmGKVQ0
         lqBmH7nKbB30HR6vWSQWtvlcfX25h/7hC3axocJq8j5FxexmiVWJ901S1kl3F+K0Ttj8
         3K/G1kqBS2TTrzHgyp/wB1Ij9FCyHBYMWitI7iptjnyrREW3d5/hR6+cHTtt411P3q/A
         3yMoK/1pHhq6prgov44rCWM+wRrKtE+UWdg1Jbb7zJKSleHaDErPIkRDPzLAgTwTHzcF
         Fz+g==
X-Gm-Message-State: APjAAAVRYJv86ukZKq8zfgwVZjuTGGgq3QT3h658n3JjpHMwz61TWn/d
        pjmud3VdMrDfmI6Pf2gnc3c=
X-Google-Smtp-Source: APXvYqzRCHe8NZfJwm/rb4Y5QIs6ohRRrof7MdIT+Pa/qzCoh0RmIrYSXWnnIw9K2UCgqWwuS2kRUw==
X-Received: by 2002:a05:6602:2244:: with SMTP id o4mr1238924ioo.107.1569269407973;
        Mon, 23 Sep 2019 13:10:07 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id d9sm10877889ioq.9.2019.09.23.13.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:10:07 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: prevent memory leak
Date:   Mon, 23 Sep 2019 15:09:58 -0500
Message-Id: <20190923200959.29643-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In nbd_add_socket when krealloc succeeds, if nsock's allocation fail the
reallocted memory is leak. The correct behaviour should be assigning the
reallocted memory to config->socks right after success.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/block/nbd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a8e3815295fe..8ae3bd2e7b30 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -987,14 +987,15 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		sockfd_put(sock);
 		return -ENOMEM;
 	}
+
+	config->socks = socks;
+
 	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
 	if (!nsock) {
 		sockfd_put(sock);
 		return -ENOMEM;
 	}
 
-	config->socks = socks;
-
 	nsock->fallback_index = -1;
 	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
-- 
2.17.1

