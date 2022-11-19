Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B150BC4332F
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 02:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiKSCuY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 21:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiKSCuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 21:50:04 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D452F45EFA
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 18:33:44 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 9E02919380F1; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 20/20] mm: document /sys/class/bdi/<bdi>/min_ratio_fine knob
Date:   Fri, 18 Nov 2022 16:52:15 -0800
Message-Id: <20221119005215.3052436-21-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119005215.3052436-1-shr@devkernel.io>
References: <20221119005215.3052436-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This documents the new /sys/class/bdi/<bdi>/max_ratio_fine knob.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 Documentation/ABI/testing/sysfs-class-bdi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-bdi b/Documentation/AB=
I/testing/sysfs-class-bdi
index 34d2e5489c74..b4ed0db680cf 100644
--- a/Documentation/ABI/testing/sysfs-class-bdi
+++ b/Documentation/ABI/testing/sysfs-class-bdi
@@ -44,6 +44,21 @@ Description:
=20
 	(read-write)
=20
+What:		/sys/class/bdi/<bdi>/min_ratio_fine
+Date:		November 2022
+Contact:	Stefan Roesch <shr@devkernel.io>
+Description:
+	Under normal circumstances each device is given a part of the
+	total write-back cache that relates to its current average
+	writeout speed in relation to the other devices.
+
+	The 'min_ratio_fine' parameter allows assigning a minimum reserve
+	of the write-back cache to a particular device. The value is
+    expressed as part of 1 million. For example, this is useful for
+    providing a minimum QoS.
+
+	(read-write)
+
 What:		/sys/class/bdi/<bdi>/max_ratio
 Date:		January 2008
 Contact:	Peter Zijlstra <a.p.zijlstra@chello.nl>
--=20
2.30.2

