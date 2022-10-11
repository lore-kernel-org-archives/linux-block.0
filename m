Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF713C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 01:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJKB0J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJKBZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 21:25:45 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8633BC63
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 18:25:09 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id F21E234BDDD4; Mon, 10 Oct 2022 18:01:05 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com
Subject: [RFC PATCH v1 03/14] mm: document new /sys/class/bdi/<bdi>/strict_limit knob
Date:   Mon, 10 Oct 2022 18:00:33 -0700
Message-Id: <20221011010044.851537-4-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221011010044.851537-1-shr@devkernel.io>
References: <20221011010044.851537-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This documents the new /sys/class/bdi/<bdi>/strict_limit knob.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 Documentation/ABI/testing/sysfs-class-bdi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-bdi b/Documentation/AB=
I/testing/sysfs-class-bdi
index 6d2a2fc189dd..68b5d4018c2f 100644
--- a/Documentation/ABI/testing/sysfs-class-bdi
+++ b/Documentation/ABI/testing/sysfs-class-bdi
@@ -55,6 +55,17 @@ Description:
 	mount that is prone to get stuck, or a FUSE mount which cannot
 	be trusted to play fair.
=20
+	(read-write)
+What:		/sys/class/bdi/<bdi>/strict_limit
+Date:		October 2022
+Contact:	Stefan Roesch <shr@devkernel.io>
+Description:
+	Forces per-BDI checks for the share of given device in the write-back
+	cache even before the global background dirty limit is reached. This
+	is useful in situations where the global limit is much higher than
+	affordable for given relatively slow (or untrusted) device. Turning
+	strictlimit on has no visible effect if max_ratio is equal to 100%.
+
 	(read-write)
 What:		/sys/class/bdi/<bdi>/stable_pages_required
 Date:		January 2008
--=20
2.30.2

