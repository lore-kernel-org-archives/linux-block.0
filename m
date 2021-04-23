Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6600C433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 01:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D5C61435
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 01:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbhDWBLw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 21:11:52 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:37747 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbhDWBLu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 21:11:50 -0400
Received: by mail-pl1-f172.google.com with SMTP id h20so24441338plr.4;
        Thu, 22 Apr 2021 18:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xe007CS5NPPQ7JWlHW72PD0Z2Q/jumLCCgW/At5QguA=;
        b=EtPeq7C2TYbg/S2ongqZa29woRkY2tZ/EQF1Yr4sP5V9VkRTn/u/aveIZFLBKbAn4/
         jnNc30VuY4TpdMhWf9RLqZiF0623OB/4vB3ktVf6yR0oMHLC7hcViZ+LM6eywp7Gy4a9
         tVR0RDh62vfPEP/5EGIpCYo19nEQw476Qjqo9oT78PzlAMUrdpUtO3t5X/+p9MmQSwrM
         mfly2J0XmxqmchJAigDXOOjNCLiGtZJMGxBW/nnQbWrP11SdtmT/vLbfS0jR2nOWYxha
         nGuzPcaDRj1gtbj+sQVTe7OFRlT6FzCnVZ5FwwvkDNyCFsdemCgaFEi5OvqiZR+vsmod
         5iDg==
X-Gm-Message-State: AOAM532U3oVxIVChE2sq7+FuyHT9vV/JZpgH7omJiZ3pN2C1FFOB7hzR
        sFWjY0sMt8oripBoW+5lfbk=
X-Google-Smtp-Source: ABdhPJzkLF5fBWt0nypz9frlbS0xU2Hsm/25muT0qQhdshMaON3jecd/UvHrYEPVHbiijLXrmOpZcw==
X-Received: by 2002:a17:90a:c696:: with SMTP id n22mr1578808pjt.164.1619140274143;
        Thu, 22 Apr 2021 18:11:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j23sm2981657pfh.179.2021.04.22.18.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:11:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7056341DD1; Fri, 23 Apr 2021 01:11:09 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] zram: fix possible races between sysfs use and bdev access
Date:   Fri, 23 Apr 2021 01:11:08 +0000
Message-Id: <20210423011108.11988-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210423011108.11988-1-mcgrof@kernel.org>
References: <20210423011108.11988-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Its possible to run into a race where a sysfs knob is being used,
we get preempted, and a zram device is removed before we complete
use of the sysfs knob. This can happen for instance on block
devices, where for instance the zram block devices just part of
the private data of the block device. To ensure the private
data pointer is valid we must bdget() / bdput() in between
access.

For instance this can happen in the following two situations
as examples to illustrate this better:

        CPU 1                            CPU 2
destroy_devices
...
                                 compact_store()
                                 zram = dev_to_zram(dev);
idr_for_each(zram_remove_cb
  zram_remove
  ...
  kfree(zram)
                                 down_read(&zram->init_lock);

        CPU 1                            CPU 2
hot_remove_store
                                 compact_store()
                                 zram = dev_to_zram(dev);
  zram_remove
    kfree(zram)
                                 down_read(&zram->init_lock);

This issue does not fix a known crash, however this race was
spotted by Minchan Kim through code inspection upon code review
of the sysfs deadlock patch.

A generic solution for sysfs has been suggested and implemented (refer
to the dev_type_get() / dev_type_put() part of the patch) [0], however
there is no interest at this point in time in fixing this in sysfs itself.

[0] https://lkml.kernel.org/r/20210401235925.GR4332@42.do-not-panic.com

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 260 +++++++++++++++++++++++++++++-----
 1 file changed, 224 insertions(+), 36 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 701ed28da125..9201a012ea8b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -237,34 +237,55 @@ static ssize_t initstate_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	u32 val;
-	struct zram *zram = dev_to_zram(dev);
+	int len;
+	struct zram *zram;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	val = init_done(zram);
 	up_read(&zram->init_lock);
 
-	module_put(THIS_MODULE);
+	len = scnprintf(buf, PAGE_SIZE, "%u\n", val);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	bdput(dev_to_bdev(dev));
+out_nodev:
+	module_put(THIS_MODULE);
+	return len;
 }
 
 static ssize_t disksize_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 	u64 disksize;
+	int len;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
 	disksize = zram->disksize;
+	len = scnprintf(buf, PAGE_SIZE, "%llu\n", disksize);
 
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", disksize);
+	return len;
 }
 
 static ssize_t mem_limit_store(struct device *dev,
@@ -272,11 +293,17 @@ static ssize_t mem_limit_store(struct device *dev,
 {
 	u64 limit;
 	char *tmp;
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
 	limit = memparse(buf, &tmp);
 
 	/* no chars parsed, invalid input */
@@ -290,6 +317,8 @@ static ssize_t mem_limit_store(struct device *dev,
 	up_write(&zram->init_lock);
 
 out:
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 	return len;
 }
@@ -299,7 +328,7 @@ static ssize_t mem_used_max_store(struct device *dev,
 {
 	int err;
 	unsigned long val;
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 
 	err = kstrtoul(buf, 10, &val);
 	if (err || val != 0)
@@ -308,6 +337,13 @@ static ssize_t mem_used_max_store(struct device *dev,
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	if (init_done(zram)) {
 		atomic_long_set(&zram->stats.max_used_pages,
@@ -315,6 +351,8 @@ static ssize_t mem_used_max_store(struct device *dev,
 	}
 	up_read(&zram->init_lock);
 
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
 	return len;
@@ -323,8 +361,8 @@ static ssize_t mem_used_max_store(struct device *dev,
 static ssize_t idle_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
-	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	struct zram *zram;
+	unsigned long nr_pages;
 	int index;
 
 	if (!sysfs_streq(buf, "all"))
@@ -333,6 +371,14 @@ static ssize_t idle_store(struct device *dev,
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	down_read(&zram->init_lock);
 	if (!init_done(zram)) {
 		len = -EINVAL;
@@ -353,6 +399,8 @@ static ssize_t idle_store(struct device *dev,
 
 out:
 	up_read(&zram->init_lock);
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 	return len;
 }
@@ -361,91 +409,126 @@ static ssize_t idle_store(struct device *dev,
 static ssize_t writeback_limit_enable_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 	u64 val;
-	ssize_t ret = -EINVAL;
 
 	if (kstrtoull(buf, 10, &val))
-		return ret;
+		return -EINVAL;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->wb_limit_enable = val;
 	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
-	ret = len;
 
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
-	return ret;
+	return len;
 }
 
 static ssize_t writeback_limit_enable_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	bool val;
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	val = zram->wb_limit_enable;
 	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
+	len = scnprintf(buf, PAGE_SIZE, "%d\n", val);
 
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return len;
 }
 
 static ssize_t writeback_limit_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 	u64 val;
-	ssize_t ret = -EINVAL;
 
 	if (kstrtoull(buf, 10, &val))
-		return ret;
+		return -EINVAL;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->bd_wb_limit = val;
 	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
-	ret = len;
 
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
-	return ret;
+	return len;
 }
 
 static ssize_t writeback_limit_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	u64 val;
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
+	int len;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	val = zram->bd_wb_limit;
 	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
+	len = scnprintf(buf, PAGE_SIZE, "%llu\n", val);
 
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+	return len;
 }
 
 static void reset_bdev(struct zram *zram)
@@ -470,13 +553,20 @@ static ssize_t backing_dev_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct file *file;
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 	char *p;
 	ssize_t ret;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		ret = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	file = zram->backing_dev;
 	if (!file) {
@@ -496,6 +586,8 @@ static ssize_t backing_dev_show(struct device *dev,
 	buf[ret++] = '\n';
 out:
 	up_read(&zram->init_lock);
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -512,11 +604,18 @@ static ssize_t backing_dev_store(struct device *dev,
 	unsigned long nr_pages, *bitmap = NULL;
 	struct block_device *bdev = NULL;
 	int err;
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		err = -ENODEV;
+		goto out_module;
+	}
+
+	zram = dev_to_zram(dev);
+
 	file_name = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!file_name) {
 		err = -ENOMEM;
@@ -589,6 +688,7 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	pr_info("setup backing device %s\n", file_name);
 	kfree(file_name);
+	bdput(dev_to_bdev(dev));
 	module_put(THIS_MODULE);
 
 	return len;
@@ -604,6 +704,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	up_write(&zram->init_lock);
 
 	kfree(file_name);
+	bdput(dev_to_bdev(dev));
 out_module:
 	module_put(THIS_MODULE);
 	return err;
@@ -684,8 +785,8 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
-	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	struct zram *zram;
+	unsigned long nr_pages;
 	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
@@ -697,6 +798,14 @@ static ssize_t writeback_store(struct device *dev,
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		ret = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	if (sysfs_streq(buf, "idle"))
 		mode = IDLE_WRITEBACK;
 	else if (sysfs_streq(buf, "huge"))
@@ -849,6 +958,8 @@ static ssize_t writeback_store(struct device *dev,
 release_init_lock:
 	up_read(&zram->init_lock);
 out:
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
 	return ret;
@@ -1057,15 +1168,24 @@ static ssize_t comp_algorithm_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	size_t sz;
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		sz = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	sz = zcomp_available_show(zram->compressor, buf);
 	up_read(&zram->init_lock);
 
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
 	return sz;
@@ -1074,7 +1194,7 @@ static ssize_t comp_algorithm_show(struct device *dev,
 static ssize_t comp_algorithm_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 	char compressor[ARRAY_SIZE(zram->compressor)];
 	size_t sz;
 
@@ -1090,6 +1210,13 @@ static ssize_t comp_algorithm_store(struct device *dev,
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_write(&zram->init_lock);
 	if (init_done(zram)) {
 		pr_info("Can't change algorithm for initialized device\n");
@@ -1100,6 +1227,8 @@ static ssize_t comp_algorithm_store(struct device *dev,
 	strcpy(zram->compressor, compressor);
 out:
 	up_write(&zram->init_lock);
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 	return len;
 }
@@ -1107,11 +1236,18 @@ static ssize_t comp_algorithm_store(struct device *dev,
 static ssize_t compact_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	if (!init_done(zram)) {
 		len = -EINVAL;
@@ -1121,6 +1257,8 @@ static ssize_t compact_store(struct device *dev,
 	zs_compact(zram->mem_pool);
 out:
 	up_read(&zram->init_lock);
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
 	return len;
@@ -1135,6 +1273,13 @@ static ssize_t io_stat_show(struct device *dev,
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		ret = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
 			"%8llu %8llu %8llu %8llu\n",
@@ -1143,6 +1288,8 @@ static ssize_t io_stat_show(struct device *dev,
 			(u64)atomic64_read(&zram->stats.invalid_io),
 			(u64)atomic64_read(&zram->stats.notify_free));
 	up_read(&zram->init_lock);
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
 	return ret;
@@ -1151,7 +1298,7 @@ static ssize_t io_stat_show(struct device *dev,
 static ssize_t mm_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 	struct zs_pool_stats pool_stats;
 	u64 orig_size, mem_used = 0;
 	long max_used;
@@ -1162,6 +1309,13 @@ static ssize_t mm_stat_show(struct device *dev,
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		ret = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	if (init_done(zram)) {
 		mem_used = zs_get_total_pages(zram->mem_pool);
@@ -1183,6 +1337,8 @@ static ssize_t mm_stat_show(struct device *dev,
 			(u64)atomic64_read(&zram->stats.huge_pages),
 			(u64)atomic64_read(&zram->stats.huge_pages_since));
 	up_read(&zram->init_lock);
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
 	return ret;
@@ -1193,12 +1349,19 @@ static ssize_t mm_stat_show(struct device *dev,
 static ssize_t bd_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 	ssize_t ret;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		ret = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
 		"%8llu %8llu %8llu\n",
@@ -1206,7 +1369,8 @@ static ssize_t bd_stat_show(struct device *dev,
 			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
 			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
 	up_read(&zram->init_lock);
-
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 	return ret;
 }
@@ -1216,12 +1380,19 @@ static ssize_t debug_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	int version = 1;
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 	ssize_t ret;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		ret = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
 			"version: %d\n%8llu %8llu\n",
@@ -1229,7 +1400,8 @@ static ssize_t debug_stat_show(struct device *dev,
 			(u64)atomic64_read(&zram->stats.writestall),
 			(u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
-
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	module_put(THIS_MODULE);
 
 	return ret;
@@ -1825,7 +1997,7 @@ static ssize_t disksize_store(struct device *dev,
 {
 	u64 disksize;
 	struct zcomp *comp;
-	struct zram *zram = dev_to_zram(dev);
+	struct zram *zram;
 	int err;
 
 	if (!try_module_get(THIS_MODULE))
@@ -1833,6 +2005,13 @@ static ssize_t disksize_store(struct device *dev,
 
 	mutex_lock(&zram_index_mutex);
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		err = -ENODEV;
+		goto out_nodev;
+	}
+
+	zram = dev_to_zram(dev);
+
 	if (!zram_up || zram->claim) {
 		err = -ENODEV;
 		goto out;
@@ -1880,6 +2059,8 @@ static ssize_t disksize_store(struct device *dev,
 out_unlock:
 	up_write(&zram->init_lock);
 out:
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	mutex_unlock(&zram_index_mutex);
 	module_put(THIS_MODULE);
 	return err;
@@ -1902,6 +2083,11 @@ static ssize_t reset_store(struct device *dev,
 
 	mutex_lock(&zram_index_mutex);
 
+	if (!bdgrab(dev_to_bdev(dev))) {
+		len = -ENODEV;
+		goto out_nodev;
+	}
+
 	if (!zram_up) {
 		len = -ENODEV;
 		goto out;
@@ -1936,6 +2122,8 @@ static ssize_t reset_store(struct device *dev,
 	mutex_unlock(&bdev->bd_mutex);
 
 out:
+	bdput(dev_to_bdev(dev));
+out_nodev:
 	mutex_unlock(&zram_index_mutex);
 	module_put(THIS_MODULE);
 	return len;
-- 
2.27.0

