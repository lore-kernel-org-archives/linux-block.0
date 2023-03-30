Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E229DC761A6
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 16:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjC3QGV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC3QGV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 12:06:21 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B1C8A7D
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 09:06:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 94D2E5C0108;
        Thu, 30 Mar 2023 12:06:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 30 Mar 2023 12:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680192374; x=
        1680278774; bh=tHVvif+eDNbxZtxI4lTshboTBvlPW2+WdyLrYJKtS0E=; b=e
        uAJijcyeCJYH7oSvP00azksf/WOm/cs7V7izcecTRjX51eioGDUzRxzXUHr8UDPV
        bYGnmdkgoXTIPNAFF3iaOJDxS0t6NyMsr/xFPCCbaqDWuQqLuFUlxDooaZ2d2gIU
        9aI/76uLauujfoBiTXZmtx9ue9QDbxsbYHCcXkMvYFlvZt7W2aESOsaCRQm0dgJX
        OJgjJQh9U+vRIHmO0l4crwoBQBgLIZncRml1/VBWjAQ1C79/HUkutHNJWlYLo56T
        owlwr+g7P9rXrUcyCYIlPAO/CDGE09QdbWCSvLmEiZNz/n3fh9M1PvxTTM027doK
        tDJlZZorfCHxb2a7cERxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1680192374; x=
        1680278774; bh=tHVvif+eDNbxZtxI4lTshboTBvlPW2+WdyLrYJKtS0E=; b=R
        nC4IH239Yz8OfdxFrnlHnsdYk7iJSK7TamGDK5O9IBp7s+QV3IGUv+sBTsRa4PA2
        pDezv6nx7PM1EvvPtYza9nReHn+APikqpYszzdPhwUV5hFvqzVGAujBdkFPTWxQf
        fEQDmRC1Q/TPU5hd//h1OXG6W9DWT+6G67pBdAenG4OxD3y9LH7jEjfA2oAR4Uz/
        68sdF+bWAAHAuK3hM4wA+F3Dfipd0kyB5+8HvPdyCbeYoy9TxyXC5OLmTFhFuXVG
        aDicq19MTpDYYmk/eY9Sm2vjImQ2a5vpRMYjfqYvPj9JxeabIFFzE+18YrgQQ/hC
        QRApU0RIfuMM5UcGBDbvQ==
X-ME-Sender: <xms:dbMlZBRCkyK2jjfEXN-ayRHT8oesiWq67cHU2s2HPWOWJZBulThqcg>
    <xme:dbMlZKw2d5DWgimCFjG_F99QUqKLTxmGAuZS_3RCpJpM_FMTmo3wz8HAFoYsJcELi
    8gJOw27Rtkgm83mGw>
X-ME-Received: <xmr:dbMlZG0n0SNqwvHdDSUOWNkvdBfdjo5VpIWTdjD18AKI0a5cksws_8j0H4qCZpHE-PHOF25hVKeJbSDoC5zlm_zf_CJ9yYgfHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlhihs
    shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepve
    ejtefftdelgeffvefhheefkeefueevjefgjedvteeljeefkedvtefftdevudeunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:dbMlZJAj2UzUjGCBFTn1b8q6pIIm1bpmKeieGM3VGqpYl2LQ1PRn0A>
    <xmx:dbMlZKhIa7MG9BEDhY1rjyZ5eg6F5ALgtExR_H45huGg79bkgNWUvw>
    <xmx:dbMlZNp7u_Mkuoa-IH3-flKgx7XsH73wUutpFtgpjfIz0MXSYIrGEg>
    <xmx:drMlZLvCQQ_lvHC95LATRvEHgwvmOciWvQmYc65NyTf4AjRbAplPFw>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 12:06:13 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 5008023F7; Thu, 30 Mar 2023 16:06:10 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     chaitanyak@nvidia.com,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     axboe@kernel.dk, hch@lst.de, hi@alyssa.is,
        linux-block@vger.kernel.org
Subject: [PATCH blktests] loop/009: add test for loop partition uvents
Date:   Thu, 30 Mar 2023 16:02:47 +0000
Message-Id: <20230330160247.16030-1-hi@alyssa.is>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <21c2861f-9b7d-636e-74e1-27bd7bbb1a4f@nvidia.com>
References: <21c2861f-9b7d-636e-74e1-27bd7bbb1a4f@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Link: https://lore.kernel.org/r/20230320125430.55367-1-hch@lst.de/
Suggested-by: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 tests/loop/009     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/loop/009.out |  3 +++
 2 files changed, 65 insertions(+)
 create mode 100755 tests/loop/009
 create mode 100644 tests/loop/009.out

diff --git a/tests/loop/009 b/tests/loop/009
new file mode 100755
index 0000000..dfa9de3
--- /dev/null
+++ b/tests/loop/009
@@ -0,0 +1,62 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright 2023 Alyssa Ross
+#
+# Regression test for patch "loop: LOOP_CONFIGURE: send uevents for partitions".
+
+. tests/loop/rc
+
+DESCRIPTION="check that LOOP_CONFIGURE sends uevents for partitions"
+
+QUICK=1
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	# Make a disk image with a partition.
+	truncate -s 3MiB "$TMPDIR/img"
+	sfdisk "$TMPDIR/img" >"$FULL" <<EOF
+label: gpt
+size=1MiB
+EOF
+
+	mkfifo "$TMPDIR/mon"
+	timeout 5 udevadm monitor -ks block/partition >"$TMPDIR/mon" &
+
+	# Open the fifo for reading, and wait for udevadm monitor to start.
+	exec 3< "$TMPDIR/mon"
+	read -r _ <&3
+	read -r _ <&3
+	read -r _ <&3
+
+	dev="$(losetup -f)"
+
+	# The default udev behavior is to watch loop devices, which means that
+	# udevd will explicitly prompt the kernel to rescan the partitions with
+	# ioctl(BLKRRPART).  We want to make sure we're getting uevents from
+	# ioctl(LOOP_CONFIGURE), so disable this udev behavior for our device to
+	# avoid false positives.
+	echo "ACTION!=\"remove\", KERNEL==\"${dev#/dev/}\", OPTIONS+=\"nowatch\"" \
+		>/run/udev/rules.d/99-blktests-$$.rules
+	udevadm control -R
+
+	# Open and close the loop device for writing, to trigger the inotify
+	# event udevd had already started listening for.
+	: > "$dev"
+
+	# Wait for udev to have processed the inotify event.
+	udevadm control --ping
+
+	losetup -P "$dev" "$TMPDIR/img"
+
+	# Wait for at most 1 add event so we don't need to wait for timeout if
+	# we get what we're looking for.
+	<&3 grep -m 1 '^KERNEL\[.*\] add' |
+		sed -e 's/\[.*\]//' -e 's/loop[0-9]\+/loop_/g'
+
+	rm /run/udev/rules.d/99-blktests-$$.rules
+	udevadm control -R
+	losetup -d "$dev"
+
+	echo "Test complete"
+}
diff --git a/tests/loop/009.out b/tests/loop/009.out
new file mode 100644
index 0000000..658dcff
--- /dev/null
+++ b/tests/loop/009.out
@@ -0,0 +1,3 @@
+Running loop/009
+KERNEL add      /devices/virtual/block/loop_/loop_p1 (block)
+Test complete
-- 
2.37.1

