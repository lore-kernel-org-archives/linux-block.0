Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34582 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161559AbcE3Ngv (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 30 May 2016 09:36:51 -0400
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@canonical.com>,
	Keith Busch <keith.busch@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v6 8/8] block: mark BIO_MAX_SIZE as obsolete
Date: Mon, 30 May 2016 21:34:36 +0800
Message-Id: <1464615294-9946-9-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Some in-tree drivers may use big bio which size is more
than BIO_MAX_SIZE, also the macro is seldom used in tree.

So mark it as obsolete now, and it doesn't make sense
after multipage bvec is introduced.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index fb59a06..b284595 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -41,6 +41,13 @@
 #endif
 
 #define BIO_MAX_PAGES		256
+
+/*
+ * This is obsolete now and shouldn't be used, and the macro
+ * doesn't make any sense especially when multipage bvecs is
+ * supported. Even now some drivers may pass big bio which size
+ * is more than the value, such as bcache.
+ */
 #define BIO_MAX_SIZE		(BIO_MAX_PAGES << PAGE_SHIFT)
 
 /*
-- 
1.9.1

