Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5308FC31E51
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABEA20665
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NMgKkrJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfFRHEM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:04:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7918 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfFRHEM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 03:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560841452; x=1592377452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bI9j3kj4foQo5nMw5CIMB0dDQiCRAJjycv2LnOj6d8M=;
  b=NMgKkrJOXXI/rSDOdk5JVvEotSjwYZ8Hnr7/wYFqoCw800/faQmAeh7p
   8MK4C/dC8yTNjZOI63Bj1KEHjW4cK658KiSO5Aed/Swwb28/6UnosB5Rl
   73Gbnq3+eHL48DpMPyQfNVxVvSbrvY6KkTNrGEGKIZZjig/5sH3OJpwwv
   6E305mxSYQWL67538Hj1hKpYz+TBWiRQi7LtqEzBXV4mH9bUFbh0tC0Mj
   z/bSVHvYhThay1/h9UXSyVQ7z44Lw9+htI7LYc4QWgd9QswTW3hn5kKZN
   vXs9R9/dQzOhN2pUF2FMpLppsk3Qz44+4mQ42HLJILaYiqkHHAXcCF4of
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="115733440"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 13:42:53 +0800
IronPort-SDR: cJKFoeMN78Rif7bRHc1cJbQZqQ5ea1ItFb42/5YHlSn8Fg2NovEBM9FnQtJwEhnZH8SEkKGAFc
 odAuVqCNbZ/C6r1kkoIErkvztzLXAKieSfV8VLTs8Lb5mUU7Ququ4SGd5rg1xHy7gSbOv/ZfL0
 MyHYlXUKttzv3c8EpZaarW6C0nR6SqcncyrMDxLQw2oMVfh3byRSG8ivZ3Pa53qeML0hrofwLI
 lOIAmrAYF+rIGbdzQYTnuSHVPb5lzE2ZvkI5GaBa1EYwr9tgafGIMOCOhyhcHplw+/8CdYbJNK
 o/+ees8qKqvrlkNwzKSpLYay
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 22:42:23 -0700
IronPort-SDR: rWvteRosPGCcznMiZ2GtvMH9li4CAROY9IkXL4Cao6MQymnzw/JhttG6av3P0dKBcvUMk2Ogsx
 J05lwzmGRHY/ptyn3sleRydvvLEsTFToXWHYtiZj/2MxPxoFE7/dBCpB+/GgnjmWWkD7sdBmBr
 M3ck1JRnfHsJC5JYj6Y1UVeBT+DbZYklgDgf/XCCJrH+nFxUeFjbYBEYft0JMqNo3ByAT+2XSm
 BlqesJ9ZjdJURu+2yO+HUAKuqkq3G2fhHEVpugDmVkl+4suSLuWGrcMF3LBP7+YasENkKp0+65
 nao=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 22:42:53 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 6/6] f2fs: get rid of duplicate code for in tracing
Date:   Mon, 17 Jun 2019 22:42:24 -0700
Message-Id: <20190618054224.25985-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we have used the blk_op_str(), get rid of show_bio_type() and
show_bio_op() to eliminate the duplicate code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/f2fs.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index ec4dba5a4c30..a8e4fe053e7c 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -73,20 +73,6 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
 			REQ_PREFLUSH | REQ_FUA)
 #define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
 
-#define show_bio_type(op,op_flags)	show_bio_op(op),		\
-						show_bio_op_flags(op_flags)
-
-#define show_bio_op(op)							\
-	__print_symbolic(op,						\
-		{ REQ_OP_READ,			"READ" },		\
-		{ REQ_OP_WRITE,			"WRITE" },		\
-		{ REQ_OP_FLUSH,			"FLUSH" },		\
-		{ REQ_OP_DISCARD,		"DISCARD" },		\
-		{ REQ_OP_SECURE_ERASE,		"SECURE_ERASE" },	\
-		{ REQ_OP_ZONE_RESET,		"ZONE_RESET" },		\
-		{ REQ_OP_WRITE_SAME,		"WRITE_SAME" },		\
-		{ REQ_OP_WRITE_ZEROES,		"WRITE_ZEROES" })
-
 #define show_bio_op_flags(flags)					\
 	__print_flags(F2FS_BIO_FLAG_MASK(flags), "|",			\
 		{ REQ_RAHEAD,		"R" },				\
-- 
2.19.1

