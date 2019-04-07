Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3DBC10F0E
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 15:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D13C20880
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 15:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUebQd7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfDGPcx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 11:32:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43686 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfDGPcx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 11:32:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so2898022pgu.10
        for <linux-block@vger.kernel.org>; Sun, 07 Apr 2019 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9M0+N9W9Ti/eIPVfd9uKQjunxkS8x/zOD7AyfaBmEoU=;
        b=OUebQd7Bq4Pje1kkK9EdKGircRCpo2gZbZJcnb/D5V8GWmnaj24WmB34Ym4VF/1zQh
         eMSCFzJ7JcYiobFzqHCjUElWraW/mN8TyVEDq0ic9MMjQHXxhsAq6qEJEBAeo/zi4ldi
         bZGpIs4mEYGJlsh5MrFTnA4nV2qD2G3tksEKAN8YYVqtI2hfwO9YMUxvv3ahN8iLvP2r
         XJgq5Rtm9mHMe+lxbGRrbymen+QQi3HGMecYLmIxkpq0ddV68fm9xpDezOwy+BOM98V7
         BFFeE0T7RYozuTzVeOAQ+8+/HbCqyCJN9zM5GeC7G2kcTC5CCWuLFnD58Lc6OsVqdf6p
         LAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9M0+N9W9Ti/eIPVfd9uKQjunxkS8x/zOD7AyfaBmEoU=;
        b=N2WMI7nXqXZ0GprHbi2PFoDBYlFKBu5Ja9y8bCINEzMIdyq823i/s7c3UfTTD7pyV+
         FCJKKDcVGxjt/Eg4pMKadTyS9ttrsgze7suirFYJ3EOTIJrJ35VUYBExEkKjCYrA8E2Q
         hcZpuKGm4wjmAB9/k+G/pUW+M9NPQ/ihKqOI9omUFNOCAainoSp9uFmRen9F6OYzrwXQ
         QPir10/9v+xwbFN6YLa2oU+/YutmcEN9icWx+vdEjQPUOwH+f2kh8l7GspoMr7Ws5gcs
         XOyBugxwuu8S4ovDYpo+lqxErgNZr33cQm2adb+H8GNWao2Kqo31odiwB1wfDSyawe6M
         gWYg==
X-Gm-Message-State: APjAAAVYYNpQ90eGvEP04nbXLTpz180CkoXMpuXhnxYquNyBvxSjRVNL
        cJxj9/baB37mUDOjjPNoGR0=
X-Google-Smtp-Source: APXvYqxSDNRWijfBeO4bfTNALuTJY92RmPGcnmdfSnHlB+kBKuROMUa2ysUe595IOjjVY19qn3f0JQ==
X-Received: by 2002:a62:6842:: with SMTP id d63mr25234963pfc.9.1554651172170;
        Sun, 07 Apr 2019 08:32:52 -0700 (PDT)
Received: from localhost (p175034-ipngn200303fukui.fukui.ocn.ne.jp. [180.5.54.34])
        by smtp.gmail.com with ESMTPSA id u6sm18652874pfm.10.2019.04.07.08.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 08:32:51 -0700 (PDT)
From:   Hisao Tanabe <xtanabe@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hisao Tanabe <xtanabe@gmail.com>
Subject: [PATCH] block: remove unused variable 'def'
Date:   Mon,  8 Apr 2019 00:27:42 +0900
Message-Id: <20190407152742.30821-1-xtanabe@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'def' local variable became unused after commit f382fb0bcef4 ("block: remove
legacy IO schedulers"), let's remove it.

Signed-off-by: Hisao Tanabe <xtanabe@gmail.com>
---
 block/elevator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index d6d835a08de6..2e5399d9f40f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -509,8 +509,6 @@ void elv_unregister_queue(struct request_queue *q)
 
 int elv_register(struct elevator_type *e)
 {
-	char *def = "";
-
 	/* create icq_cache if requested */
 	if (e->icq_size) {
 		if (WARN_ON(e->icq_size < sizeof(struct io_cq)) ||
@@ -535,8 +533,8 @@ int elv_register(struct elevator_type *e)
 	list_add_tail(&e->list, &elv_list);
 	spin_unlock(&elv_list_lock);
 
-	printk(KERN_INFO "io scheduler %s registered%s\n", e->elevator_name,
-								def);
+	printk(KERN_INFO "io scheduler %s registered\n", e->elevator_name);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(elv_register);
-- 
2.20.1

