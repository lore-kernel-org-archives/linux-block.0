Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62838C10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 16:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1042183F
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 16:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbfDRQcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:32:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:18987 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfDRQcL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 12:32:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 09:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,366,1549958400"; 
   d="scan'208";a="224674371"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2019 09:32:10 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2] fio: Add advise THP option to mmap engine
Date:   Thu, 18 Apr 2019 10:25:56 -0600
Message-Id: <20190418162556.7829-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The Linux specific transparent hugepage memory advisory has potentially
significant implications for how the memory management behaves. If the
platform supports it, add a new mmap ioengine specific option that advises
HUGEPAGE on an mmap'ed range. The option availability is detected during
configure. If the option is set, fio can test THP when used with private
anonymous memory (i.e. mmap /dev/zero).

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v1 -> v2:

  Added a 'configure' check for MADV_HUGEPAGE support rather than just
  consider only OS Linux

  Fixed cases when MADV_HUGEPAGE is not supported

  Run madvise when after the original mmap() rather than during prep

  Changelog updates

 configure      | 27 +++++++++++++++++++++++++++
 engines/mmap.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 optgroup.h     |  2 ++
 3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 6e549cdc..3c882f0f 100755
--- a/configure
+++ b/configure
@@ -2326,6 +2326,30 @@ if compile_prog "-Wimplicit-fallthrough" "" "-Wimplicit-fallthrough"; then
 fi
 print_config "-Wimplicit-fallthrough" "$fallthrough"
 
+##########################################
+# check for MADV_HUGEPAGE support
+if test "$thp" != "yes" ; then
+  thp="no"
+fi
+if test "$esx" != "yes" ; then
+  cat > $TMPC <<EOF
+#include <sys/mman.h>
+int main(void)
+{
+  return madvise(0, 0x1000, MADV_HUGEPAGE);
+}
+EOF
+  if compile_prog "" "" "thp" ; then
+    thp=yes
+  else
+    if test "$thp" = "yes" ; then
+      feature_not_found "Transparent Huge Page" ""
+    fi
+    thp=no
+  fi
+fi
+print_config "MADV_HUGEPAGE" "$thp"
+
 #############################################################################
 
 if test "$wordsize" = "64" ; then
@@ -2600,6 +2624,9 @@ fi
 if test "$fallthrough" = "yes"; then
   CFLAGS="$CFLAGS -Wimplicit-fallthrough"
 fi
+if test "$thp" = "yes" ; then
+  output_sym "CONFIG_HAVE_THP"
+fi
 
 echo "LIBS+=$LIBS" >> $config_host_mak
 echo "GFIO_LIBS+=$GFIO_LIBS" >> $config_host_mak
diff --git a/engines/mmap.c b/engines/mmap.c
index 308b4665..55ba1ab3 100644
--- a/engines/mmap.c
+++ b/engines/mmap.c
@@ -11,6 +11,7 @@
 #include <sys/mman.h>
 
 #include "../fio.h"
+#include "../optgroup.h"
 #include "../verify.h"
 
 /*
@@ -26,11 +27,40 @@ struct fio_mmap_data {
 	off_t mmap_off;
 };
 
+#ifdef CONFIG_HAVE_THP
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
+#endif
+
 static bool fio_madvise_file(struct thread_data *td, struct fio_file *f,
 			     size_t length)
 
 {
 	struct fio_mmap_data *fmd = FILE_ENG_DATA(f);
+#ifdef CONFIG_HAVE_THP
+	struct mmap_options *o = td->eo;
+
+	/* Ignore errors on this optional advisory */
+	if (o->thp)
+		madvise(fmd->mmap_ptr, length, MADV_HUGEPAGE);
+#endif
 
 	if (!td->o.fadvise_hint)
 		return true;
@@ -50,11 +80,27 @@ static bool fio_madvise_file(struct thread_data *td, struct fio_file *f,
 	return true;
 }
 
+#ifdef CONFIG_HAVE_THP
+static int fio_mmap_get_shared(struct thread_data *td)
+{
+	struct mmap_options *o = td->eo;
+
+	if (o->thp)
+		return MAP_PRIVATE;
+	return MAP_SHARED;
+}
+#else
+static int fio_mmap_get_shared(struct thread_data *td)
+{
+	return MAP_SHARED;
+}
+#endif
+
 static int fio_mmap_file(struct thread_data *td, struct fio_file *f,
 			 size_t length, off_t off)
 {
 	struct fio_mmap_data *fmd = FILE_ENG_DATA(f);
-	int flags = 0;
+	int flags = 0, shared = fio_mmap_get_shared(td);
 
 	if (td_rw(td) && !td->o.verify_only)
 		flags = PROT_READ | PROT_WRITE;
@@ -66,7 +112,7 @@ static int fio_mmap_file(struct thread_data *td, struct fio_file *f,
 	} else
 		flags = PROT_READ;
 
-	fmd->mmap_ptr = mmap(NULL, length, flags, MAP_SHARED, f->fd, off);
+	fmd->mmap_ptr = mmap(NULL, length, flags, shared, f->fd, off);
 	if (fmd->mmap_ptr == MAP_FAILED) {
 		fmd->mmap_ptr = NULL;
 		td_verror(td, errno, "mmap");
@@ -275,6 +321,10 @@ static struct ioengine_ops ioengine = {
 	.close_file	= fio_mmapio_close_file,
 	.get_file_size	= generic_get_file_size,
 	.flags		= FIO_SYNCIO | FIO_NOEXTEND,
+#ifdef CONFIG_HAVE_THP
+	.options	= options,
+	.option_struct_size = sizeof(struct mmap_options),
+#endif
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

