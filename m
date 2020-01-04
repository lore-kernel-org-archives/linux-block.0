Return-Path: <SRS0=MEbK=2Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373B4C2D0C2
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E2B21734
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="msCqm+84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgADQYY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:24:24 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:43152 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgADQYX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 Jan 2020 11:24:23 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47qnCm5QvSzqH;
        Sat,  4 Jan 2020 17:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578155060; bh=SJg9+JjaSMHNa+k1IX8sg3nhFNF9mHiHz291qBzLAzk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=msCqm+84765w7SpzJsxnOwOi7tPzAgsIQPFtxj72jU1VlDaI3CyKtkWcp9BAtbLzv
         RwKbR6/C5LOnNohSvLnSAHVOIzS0xrCfpRbxJMq1zfbuVk1xfENTdZjinXffSeWN1g
         J81kpUCX2gF8so+57y7RgnFhEc+aXSzf/UbABr5osi+RcTh6nEwSHrNdGnSc3Sdhok
         TwFlrUEVl88b93HErq53okY6V65oeeLBKRs1LUvx1RiGpOlSOVPLmU3Nz532YFrF8H
         t3L+WTfhs0N2yVglbv3tOephyJ+vX9LO0qn7SrMu/Gmdh8UPiiIFoZDt4b6GbIHG0k
         wQv3ym7N20Q/g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 04 Jan 2020 17:24:20 +0100
Message-Id: <2b13cbb612add74856aa88a71375db3718d4aae6.1578154967.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <6e542430795eeddb718db88cb08224d2e1bc6b4b.1578154967.git.mirq-linux@rere.qmqm.pl>
References: <6e542430795eeddb718db88cb08224d2e1bc6b4b.1578154967.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] block: allow empty cmdline partition set
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make no-partitions setting valid. This makes it possible to prevent
kernel from trying to read partition table from a device.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 Documentation/block/cmdline-partition.rst | 2 +-
 block/cmdline-parser.c                    | 8 +++-----
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
diff --git a/block/cmdline-parser.c b/block/cmdline-parser.c
index f2a14571882b..bc63e46e7bfc 100644
--- a/block/cmdline-parser.c
+++ b/block/cmdline-parser.c
@@ -133,11 +133,9 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
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
2.20.1

