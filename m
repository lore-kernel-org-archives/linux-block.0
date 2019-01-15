Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43021C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 03:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAC720659
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 03:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWUI5HHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfAODG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:06:27 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45141 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAODG1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 22:06:27 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so1340424edb.12;
        Mon, 14 Jan 2019 19:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ll9m/aqiuzBB9p5qvWyeWVgdGfxqU+Ww6QX2/aZWj8Y=;
        b=AWUI5HHlogaXIPvUNe6neRH9r80Mr+8zGEqVXrrhLV3zkz8sYJn9ns/gjq/22Iktul
         WbSR9UeVXHXZqG9X5KyHlKfr3rpUhBsviOWF834yEHzqlPds8q7+71kaBbO+90ICWWPi
         0kX8C7t/zbbsK15ZJ6zBO5txPl88lcrJXCNzjnlqlRsxTjHQIbLypWKywD/UY8KqJFvx
         w7vCRrBfRRfWkTZBSLAZ6U9XO1a4VFXlIwMkkWMBBrXYvCilWaIAmZyxwY6Pa25qvRQn
         jx23yjC4E4ABss6Yj2F7SfPkLxh+dvhWqeLhPlrLcRAfBbtZ/csIr8nql8E3X6FFmQ+E
         mTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ll9m/aqiuzBB9p5qvWyeWVgdGfxqU+Ww6QX2/aZWj8Y=;
        b=jeX1BafhXYYZJs2aWbot+PegiurHWyAR8ZjCaG0xIL1s96BMIyjvS/Vzz990rw+6k7
         jB4v5fiOzI/Ogx+iAy5XdMkWiDyqp/pEfuVqL1x/ORNSpXR5hnsvlR76tj+QYVyHO2PB
         5GPOje9uYAqa38O+kmPE6c2FtV9C65zRASxzfSkJ10Mer8Oxp0oiYWFl1jONWIiNy1q5
         O9Ld2jIeSzPK/5oJ6Fl6CSy+K3/6RFhQN943jg+Tm5YT5ZDj6zZDnZzUvuJCTm39SoEW
         yXnQv/nyAlaydilx14f5q/te0p70iYpSoX1sbj+Hx53mDuBbDXpmtw/MulDIUzj7QmEJ
         VmUw==
X-Gm-Message-State: AJcUukcsuf9C1zXb6VWQoGZ+gTcCQqp+9R4vo+jW4bwussxJRE2doJw8
        VjOQCW0ZVHZCnRmPRxzgrcEjwtda
X-Google-Smtp-Source: ALg8bN7KNtijN7WCh3zkzb+h2IY2JQsjRri3EskFLT7WlVOu3kcGdbQhm4J2drDKfiEeOy4ioGvslA==
X-Received: by 2002:a17:906:a4cf:: with SMTP id cc15-v6mr1440626ejb.157.1547521585037;
        Mon, 14 Jan 2019 19:06:25 -0800 (PST)
Received: from bebop.suse.de ([189.58.144.218])
        by smtp.gmail.com with ESMTPSA id a38sm4510484edd.44.2019.01.14.19.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 19:06:23 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH] block/blk-sysfs.c: Remove last reference of blk_init_queue
Date:   Tue, 15 Jan 2019 01:06:15 -0200
Message-Id: <20190115030615.1090578-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_init_queue was removed in a1ce35fa4985.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 There are more two references in Documentation/block/biodoc.txt, but maybe that
 file needs a rewrite in rst anyway?

 block/blk-sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 590d1ef2f961..dd9b50226c6e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -821,10 +821,9 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
  * @work: pointer to the release_work member of the request queue to be released
  *
  * Description:
- *     blk_release_queue is the counterpart of blk_init_queue(). It should be
- *     called when a request queue is being released; typically when a block
- *     device is being de-registered. Its primary task it to free the queue
- *     itself.
+ *     Should be called when a request queue is being released;
+ *     typically when a block device is being de-registered. Its primary task it
+ *     to free the queue itself.
  *
  * Notes:
  *     The low level driver must have finished any outstanding requests first
-- 
2.16.4

