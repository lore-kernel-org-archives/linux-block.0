Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E4C432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 11:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E342178F
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 11:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfK1Lxf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:53:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:45362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfK1Lxe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 06:53:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25474AF37;
        Thu, 28 Nov 2019 11:53:33 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Roman Penyaev <rpenyaev@suse.de>
Subject: [PATCH 1/1] io_uring: add mapping support for NOMMU archs
Date:   Thu, 28 Nov 2019 12:53:22 +0100
Message-Id: <20191128115322.416956-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

That is a bit weird scenario but I find it interesting to run fio loads
using LKL linux, where MMU is disabled.  Probably other real archs which
run uClinux can also benefit from this patch.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
---
 fs/io_uring.c | 57 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8a0381f1a43b..ebe9f9e6e81b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3536,12 +3536,11 @@ static int io_uring_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
+static void *io_uring_validate_mmap_request(struct file *file,
+					    loff_t pgoff, size_t sz)
 {
-	loff_t offset = (loff_t) vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long sz = vma->vm_end - vma->vm_start;
 	struct io_ring_ctx *ctx = file->private_data;
-	unsigned long pfn;
+	loff_t offset = pgoff << PAGE_SHIFT;
 	struct page *page;
 	void *ptr;
 
@@ -3554,17 +3553,59 @@ static int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
 		ptr = ctx->sq_sqes;
 		break;
 	default:
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	page = virt_to_head_page(ptr);
 	if (sz > page_size(page))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
+
+	return ptr;
+}
+
+#ifdef CONFIG_MMU
+
+static int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	size_t sz = vma->vm_end - vma->vm_start;
+	unsigned long pfn;
+	void *ptr;
+
+	ptr = io_uring_validate_mmap_request(file, vma->vm_pgoff, sz);
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
 
 	pfn = virt_to_phys(ptr) >> PAGE_SHIFT;
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
 
+#else /* !CONFIG_MMU */
+
+static int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return vma->vm_flags & (VM_SHARED | VM_MAYSHARE) ? 0 : -EINVAL;
+}
+
+static unsigned int io_uring_nommu_mmap_capabilities(struct file *file)
+{
+	return NOMMU_MAP_DIRECT | NOMMU_MAP_READ | NOMMU_MAP_WRITE;
+}
+
+static unsigned long io_uring_nommu_get_unmapped_area(struct file *file,
+	unsigned long addr, unsigned long len,
+	unsigned long pgoff, unsigned long flags)
+{
+	void *ptr;
+
+	ptr = io_uring_validate_mmap_request(file, pgoff, len);
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+
+	return (unsigned long) ptr;
+}
+
+#endif /* !CONFIG_MMU */
+
 SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		u32, min_complete, u32, flags, const sigset_t __user *, sig,
 		size_t, sigsz)
@@ -3639,6 +3680,10 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 static const struct file_operations io_uring_fops = {
 	.release	= io_uring_release,
 	.mmap		= io_uring_mmap,
+#ifndef CONFIG_MMU
+	.get_unmapped_area = io_uring_nommu_get_unmapped_area,
+	.mmap_capabilities = io_uring_nommu_mmap_capabilities,
+#endif
 	.poll		= io_uring_poll,
 	.fasync		= io_uring_fasync,
 };
-- 
2.24.0

