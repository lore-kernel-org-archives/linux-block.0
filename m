Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06E5C7EE29
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 17:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjEYR7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjEYR7F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 13:59:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E261B6
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:59:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae4d1d35e6so12772955ad.0
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685037544; x=1687629544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xh+Sq/uMyLsRA2RTYACG11SUiMBdUyGxyXcentsDWSs=;
        b=nDewzevdtTcZW/Tvxz9qXEWwVsruFiYTgQTHW+iZtEyL+o/CxyuIeqaaGsPgbuaP/u
         5CjPB1dlDLA4eqiRE/F4yTYJiTCIrHO6QLqO7v6cC1TIaFMtKT0gRQ1xlf4BqICtZJIh
         7FKr9Uye6UaczrjrbLFkN4fVzdmUFWfeKJXzcuEMWqgLRwrzUDMCE+4r7XdNUplj/+0t
         EPb237145QDzRlf9LoB5ybdrH7Wh8oKmaYhd9e76CkS3MVDp4/1YmgwDChQjZ2qJGbXn
         XlNRgdv0G0EC5WyMh/pipDRwuY6fIFgAbBHyunGjVunTIonwqf1sCpx44jJ6pCoVZJvV
         9NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685037544; x=1687629544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xh+Sq/uMyLsRA2RTYACG11SUiMBdUyGxyXcentsDWSs=;
        b=UZCUvckCEELvfemtxUHEybzcm/NzmvgnyAgJM2UYlfrXh/LE7e6F+qz/OFI2b88EHg
         53FD+TogmroN5z6W5mcirB7id1xLJAc4uJo64mN0M1LeTXSQne8/KB0YJvsJe+uyb8pY
         KgTcvz4fR/ihbep3SfHhYsPDMlIjCzwVCFBE502Rch/v67M/cVhwArRTf3L80RR0iBS+
         A2cuACbHFPP0t7py9FqIGVRcpR6HLu8II5ToqZtPirwb2oy22/18XKMYkU9wD3QmeYny
         SPa7JIqkj7ANur7iJNV+1NpcdlBDcx+DgADoUYqXo5YDFnt2rWp9hUtK1LSNDTz/Zibv
         GQnw==
X-Gm-Message-State: AC+VfDyDiFGMmL2KwDga4bqdWCh0CYiSqDKysiX+GQ8PNCcsPolZ94XH
        brBab6TVzaI0sxhMhfNoCRM=
X-Google-Smtp-Source: ACHHUZ729FU4RR8vYy5N7+Ip8rYe+diPK0tpc00S2BYla8wjOuruHnFPIF2tOfxPaaIBu4QGoY+0jQ==
X-Received: by 2002:a17:902:f693:b0:1a9:6dfb:4b09 with SMTP id l19-20020a170902f69300b001a96dfb4b09mr2745747plg.67.1685037543397;
        Thu, 25 May 2023 10:59:03 -0700 (PDT)
Received: from Osmten.. ([103.84.150.78])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b001af98dcf958sm1686359plx.288.2023.05.25.10.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 10:59:03 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] pktcdvd.c: Drop error checking for debugfs_create_dir
Date:   Thu, 25 May 2023 22:58:36 +0500
Message-Id: <20230525175836.19058-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch remove the error checking in pktcdvd.c.
The DebugFS kernel API is developed in
a way that the caller can safely ignore the errors that
occur during the creation of DebugFS nodes.

The comment above debugfs_create_dir includes the following text.

 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dentry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/block/pktcdvd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index d5d7884cedd4..37cdd68c3de5 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -451,8 +451,6 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pkt_debugfs_root)
 		return;
 	pd->dfs_d_root = debugfs_create_dir(pd->name, pkt_debugfs_root);
-	if (!pd->dfs_d_root)
-		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444,
 					     pd->dfs_d_root, pd, &debug_fops);
-- 
2.34.1

