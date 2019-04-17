Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AAFC282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7C21850
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfDQVec (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:34:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:9681 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfDQVec (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 17:34:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 14:34:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,363,1549958400"; 
   d="scan'208";a="162824918"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 17 Apr 2019 14:34:31 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH] fio: Add advise THP option to mmap engine
Date:   Wed, 17 Apr 2019 15:28:16 -0600
Message-Id: <20190417212816.6460-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The transparent hugepage Linux-specific memory advisory has potentially
significant implications for how the memory management behaves. Add a
new mmap specific option that enables private TLP mmap mode when set so
we can test running fio with anonymous memory (i.e. mmap /dev/zero).

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 engines/mmap.c | 39 ++++++++++++++++++++++++++++++++++++---
 optgroup.h     |  2 ++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/engines/mmap.c b/engines/mmap.c
index 308b4665..7bca6c20 100644
--- a/engines/mmap.c
+++ b/engines/mmap.c
@@ -11,6 +11,7 @@
 #include <sys/mman.h>
 
 #include "../fio.h"
+#include "../optgroup.h"
 #include "../verify.h"
 
 /*
@@ -26,6 +27,26 @@ struct fio_mmap_data {
 	off_t mmap_off;
 };
 
+struct mmap_options {
+	void *pad;
+	unsigned int thp;
+};
+
+static struct fio_option options[] = {
+	{
+		.name	= "thp",
+		.lname	= "Transparent Huge Pages",
+		.type	= FIO_OPT_INT,
+		.off1	= offsetof(struct mmap_options, thp),
+		.help	= "Memory Advise Huge Page",
+		.category = FIO_OPT_C_ENGINE,
+		.group	= FIO_OPT_G_MMAP,
+	},
+	{
+		.name = NULL,
+	},
+};
+
 static bool fio_madvise_file(struct thread_data *td, struct fio_file *f,
 			     size_t length)
 
@@ -54,7 +75,8 @@ static int fio_mmap_file(struct thread_data *td, struct fio_file *f,
 			 size_t length, off_t off)
 {
 	struct fio_mmap_data *fmd = FILE_ENG_DATA(f);
-	int flags = 0;
+	struct mmap_options *o = td->eo;
+	int flags = 0, shared = MAP_SHARED;
 
 	if (td_rw(td) && !td->o.verify_only)
 		flags = PROT_READ | PROT_WRITE;
@@ -66,7 +88,12 @@ static int fio_mmap_file(struct thread_data *td, struct fio_file *f,
 	} else
 		flags = PROT_READ;
 
-	fmd->mmap_ptr = mmap(NULL, length, flags, MAP_SHARED, f->fd, off);
+#if FIO_OS==os_linux
+	if (o->thp)
+		shared = MAP_PRIVATE;
+#endif
+
+	fmd->mmap_ptr = mmap(NULL, length, flags, shared, f->fd, off);
 	if (fmd->mmap_ptr == MAP_FAILED) {
 		fmd->mmap_ptr = NULL;
 		td_verror(td, errno, "mmap");
@@ -146,6 +173,7 @@ static int fio_mmapio_prep(struct thread_data *td, struct io_u *io_u)
 {
 	struct fio_file *f = io_u->file;
 	struct fio_mmap_data *fmd = FILE_ENG_DATA(f);
+	struct mmap_options *o = td->eo;
 	int ret;
 
 	/*
@@ -170,10 +198,13 @@ static int fio_mmapio_prep(struct thread_data *td, struct io_u *io_u)
 		if (ret)
 			return ret;
 	}
-
 done:
 	io_u->mmap_data = fmd->mmap_ptr + io_u->offset - fmd->mmap_off -
 				f->file_offset;
+#if FIO_OS==os_linux
+	if (o->thp)
+		madvise(io_u->mmap_data, fmd->mmap_sz, MADV_HUGEPAGE);
+#endif
 	return 0;
 }
 
@@ -275,6 +306,8 @@ static struct ioengine_ops ioengine = {
 	.close_file	= fio_mmapio_close_file,
 	.get_file_size	= generic_get_file_size,
 	.flags		= FIO_SYNCIO | FIO_NOEXTEND,
+	.options		= options,
+	.option_struct_size	= sizeof(struct mmap_options),
 };
 
 static void fio_init fio_mmapio_register(void)
diff --git a/optgroup.h b/optgroup.h
index adf4d09b..bf1bb036 100644
--- a/optgroup.h
+++ b/optgroup.h
@@ -61,6 +61,7 @@ enum opt_category_group {
 	__FIO_OPT_G_MTD,
 	__FIO_OPT_G_HDFS,
 	__FIO_OPT_G_SG,
+	__FIO_OPT_G_MMAP,
 	__FIO_OPT_G_NR,
 
 	FIO_OPT_G_RATE		= (1ULL << __FIO_OPT_G_RATE),
@@ -97,6 +98,7 @@ enum opt_category_group {
 	FIO_OPT_G_MTD		= (1ULL << __FIO_OPT_G_MTD),
 	FIO_OPT_G_HDFS		= (1ULL << __FIO_OPT_G_HDFS),
 	FIO_OPT_G_SG		= (1ULL << __FIO_OPT_G_SG),
+	FIO_OPT_G_MMAP		= (1ULL << __FIO_OPT_G_MMAP),
 	FIO_OPT_G_INVALID	= (1ULL << __FIO_OPT_G_NR),
 };
 
-- 
2.14.4

