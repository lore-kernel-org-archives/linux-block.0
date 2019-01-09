Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76714C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3702146F
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hati+OwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfAIBgT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65001 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAIBgT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997779; x=1578533779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAGyZQ7+FNpyiXRbTxcNB1esL7HID4qGdn8aQyoIJoU=;
  b=hati+OwLquiuE18ZXMw8ZlhdAMDXI9r95dak4KiDEYfwQtXA8qWzdWGS
   aAxviFWwfuVljBgyJSLTewilieKYRLrum1QufT4rNOnv0yBchjeizj0uF
   HUcsCVAC3ZYPYbDiLHm6X4jGmfmR79LtGHcg5T093nqPLh8vMqkYgJY3p
   3jMeyOng4x7+9Wp2MpesID/uWt8Q4D3PCaBuyTjmwH3VBbNzew31BrJDC
   gtZJOTYNn/87tBwjy1/MNiDesGt68QTe5PMvwfpRJx1PnRLkJJA1uMI7e
   HmCrBn0Z+vpTU/xgA+G3ysrppk+cmNhzi3o09YhhJOGTt3MiToT4S1QPf
   A==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="203169196"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:36:18 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:16:19 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:36:16 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 06/14] block/018,024: Skip when ZONED is set
Date:   Wed,  9 Jan 2019 10:35:34 +0900
Message-Id: <20190109013542.23686-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109013542.23686-1-damien.lemoal@wdc.com>
References: <20190109013542.23686-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

These tests do not execute a purely sequential write pattern which will
cause I/O failures when ZONED is set and null_blk is created with zoned
mode. Skip the tests in such case.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/018 | 2 +-
 tests/block/024 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/block/018 b/tests/block/018
index 7312723..3c1eca4 100755
--- a/tests/block/018
+++ b/tests/block/018
@@ -11,7 +11,7 @@ DESCRIPTION="do I/O and check iostats times"
 QUICK=1
 
 requires() {
-	_have_null_blk
+	_have_null_blk && _null_blk_not_zoned
 }
 
 init_times() {
diff --git a/tests/block/024 b/tests/block/024
index cf14707..c8dd1f7 100755
--- a/tests/block/024
+++ b/tests/block/024
@@ -13,7 +13,7 @@ DESCRIPTION="do I/O faster than a jiffy and check iostats times"
 QUICK=1
 
 requires() {
-	_have_null_blk
+	_have_null_blk && _null_blk_not_zoned
 }
 
 init_times() {
-- 
2.20.1

