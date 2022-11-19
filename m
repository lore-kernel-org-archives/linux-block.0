Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C97C433FE
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 01:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiKSBvv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiKSBv3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:51:29 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FA11EAD1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 17:27:38 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 6FA0819380D8; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 09/20] mm: document /sys/class/bdi/<bdi>/max_bytes knob
Date:   Fri, 18 Nov 2022 16:52:04 -0800
Message-Id: <20221119005215.3052436-10-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119005215.3052436-1-shr@devkernel.io>
References: <20221119005215.3052436-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This documents the new /sys/class/bdi/<bdi>/max_bytes knob.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 Documentation/ABI/testing/sysfs-class-bdi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-bdi b/Documentation/AB=
I/testing/sysfs-class-bdi
index 68b5d4018c2f..580f723de049 100644
--- a/Documentation/ABI/testing/sysfs-class-bdi
+++ b/Documentation/ABI/testing/sysfs-class-bdi
@@ -56,6 +56,20 @@ Description:
 	be trusted to play fair.
=20
 	(read-write)
+
+What:		/sys/class/bdi/<bdi>/max_bytes
+Date:		October 2022
+Contact:	Stefan Roesch <shr@devkernel.io>
+Description:
+	Allows limiting a particular device to use not more than the
+	given 'max_bytes' of the write-back cache.  This is useful in
+	situations where we want to avoid one device taking all or
+	most of the write-back cache.  For example in case of an NFS
+	mount that is prone to get stuck, a FUSE mount which cannot be
+	trusted to play fair, or a nbd device.
+
+	(read-write)
+
 What:		/sys/class/bdi/<bdi>/strict_limit
 Date:		October 2022
 Contact:	Stefan Roesch <shr@devkernel.io>
--=20
2.30.2

