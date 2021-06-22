Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D259C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F1060FE3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFVXXh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:23:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20476 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVXXh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624404079; x=1655940079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t40odd6V29S8avxaZzWGWVtQNrj5GX4pB2nkwFs3pO0=;
  b=bjNedOadCeysWvMhyflWtos8k6YHbNqfGfdRVkusXbUVi08RV0i/FzkH
   2/VVqZjKMGL7jehRHTvc7iJUAaDsJkf36Pclxn0ZGOEZ4t3TYs0bF9qjD
   Ty+K3WnbM8HWfn9AlAepTzkKhUn/w2ILkenDBnEZz/N2Dz1t/x1pjkIfd
   8IOx7jsjX5g1zXC7uSgsf/u1n7V5zSwrMkGzsVDXU1VvHMjMZCJ2tEq5N
   NvOgy01ceov/D6b1gJuzmp4O8USfFsQzGgWSkr+0Narzy2QWCfSiibEOj
   0uYVEVohpy3TX3iaRVKr+nqU4/NDLctPf1+pMVACmo1qkxy4oOWv19jO9
   g==;
IronPort-SDR: AxjsT1zto02Hy4VP6t6jlv0WBEngKofQi5Gm+BV+RHqYPpBIZGYvherCi2ocX5Bfl8QlHfrW3b
 UIcyRMtOThVLQu2p4/NAlofRQy82ucyhSiwRckqvvOMtaFzHybNaNgR5xKB1D6qGF92d6fSEMx
 yywt8Be+uE/SHkhZ5Nstp4+lvv21g4qZNUxa1o3nZn1huVtklj2cl/KD/xh3hzoiynZBVTF+He
 0m0YedWbsdIHYAbJXwlWZ9JgyOITmBCYmSJiVALlfEhI6IF52cWXwGf7crNhKOtrEWOMj0MoJc
 V+w=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="172632971"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 07:21:19 +0800
IronPort-SDR: 2ctxYcyFL7dVmNeviOvsz/NRVr6VTi2VuwZi0nfqbP4R4Qx4HofeVmefkk6DjfLHKqbD8veuBB
 dhLuPLWX4OEGqDRL08jKYFr+zLRJNC7NmKrLscOxL+6apOinFzGdoz/pTmLlVqbXr6xbPLkY6p
 pdRMREyUqcdLS8MRvBvbqEDjf45nl2EjAQCbzEb1x48CO9q0OWVaZBngbop0b2JsSrpym0r6WE
 9U3sHSjzoTmwnjlDePxeeW9HFOrqytJCnzHSD5lOv/cyVnDYRhBM3mAYiShYT5KfsBp5wlkGM2
 uZ5Hnc9eYfPLnIeeyl3+HMop
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:59:58 -0700
IronPort-SDR: wJJnZtwQ3HsIGWjGJnOHsfRmx4e9YL2+EjKIAN1T4KyZnwQOFOkpe0GrUDE9gX1v8AVeqmy5nr
 0UESd9f/1BglmOugZO3bPX6F1/CXcmMV5wL3UoTYR64c0TscL7l8YCvWSkeZ2K6wGv+ihJvvv/
 pBTPQXsuHWZMAdwQidOkplhCzmT/56wDAc7osiG8H/5ldHC5fRZrVEyKZKFUhg7GgP/yWfo3QE
 E2Q/iZuFB0WSXjZmG25HBbBkraYmz//nNtjqD1vSDbNPRXq4D8m/0cyy1M6dHHoHWpjyEj3u2s
 k2E=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2021 16:21:21 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 8/9] loop: remove the extra line in declaration
Date:   Tue, 22 Jun 2021 16:19:50 -0700
Message-Id: <20210622231952.5625-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
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
index 58b315342af2..6fc3cfa87598 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2046,8 +2046,7 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 
 static void loop_queue_work(struct kthread_work *work)
 {
-	struct loop_cmd *cmd =
-		container_of(work, struct loop_cmd, work);
+	struct loop_cmd *cmd = container_of(work, struct loop_cmd, work);
 
 	loop_handle_cmd(cmd);
 }
-- 
2.22.1

