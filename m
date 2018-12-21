Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E489CC43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 14:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB4721720
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 14:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545404091;
	bh=wml/K4J5nP74r7L4X1Q7BI5a3B0V6HI6ZnhR5bPn9MY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XPR01JS46qRHtDogKgv3NtwHRHc7QRJpMGmW/tC8htiiAZwvcJnDPxSpUgwyn8GcL
	 PB8NMTzvyLJGUh2S+diBAn/vAWkdeQZfW8RvJtNxer6lftZoTo6ksI0r45oxLzJeQQ
	 qJ7SHK3334lyQfzi2fpwhj3YJ22cZa62eE4xHmTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbeLUOyu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:54:50 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33755 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbeLUOyu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 09:54:50 -0500
Received: by mail-yw1-f66.google.com with SMTP id p65so1045183ywe.0;
        Fri, 21 Dec 2018 06:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GnWw34EUMHWcEqLf5GmmebOYoPKtH2U+0j1NgExUaKU=;
        b=C/wwgs+tjgaFwRDJuD1li3++9RkBelnk7FFu4unOJ8XxHOSjsm52ghixMygfORmTvp
         hHpvPx5hlHVVCy7+DRNTYWlCiKDfafQvalL5Hvq9uZ0HugmxW38IRmLQo2LXFrKVxIEX
         7zBiH1qigW6y/wN9HllNe4bBpwQprMTQ0c/HJBJSCSWfzWlv+iNBmEFwt0dvFqR5j8/M
         Vxe/icsfF3QwaBxIXBm0U0u0pAqtwYMjR+F0XrvP3Pf/iQgoevhdqGnMHCeD6WxxS2MS
         CAruEYOr53JsV0e11KtHbA3gc9kkz8dO+10W2ifTPNph92iUG9+TPuTvzc4B62IO5WGP
         Dtkg==
X-Gm-Message-State: AA+aEWb849ETqqNY7y11hGlNY/X11FPMn9JyRokGX2PEF3yL9ig0B25P
        IeeVcedP8nfUIztzd0P/1dA=
X-Google-Smtp-Source: AFSGD/XN4KedZRhXoVbszrZqpjSqrf41FyH5qN0dMTUVpbTP6ogg1LZl5ztEZJXcuKcMvXE5tRSiMQ==
X-Received: by 2002:a81:9184:: with SMTP id i126mr2746230ywg.371.1545404088874;
        Fri, 21 Dec 2018 06:54:48 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.2])
        by smtp.gmail.com with ESMTPSA id x4sm14607101ywj.80.2018.12.21.06.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Dec 2018 06:54:48 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] blkcg: add rcu lock to bio_clone_blkg_association()
Date:   Fri, 21 Dec 2018 08:54:41 -0600
Message-Id: <20181221145441.13814-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I cleaned up blkg_tryget_closest() to require rcu_read_lock() earlier.
However, this was a subtle case too which clearly was too subtle for me.
The idea was the src bio should be holding a ref to the blkg so rcu
wasn't technically needed. If it doesn't hold a ref, it should be %NULL
and the blkg->parent pointers are unused.

This adds the appropriate read lock in bio_clone_blkg_association().

Fixes: 80fd3c272c1a ("blkcg: clean up blkg_tryget_closest()")
Reported-by: syzbot+a36a3ba92bea3b315c64@syzkaller.appspotmail.com
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 block/bio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c288b9057042..9194d8ad3d5e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2096,8 +2096,12 @@ EXPORT_SYMBOL_GPL(bio_associate_blkg);
  */
 void bio_clone_blkg_association(struct bio *dst, struct bio *src)
 {
+	rcu_read_lock();
+
 	if (src->bi_blkg)
 		__bio_associate_blkg(dst, src->bi_blkg);
+
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(bio_clone_blkg_association);
 #endif /* CONFIG_BLK_CGROUP */
-- 
2.17.1

