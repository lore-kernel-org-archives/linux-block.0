Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41A1C43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 20:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3192184C
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 20:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zpj69B1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKKUGi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:06:38 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28439 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKUGi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 15:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573502798; x=1605038798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=44eknWJyDEPhKc2xiOjlO9fkpUOHY6ARx+9XVvvmia4=;
  b=Zpj69B1x5hOI6SVFPCDOo2JbeLqsIwnsSqtaosAhC3jwKd6xpVYmV/x8
   Yfhdb/0t2mQH1qK4asDOLkWEhIYxdmHYda2A76EeIMTwj64jthXgUMvah
   PXTYQgUVvSm1ooHZCK9JGT7lNQGXL6FkzsDiOVCy5GjRYdfXiRUTZSBly
   Agy4/p/GxLphJSkEyWdnXLD5RqkPwIDBaSiqGJ9ElQIvoLiUOKAtGXwWv
   4P/nK1p17GXS0jyUxW9cV1j1ybkwwgwTQzsPqyQbHrOfrdwQD1UycR1RF
   r0J0T143mofCekmc2YKvRFcLGIuNQk+Gem5IQBrpW/kceDVLOmiNFtDsQ
   g==;
IronPort-SDR: v1YYr8JpppbLtrj/uKWuUOD42yY/4kiOZZ5/nKxc0hbBdNL5xoAVZvZuBVDt1ClSeTOFDisalw
 mxiNpOHrjrqAz0OF02x324/eXo0CCSFnYCXFz6s4u+y+4TMW62tN4ATKxIS2rhUpaIztPVaWq1
 /5K8GWVPEjAy7HCbHURcsJ7YP8j1hN6a8RAZBK5pIFk4dl4uw58ntJ2Ao5mMYvtquUqibuh5UZ
 FUEU5gJGZE1CMMN0K9vn1oYXQjtBaLb15R50PlDni91ZlIbpxL31+4USsZXnxxZxCYfbhJoq59
 PXE=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; 
   d="scan'208";a="229987721"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 04:06:19 +0800
IronPort-SDR: xZrSfT0uG4bhEWesn748A89y7nhvB1ILuY2rsWzCWlSFrmo1IYR2LSrgTF6g2tSoFMar0UWx56
 4PbmsmO1NzIaSm+AX8pNz7jzm6vmVpASKL/RRsLIeFlmpTBqp0oLtK74zA/dhXybDiyM6dTMS7
 KI24UUFy154fu47MSLkkz9X89FP13zIjSV8Oz6Bwkn94Pj12TLwFfHokOcEtsfQVB0a53sCXXJ
 DeY9/gXk+NaiDKw2YApi6n3vlL3OaLMM1TqwPA9zDaxrbFDitGkGZXkEJGw4hjVy8Hwfz6hlS+
 7uNFP542029QiTWcoHrzG4BU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 12:01:22 -0800
IronPort-SDR: wlDLW//PQwC1HTcgghn00C1M68A7LP53O32yx/HIGQh4M2b/yyBzBN5pTX6zZ+9mdh0aOn1v85
 Dta9WmV83KC9fefyvaBMgNnuPuY7TZbGH6Z2Q04ovtBXiDKah/h72RnYHeYE4Nkwh//nCqzCqJ
 pkuW/SEPx7rCMItdj24vqo9nmT7hMyUxpTmKfYJxzfEHrfSlYrxzT8AF0KKztY0D//9pkh6nAd
 lMCXGjurm5d7aSItsIciIfpe8hncqCZxQJT3MVzhzkBdYA4UYFxGua+nX7e3IzpafLKNb7Xyci
 oro=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Nov 2019 12:06:19 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] io_uring: fix compilation warning
Date:   Mon, 11 Nov 2019 11:02:28 -0800
Message-Id: <1573498948-27573-1-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes following compilation warning :-

fs/io_uring.c: In function ‘io_uring_cancel_files’:
fs/io_uring.c:4280:25: warning: unused variable ‘cancel_req’
[-Wunused-variable]
  struct io_kiocb *req, *cancel_req;
                           ^~~~~~~~~~
Fixes: 93ef402a2272 ("io_uring: don't do flush cancel under inflight_lock")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 283c1ba..55f3dfe 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4277,7 +4277,7 @@ static int io_uring_release(struct inode *inode, struct file *file)
 static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 				  struct files_struct *files)
 {
-	struct io_kiocb *req, *cancel_req;
+	struct io_kiocb *req;
 	DEFINE_WAIT(wait);
 
 	while (!list_empty_careful(&ctx->inflight_list)) {
-- 
1.8.3.1

