Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCA9C61DD8
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899FE21D7F
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 16:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKPC7cTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgKLQuN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgKLQuM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 11:50:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5176C0613D1
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2020 08:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DJP/8vs4ykzHKc6DHLcxHUQQ4kXE+U15/2xsaVbVlkc=; b=AKPC7cTPU7x858fam2CQQEv3D5
        PRUCOM6nvX1J0KxcgF6MEIotk/rL8Acxarp6Xnb6dr+OaUsverD//0zDounuTom3O52cVcoqDGxfU
        C6fMvPen3vb0TsTDjszfcOxJhdc5BEuzJGJMqpTJ/ZOkGdHhx2MHl9kBnoXVGonQF4j2Usoqtin1i
        VXKiEhpRA+TtgBGyvihNHi1rwnAYLmmOgswREmMYuwNoE9xNJ0K56Kz6KlD7B/rC2UW6vDmCouCUw
        SnrATPE9AMdrWqg8KPyrXFW4L0OcZaOkSEkQf4AGhUrRo407uxIMJzCc9YLxBWOTEiHxB5+Fy3mtJ
        kS9khKTw==;
Received: from [2001:4bb8:180:6600:5c73:9bb4:23ff:391c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdFnW-0006yy-5o; Thu, 12 Nov 2020 16:50:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Petr Vorel <pvorel@suse.cz>, Martijn Coenen <maco@android.com>,
        linux-block@vger.kernel.org, ltp@lists.linux.it
Subject: [PATCH 2/2] loop: Fix occasional uevent drop
Date:   Thu, 12 Nov 2020 17:50:05 +0100
Message-Id: <20201112165005.4022502-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112165005.4022502-1-hch@lst.de>
References: <20201112165005.4022502-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Petr Vorel <pvorel@suse.cz>

Commit 716ad0986cbd ("loop: Switch to set_capacity_revalidate_and_notify")
causes an occasional drop of loop device uevent, which are no longer
triggered in loop_set_size() but in a different part of code.

Bug is reproducible with LTP test uevent01 [1]:

i=0; while true; do
    i=$((i+1)); echo "== $i =="
    lsmod |grep -q loop && rmmod -f loop
    ./uevent01 || break
done

Put back triggering through code called in loop_set_size().

Fix required to add yet another parameter to
set_capacity_revalidate_and_notify().

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/uevents/uevent01.c

Fixes: 716ad0986cbd ("loop: Switch to set_capacity_revalidate_and_notify")
Reported-by: <ltp@lists.linux.it>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
[hch: rebased on a different change to the prototype of
 set_capacity_revalidate_and_notify]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb1191d6e945f2..a58084c2ed7ceb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -255,7 +255,8 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 
 	bd_set_nr_sectors(bdev, size);
 
-	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
+	if (!set_capacity_revalidate_and_notify(lo->lo_disk, size, false))
+		kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
 }
 
 static inline int
-- 
2.28.0

