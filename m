Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A4C433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 06:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348860AbiDSGf4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 02:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiDSGfz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 02:35:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770422611F;
        Mon, 18 Apr 2022 23:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=nUuX50OOwwXYW2i4N0xMsaYgoS/f9c5Drxd0p73beA0=; b=gTnPzgLUBRkVe6fgxsHngbj2lc
        rQFfKS23bN1U7xiZNqKP8SX2IG7owEtY9cCyUMol2l9BisjYIYaGWEDQ7zWpgDCePVdJv2ADLersU
        IA1aEE0f1tf/3FGc0puhsdBXfr6ceLAPk+vDav9QE66CiOUUgESaFw36274YN4X1ijX11QGXc8ha8
        IapIlzn3cpOKsc9HnY1+tJpOfeI3oAeQa6bcULvhnQ0KShN/bcfsB89a3OVVuo2IpbQAizfnDRPgP
        vz+oYCVWfl+ZNdHEHDdJF6zx56IFV3URiL1e1VPp7+mqlL4EF93x7A3LFcptEfEXxgSi1w7RhjItL
        ER+EEfYQ==;
Received: from [2001:4bb8:191:364b:8ef6:df8:5a60:ae5d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nghQH-001i0G-0y; Tue, 19 Apr 2022 06:33:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: [PATCH 3/4] loop: remove most the top-of-file boilerplate comment
Date:   Tue, 19 Apr 2022 08:33:02 +0200
Message-Id: <20220419063303.583106-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419063303.583106-1-hch@lst.de>
References: <20220419063303.583106-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the irrelevant changelogs and todo notes and just leave the SPDX
marker and the copyright notice.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 47 --------------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b87151b60dc20..919c96c15be87 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1,54 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/drivers/block/loop.c
- *
- *  Written by Theodore Ts'o, 3/29/93
- *
  * Copyright 1993 by Theodore Ts'o.
- *
- * DES encryption plus some minor changes by Werner Almesberger, 30-MAY-1993
- * more DES encryption plus IDEA encryption by Nicholas J. Leon, June 20, 1996
- *
- * Modularized and updated for 1.1.16 kernel - Mitch Dsouza 28th May 1994
- * Adapted for 1.3.59 kernel - Andries Brouwer, 1 Feb 1996
- *
- * Fixed do_loop_request() re-entrancy - Vincent.Renardias@waw.com Mar 20, 1997
- *
- * Added devfs support - Richard Gooch <rgooch@atnf.csiro.au> 16-Jan-1998
- *
- * Handle sparse backing files correctly - Kenn Humborg, Jun 28, 1998
- *
- * Loadable modules and other fixes by AK, 1998
- *
- * Make real block number available to downstream transfer functions, enables
- * CBC (and relatives) mode encryption requiring unique IVs per data block.
- * Reed H. Petty, rhp@draper.net
- *
- * Maximum number of loop devices now dynamic via max_loop module parameter.
- * Russell Kroll <rkroll@exploits.org> 19990701
- *
- * Maximum number of loop devices when compiled-in now selectable by passing
- * max_loop=<1-255> to the kernel on boot.
- * Erik I. Bolsø, <eriki@himolde.no>, Oct 31, 1999
- *
- * Completely rewrite request handling to be make_request_fn style and
- * non blocking, pushing work to a helper thread. Lots of fixes from
- * Al Viro too.
- * Jens Axboe <axboe@suse.de>, Nov 2000
- *
- * Support up to 256 loop devices
- * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
- *
- * Support for falling back on the write file operation when the address space
- * operations write_begin is not available on the backing filesystem.
- * Anton Altaparmakov, 16 Feb 2005
- *
- * Still To Fix:
- * - Advisory locking is ignored here.
- * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
- *
  */
-
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
-- 
2.30.2

