Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD66C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022D364EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhBBFjU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:39:20 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43351 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhBBFjT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244358; x=1643780358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ohU0hoBnxnVD7RrmFfsPWCRZPgRPY5M/4trVfv1J0Ug=;
  b=B6g3d4IT/mGkvPH8mWBDPSPAG/ybd7cqIQJRg8L9xCg8jqKoRFlGeC6o
   5THB0dlBYQHvJRjg+2m8l4TlLlksdQ/ef4Porf2ue102b8M+bVUow65s9
   uPNigIO9qQioUqYNcy3wKbrZlZgMfDdXJ6+bMDjFwpBAOjTbuN5pwrE+a
   WfBNymOmo3sfx0dmD6UGM7xH0TFuFyWWftxT4P6tZk2Je7YB3TYM3FWZk
   mhk9G+4jNc95xzgYC9K8Vtm550h8OsVCgJxKYCwB58PVAmTKqDdAXHVnX
   R7AxfIdwSwxj2izSCYLwmegUlNL9K3FLDjrmt9YpEaWEEbIdrr2LvTpAb
   A==;
IronPort-SDR: fXXp81jf8DVpf802unacaP2RAd//Ngw3QkTCVe6titzzPmwFtLQfAftIwd8fDE4Ew8/pBJFmpe
 ZOjTF4QzF31MjSJHAOPpxg+2iCm7fRF0V+l6IYJ7EF7quXZYO9ivtuDHY6HNX1aJgUtF76PF6G
 4uy4voGpIbxjYUNBqfzbbq2ygCtW9CMF2p7jybH9u3WOG/53TAjyze8poba8/krj30PyF+HweE
 fncwPfYFu/lnKu3PVDmuU6xjApwli5qabJUFC0zcF4BiebasAB4Ts2Cxxwff/aKkzctGarSBIJ
 D7o=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163334507"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:38:38 +0800
IronPort-SDR: QTO/kDHmt6U32a4VXvMyqroR47FPSwBgsFj0q2Fms/YHIWOp5gHI6CpJSPmcfhEWZz+J/femdm
 GuWQG5Z9oG1Lpv7WvPP+kb/CyXa/fnAWhMUNu+MpcI1QzIdLBsc6cKHxjxhv2sSSXv8YU10nwH
 rsVygq9h3/MsIt38HNv4/wyTF7gswPZXWr67mWEU3ytW04SGI54/9hPvEnA+YjAkzlikbVUpSF
 JDNY5V8f9a8VUokJWHt0sPUSInsi1JrvgMvxKyREy9BzjQ1basfyNPATpBAGpJYnsl7hEjIcys
 FffBKVjAYA5rn+H2WefgHDmF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:22:47 -0800
IronPort-SDR: YdnTVhZiLQYId5VS+WERx7iRFtIki0Eaxihwdjkj3CJGczfRfjJeHDHGn8OEHZQv4MNj5eUMF4
 9LogNh2kdIXvaEaiPo3tf1JekTUlf7/7Zt/oVvbUcUlKiDuoJ8JKtjM0LHUVQNXLr36oVdu1uM
 ZDxCRi/VPSFEMZp/ftt0rGW8IZE6jI4zaJIRvWt1JPkpJxMm5KGCUB4UwBfZXd5bWMQ2oxzrZO
 Vxi/WAs1tbltfg03TB6ayNk8YQ/jJ64VwA3wEGtMbteVPFYMOfnukjuSgrU3h3dRflUMBbmIaV
 Y24=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:38:38 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 20/20] loop: remove the extra line in declaration
Date:   Mon,  1 Feb 2021 21:35:52 -0800
Message-Id: <20210202053552.4844-21-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The initialization line fits into the one line nicely no need to break
it to the next line.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ef70795e36ab..e691a8c6b04a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2033,8 +2033,7 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 
 static void loop_queue_work(struct kthread_work *work)
 {
-	struct loop_cmd *cmd =
-		container_of(work, struct loop_cmd, work);
+	struct loop_cmd *cmd = container_of(work, struct loop_cmd, work);
 
 	loop_handle_cmd(cmd);
 }
-- 
2.22.1

