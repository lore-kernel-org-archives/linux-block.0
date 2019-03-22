Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A0C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA7621841
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXCmqdMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfCVPvQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:51:16 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:43941 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfCVPvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 11:51:15 -0400
Received: by mail-qt1-f202.google.com with SMTP id q21so2685297qtf.10
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yUz3y/zqCbfeOFiLbP3Lq55devgNy7EQ14ho/1e7cgg=;
        b=bXCmqdMkoVV++PgP0anhaNAJ8So6+rSMdfLApto1SqkbAfSqbdqGbQyrSMiFIhyJCA
         YswP0mUnanDjEBjbZjdh2zxumEHNvja3fuNZTXyz+vVJYXFc0Idv891emys/ULPH1QjZ
         Iw9uqC0328+QH2KZO7fdZJa17ynpNymArlEZWmcU7SzKEM43Irv/lB5wcF5D5rTL435S
         rcqPNHA5ZjCLycJmFTyjU23ut/QF+DNhIMCbRAd/3AHyNACzgvkmGeRgkfAf4ascQkFu
         VRRCSKV0UUrREcxduPo9F4KiTfJGNV8RlKEs+tShpTIKIuWFrU1+Yv0yn5PwYicyRKJJ
         +54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yUz3y/zqCbfeOFiLbP3Lq55devgNy7EQ14ho/1e7cgg=;
        b=nzzPi63xkNdaC2vPUprO3/DhF6UpXP8O/Q3nWM2Azo+lqklgSSyl/4dGhm91J/AlNZ
         ZRaEbHqfhKAAiZnaq3Jlhizd5iFbzd07zv+Wtg7VL/qJ5ZVshLt49HcN9vXKtaOpxeQj
         I7WZUP3u2ahsW+STP84TVp5fbZWknJV1SWKhoy2IBVOwxBt/WvjrgWhGTu1c1oN57mA4
         p9Tx8HJM0OIOOtnefaajqJKCrHmIs8L7lV9E+aDcS4djuZs+ECvu2k0OVrYyajqqknBU
         MAVkGCfiitYbEozPw1O5pRyY9ra8cYeUKZhar2q1sJTrQmore7dVEdptumVxZqxh5GXe
         OM+Q==
X-Gm-Message-State: APjAAAXJ8YEWbDZFwsssyICzF/wXkkS0uRcTJtDzp98kTiuw1GZHU8dE
        M7GnxNzHhSZRCBslJPVJ/53KfPlfQ7ndOOI=
X-Google-Smtp-Source: APXvYqx1lOi+X0TXvG1ak5iG/8IAbp0LG/ylIQiPjgHJ5dOLYLpuGJ5zx9MnZ+d1i19F1/rVzYiOo5U62EACGVg=
X-Received: by 2002:ac8:1be8:: with SMTP id m37mr1933756qtk.148.1553269874386;
 Fri, 22 Mar 2019 08:51:14 -0700 (PDT)
Date:   Fri, 22 Mar 2019 23:46:11 +0800
Message-Id: <20190322154610.164564-1-liumartin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC PATCH] mm: readahead: add readahead_shift into backing device
From:   Martin Liu <liumartin@google.com>
To:     akpm@linux-foundation.org, fengguang.wu@intel.com, axboe@kernel.dk,
        dchinner@redhat.com
Cc:     jenhaochen@google.com, salyzyn@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        liumartin@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As the discussion https://lore.kernel.org/patchwork/patch/334982/
We know an open file's ra_pages might run out of sync from
bdi.ra_pages since sequential, random or error read. Current design
is we have to ask users to reopen the file or use fdavise system
call to get it sync. However, we might have some cases to change
system wide file ra_pages to enhance system performance such as
enhance the boot time by increasing the ra_pages or decrease it to
mitigate the trashing under memory pressure. Those are the cases
we need to globally and immediately change this value. However,
from the discussion, we know bdi readahead tend to be an optimal
value to be a physical property of the storage and doesn't tend to
change dynamically. Thus we'd like to purpose readahead_shift into
backing device. This value is used as a shift bit number with bdi
readahead value to come out the readahead value and the negative
value means the division effect in the fixup function. The fixup
would only take effect when shift value is not zero;otherwise,
it returns file's ra_pages directly. Thus, an administrator could
use this value to control the amount readahead referred to
its backing device to achieve its goal.

Signed-off-by: Martin Liu <liumartin@google.com>
---
I'd like to get some feedback about the patch. If you have any
concern, please let me know. Thanks. 
---
 block/blk-sysfs.c                | 28 ++++++++++++++++++++++++++++
 include/linux/backing-dev-defs.h |  1 +
 include/linux/backing-dev.h      | 10 ++++++++++
 mm/backing-dev.c                 | 27 +++++++++++++++++++++++++++
 mm/filemap.c                     |  8 +++++---
 mm/readahead.c                   |  2 +-
 6 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 59685918167e..f48b68e05d0e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -107,6 +107,27 @@ queue_ra_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
+static ssize_t queue_ra_shift_show(struct request_queue *q, char *page)
+{
+	int ra_shift = q->backing_dev_info->read_ahead_shift;
+
+	return scnprintf(page, PAGE_SIZE - 1, "%d\n", ra_shift);
+}
+
+static ssize_t queue_ra_shift_store(struct request_queue *q, const char *page,
+				    size_t count)
+{
+	s8 ra_shift;
+	ssize_t ret = kstrtos8(page, 10, &ra_shift);
+
+	if (ret)
+		return ret;
+
+	q->backing_dev_info->read_ahead_shift = ra_shift;
+
+	return count;
+}
+
 static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
 {
 	int max_sectors_kb = queue_max_sectors(q) >> 1;
@@ -540,6 +561,12 @@ static struct queue_sysfs_entry queue_ra_entry = {
 	.store = queue_ra_store,
 };
 
+static struct queue_sysfs_entry queue_ra_shift_entry = {
+	.attr = {.name = "read_ahead_shift", .mode = 0644 },
+	.show = queue_ra_shift_show,
+	.store = queue_ra_shift_store,
+};
+
 static struct queue_sysfs_entry queue_max_sectors_entry = {
 	.attr = {.name = "max_sectors_kb", .mode = 0644 },
 	.show = queue_max_sectors_show,
@@ -729,6 +756,7 @@ static struct queue_sysfs_entry throtl_sample_time_entry = {
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
+	&queue_ra_shift_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_max_segments_entry.attr,
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 07e02d6df5ad..452002df5232 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -167,6 +167,7 @@ struct bdi_writeback {
 struct backing_dev_info {
 	struct list_head bdi_list;
 	unsigned long ra_pages;	/* max readahead in PAGE_SIZE units */
+	s8 read_ahead_shift; /* shift to ra_pages */
 	unsigned long io_pages;	/* max allowed IO size */
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
 	void *congested_data;	/* Pointer to aux data for congested func */
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index f9b029180241..23f755fe386e 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -221,6 +221,16 @@ static inline int bdi_sched_wait(void *word)
 	return 0;
 }
 
+static inline unsigned long read_ahead_fixup(struct file *file)
+{
+	unsigned long ra = file->f_ra.ra_pages;
+	s8 shift = (inode_to_bdi(file->f_mapping->host))->read_ahead_shift;
+
+	ra = (shift >= 0) ? ra << shift : ra >> abs(shift);
+
+	return ra;
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct bdi_writeback_congested *
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 72e6d0c55cfa..1b5163a5ead5 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -172,6 +172,32 @@ static DEVICE_ATTR_RW(name);
 
 BDI_SHOW(read_ahead_kb, K(bdi->ra_pages))
 
+static ssize_t read_ahead_shift_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi = dev_get_drvdata(dev);
+	s8 read_ahead_shift;
+	ssize_t ret = kstrtos8(buf, 10, &read_ahead_shift);
+
+	if (ret)
+		return ret;
+
+	bdi->read_ahead_shift = read_ahead_shift;
+
+	return count;
+}
+
+static ssize_t read_ahead_shift_show(struct device *dev,
+				     struct device_attribute *attr, char *page)
+{
+	struct backing_dev_info *bdi = dev_get_drvdata(dev);
+
+	return scnprintf(page, PAGE_SIZE - 1, "%d\n", bdi->read_ahead_shift);
+}
+
+static DEVICE_ATTR_RW(read_ahead_shift);
+
 static ssize_t min_ratio_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -223,6 +249,7 @@ static DEVICE_ATTR_RO(stable_pages_required);
 
 static struct attribute *bdi_dev_attrs[] = {
 	&dev_attr_read_ahead_kb.attr,
+	&dev_attr_read_ahead_shift.attr,
 	&dev_attr_min_ratio.attr,
 	&dev_attr_max_ratio.attr,
 	&dev_attr_stable_pages_required.attr,
diff --git a/mm/filemap.c b/mm/filemap.c
index d78f577baef2..cd8d0e00ff93 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2469,6 +2469,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct address_space *mapping = file->f_mapping;
 	struct file *fpin = NULL;
 	pgoff_t offset = vmf->pgoff;
+	unsigned long max;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
@@ -2498,9 +2499,10 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 * mmap read-around
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
-	ra->size = ra->ra_pages;
-	ra->async_size = ra->ra_pages / 4;
+	max = read_ahead_fixup(file);
+	ra->start = max_t(long, 0, offset - max / 2);
+	ra->size = max;
+	ra->async_size = max / 4;
 	ra_submit(ra, mapping, file);
 	return fpin;
 }
diff --git a/mm/readahead.c b/mm/readahead.c
index a4593654a26c..546bf344fc4d 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -384,7 +384,7 @@ ondemand_readahead(struct address_space *mapping,
 		   unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	unsigned long max_pages = ra->ra_pages;
+	unsigned long max_pages = read_ahead_fixup(filp);
 	unsigned long add_pages;
 	pgoff_t prev_offset;
 
-- 
2.21.0.392.gf8f6787159e-goog

