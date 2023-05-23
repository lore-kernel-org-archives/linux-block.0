Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC6EC7EE2F
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 21:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbjEWVqi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 17:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbjEWVqh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB63E6
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urKOvi6UOfSDXUeVkbCVDUoA/uyj8/kt3m1bl3zK/BQ=;
        b=Ks1Si2zYSvJ6RXxUvRASPPL1J1q92cWg5ypGV89fTzWIq2ruwIjQBM8w3GlWaa3fJBJmFT
        v0xH5tOL9YHkBYYg4j50Rv8g6Xm9X27dTtri46ffDWbnz5G6CPM2ATFhY8oWUaprdWh5/C
        q4EByrVa3VmTbZ9YHs8DDowMqmsWFS8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-V9XzHXcZMCiUD-506DT70Q-1; Tue, 23 May 2023 17:45:50 -0400
X-MC-Unique: V9XzHXcZMCiUD-506DT70Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b11909381so66600585a.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878350; x=1687470350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urKOvi6UOfSDXUeVkbCVDUoA/uyj8/kt3m1bl3zK/BQ=;
        b=Be/Xkivi+tdBbt0BF5P0A2peN4zFmNgDXEP+UEaKyuX5N38s8JttgBPBVPgo1Nn//i
         ponHcB65H+AiQWXumSRM9fx2dsOoeA1B6jY0H8jjsSpNGbIZtYqeNIzIdw3m2W0UZ5b+
         Lw3EWVE0n9MTI74DQYedjv8BdM1kNJCvm/mrBkjw6F574nCuAHsXpOZDWeksXvccK2rG
         HfEtzP10W1l5hwDPejSdzq49gtqT3ix6CKUFym1gqha2ERx/DihWASiSGiIjRzEbTruX
         jFkjl7YkH61hFE5CQGDKdf0XEMe570ViG/bG1htOxg9w9CVcdjqYgcAcj/mDwwGEUwTv
         FSMQ==
X-Gm-Message-State: AC+VfDwwSRYHLoFFGvYTsR7WctlGT8Qr66vz3200wTv/1vkfYGJSvpzS
        iAWkK/CDmruKtoRvy9dWCUmqc+g7KPBWBaLNKvTGqtUghrsbBDjw5vRyQxWrQ+UZ2aw/2GOpaGH
        9PuNMuceTXDYQh/amSCIYbXrW/MQKHzA=
X-Received: by 2002:a37:58f:0:b0:75b:23a1:3615 with SMTP id 137-20020a37058f000000b0075b23a13615mr5015351qkf.38.1684878349376;
        Tue, 23 May 2023 14:45:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Ak4lDBwVfxSsnceXjWH7ezsY/9t88N9uUiPDE4p8w/1IDS20Jlw2kT0KVYJ7E4GMv2ZzmLQ==
X-Received: by 2002:a37:58f:0:b0:75b:23a1:3615 with SMTP id 137-20020a37058f000000b0075b23a13615mr5015325qkf.38.1684878348939;
        Tue, 23 May 2023 14:45:48 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id s24-20020ae9f718000000b0074fafbea974sm2821592qkg.2.2023.05.23.14.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:45:48 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 03/39] Add memory allocation utilities.
Date:   Tue, 23 May 2023 17:45:03 -0400
Message-Id: <20230523214539.226387-4-corwin@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523214539.226387-1-corwin@redhat.com>
References: <20230523214539.226387-1-corwin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds standardized allocation macros and memory tracking tools to
track and report any allocated memory that is not freed. This makes it
easier to ensure that the vdo target does not leak memory.

This patch also adds utilities for controlling whether certain threads are
allowed to allocate memory, since memory allocation during certain critical
code sections can cause the vdo target to deadlock.

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/dm-vdo/memory-alloc.c | 447 +++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/memory-alloc.h | 181 +++++++++++++
 2 files changed, 628 insertions(+)
 create mode 100644 drivers/md/dm-vdo/memory-alloc.c
 create mode 100644 drivers/md/dm-vdo/memory-alloc.h

diff --git a/drivers/md/dm-vdo/memory-alloc.c b/drivers/md/dm-vdo/memory-alloc.c
new file mode 100644
index 00000000000..00b992e96bd
--- /dev/null
+++ b/drivers/md/dm-vdo/memory-alloc.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include <linux/delay.h>
+#include <linux/mm.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "logger.h"
+#include "memory-alloc.h"
+#include "permassert.h"
+
+/*
+ * UDS and VDO keep track of which threads are allowed to allocate memory freely, and which threads
+ * must be careful to not do a memory allocation that does an I/O request. The allocating_threads
+ * threads_registry and its associated methods implement this tracking.
+ */
+static struct thread_registry allocating_threads;
+
+static bool allocations_allowed(void)
+{
+	const bool *pointer = uds_lookup_thread(&allocating_threads);
+
+	return (pointer != NULL) ? *pointer : false;
+}
+
+/*
+ * Register the current thread as an allocating thread.
+ *
+ * An optional flag location can be supplied indicating whether, at any given point in time, the
+ * threads associated with that flag should be allocating storage. If the flag is false, a message
+ * will be logged.
+ *
+ * If no flag is supplied, the thread is always allowed to allocate storage without complaint.
+ *
+ * @new_thread: registered_thread structure to use for the current thread
+ * @flag_ptr: Location of the allocation-allowed flag
+ */
+void uds_register_allocating_thread(struct registered_thread *new_thread, const bool *flag_ptr)
+{
+	if (flag_ptr == NULL) {
+		static const bool allocation_always_allowed = true;
+
+		flag_ptr = &allocation_always_allowed;
+	}
+
+	uds_register_thread(&allocating_threads, new_thread, flag_ptr);
+}
+
+/* Unregister the current thread as an allocating thread. */
+void uds_unregister_allocating_thread(void)
+{
+	uds_unregister_thread(&allocating_threads);
+}
+
+/*
+ * We track how much memory has been allocated and freed. When we unload the module, we log an
+ * error if we have not freed all the memory that we allocated. Nearly all memory allocation and
+ * freeing is done using this module.
+ *
+ * We do not use kernel functions like the kvasprintf() method, which allocate memory indirectly
+ * using kmalloc.
+ *
+ * These data structures and methods are used to track the amount of memory used.
+ */
+
+/*
+ * We allocate very few large objects, and allocation/deallocation isn't done in a
+ * performance-critical stage for us, so a linked list should be fine.
+ */
+struct vmalloc_block_info {
+	void *ptr;
+	size_t size;
+	struct vmalloc_block_info *next;
+};
+
+static struct {
+	spinlock_t lock;
+	size_t kmalloc_blocks;
+	size_t kmalloc_bytes;
+	size_t vmalloc_blocks;
+	size_t vmalloc_bytes;
+	size_t peak_bytes;
+	struct vmalloc_block_info *vmalloc_list;
+} memory_stats __cacheline_aligned;
+
+static void update_peak_usage(void)
+{
+	size_t total_bytes = memory_stats.kmalloc_bytes + memory_stats.vmalloc_bytes;
+
+	if (total_bytes > memory_stats.peak_bytes)
+		memory_stats.peak_bytes = total_bytes;
+}
+
+static void add_kmalloc_block(size_t size)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&memory_stats.lock, flags);
+	memory_stats.kmalloc_blocks++;
+	memory_stats.kmalloc_bytes += size;
+	update_peak_usage();
+	spin_unlock_irqrestore(&memory_stats.lock, flags);
+}
+
+static void remove_kmalloc_block(size_t size)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&memory_stats.lock, flags);
+	memory_stats.kmalloc_blocks--;
+	memory_stats.kmalloc_bytes -= size;
+	spin_unlock_irqrestore(&memory_stats.lock, flags);
+}
+
+static void add_vmalloc_block(struct vmalloc_block_info *block)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&memory_stats.lock, flags);
+	block->next = memory_stats.vmalloc_list;
+	memory_stats.vmalloc_list = block;
+	memory_stats.vmalloc_blocks++;
+	memory_stats.vmalloc_bytes += block->size;
+	update_peak_usage();
+	spin_unlock_irqrestore(&memory_stats.lock, flags);
+}
+
+static void remove_vmalloc_block(void *ptr)
+{
+	struct vmalloc_block_info *block;
+	struct vmalloc_block_info **block_ptr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&memory_stats.lock, flags);
+	for (block_ptr = &memory_stats.vmalloc_list;
+	     (block = *block_ptr) != NULL;
+	     block_ptr = &block->next) {
+		if (block->ptr == ptr) {
+			*block_ptr = block->next;
+			memory_stats.vmalloc_blocks--;
+			memory_stats.vmalloc_bytes -= block->size;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&memory_stats.lock, flags);
+	if (block != NULL)
+		UDS_FREE(block);
+	else
+		uds_log_info("attempting to remove ptr %px not found in vmalloc list", ptr);
+}
+
+/*
+ * Determine whether allocating a memory block should use kmalloc or __vmalloc.
+ *
+ * vmalloc can allocate any integral number of pages.
+ *
+ * kmalloc can allocate any number of bytes up to a configured limit, which defaults to 8 megabytes
+ * on some systems. kmalloc is especially good when memory is being both allocated and freed, and
+ * it does this efficiently in a multi CPU environment.
+ *
+ * kmalloc usually rounds the size of the block up to the next power of two, so when the requested
+ * block is bigger than PAGE_SIZE / 2 bytes, kmalloc will never give you less space than the
+ * corresponding vmalloc allocation. Sometimes vmalloc will use less overhead than kmalloc.
+ *
+ * The advantages of kmalloc do not help out UDS or VDO, because we allocate all our memory up
+ * front and do not free and reallocate it. Sometimes we have problems using kmalloc, because the
+ * Linux memory page map can become so fragmented that kmalloc will not give us a 32KB chunk. We
+ * have used vmalloc as a backup to kmalloc in the past, and a follow-up vmalloc of 32KB will work.
+ * But there is no strong case to be made for using kmalloc over vmalloc for these size chunks.
+ *
+ * The kmalloc/vmalloc boundary is set at 4KB, and kmalloc gets the 4KB requests. There is no
+ * strong reason for favoring either kmalloc or vmalloc for 4KB requests, except that tracking
+ * vmalloc statistics uses a linked list implementation. Using a simple test, this choice of
+ * boundary results in 132 vmalloc calls. Using vmalloc for requests of exactly 4KB results in an
+ * additional 6374 vmalloc calls, which is much less efficient for tracking.
+ *
+ * @size: How many bytes to allocate
+ */
+static inline bool use_kmalloc(size_t size)
+{
+	return size <= PAGE_SIZE;
+}
+
+/*
+ * Allocate storage based on memory size and alignment, logging an error if the allocation fails.
+ * The memory will be zeroed.
+ *
+ * @size: The size of an object
+ * @align: The required alignment
+ * @what: What is being allocated (for error logging)
+ * @ptr: A pointer to hold the allocated memory
+ *
+ * Return: UDS_SUCCESS or an error code
+ */
+int uds_allocate_memory(size_t size, size_t align, const char *what, void *ptr)
+{
+	/*
+	 * The __GFP_RETRY_MAYFAIL flag means the VM implementation will retry memory reclaim
+	 * procedures that have previously failed if there is some indication that progress has
+	 * been made elsewhere. It can wait for other tasks to attempt high level approaches to
+	 * freeing memory such as compaction (which removes fragmentation) and page-out. There is
+	 * still a definite limit to the number of retries, but it is a larger limit than with
+	 * __GFP_NORETRY. Allocations with this flag may fail, but only when there is genuinely
+	 * little unused memory. While these allocations do not directly trigger the OOM killer,
+	 * their failure indicates that the system is likely to need to use the OOM killer soon.
+	 * The caller must handle failure, but can reasonably do so by failing a higher-level
+	 * request, or completing it only in a much less efficient manner.
+	 */
+	const gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL;
+	unsigned int noio_flags;
+	bool allocations_restricted = !allocations_allowed();
+	unsigned long start_time;
+	void *p = NULL;
+
+	if (ptr == NULL)
+		return UDS_INVALID_ARGUMENT;
+
+	if (size == 0) {
+		*((void **) ptr) = NULL;
+		return UDS_SUCCESS;
+	}
+
+	if (allocations_restricted)
+		noio_flags = memalloc_noio_save();
+
+	start_time = jiffies;
+	if (use_kmalloc(size) && (align < PAGE_SIZE)) {
+		p = kmalloc(size, gfp_flags | __GFP_NOWARN);
+		if (p == NULL) {
+			/*
+			 * It is possible for kmalloc to fail to allocate memory because there is
+			 * no page available (see VDO-3688). A short sleep may allow the page
+			 * reclaimer to free a page.
+			 */
+			fsleep(1000);
+			p = kmalloc(size, gfp_flags);
+		}
+
+		if (p != NULL)
+			add_kmalloc_block(ksize(p));
+	} else {
+		struct vmalloc_block_info *block;
+
+		if (UDS_ALLOCATE(1, struct vmalloc_block_info, __func__, &block) ==
+		    UDS_SUCCESS) {
+			/*
+			 * It is possible for __vmalloc to fail to allocate memory because there
+			 * are no pages available (see VDO-3661). A short sleep may allow the page
+			 * reclaimer to free enough pages for a small allocation.
+			 *
+			 * For larger allocations, the page_alloc code is racing against the page
+			 * reclaimer. If the page reclaimer can stay ahead of page_alloc, the
+			 * __vmalloc will succeed. But if page_alloc overtakes the page reclaimer,
+			 * the allocation fails. It is possible that more retries will succeed.
+			 */
+			for (;;) {
+				p = __vmalloc(size, gfp_flags | __GFP_NOWARN);
+
+				if (p != NULL)
+					break;
+
+				if (jiffies_to_msecs(jiffies - start_time) > 1000) {
+					/* Try one more time, logging a failure for this call. */
+					p = __vmalloc(size, gfp_flags);
+					break;
+				}
+
+				fsleep(1000);
+			}
+
+			if (p == NULL) {
+				UDS_FREE(block);
+			} else {
+				block->ptr = p;
+				block->size = PAGE_ALIGN(size);
+				add_vmalloc_block(block);
+			}
+		}
+	}
+
+	if (allocations_restricted)
+		memalloc_noio_restore(noio_flags);
+
+	if (p == NULL) {
+		unsigned int duration = jiffies_to_msecs(jiffies - start_time);
+
+		uds_log_error("Could not allocate %zu bytes for %s in %u msecs",
+			      size,
+			      what,
+			      duration);
+		return -ENOMEM;
+	}
+
+	*((void **) ptr) = p;
+	return UDS_SUCCESS;
+}
+
+/*
+ * Allocate storage based on memory size, failing immediately if the required memory is not
+ * available. The memory will be zeroed.
+ *
+ * @size: The size of an object.
+ * @what: What is being allocated (for error logging)
+ *
+ * Return: pointer to the allocated memory, or NULL if the required space is not available.
+ */
+void *uds_allocate_memory_nowait(size_t size, const char *what __maybe_unused)
+{
+	void *p = kmalloc(size, GFP_NOWAIT | __GFP_ZERO);
+
+	if (p != NULL)
+		add_kmalloc_block(ksize(p));
+
+	return p;
+}
+
+void uds_free_memory(void *ptr)
+{
+	if (ptr != NULL) {
+		if (is_vmalloc_addr(ptr)) {
+			remove_vmalloc_block(ptr);
+			vfree(ptr);
+		} else {
+			remove_kmalloc_block(ksize(ptr));
+			kfree(ptr);
+		}
+	}
+}
+
+/*
+ * Reallocate dynamically allocated memory. There are no alignment guarantees for the reallocated
+ * memory. If the new memory is larger than the old memory, the new space will be zeroed.
+ *
+ * @ptr: The memory to reallocate.
+ * @old_size: The old size of the memory
+ * @size: The new size to allocate
+ * @what: What is being allocated (for error logging)
+ * @new_ptr: A pointer to hold the reallocated pointer
+ *
+ * Return: UDS_SUCCESS or an error code
+ */
+int uds_reallocate_memory(void *ptr, size_t old_size, size_t size, const char *what, void *new_ptr)
+{
+	int result;
+
+	if (size == 0) {
+		UDS_FREE(ptr);
+		*(void **) new_ptr = NULL;
+		return UDS_SUCCESS;
+	}
+
+	result = UDS_ALLOCATE(size, char, what, new_ptr);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	if (ptr != NULL) {
+		if (old_size < size)
+			size = old_size;
+
+		memcpy(*((void **) new_ptr), ptr, size);
+		UDS_FREE(ptr);
+	}
+
+	return UDS_SUCCESS;
+}
+
+int uds_duplicate_string(const char *string, const char *what, char **new_string)
+{
+	int result;
+	u8 *dup;
+
+	result = UDS_ALLOCATE(strlen(string) + 1, u8, what, &dup);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	memcpy(dup, string, strlen(string) + 1);
+	*new_string = dup;
+	return UDS_SUCCESS;
+}
+
+void uds_memory_init(void)
+{
+	spin_lock_init(&memory_stats.lock);
+	uds_initialize_thread_registry(&allocating_threads);
+}
+
+void uds_memory_exit(void)
+{
+	ASSERT_LOG_ONLY(memory_stats.kmalloc_bytes == 0,
+			"kmalloc memory used (%zd bytes in %zd blocks) is returned to the kernel",
+			memory_stats.kmalloc_bytes,
+			memory_stats.kmalloc_blocks);
+	ASSERT_LOG_ONLY(memory_stats.vmalloc_bytes == 0,
+			"vmalloc memory used (%zd bytes in %zd blocks) is returned to the kernel",
+			memory_stats.vmalloc_bytes,
+			memory_stats.vmalloc_blocks);
+	uds_log_debug("peak usage %zd bytes", memory_stats.peak_bytes);
+}
+
+void uds_get_memory_stats(u64 *bytes_used, u64 *peak_bytes_used)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&memory_stats.lock, flags);
+	*bytes_used = memory_stats.kmalloc_bytes + memory_stats.vmalloc_bytes;
+	*peak_bytes_used = memory_stats.peak_bytes;
+	spin_unlock_irqrestore(&memory_stats.lock, flags);
+}
+
+/*
+ * Report stats on any allocated memory that we're tracking. Not all allocation types are
+ * guaranteed to be tracked in bytes (e.g., bios).
+ */
+void uds_report_memory_usage(void)
+{
+	unsigned long flags;
+	u64 kmalloc_blocks;
+	u64 kmalloc_bytes;
+	u64 vmalloc_blocks;
+	u64 vmalloc_bytes;
+	u64 peak_usage;
+	u64 total_bytes;
+
+	spin_lock_irqsave(&memory_stats.lock, flags);
+	kmalloc_blocks = memory_stats.kmalloc_blocks;
+	kmalloc_bytes = memory_stats.kmalloc_bytes;
+	vmalloc_blocks = memory_stats.vmalloc_blocks;
+	vmalloc_bytes = memory_stats.vmalloc_bytes;
+	peak_usage = memory_stats.peak_bytes;
+	spin_unlock_irqrestore(&memory_stats.lock, flags);
+	total_bytes = kmalloc_bytes + vmalloc_bytes;
+	uds_log_info("current module memory tracking (actual allocation sizes, not requested):");
+	uds_log_info("  %llu bytes in %llu kmalloc blocks",
+		     (unsigned long long) kmalloc_bytes,
+		     (unsigned long long) kmalloc_blocks);
+	uds_log_info("  %llu bytes in %llu vmalloc blocks",
+		     (unsigned long long) vmalloc_bytes,
+		     (unsigned long long) vmalloc_blocks);
+	uds_log_info("  total %llu bytes, peak usage %llu bytes",
+		     (unsigned long long) total_bytes,
+		     (unsigned long long) peak_usage);
+}
diff --git a/drivers/md/dm-vdo/memory-alloc.h b/drivers/md/dm-vdo/memory-alloc.h
new file mode 100644
index 00000000000..2ea2464326d
--- /dev/null
+++ b/drivers/md/dm-vdo/memory-alloc.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef UDS_MEMORY_ALLOC_H
+#define UDS_MEMORY_ALLOC_H
+
+#include <linux/cache.h>
+#include <linux/io.h> /* for PAGE_SIZE */
+
+#include "permassert.h"
+#include "thread-registry.h"
+
+/* Custom memory allocation functions for UDS that track memory usage */
+
+int __must_check uds_allocate_memory(size_t size, size_t align, const char *what, void *ptr);
+
+void uds_free_memory(void *ptr);
+
+/* Free memory allocated with UDS_ALLOCATE(). */
+#define UDS_FREE(PTR) uds_free_memory(PTR)
+
+static inline void *uds_forget(void **ptr_ptr)
+{
+	void *ptr = *ptr_ptr;
+
+	*ptr_ptr = NULL;
+	return ptr;
+}
+
+/*
+ * Null out a pointer and return a copy to it. This macro should be used when passing a pointer to
+ * a function for which it is not safe to access the pointer once the function returns.
+ */
+#define UDS_FORGET(ptr) uds_forget((void **) &(ptr))
+
+/*
+ * Allocate storage based on element counts, sizes, and alignment.
+ *
+ * This is a generalized form of our allocation use case: It allocates an array of objects,
+ * optionally preceded by one object of another type (i.e., a struct with trailing variable-length
+ * array), with the alignment indicated.
+ *
+ * Why is this inline? The sizes and alignment will always be constant, when invoked through the
+ * macros below, and often the count will be a compile-time constant 1 or the number of extra bytes
+ * will be a compile-time constant 0. So at least some of the arithmetic can usually be optimized
+ * away, and the run-time selection between allocation functions always can. In many cases, it'll
+ * boil down to just a function call with a constant size.
+ *
+ * @count: The number of objects to allocate
+ * @size: The size of an object
+ * @extra: The number of additional bytes to allocate
+ * @align: The required alignment
+ * @what: What is being allocated (for error logging)
+ * @ptr: A pointer to hold the allocated memory
+ *
+ * Return: UDS_SUCCESS or an error code
+ */
+static inline int uds_do_allocation(size_t count,
+				    size_t size,
+				    size_t extra,
+				    size_t align,
+				    const char *what,
+				    void *ptr)
+{
+	size_t total_size = count * size + extra;
+
+	/* Overflow check: */
+	if ((size > 0) && (count > ((SIZE_MAX - extra) / size)))
+		/*
+		 * This is kind of a hack: We rely on the fact that SIZE_MAX would cover the entire
+		 * address space (minus one byte) and thus the system can never allocate that much
+		 * and the call will always fail. So we can report an overflow as "out of memory"
+		 * by asking for "merely" SIZE_MAX bytes.
+		 */
+		total_size = SIZE_MAX;
+
+	return uds_allocate_memory(total_size, align, what, ptr);
+}
+
+int __must_check uds_reallocate_memory(void *ptr,
+				       size_t old_size,
+				       size_t size,
+				       const char *what,
+				       void *new_ptr);
+
+/*
+ * Allocate one or more elements of the indicated type, logging an error if the allocation fails.
+ * The memory will be zeroed.
+ *
+ * @COUNT: The number of objects to allocate
+ * @TYPE: The type of objects to allocate. This type determines the alignment of the allocation.
+ * @WHAT: What is being allocated (for error logging)
+ * @PTR: A pointer to hold the allocated memory
+ *
+ * Return: UDS_SUCCESS or an error code
+ */
+#define UDS_ALLOCATE(COUNT, TYPE, WHAT, PTR) \
+	uds_do_allocation(COUNT, sizeof(TYPE), 0, __alignof__(TYPE), WHAT, PTR)
+
+/*
+ * Allocate one object of an indicated type, followed by one or more elements of a second type,
+ * logging an error if the allocation fails. The memory will be zeroed.
+ *
+ * @TYPE1: The type of the primary object to allocate. This type determines the alignment of the
+ *         allocated memory.
+ * @COUNT: The number of objects to allocate
+ * @TYPE2: The type of array objects to allocate
+ * @WHAT: What is being allocated (for error logging)
+ * @PTR: A pointer to hold the allocated memory
+ *
+ * Return: UDS_SUCCESS or an error code
+ */
+#define UDS_ALLOCATE_EXTENDED(TYPE1, COUNT, TYPE2, WHAT, PTR)            \
+	__extension__({                                                  \
+		int _result;						 \
+		TYPE1 **_ptr = (PTR);                                    \
+		STATIC_ASSERT(__alignof__(TYPE1) >= __alignof__(TYPE2)); \
+		_result = uds_do_allocation(COUNT,                       \
+					    sizeof(TYPE2),               \
+					    sizeof(TYPE1),               \
+					    __alignof__(TYPE1),          \
+					    WHAT,                        \
+					    _ptr);                       \
+		_result;                                                 \
+	})
+
+/*
+ * Allocate memory starting on a cache line boundary, logging an error if the allocation fails. The
+ * memory will be zeroed.
+ *
+ * @size: The number of bytes to allocate
+ * @what: What is being allocated (for error logging)
+ * @ptr: A pointer to hold the allocated memory
+ *
+ * Return: UDS_SUCCESS or an error code
+ */
+static inline int __must_check uds_allocate_cache_aligned(size_t size, const char *what, void *ptr)
+{
+	return uds_allocate_memory(size, L1_CACHE_BYTES, what, ptr);
+}
+
+void *__must_check uds_allocate_memory_nowait(size_t size, const char *what);
+
+/*
+ * Allocate one element of the indicated type immediately, failing if the required memory is not
+ * immediately available.
+ *
+ * @TYPE: The type of objects to allocate
+ * @WHAT: What is being allocated (for error logging)
+ *
+ * Return: pointer to the memory, or NULL if the memory is not available.
+ */
+#define UDS_ALLOCATE_NOWAIT(TYPE, WHAT) uds_allocate_memory_nowait(sizeof(TYPE), WHAT)
+
+int __must_check uds_duplicate_string(const char *string, const char *what, char **new_string);
+
+/* Wrapper which permits freeing a const pointer. */
+static inline void uds_free_const(const void *pointer)
+{
+	union {
+		const void *const_p;
+		void *not_const;
+	} u = { .const_p = pointer };
+	UDS_FREE(u.not_const);
+}
+
+void uds_memory_exit(void);
+
+void uds_memory_init(void);
+
+void uds_register_allocating_thread(struct registered_thread *new_thread, const bool *flag_ptr);
+
+void uds_unregister_allocating_thread(void);
+
+void uds_get_memory_stats(u64 *bytes_used, u64 *peak_bytes_used);
+
+void uds_report_memory_usage(void);
+
+#endif /* UDS_MEMORY_ALLOC_H */
-- 
2.40.1

