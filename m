Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFDAC77B73
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 07:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjDSHu4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjDSHuj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 03:50:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1749C175;
        Wed, 19 Apr 2023 00:50:09 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681890606;
        bh=kSlTxie2Ksev8vTGCDWHXnNc4gL+EGM1NG1+H1a+m6E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=l8DYAJVtorw7L4oqC+eL7xArCxF0pNZgDiJh5GTlfkWKPhqU3+9dyZEB5ePCv4+VD
         Rl0xSBuODwChxCxKuoWOWqxnzlPqZD5y44QD/iH97YYQOfZBaAQCVCMfpwcNpiAzna
         YgEb+VMGmvp69gQCYdFJMZt8IhD8ozmqO6boHrfw=
Date:   Wed, 19 Apr 2023 09:50:01 +0200
Subject: [PATCH 1/4] block: constify partition prober array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v1-1-2d66f2d83873@weissschuh.net>
References: <20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net>
In-Reply-To: <20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681890605; l=698;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kSlTxie2Ksev8vTGCDWHXnNc4gL+EGM1NG1+H1a+m6E=;
 b=DjdLzIs3C9Vi612gPssij7yXcJOt4k/kQJmuexW0wQ7fSreII52rD8l2eI00RFP7uk3Udg0Tq
 joRXaGTK8QDAKCsrAasX3qd78urpEuX/9fQCfnv/27kCSKmCm7m3uym
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The array is never modified so it can be const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 7b8ef6296abd..667f3dcebd59 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -12,7 +12,7 @@
 #include <linux/raid/detect.h>
 #include "check.h"
 
-static int (*check_part[])(struct parsed_partitions *) = {
+static const int (*check_part[])(struct parsed_partitions *) = {
 	/*
 	 * Probe partition formats with tables at disk address 0
 	 * that also have an ADFS boot block at 0xdc0.

-- 
2.40.0

