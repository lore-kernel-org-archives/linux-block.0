Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8E9C433F5
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 09:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9B960F45
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 09:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhKLJk5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbhKLJk4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 04:40:56 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB85C061766;
        Fri, 12 Nov 2021 01:38:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v11so35349848edc.9;
        Fri, 12 Nov 2021 01:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQTrXaTc/lNdG2njTmpBunO4PJ13P2OY2tx73UH6CuU=;
        b=UuPQDmaDEsA8PwyeTSw9cpcEoCcpZvH3lk+fjcDXoPBJ+/ZAFaBw2otYEVHb362ufH
         F2LzjEVO6nkcmACl3nWJZ/sJ8s50vKy5nuO2JWZN033YzeQNfWq8Xmc3MRiGMcql8mt4
         Ce/iL3jaZm7r8X5puEADTcVg3ncGREI+8SpzWFJZ3sBi/VQ7uNaakWLVNIalYDg5YYrD
         5RmVFwSoZBupqp1ANqYDx+hIczdItoX4s7R/c0OjqFdCZ3ixtKdzeGDwt8U47yprEsbc
         TtT2JKVUA4GgH1Q4xfPNlTCUSKNsSVy3yqQtfg1scMIDVkS2PJL4HFn0lVb7PTqTHI5j
         6lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQTrXaTc/lNdG2njTmpBunO4PJ13P2OY2tx73UH6CuU=;
        b=OrErs9ZjZxIHrk44ElHeC6JPpfl1W+J5mhriHOihvbXAbT/+6QDtpB5RJrTmw73jb4
         KJnlsBit2UN6qGYAwbyOfx09zjjnSdq2mh03xAaOLcq0Nr5y4fSO90HN5+ZfxA5ZbPTM
         GLTt1Uq1F5seJT6lL0Ba61fUP9IXEU1fmF6yfxR5GKkaspP0DvVUVV7Hrr3jcNTUlTsN
         l/eEEmbwJu3+mmhtEoMRn9ERKvYi0UvkSlIgjaGm9xbaUq0YymBGknmwZrZEHX++S4gE
         0Dl+NluDXCOzDS5ozigA3gORQdp4VyRHlgPqrRhSQeF0v0gcKej7E+5K/FaTCKtyu2SJ
         gxpA==
X-Gm-Message-State: AOAM530DlzN4sByRcy/JklQ5VDj0VHSIkMf7/TVdh/iihfI7k/tIk8/C
        MWSKf6LYzjMW93aYNu6VVHI=
X-Google-Smtp-Source: ABdhPJxmYjAv5I/zFbX5GzObOpTS0ULNPZBHNhapqmiB8HEktW7Acxn3OkriYXH/E3fVEGgGZEFKwQ==
X-Received: by 2002:a50:9b06:: with SMTP id o6mr19004140edi.284.1636709884459;
        Fri, 12 Nov 2021 01:38:04 -0800 (PST)
Received: from localhost.localdomain (i5C74E2C0.versanet.de. [92.116.226.192])
        by smtp.gmail.com with ESMTPSA id jz4sm1699852ejc.19.2021.11.12.01.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 01:38:03 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] blk-iocost: drop selecting undefined BLK_RQ_IO_DATA_LEN
Date:   Fri, 12 Nov 2021 10:37:28 +0100
Message-Id: <20211112093728.3237-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit cd006509b0a9 ("blk-iocost: account for IO size when testing
latencies") selects the non-existing config BLK_RQ_IO_DATA_LEN in
config BLK_CGROUP_IOCOST.

Hence, ./scripts/checkkconfigsymbols.py warns:

  BLK_RQ_IO_DATA_LEN
  Referencing files: block/Kconfig

Probably, this select is just some unintended left-over from an earlier
draft version; BLK_RQ_IO_DATA_LEN was never defined in any commit in the
repository. So, drop this dead select to an undefined config.

Fixes: cd006509b0a9 ("blk-iocost: account for IO size when testing latencies")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index c6ce41a5e5b2..486bc6003b9e 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -133,7 +133,6 @@ config BLK_CGROUP_FC_APPID
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP
-	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	help
 	Enabling this option enables the .weight interface for cost
-- 
2.26.2

