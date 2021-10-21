Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FCEC433FE
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 22:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786DE61354
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 22:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhJUWxm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:53:42 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:56520 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhJUWxm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 18:53:42 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Hb2lc2JCTz6R;
        Fri, 22 Oct 2021 00:51:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1634856684; bh=ZwoePfzEfsoQ8Zx+vw7u0tVHnJGAJrlBMlcivXSgOgA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ayTpHcro7nKHbKWJIgWmfnXcSv3s0VwFAF5kxAaIK6X2ZsDRkHMDQNM1G89k74UDn
         hU9QvKZrKV+F1hfoeYFbXyVGGbfWzIQ925Q+6D9dSj4sqjrkRVqA12SnGiiMUM/6B2
         ayvj4eHkN3njrYneicJUXRiKsOjE+swpDNBJ3x4uzZ2ENk2Prk6wLuAnUEee1sBEaE
         bsp4v8nQrbXXynshNwXaLIKzxpXm9pr6yOry3nvZa/NwrlexTTLBGqIl+jheqqiOBU
         ZhLcTg6D2wJxLK0Y7J6lANZEyvsI41x7nHVnusJGYabTsVwF5qe+s+Zp3ytcqRT8fP
         HLM6yp6xZKiVQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Fri, 22 Oct 2021 00:51:24 +0200
Message-Id: <b84381943483d1e0b44ca28b4e549f2f912349bf.1634856658.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <8a6b11c6ada5d55bdb2b1f8319e47bbf5192654b.1634856658.git.mirq-linux@rere.qmqm.pl>
References: <8a6b11c6ada5d55bdb2b1f8319e47bbf5192654b.1634856658.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] block: allow empty cmdline partition set
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make no-partitions setting valid. This makes it possible to prevent
kernel from trying to read a partition table from a device.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 Documentation/block/cmdline-partition.rst | 2 +-
 block/partitions/cmdline.c                | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/block/cmdline-partition.rst b/Documentation/block/cmdline-partition.rst
index 530bedff548a..a5ccacee982f 100644
--- a/Documentation/block/cmdline-partition.rst
+++ b/Documentation/block/cmdline-partition.rst
@@ -13,7 +13,7 @@ Users can easily change the partition.
 The format for the command line is just like mtdparts:
 
 blkdevparts=<blkdev-def>[;<blkdev-def>]
-  <blkdev-def> := <blkdev-id>:<partdef>[,<partdef>]
+  <blkdev-def> := <blkdev-id>:[<partdef>[,<partdef>]]
     <partdef> := <size>[@<offset>](part-name)
 
 <blkdev-id>
diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index 1af610f0ba8c..3655e8c8e949 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -164,11 +164,9 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
 		next_subpart = &(*next_subpart)->next_subpart;
 	}
 
-	if (!newparts->subpart) {
-		pr_warn("cmdline partition has no valid partition.");
-		ret = -EINVAL;
-		goto fail;
-	}
+	if (!newparts->subpart)
+		pr_warn("%s: cmdline partition has no valid partitions.",
+			newparts->name);
 
 	*parts = newparts;
 
-- 
2.30.2

