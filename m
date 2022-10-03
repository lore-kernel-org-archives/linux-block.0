Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6509DC433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 20:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJCU23 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 16:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJCU23 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 16:28:29 -0400
X-Greylist: delayed 153 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Oct 2022 13:28:27 PDT
Received: from resqmta-h1p-028588.sys.comcast.net (resqmta-h1p-028588.sys.comcast.net [IPv6:2001:558:fd02:2446::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59B928E03
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 13:28:27 -0700 (PDT)
Received: from resomta-h1p-027913.sys.comcast.net ([96.102.179.200])
        by resqmta-h1p-028588.sys.comcast.net with ESMTP
        id fJh3oJu9seTLRfS0foDjHp; Mon, 03 Oct 2022 20:25:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1664828753;
        bh=sSK/2hKHyH3SFlM85+1nh0ZaqIwSaRS3+OpWNmPHmsI=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
        b=iMsuAAwrs5l4nIWtB3dk0nHnr/RW3wgvrAhSQrzVnWSlFZ+YfWi2exjYzTUrD6na9
         3DOp10gJTycAh2uvNFVtzSgNlLyo3JI2M7zWTf6l0QmbKuamf1KlxfnBLCoE8HeJoK
         03ew10FLuhqz5rczKfL+IjWKQLfvfbSyX+nesNANPMOUEvNCyFEi4ayG61SHNZTpXP
         3F4JNSfVba5D1vZeR+7AVPsI74385UtLE9GwmyaWO2fZKjRBga2Fg5URxjYU/jg2L3
         rBo5AxPGhiAE8myEhx6DsvW9cZkctq7qSmV6c3dZ2Asvy0mPoZ6Mid+Gk+BLdKDvy4
         jClG0/LWgA8LA==
Received: from DESKTOP-2K9CI8E.localdomain ([71.205.181.50])
        by resomta-h1p-027913.sys.comcast.net with ESMTPA
        id fS00oXCiSvH2AfS0HoqRcg; Mon, 03 Oct 2022 20:25:30 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehledgudegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevohhmtggrshhtqdftvghsihdpqfgfvfdppffquffrtefokffrnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedvtdejiefgueelteevudevhfdvjedvhfdtgfehjeeitdevueektdegtedttdehvdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopeffgffumffvqffrqddvmfelvefkkefgrdhlohgtrghlughomhgrihhnpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=0.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH] MAINTAINERS: Update SED-Opal Maintainers
Date:   Mon,  3 Oct 2022 14:25:11 -0600
Message-Id: <20221003202511.5124-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add my new email address and remove Revanth

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f9be379f5..5aad8c528 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18316,8 +18316,7 @@ S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-imx.c
 
 SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
-M:	Jonathan Derrick <jonathan.derrick@intel.com>
-M:	Revanth Rajashekar <revanth.rajashekar@intel.com>
+M:	Jonathan Derrick <jonathan.derrick@linux.dev>
 L:	linux-block@vger.kernel.org
 S:	Supported
 F:	block/opal_proto.h
-- 
2.25.1

