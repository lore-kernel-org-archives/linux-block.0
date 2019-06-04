Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD5C282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 07:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B669624AEC
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 07:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VrBCTpgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFDHXn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:23:43 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61929 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFDHXm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 03:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559633025; x=1591169025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fg+CIfq0i4Z8T9OFilsi880qv/qqeVv7+jIGZTgYjvs=;
  b=VrBCTpgEscRW4usYhqaQGTNRKQBjvMHScKV2aX6X8USGtHEQUIUN1BI1
   mYiSZ/cJJF7uBiKMSmYkHBYoFia0R6GYj58DzklLpiwikB9PHYixbwDt+
   HJEg6+9tvv9d4IYgUlI2i+cz0BhOEGtMwlaYJpeVjQ6XOagVKtgz7KjZ1
   ulZFLnanE/A5BgZLrJT4e4118gjFGN4dcNFv0yacIE2QNqDNWV1nzdbin
   6pCeAH8OhhDpZD+736BbsI7I/nD5gyNIehKr7dQTMn9i27zU4xxhIlbYr
   5+qT9Hh/qJeTo+xW1Vgbc3fOorXc//QV9I2c5CWZEBais6+W0kC9c8o1V
   A==;
X-IronPort-AV: E=Sophos;i="5.60,549,1549900800"; 
   d="scan'208";a="209341295"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2019 15:23:45 +0800
IronPort-SDR: 2atXjGWpA1eUP9mp5+m5TX2xp5t2JXQo74qwTsow2ovmk2Zo2evvw6QsvGoX17n17coPuLguue
 IAx7yyDvXuPT7GGAJVaTUxnsuGqmJqbu3zcDLmpYQ3lBNJDv/puvbMdwDe/u6iU4MRLBpjwnby
 REe2hgDXQZ6XoGlEnVFtowcWd7QmljUqPo6U0WkbjrryQfOFxKAtYhhpmm1BD/aesdTwDXpF8R
 WmocfXPQjf4SWnza/sKEVSXqNsH2jm1R7KqwzzPnMD15u+JfKV3U+YhU98Pm71qjXm4lHYVeLS
 JC24EN+gPE/uJMGpHD/veltS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 04 Jun 2019 00:01:05 -0700
IronPort-SDR: lAMa/DEaLk9hleZFNi3h8f8kQ/yXBsiYQbozLsCRXwGgBrpxcXF0eLHtPDZvaQDEYhznFdct7J
 QXeWi0H6lOyYJS/CJfRy3G86JhFeW1uHOMS4BZqEtj2TvEQnh1MT64/JdsvbRRd2kTB2snnfIY
 Y3yB8o1+dKVBKg1Qy2F9hFWVjdJR+NYsq8JwITuOgZgp88qyHBg9T0+WIKlq4kKbCa6YpcaV9D
 myFmvU69F27BoG860vdo2nP8N0Sp6wG93eAA1T3cr8wVjbbOuor9Sg35KC01kcabPU3iYA4q0u
 B/g=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Jun 2019 00:23:42 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Matias Bjorling <matias.bjorling@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] block: force select mq-deadline for zoned block devices
Date:   Tue,  4 Jun 2019 16:23:40 +0900
Message-Id: <20190604072340.12224-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In most use cases of zoned block devices (aka SMR disks), the
mq-deadline scheduler is mandatory as it implements sequential write
command processing guarantees with zone write locking. So make sure that
this scheduler is always enabled if CONFIG_BLK_DEV_ZONED is selected.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/Kconfig b/block/Kconfig
index 1b220101a9cb..2466dcc3ef1d 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -73,6 +73,7 @@ config BLK_DEV_INTEGRITY
 
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
+	select MQ_IOSCHED_DEADLINE
 	---help---
 	Block layer zoned block device support. This option enables
 	support for ZAC/ZBC host-managed and host-aware zoned block devices.
-- 
2.21.0

