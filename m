Return-Path: <SRS0=CCtz=CH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0686BC433E2
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 09:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD1120791
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 09:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kdrag0n.dev header.i=@kdrag0n.dev header.b="sERlu4vT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m4+iXbAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgH2JO1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Aug 2020 05:14:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55905 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbgH2JOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Aug 2020 05:14:25 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AB40B5C0161;
        Sat, 29 Aug 2020 05:14:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 29 Aug 2020 05:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdrag0n.dev; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=vdgCpwlVAM9JPg+izfOV7VwaHm
        Ozcnhhr5dI10N741Y=; b=sERlu4vTM9W4o+BsA3vsuG7ET1JJmL4YcqnYXfZwai
        T5lA1CimLxQwHg1UqUfh0D8fDJMq7k2MV2NPzNsnEwJ8myFfpxIMGAsIZJxADYYv
        IU1N5kUAMeGl+Yu0WT5wMlxek8XW3gkRYzrWxAXjOrDAZ6oJ7sjWpNOn9V81ELFC
        xOwdGV3oe9oU7i/B6oMepxQueatQfGVBEGpTsk7ZbQXopyNs4xMqqTf7We95PFBG
        8yZ49eMHC2U8yQSQeXJmxZrn0uPvpB3E1EKOhfO/Kh8FVmlZVBBgz4ijKXw41lPJ
        rKO1xmgjOa/qmgNbqE15evoeey3s7wxB2jNqClxC6GcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vdgCpwlVAM9JPg+iz
        fOV7VwaHmOzcnhhr5dI10N741Y=; b=m4+iXbAwXcxgEWvqMT0DZwXLPt8MK/EmM
        pehXHmVk7E86D58Fihgu6dUqhhhQUeYfENcLa+5AHiAa8GG8hMgx7DqK2hlXSL9C
        CBSuiHBCjxM/i4LIgS0LgPEH0iDD4/AZVNAwwJ6MxZu/KtFFYqoY2OIHPSfQ5q35
        2AM6I77K2mVsCiw2yZ0CoCYyzKuZy3SOyfVCNrHx4mNCCwvEq1Igfye3bXFT7UTG
        BFEGT/UmrRkaFyz+sEx5P9qWbwGpedzz1pKsdwKR7/fh6wNjIYzXrUr2bIrZE4gC
        xwGobuj8rMpfTj9b00ZdN6wv8Iz0HN87CetiC0r8rKk+pkRGpG+tQ==
X-ME-Sender: <xms:bxxKX1pPr69mjndIWH6grRgwhsLcAmrTuAOMK10Dhp8QrLycuiKY9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnnhihucfn
    ihhnuceouggrnhhnhieskhgurhgrghdtnhdruggvvheqnecuggftrfgrthhtvghrnhephf
    eihffglefgudefvdduledvfedvfefgieeuueefgeetffdukeeghfevtdeifeetnecukfhp
    pedutdegrddvtddtrdduvdelrddvuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggrnhhnhieskhgurhgrghdtnhdruggvvh
X-ME-Proxy: <xmx:bxxKX3rB3ckTgh6fUNE1CirxBSaxhTK73eRbymscTXp37xsBg1fvIg>
    <xmx:bxxKXyNVF094Vkrwp7dD8pyEArAqgEw8whS0d37Un75OHCby08iY-Q>
    <xmx:bxxKXw4elL48Xrie--ogZiLdSHo0n9DNduvMNVhPpGTJEcaiAcwd5A>
    <xmx:bxxKX5jTPuMH-U2rrQRKpN7RuTEKtiIX-Nc6wYbikXqHHZGYX9nZ7Q>
Received: from pinwheel.localdomain (unknown [104.200.129.212])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5EB653280060;
        Sat, 29 Aug 2020 05:14:21 -0400 (EDT)
From:   Danny Lin <danny@kdrag0n.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danny Lin <danny@kdrag0n.dev>
Subject: [PATCH] blk-wbt: Remove obsolete multiqueue I/O scheduling comment
Date:   Sat, 29 Aug 2020 02:13:53 -0700
Message-Id: <20200829091353.2923361-1-danny@kdrag0n.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This comment was added before the multiqueue I/O scheduler framework
was introduced; multiqueue has support for I/O scheduling now, so this
obsolete comment can be removed.

Signed-off-by: Danny Lin <danny@kdrag0n.dev>
---
 block/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index bbad5e8bbffe..a2297edfdde8 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -161,8 +161,6 @@ config BLK_WBT_MQ
 	depends on BLK_WBT
 	help
 	Enable writeback throttling by default on multiqueue devices.
-	Multiqueue currently doesn't have support for IO scheduling,
-	enabling this option is recommended.
 
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
-- 
2.27.0

