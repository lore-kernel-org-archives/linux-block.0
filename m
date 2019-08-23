Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A05BC3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 23:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE2121726
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 23:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=manuel-bentele.de header.i=@manuel-bentele.de header.b="snLw+KTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfHWXBr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:01:47 -0400
Received: from host1.nc.manuel-bentele.de ([92.60.37.180]:55820 "EHLO
        host1.nc.manuel-bentele.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbfHWXBr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 19:01:47 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: development@manuel-bentele.de)
        by host1.nc.manuel-bentele.de (Postcow) with ESMTPSA id 6D47A641F5;
        Sat, 24 Aug 2019 00:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manuel-bentele.de;
        s=dkim; t=1566600981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXLbQgjGWhzcWqU3zQqfArsgI0EbAZYxCwHXS4sPZVM=;
        b=snLw+KTgelGP6K+PwXLx1iMZrfaLe7rr6rE6ISwvKGiR+Fxi1117rffMMIyRRA7GSmi5OJ
        HIH4mkv9iHnutxvjRFryOEXXL6tLIwPr70jsPrsqRHXNEMRpKSpt6apcuc6+EY8h1T5y3w
        GlJ9IJJimJ+1XhtJDnA/hHvmRKognOcJz0a1by0gxHteUuO2ys2LnW76HwUAnaNTXr6IRD
        FcJpaTmhqPVVR+ptWestHwEMYZgTxDJDSzLpvYWauDZzJQwBg4yb1uVgsqLB3TF8inoLZt
        elTX5Guto5YfQ3XnVqN4+QPtHamhynsCUEmD2oImgAAC5zowoYut0fh9Gkt/qg==
From:   development@manuel-bentele.de
To:     linux-block@vger.kernel.org
Cc:     Manuel Bentele <development@manuel-bentele.de>
Subject: [PATCH 3/5] doc: driver-api: add loop file format subsystem API documentation
Date:   Sat, 24 Aug 2019 00:56:17 +0200
Message-Id: <20190823225619.15530-4-development@manuel-bentele.de>
In-Reply-To: <20190823225619.15530-1-development@manuel-bentele.de>
References: <20190823225619.15530-1-development@manuel-bentele.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manuel-bentele.de; s=dkim; t=1566600981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXLbQgjGWhzcWqU3zQqfArsgI0EbAZYxCwHXS4sPZVM=;
        b=NGzEcMqVUTN/0cu1ffMRn/KUTkLaPBxwkfFhEMfU36VIaRxXs4fXEmxSFBGHWebUmiBb+Z
        CdA1dnrF1LssKLWlKTPFxtT4XUGKC9BqicKfhG1MXMCaCriRDV/kcifiUbg9QnlkYvnon5
        H3KdDeUtGA+h9e3y+N7EZtvrO+swow4EgcvvZ/kyowYsrrAB4jTloJW3JspRV+cViEgrM8
        8FXI0iI4pqb6Wvz1yUXVrqd29fOqcyQfELXwvR+x1s0CvNnmM23C4NyMlH7IMSu2IbXGVU
        moWnrV9jA/tr4duibkFIveARtb/zoOptKE/b4whYqLi0CB8BQVHeufBjTXgByQ==
ARC-Seal: i=1; s=dkim; d=manuel-bentele.de; t=1566600981; a=rsa-sha256;
        cv=none;
        b=rMSJbbZrC0YPYX9pAg6z/tXLd7zxD6xWy1tqjn3m7krogQ1QpekvYG0bJOCj3iOVsWI2xw
        jAI6g68ONSvnwjexHT+mUGZx3D7qliCgvzdNkRUp2RCMr3EDnuNsuNcn/aFPvu8DCrvPrs
        ePp0a+82NxbhoEdq28Ei5g/oi3H+qFH9hL9qZ37KmcA4gv5718CIQbU0b/EzJaoLFBtEqp
        2NO6Gkb8GkKYjBrLwLRK5z5YEMJLN9BqPS2dd/rT/xcHQ/Wc7cgCNBPhsgKGsWw+sDeqXQ
        FVxDENIdHt+LaA6y3JXU9fZww+YN0E7IRPQM3WWMUZ0WVMrLHv6PGrEkRrSUbA==
ARC-Authentication-Results: i=1;
        host1.nc.manuel-bentele.de;
        auth=pass smtp.auth=development@manuel-bentele.de smtp.mailfrom=development@manuel-bentele.de
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Manuel Bentele <development@manuel-bentele.de>

The entire API of the file format subsystem for loop devices is documented
in the reST kernel documentation format. The documentation deals with the
description of the internal API of the file format subsystem to access its
functionality and adds a section on how to write own loop file format
drivers using the driver API of the subsystem.

Signed-off-by: Manuel Bentele <development@manuel-bentele.de>
---
 Documentation/driver-api/index.rst         |   1 +
 Documentation/driver-api/loop-file-fmt.rst | 137 +++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/driver-api/loop-file-fmt.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 38e638abe3eb..88736bd668f3 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -51,6 +51,7 @@ available subsections can be seen below.
    mmc/index
    nvdimm/index
    w1
+   loop-file-fmt
    rapidio/index
    s390-drivers
    vme
diff --git a/Documentation/driver-api/loop-file-fmt.rst b/Documentation/driver-api/loop-file-fmt.rst
new file mode 100644
index 000000000000..1f47b19bdef0
--- /dev/null
+++ b/Documentation/driver-api/loop-file-fmt.rst
@@ -0,0 +1,137 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
+Loopback block device file format subsystem
+===========================================
+
+This document outlines the file format subsystem used in the loopback block
+device module. This subsystem deals with the abstraction of direct file access
+to allow the implementation of various disk file formats. The subsystem can
+handle ...
+
+   - read
+   - write
+   - discard
+   - flush
+   - sector size
+
+... operations of a loop device.
+
+Therefore, the subsystem provides an internal API for the loop device module to
+access its functionality and exports a file format driver API to implement any
+file format driver for loop devices.
+
+
+Use the file format subsystem
+=============================
+
+At the moment, the file format subsystem is only intended to be used from the
+loopback device module to provide a specific file format implementation per
+configured loop device. Therefore, the loop device module can use the following
+internal file format API functions to set up loop file formats and access the
+file format subsystem.
+
+
+Internal subsystem API
+----------------------
+
+.. kernel-doc:: drivers/block/loop/loop_file_fmt.h
+   :functions: loop_file_fmt_alloc loop_file_fmt_free \
+               loop_file_fmt_set_lo loop_file_fmt_get_lo
+               loop_file_fmt_init loop_file_fmt_exit \
+               loop_file_fmt_read loop_file_fmt_read_aio \
+               loop_file_fmt_write loop_file_fmt_write_aio \
+               loop_file_fmt_discard loop_file_fmt_flush \
+               loop_file_fmt_sector_size loop_file_fmt_change
+
+
+Finite state machine
+--------------------
+
+To prevent a misuse of the internal file format API, the file format subsystem
+implements an finite state machine. The state machine consists of two states
+and a transition for each internal API function. The state
+*file_fmt_uninitialized* of a loop file format denotes that the file format is
+already allocated but not initialized. After the initialization, the file
+format's state is set to *file_fmt_initialized*. In this state, all IO related
+file format operations can be accessed.
+
+.. note:: If an internal API call does not succeed the file format's state \
+          does not change accordingly to its transition and remains in the \
+          original state before the API call.
+
+The entire implemented finite state machine looks like the following:
+
+.. kernel-render:: DOT
+   :alt: loop file format states
+   :caption: File format states and transitions
+
+   digraph file_fmt_states {
+       rankdir = LR;
+       node [ shape = point,        label = "" ] ENTRY, EXIT;
+       node [ shape = circle,       label = "file_fmt_uninitialized" ] UN;
+       node [ shape = doublecircle, label = "file_fmt_initialized" ]   IN;
+       subgraph helper {
+           rank = "same";
+           ENTRY -> UN   [ label = "loop_file_fmt_alloc()" ];
+           UN    -> EXIT [ label = "loop_file_fmt_free()" ];
+       }
+       UN    -> IN   [ label = "loop_file_fmt_init()" ];
+       IN    -> UN   [ label = "loop_file_fmt_exit()" ];
+       IN    -> IN   [ label = "loop_file_fmt_read()\nloop_file_fmt_read_aio()\nloop_file_fmt_write()\n loop_file_fmt_write_aio()\nloop_file_fmt_discard()\nloop_file_fmt_flush()\nloop_file_fmt_sector_size()\nloop_file_fmt_change()" ];
+   }
+
+
+Write file format drivers
+=========================
+
+A file format driver for the loop file format subsystem is implemented as
+kernel module. In the kernel module's code, the file format driver structure is
+statically allocated and must be initialized. An example definition would look
+like::
+
+   struct loop_file_fmt_driver raw_file_fmt_driver = {
+       .name          = "RAW",
+       .file_fmt_type = LO_FILE_FMT_RAW,
+       .ops           = &raw_file_fmt_ops,
+       .owner         = THIS_MODULE
+   };
+
+The definition assigns a *name* to the file format driver. The *file_fmt_type*
+field is set to the file format type that the driver implements. The *owner*
+specifies the driver's owner and is used to lock the kernel module of the
+driver if the file format driver is in use. The most important field of a loop
+file format driver is the specification of its implementation. Therefore, the
+*ops* field proposes all file format operations that the driver implement by
+link to a statically allocated operations structure.
+
+.. note:: All fields of the **loop_file_fmt_driver** structure must be \
+          initialized and set up accordingly, otherwise the driver does not \
+          work properly.
+
+An example of such an operations structure looks like::
+
+   struct loop_file_fmt_ops raw_file_fmt_ops = {
+       .init        = NULL,
+       .exit        = NULL,
+       .read        = raw_file_fmt_read,
+       .write       = raw_file_fmt_write,
+       .read_aio    = raw_file_fmt_read_aio,
+       .write_aio   = raw_file_fmt_write_aio,
+       .discard     = raw_file_fmt_discard,
+       .flush       = raw_file_fmt_flush,
+       .sector_size = raw_file_fmt_sector_size
+   };
+
+The operations structure consists of a bunch of functions pointers which are
+set in this example to some functions of the binary raw disk file format
+implemented in the example driver. If a function is not available in the
+driver's implementation the function pointer in the operations structure must
+be set to *NULL*.
+
+If all definitions are available and set up correctly the driver can be
+registered and later on unregistered by using the following functions exported
+by the file format subsystem:
+
+.. kernel-doc:: drivers/block/loop/loop_file_fmt.h
+   :functions: loop_file_fmt_register_driver loop_file_fmt_unregister_driver
-- 
2.23.0

