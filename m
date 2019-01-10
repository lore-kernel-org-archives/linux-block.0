Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B6C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3489214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="opR81Uva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfAJJiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:38:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25557 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfAJJiE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113086; x=1578649086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NWBGjS2c3O5GeVg7/WntRTuwCdCNJ7t0rStpgraWiQE=;
  b=opR81UvaS+oqpVLZ3r1EtcoszYrtIg45pxBiPWPtLWCnXi/N25vpbw+K
   8yjY2oCIh1HOYgOQ41utM9USIfTZWamYmNDMZKo16o7vMAd/RjuUrbGL+
   RdIL1g5e4HQSGz6CEoKviIbyST4PoBqWp5dtOJTVYoMsNJnHABRoNVNib
   MQkohR2wGbzRLz4uA8Vv90PML949lPp15752lMHU4WBGHp/Y+8hVlpNEA
   MxcON3hzS900VsnIYnGkMNR1/QuH1Rl8K1cdUhNpnu0A6/+PA1f4c9o3U
   YVmt7pvDJew5o8V7puyO/8oG0TpPluBg7FckHeeYnN2AHc/U2gK6TnRNC
   w==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="196468984"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:44 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:19:30 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:37:56 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v2 07/16] block/018,024: Skip when ZONED is set
Date:   Thu, 10 Jan 2019 18:37:16 +0900
Message-Id: <20190110093725.32675-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

