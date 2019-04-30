Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F78BC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 18:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B70A21670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 18:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="COyru0E9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfD3Snx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:43:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfD3Sn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 14:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mAbpF8c0hCljXlnNixYDVqV/+ckI65P7ypbjPuFBFjw=; b=COyru0E9wj7FkfX/o/IsbPTsX
        bz31Mz0wNrCFnoRaLXob0WjgcL2LpmeKkxnqBsQHmO7Hdx0WAkQR7y0DxNvNr2e22MpCyAK343ogv
        Gq2HqFcDvleJjz4Gjc+/FlwrRjxIBbahlb0+SmCgZbEfFkdhBm2VabgkFiDyXuufQTuKD8P0kR/Iw
        JS5E9J4w99y/CZ7P2e18kryLmygi3o7Q1nAa163JpUzrh7J2njHOMhEZkRbdy6KabKWyIDDvKpnlC
        q27QTT+xyDC5iKhBPnFOoZCMuz62PgqThY5+JLjw+I5qKX8Qiwt3gAmIHFExCYh3MEvagCqJ8s68u
        5x8P59vjA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLXis-0000s6-7W; Tue, 30 Apr 2019 18:43:22 +0000
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
Subject: [PATCH 1/5] block: switch all files cleared marked as GPLv2 to SPDX tags
Date:   Tue, 30 Apr 2019 14:42:39 -0400
Message-Id: <20190430184243.23436-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430184243.23436-1-hch@lst.de>
References: <20190430184243.23436-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All these files have some form of the usual GPLv2 boilerplate.  Switch
them to use SPDX tags instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/badblocks.c        | 10 +---------
 block/bio-integrity.c    | 16 +---------------
 block/bio.c              | 15 +--------------
 block/blk-flush.c        |  3 +--
 block/blk-integrity.c    | 16 +---------------
 block/blk-mq-debugfs.c   | 13 +------------
 block/blk-mq-pci.c       | 10 +---------
 block/blk-mq-rdma.c      | 10 +---------
 block/blk-mq-virtio.c    | 10 +---------
 block/bsg.c              |  9 +--------
 block/kyber-iosched.c    | 13 +------------
 block/opal_proto.h       | 10 +---------
 block/partitions/acorn.c |  7 +------
 block/scsi_ioctl.c       | 16 +---------------
 block/sed-opal.c         | 10 +---------
 block/t10-pi.c           | 19 +------------------
 include/linux/bio.h      | 15 +--------------
 include/linux/bvec.h     | 15 +--------------
 include/linux/sed-opal.h | 10 +---------
 19 files changed, 19 insertions(+), 208 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 91f7bcf979d3..2e5f5697db35 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Bad block management
  *
  * - Heavily based on MD badblocks code from Neil Brown
  *
  * Copyright (c) 2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 
 #include <linux/badblocks.h>
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 1b633a3526d4..42536674020a 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -1,23 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bio-integrity.c - bio data integrity extensions
  *
  * Copyright (C) 2007, 2008, 2009 Oracle Corporation
  * Written by: Martin K. Petersen <martin.petersen@oracle.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; see the file COPYING.  If not, write to
- * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
- * USA.
- *
  */
 
 #include <linux/blkdev.h>
diff --git a/block/bio.c b/block/bio.c
index 029afb121a48..683cbb40f051 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 Jens Axboe <axboe@kernel.dk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public Licens
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
- *
  */
 #include <linux/mm.h>
 #include <linux/swap.h>
diff --git a/block/blk-flush.c b/block/blk-flush.c
index d95f94892015..aedd9320e605 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -1,11 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Functions to sequence PREFLUSH and FUA writes.
  *
  * Copyright (C) 2011		Max Planck Institute for Gravitational Physics
  * Copyright (C) 2011		Tejun Heo <tj@kernel.org>
  *
- * This file is released under the GPLv2.
- *
  * REQ_{PREFLUSH|FUA} requests are decomposed to sequences consisted of three
  * optional steps - PREFLUSH, DATA and POSTFLUSH - according to the request
  * properties and hardware capability.
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index d1ab089e0919..7f302f7b9d84 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -1,23 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * blk-integrity.c - Block layer data integrity extensions
  *
  * Copyright (C) 2007, 2008 Oracle Corporation
  * Written by: Martin K. Petersen <martin.petersen@oracle.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; see the file COPYING.  If not, write to
- * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
- * USA.
- *
  */
 
 #include <linux/blkdev.h>
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ec1d18cb643c..6aea0ebc3a73 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Facebook
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public
- * License v2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <https://www.gnu.org/licenses/>.
  */
 
 #include <linux/kernel.h>
diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index 1dce18553984..ad4545a2a98b 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016 Christoph Hellwig.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 #include <linux/kobject.h>
 #include <linux/blkdev.h>
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 45030a81a1ed..cc921e6ba709 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2017 Sagi Grimberg.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-rdma.h>
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 370827163835..75a52c18a8f6 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016 Christoph Hellwig.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 #include <linux/device.h>
 #include <linux/blk-mq.h>
diff --git a/block/bsg.c b/block/bsg.c
index f306853c6b08..833c44b3d458 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -1,13 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bsg.c - block layer implementation of the sg v4 interface
- *
- * Copyright (C) 2004 Jens Axboe <axboe@suse.de> SUSE Labs
- * Copyright (C) 2004 Peter M. Jones <pjones@redhat.com>
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License version 2.  See the file "COPYING" in the main directory of this
- *  archive for more details.
- *
  */
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index ec6a04e01bc1..c3b05119cebd 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * The Kyber I/O scheduler. Controls latency by throttling queue depths using
  * scalable techniques.
  *
  * Copyright (C) 2017 Facebook
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public
- * License v2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <https://www.gnu.org/licenses/>.
  */
 
 #include <linux/kernel.h>
diff --git a/block/opal_proto.h b/block/opal_proto.h
index b6e352cfe982..d9a05ad02eb5 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -1,18 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright © 2016 Intel Corporation
  *
  * Authors:
  *    Rafael Antognolli <rafael.antognolli@intel.com>
  *    Scott  Bauer      <scott.bauer@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 #include <linux/types.h>
 
diff --git a/block/partitions/acorn.c b/block/partitions/acorn.c
index fbeb697374d5..7587700fad4a 100644
--- a/block/partitions/acorn.c
+++ b/block/partitions/acorn.c
@@ -1,12 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *  linux/fs/partitions/acorn.c
- *
  *  Copyright (c) 1996-2000 Russell King.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  *  Scan ADFS partitions on hard disk drives.  Unfortunately, there
  *  isn't a standard for partitioning drives on Acorn machines, so
  *  every single manufacturer of SCSI and IDE cards created their own
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 533f4aee8567..f5e0ad65e86a 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 Jens Axboe <axboe@suse.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public Licens
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
- *
  */
 #include <linux/kernel.h>
 #include <linux/errno.h>
diff --git a/block/sed-opal.c b/block/sed-opal.c
index b1aa0cc25803..a46e8d13e16d 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright © 2016 Intel Corporation
  *
  * Authors:
  *    Scott  Bauer      <scott.bauer@intel.com>
  *    Rafael Antognolli <rafael.antognolli@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ":OPAL: " fmt
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 62aed77d0bb9..0c0094609dd6 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -1,24 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * t10_pi.c - Functions for generating and verifying T10 Protection
  *	      Information.
- *
- * Copyright (C) 2007, 2008, 2014 Oracle Corporation
- * Written by: Martin K. Petersen <martin.petersen@oracle.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; see the file COPYING.  If not, write to
- * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
- * USA.
- *
  */
 
 #include <linux/t10-pi.h>
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 077cecdf9437..ea73df36529a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -1,19 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2001 Jens Axboe <axboe@suse.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public Licens
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
  */
 #ifndef __LINUX_BIO_H
 #define __LINUX_BIO_H
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index a4811410e4fc..545a480528e0 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * bvec iterator
  *
  * Copyright (C) 2001 Ming Lei <ming.lei@canonical.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public Licens
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
  */
 #ifndef __LINUX_BVEC_ITER_H
 #define __LINUX_BVEC_ITER_H
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 04b124fca51e..3e76b6d7d97f 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -1,18 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright © 2016 Intel Corporation
  *
  * Authors:
  *    Rafael Antognolli <rafael.antognolli@intel.com>
  *    Scott  Bauer      <scott.bauer@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 
 #ifndef LINUX_OPAL_H
-- 
2.20.1

