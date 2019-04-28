Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A656C43218
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 07:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED38214AE
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 07:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfl8jRL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfD1HsL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 03:48:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37392 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfD1HsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 03:48:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id z8so3593140pln.4
        for <linux-block@vger.kernel.org>; Sun, 28 Apr 2019 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QqJOj91Ll5mqQSVD9RfnhrGlGzBnhOMYKV6F/t8uQg0=;
        b=bfl8jRL4l6vJ8nZq1E8TpBE2Pkn3qCTQECYmlEfaoOKYmHLCgNeg2kmYaHwbVBSB2I
         xpboyyiCtsbbD+zOfLzGbjNDkolpcuB4xxVs7ZTGw0ZkErbzE6pg9gMEJ8usq0IvvMit
         9Wlnt6HP4asMGNH0O2VUY+PMJNrWrmjmAMUM9zHmKkAD3H4o8Tumxo4hWOH9gYgGTiNn
         9awkpokHqY0HOjxqICtICGv0SXTClbe/23y7fGjSEC6HsUhKxt/8im2x4SVtyz5PpyGM
         SWeI9TBsto5/J24iMDHi6++3LBo3rc8qHccD9//4tNvgY6OwcAzgl/ylUGKjo3t1jDZG
         MJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QqJOj91Ll5mqQSVD9RfnhrGlGzBnhOMYKV6F/t8uQg0=;
        b=nEPozr8vYkbBVyQG7rp6/+dLuUyyh50d/5teTIbhE+BeaQGeBrWbXzMHnQ0Qes3R6I
         OuXaRzqgRLZmflFUJCZeFpjBI70q4pRLd9kDTAVr9a/ITGo75KCbmDq+isqg4ocsBd6k
         wow7asgDMIaEva9Lv81MmgC8AelDSCoYy7Ye5Nzvx8XIdk3dm1KVu9pNZz6ZYc/1PWRk
         VpM+ovA2OPWd0eUHdybiXtbMzSGeTxiiRMUi7kIzxqfucol4bgCdXzF+M3kY4Vqvvrn6
         YlBTC6eJ7hSyb4DaPKvBs+fkl//aiTCKLc8kfdBjhy9SMEGVZaOg4MWjoOwCi8h1uTxc
         HRPQ==
X-Gm-Message-State: APjAAAU/2ZWlKFpR8Jr8+FJQf0Dq16fNdVSk+HEYcUtba1xbJzm4utwk
        2FnQxXDaJjQOQV72osUAzvzRPCmUgQ0=
X-Google-Smtp-Source: APXvYqz9DUbp6b2P/6q5BK6MoiCOGspMQ0osu9UcKys7daMCj+ZrON4+YXqtfHkhHpS0mJPQgBSZGw==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr54133179plt.149.1556437690042;
        Sun, 28 Apr 2019 00:48:10 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id h20sm79241600pfj.40.2019.04.28.00.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 00:48:09 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] block: Move tag field position in struct request
Date:   Sun, 28 Apr 2019 16:48:03 +0900
Message-Id: <20190428074803.19484-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__data_len and __sector are internal fields which should not be accessed
directly in driver-level like the comment above it. But, tag field can
be accessed by driver level directly so that we need to make the comment
right by moving it to some other place.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 317ab30d2904..639ca948d644 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -137,11 +137,11 @@ struct request {
 	unsigned int cmd_flags;		/* op and common flags */
 	req_flags_t rq_flags;
 
+	int tag;
 	int internal_tag;
 
 	/* the following two fields are internal, NEVER access directly */
 	unsigned int __data_len;	/* total data len */
-	int tag;
 	sector_t __sector;		/* sector cursor */
 
 	struct bio *bio;
-- 
2.17.1

