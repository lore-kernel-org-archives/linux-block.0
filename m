Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF9C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 18:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DC321670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 18:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qlUVyXPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfD3Sn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:43:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3Sn1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 14:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K4VHT/tnWYCDGIVje8iqm8kVvq9adPTZRQZM12UmVS4=; b=qlUVyXPN3yd7xetXbyhpIiZRNC
        r9173mWsEdRps/sM72yBoyCHab5jKxapHDbSSwhND+FAYqlCugXvvo0LJ9pLpBsYFoOqGgeQ4hzn9
        WhWPvhHcfYApuoX+TqpfE57XIhF+DrAZ984rjfniRYfsply6EgUrQFFug9BoSwJwfU9a/M/R5r6cb
        cfkVMf4m56nCVLlAYW8m9OdivZV/jcv/OdWC63iwxBPdx3SnjnZLQflEVpCnwSnjiwyua3hWZ6MfG
        L+vT9Nu4b+D5TLPWuijW1vAIwC9911d3KYnEtRkS2BCPfev4P3xFxbslqecH51yJMn3ZMeF3K3pFu
        LjphfVeA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLXit-0000sM-Or; Tue, 30 Apr 2019 18:43:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] block: switch all files cleared marked as GPLv2 or later to SPDX tags
Date:   Tue, 30 Apr 2019 14:42:40 -0400
Message-Id: <20190430184243.23436-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430184243.23436-1-hch@lst.de>
References: <20190430184243.23436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All these files have some form of the usual GPLv2 or later boilerplate.
Switch them to use SPDX tags instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-cgroup.c      | 11 +----------
 block/bfq-iosched.c     | 11 +----------
 block/bfq-iosched.h     | 11 +----------
 block/bfq-wf2q.c        | 11 +----------
 block/bsg-lib.c         | 16 +---------------
 block/partitions/efi.c  | 16 +---------------
 block/partitions/efi.h  | 16 +---------------
 block/partitions/ldm.c  | 16 +---------------
 block/partitions/ldm.h  | 16 +---------------
 include/linux/bsg-lib.h | 16 +---------------
 10 files changed, 10 insertions(+), 130 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 793c027ca60e..b3796a40a61a 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * cgroups support for the BFQ I/O scheduler.
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License as
- *  published by the Free Software Foundation; either version 2 of the
- *  License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
  */
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b85a4ab8b9db..f8d430f88d25 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Budget Fair Queueing (BFQ) I/O scheduler.
  *
@@ -12,16 +13,6 @@
  *
  * Copyright (C) 2017 Paolo Valente <paolo.valente@linaro.org>
  *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License as
- *  published by the Free Software Foundation; either version 2 of the
- *  License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
  * BFQ is a proportional-share I/O scheduler, with some extra
  * low-latency capabilities. BFQ also supports full hierarchical
  * scheduling through cgroups. Next paragraphs provide an introduction
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index eba7cd449ab4..c2faa77824f8 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1,16 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Header file for the BFQ I/O scheduler: data structures and
  * prototypes of interface functions among BFQ components.
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License as
- *  published by the Free Software Foundation; either version 2 of the
- *  License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
  */
 #ifndef _BFQ_H
 #define _BFQ_H
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 48d899cfbe03..c9ba225081ce 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1,19 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Hierarchical Budget Worst-case Fair Weighted Fair Queueing
  * (B-WF2Q+): hierarchical scheduling algorithm by which the BFQ I/O
  * scheduler schedules generic entities. The latter can represent
  * either single bfq queues (associated with processes) or groups of
  * bfq queues (associated with cgroups).
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License as
- *  published by the Free Software Foundation; either version 2 of the
- *  License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
  */
 #include "bfq-iosched.h"
 
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 005e2b75d775..b898a1cdf872 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  BSG helper library
  *
  *  Copyright (C) 2008   James Smart, Emulex Corporation
  *  Copyright (C) 2011   Red Hat, Inc.  All rights reserved.
  *  Copyright (C) 2011   Mike Christie
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 #include <linux/slab.h>
 #include <linux/blk-mq.h>
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 39f70d968754..db2fef7dfc47 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /************************************************************
  * EFI GUID Partition Table handling
  *
@@ -7,21 +8,6 @@
  * efi.[ch] by Matt Domsch <Matt_Domsch@dell.com>
  *   Copyright 2000,2001,2002,2004 Dell Inc.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- *
  * TODO:
  *
  * Changelog:
diff --git a/block/partitions/efi.h b/block/partitions/efi.h
index abd0b19288a6..3e8576157575 100644
--- a/block/partitions/efi.h
+++ b/block/partitions/efi.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /************************************************************
  * EFI GUID Partition Table
  * Per Intel EFI Specification v1.02
@@ -5,21 +6,6 @@
  *
  * By Matt Domsch <Matt_Domsch@dell.com>  Fri Sep 22 22:15:56 CDT 2000  
  *   Copyright 2000,2001 Dell Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- * 
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- * 
  ************************************************************/
 
 #ifndef FS_PART_EFI_H_INCLUDED
diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 16766f267559..6db573f33219 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /**
  * ldm - Support for Windows Logical Disk Manager (Dynamic Disks)
  *
@@ -6,21 +7,6 @@
  * Copyright (C) 2001,2002 Jakob Kemi <jakob.kemi@telia.com>
  *
  * Documentation is available at http://www.linux-ntfs.org/doku.php?id=downloads 
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License as published by the Free Software
- * Foundation; either version 2 of the License, or (at your option) any later
- * version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program (in the main directory of the source in the file COPYING); if
- * not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
- * Boston, MA  02111-1307  USA
  */
 
 #include <linux/slab.h>
diff --git a/block/partitions/ldm.h b/block/partitions/ldm.h
index f4c6055df956..1ca63e97bccc 100644
--- a/block/partitions/ldm.h
+++ b/block/partitions/ldm.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /**
  * ldm - Part of the Linux-NTFS project.
  *
@@ -6,21 +7,6 @@
  * Copyright (C) 2001,2002 Jakob Kemi <jakob.kemi@telia.com>
  *
  * Documentation is available at http://www.linux-ntfs.org/doku.php?id=downloads 
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS source
- * in the file COPYING); if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #ifndef _FS_PT_LDM_H_
diff --git a/include/linux/bsg-lib.h b/include/linux/bsg-lib.h
index 7f14517a559b..960988d42f77 100644
--- a/include/linux/bsg-lib.h
+++ b/include/linux/bsg-lib.h
@@ -1,24 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *  BSG helper library
  *
  *  Copyright (C) 2008   James Smart, Emulex Corporation
  *  Copyright (C) 2011   Red Hat, Inc.  All rights reserved.
  *  Copyright (C) 2011   Mike Christie
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 #ifndef _BLK_BSG_
 #define _BLK_BSG_
-- 
2.20.1

