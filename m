Return-Path: <SRS0=imFw=XJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E12AC4CECA
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 21:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E022081B
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 21:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="KHrMpm2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TtKiMPMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfINVax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Sep 2019 17:30:53 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:54773 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbfINVax (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Sep 2019 17:30:53 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Sep 2019 17:30:52 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 152D94C1;
        Sat, 14 Sep 2019 17:24:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 14 Sep 2019 17:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=NjWTZPsB0Na17uJ46vCITbbUDs
        /Halzk/K7hR4bxfec=; b=KHrMpm2uifTwLJm3lXbzdKxZBuB1cxkkbnoDWZEbA7
        IA52V+Ymqc00sI+cHupRQqd0wIzZf993Ii7Lk8nICnArxosS2uBcfeaduylaE3cf
        Rm0C5MH6+tOctkByYRRyUOfcFWBG+PNHHfidl5ebWekttYFf9CWv0YGJQoBt6wia
        K5yR1lIpuGSNY6Tq/MyVDMmnDm336sUtBRrLDDBwZnXMMEJgmnNgH+4eolhlqWoy
        SGKVknlRIkaI9xQivUtw14dc+9oSLt/cjFnBRwApLx8AnJ+Ue5xpY7HlvtX05sH2
        YylgDSFtU2RbTv5/NyZi10s24KcOJGnFCT6VAV0Cif0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NjWTZPsB0Na17uJ46
        vCITbbUDs/Halzk/K7hR4bxfec=; b=TtKiMPMWMHuTpu+uVaFMOkg3mfJawrCEF
        mtCd0mhH5Ib3u0EOIoNtmi+EpUzgfClLd5X9trmJ13L71Cz6HLGh1CAKDFf0aH30
        EXh4Vuxyy1u8y2Usv6cGuT1zcStkDKRKAOFIhDSjx4B+lAYwsPwkG2u3b/qvGsb+
        2VD7ZSLzeASeJ5kh5kLew6z2n2nIJSSW17G0LugtvWxKdpdkUC/cSHDH53oM+R50
        eO0sfRtaW3ZznR3v+j0JHLaI9wx1MD8Qpg5d5XnNFTT3CP1JREAt/6ZO9f9+LD97
        AInIMagaQVljyJDrwz8EbIVton/ds4nZiinSmdVOqZSddNcF/w7Rw==
X-ME-Sender: <xms:fFp9XefRPHaSEnLWYD2JLi9tzxca047ANhZ74EGQ5IQ0sprpDka8MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdelgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucfkphepudeifedruddugedrudeftddrudenucfrrghrrg
    hmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiienucevlhhushhtvghrufhi
    iigvpedt
X-ME-Proxy: <xmx:fFp9XT4gnp3V3wstG8z7FdTzSrPn0a3nnQusMDTPSmvH28lT9CJdsw>
    <xmx:fFp9XXhiIxvz_AqoVqP3S1KIyKqXIIXsKLDAWRwrGDmwXt7IEojO0w>
    <xmx:fFp9XaFM43OcFu4sUmmhVOP8jB8g84bnqdiei15rfmwYeT4oji6y-A>
    <xmx:fFp9XQRPrfrbmLJPJhv5K0kDDWpmg1_DrcS9yziVVV9NAZ7eMLXTSoxslH0>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.130.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 65B4BD6005A;
        Sat, 14 Sep 2019 17:24:06 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     axboe@kernel.dk
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-block@vger.kernel.org, dmm@fb.com
Subject: [PATCH] io_uring: increase IORING_MAX_ENTRIES to 32K
Date:   Sat, 14 Sep 2019 14:23:45 -0700
Message-Id: <20190914212345.23861-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some workloads can require far more than 4K oustanding entries. For
example memcached can have ~300K sockets over ~40 cores. Bumping the max
to 32K seems to work pretty well.

Reported-by: Dan Melnic <dmm@fb.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3c8859d417eb..0dadbdbead0f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -75,7 +75,7 @@
 
 #include "internal.h"
 
-#define IORING_MAX_ENTRIES	4096
+#define IORING_MAX_ENTRIES	32768
 #define IORING_MAX_FIXED_FILES	1024
 
 struct io_uring {
-- 
2.21.0

