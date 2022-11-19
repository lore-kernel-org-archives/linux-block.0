Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CC3C4332F
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 02:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiKSCnh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 21:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiKSCnT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 21:43:19 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F218E0776
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 18:27:43 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 918AE19380EB; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 17/20] mm: document /sys/class/bdi/<bdi>/max_ratio_fine knob
Date:   Fri, 18 Nov 2022 16:52:12 -0800
Message-Id: <20221119005215.3052436-18-shr@devkernel.io>
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
 Documentation/ABI/testing/sysfs-class-bdi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-bdi b/Documentation/AB=
I/testing/sysfs-class-bdi
index bec996e29565..34d2e5489c74 100644
--- a/Documentation/ABI/testing/sysfs-class-bdi
+++ b/Documentation/ABI/testing/sysfs-class-bdi
@@ -57,6 +57,19 @@ Description:
=20
 	(read-write)
=20
+What:		/sys/class/bdi/<bdi>/max_ratio_fine
+Date:		November 2022
+Contact:	Stefan Roesch <shr@devkernel.io>
+Description:
+	Allows limiting a particular device to use not more than the
+	given value of the write-back cache.  The value is given as part
+    of 1 million. This is useful in situations where we want to avoid
+    one device taking all or most of the write-back cache.  For example
+    in case of an NFS mount that is prone to get stuck, or a FUSE mount
+    which cannot be trusted to play fair.
+
+	(read-write)
+
 What:		/sys/class/bdi/<bdi>/min_bytes
 Date:		October 2022
 Contact:	Stefan Roesch <shr@devkernel.io>
--=20
2.30.2

