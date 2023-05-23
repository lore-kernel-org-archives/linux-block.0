Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5913DC7EE29
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 21:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbjEWVqq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 17:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbjEWVqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0883
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oNpJxhRu/BYR95GzYX7kST7xxmN/d7fCcivhyBaDiCw=;
        b=V/y62g+bDT2XW8+qbEAJJk8xQkhnibBE0WxVdIoP0fN+q6kIDqb9MfW1RAsLa2s5bDvATK
        b0EBSSZ1j+KJ9bN7bWbIntWggtMcEMAYTjX4nx0BVSavrqPkPOnlGB4m8n+2ZbNRf2sh9H
        eT5GIhlOKFCqLhvFFw37AcwZ1c4CouM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-wKZzNxFlO9GgfqI0Ytoe6g-1; Tue, 23 May 2023 17:45:53 -0400
X-MC-Unique: wKZzNxFlO9GgfqI0Ytoe6g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-624b4176bf7so912676d6.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878352; x=1687470352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNpJxhRu/BYR95GzYX7kST7xxmN/d7fCcivhyBaDiCw=;
        b=Cb4YGWtjkbPIr8o7c3Da7IWkXMMOodXyHopeCBygwr/rv/fKpASLzEAfhuov9IheT0
         /7zs7jLT13WRnFsLRAtJUDYA/PQVVrkAd2EDMFl5eBV4deeaYtCMClh+GloVKZPch1Lm
         s5VVMB79bsSyjtJvv1nj79dzKrwZfLX+U3aaoxoOUmKXxznIHo0xeoe7crAI2N6NxjUc
         GOoS/h1ys2imQRB+4y400pcSNi1NaGIWHPU1b3XCGw8qkohVn6maAF5pyQei21drDj0t
         Jjifbvv3l3hY054E+bSglshUhRuV9eld5NFeAZs2lqa+XuavQSftuQ1WJ0gUOk/BlSGh
         YWpw==
X-Gm-Message-State: AC+VfDzwzr5fvpD8l5+qk2eydwu6UG4NYKs4cNQGCnToYdr1f0WNoPSk
        S0Cq0cPMi5p8sGWSGprzNqIP2TMI6hXslaofPojKuKexVBC7sj8ECetUI3Yqwjtfz8fchKPvsA7
        rnUV2sWcg/2oz6NLjRHwS1bg=
X-Received: by 2002:ae9:e80b:0:b0:75b:23a0:d9d3 with SMTP id a11-20020ae9e80b000000b0075b23a0d9d3mr5235745qkg.41.1684878352246;
        Tue, 23 May 2023 14:45:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ojvbKlGoQVYVDoeiIsNNJgyowS6OFaR2eaZrq9KsLhBmm7K56Js9msMYH/E8KmGSy74yjYQ==
X-Received: by 2002:ae9:e80b:0:b0:75b:23a0:d9d3 with SMTP id a11-20020ae9e80b000000b0075b23a0d9d3mr5235731qkg.41.1684878351865;
        Tue, 23 May 2023 14:45:51 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id s24-20020ae9f718000000b0074fafbea974sm2821592qkg.2.2023.05.23.14.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:45:51 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 06/39] Add thread and synchronization utilities.
Date:   Tue, 23 May 2023 17:45:06 -0400
Message-Id: <20230523214539.226387-7-corwin@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523214539.226387-1-corwin@redhat.com>
References: <20230523214539.226387-1-corwin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds utilities for managing and using named threads, as well as
several locking and sychronization utilities. These utilities help dm-vdo
minimize thread transitions nad manage cross-thread interations.

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/dm-vdo/thread-cond-var.c |  46 +++++++
 drivers/md/dm-vdo/thread-device.c   |  35 ++++++
 drivers/md/dm-vdo/thread-device.h   |  19 +++
 drivers/md/dm-vdo/thread-registry.c |  93 ++++++++++++++
 drivers/md/dm-vdo/thread-registry.h |  33 +++++
 drivers/md/dm-vdo/uds-threads.c     | 189 ++++++++++++++++++++++++++++
 drivers/md/dm-vdo/uds-threads.h     | 126 +++++++++++++++++++
 7 files changed, 541 insertions(+)
 create mode 100644 drivers/md/dm-vdo/thread-cond-var.c
 create mode 100644 drivers/md/dm-vdo/thread-device.c
 create mode 100644 drivers/md/dm-vdo/thread-device.h
 create mode 100644 drivers/md/dm-vdo/thread-registry.c
 create mode 100644 drivers/md/dm-vdo/thread-registry.h
 create mode 100644 drivers/md/dm-vdo/uds-threads.c
 create mode 100644 drivers/md/dm-vdo/uds-threads.h

diff --git a/drivers/md/dm-vdo/thread-cond-var.c b/drivers/md/dm-vdo/thread-cond-var.c
new file mode 100644
index 00000000000..4a3af5d0618
--- /dev/null
+++ b/drivers/md/dm-vdo/thread-cond-var.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include <linux/jiffies.h>
+#include <linux/minmax.h>
+
+#include "errors.h"
+#include "time-utils.h"
+#include "uds-threads.h"
+
+int uds_init_cond(struct cond_var *cv)
+{
+	init_waitqueue_head(&cv->wait_queue);
+	return UDS_SUCCESS;
+}
+
+int uds_signal_cond(struct cond_var *cv)
+{
+	wake_up(&cv->wait_queue);
+	return UDS_SUCCESS;
+}
+
+int uds_broadcast_cond(struct cond_var *cv)
+{
+	wake_up_all(&cv->wait_queue);
+	return UDS_SUCCESS;
+}
+
+int uds_wait_cond(struct cond_var *cv, struct mutex *mutex)
+{
+	DEFINE_WAIT(__wait);
+
+	prepare_to_wait(&cv->wait_queue, &__wait, TASK_IDLE);
+	uds_unlock_mutex(mutex);
+	schedule();
+	finish_wait(&cv->wait_queue, &__wait);
+	uds_lock_mutex(mutex);
+	return UDS_SUCCESS;
+}
+
+int uds_destroy_cond(struct cond_var *cv)
+{
+	return UDS_SUCCESS;
+}
diff --git a/drivers/md/dm-vdo/thread-device.c b/drivers/md/dm-vdo/thread-device.c
new file mode 100644
index 00000000000..906dfd4f617
--- /dev/null
+++ b/drivers/md/dm-vdo/thread-device.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "thread-device.h"
+
+#include "thread-registry.h"
+
+/* A registry of threads associated with device id numbers. */
+static struct thread_registry device_id_thread_registry;
+
+/* Any registered thread must be unregistered. */
+void uds_register_thread_device_id(struct registered_thread *new_thread, unsigned int *id_ptr)
+{
+	uds_register_thread(&device_id_thread_registry, new_thread, id_ptr);
+}
+
+void uds_unregister_thread_device_id(void)
+{
+	uds_unregister_thread(&device_id_thread_registry);
+}
+
+int uds_get_thread_device_id(void)
+{
+	const unsigned int *pointer;
+
+	pointer = uds_lookup_thread(&device_id_thread_registry);
+	return (pointer != NULL) ? *pointer : -1;
+}
+
+void uds_initialize_thread_device_registry(void)
+{
+	uds_initialize_thread_registry(&device_id_thread_registry);
+}
diff --git a/drivers/md/dm-vdo/thread-device.h b/drivers/md/dm-vdo/thread-device.h
new file mode 100644
index 00000000000..c33a16faa38
--- /dev/null
+++ b/drivers/md/dm-vdo/thread-device.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef UDS_THREAD_DEVICE_H
+#define UDS_THREAD_DEVICE_H
+
+#include "thread-registry.h"
+
+void uds_register_thread_device_id(struct registered_thread *new_thread, unsigned int *id_ptr);
+
+void uds_unregister_thread_device_id(void);
+
+int uds_get_thread_device_id(void);
+
+void uds_initialize_thread_device_registry(void);
+
+#endif /* UDS_THREAD_DEVICE_H */
diff --git a/drivers/md/dm-vdo/thread-registry.c b/drivers/md/dm-vdo/thread-registry.c
new file mode 100644
index 00000000000..bdfaf9c2112
--- /dev/null
+++ b/drivers/md/dm-vdo/thread-registry.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "thread-registry.h"
+
+#include <linux/rculist.h>
+
+#include "permassert.h"
+
+/*
+ * We need to be careful when using other facilities that may use thread registry functions in
+ * their normal operation. For example, we do not want to invoke the logger while holding a lock.
+ */
+
+void uds_initialize_thread_registry(struct thread_registry *registry)
+{
+	INIT_LIST_HEAD(&registry->links);
+	spin_lock_init(&registry->lock);
+}
+
+/* Register the current thread and associate it with a data pointer. */
+void uds_register_thread(struct thread_registry *registry,
+			 struct registered_thread *new_thread,
+			 const void *pointer)
+{
+	struct registered_thread *thread;
+	bool found_it = false;
+
+	INIT_LIST_HEAD(&new_thread->links);
+	new_thread->pointer = pointer;
+	new_thread->task = current;
+
+	spin_lock(&registry->lock);
+	list_for_each_entry(thread, &registry->links, links) {
+		if (thread->task == current) {
+			/* There should be no existing entry. */
+			list_del_rcu(&thread->links);
+			found_it = true;
+			break;
+		}
+	}
+	list_add_tail_rcu(&new_thread->links, &registry->links);
+	spin_unlock(&registry->lock);
+
+	ASSERT_LOG_ONLY(!found_it, "new thread not already in registry");
+	if (found_it) {
+		/* Ensure no RCU iterators see it before re-initializing. */
+		synchronize_rcu();
+		INIT_LIST_HEAD(&thread->links);
+	}
+}
+
+void uds_unregister_thread(struct thread_registry *registry)
+{
+	struct registered_thread *thread;
+	bool found_it = false;
+
+	spin_lock(&registry->lock);
+	list_for_each_entry(thread, &registry->links, links) {
+		if (thread->task == current) {
+			list_del_rcu(&thread->links);
+			found_it = true;
+			break;
+		}
+	}
+	spin_unlock(&registry->lock);
+
+	ASSERT_LOG_ONLY(found_it, "thread found in registry");
+	if (found_it) {
+		/* Ensure no RCU iterators see it before re-initializing. */
+		synchronize_rcu();
+		INIT_LIST_HEAD(&thread->links);
+	}
+}
+
+const void *uds_lookup_thread(struct thread_registry *registry)
+{
+	struct registered_thread *thread;
+	const void *result = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(thread, &registry->links, links) {
+		if (thread->task == current) {
+			result = thread->pointer;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return result;
+}
diff --git a/drivers/md/dm-vdo/thread-registry.h b/drivers/md/dm-vdo/thread-registry.h
new file mode 100644
index 00000000000..b5ba1b86558
--- /dev/null
+++ b/drivers/md/dm-vdo/thread-registry.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef UDS_THREAD_REGISTRY_H
+#define UDS_THREAD_REGISTRY_H
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+struct thread_registry {
+	struct list_head links;
+	spinlock_t lock;
+};
+
+struct registered_thread {
+	struct list_head links;
+	const void *pointer;
+	struct task_struct *task;
+};
+
+void uds_initialize_thread_registry(struct thread_registry *registry);
+
+void uds_register_thread(struct thread_registry *registry,
+			 struct registered_thread *new_thread,
+			 const void *pointer);
+
+void uds_unregister_thread(struct thread_registry *registry);
+
+const void *uds_lookup_thread(struct thread_registry *registry);
+
+#endif /* UDS_THREAD_REGISTRY_H */
diff --git a/drivers/md/dm-vdo/uds-threads.c b/drivers/md/dm-vdo/uds-threads.c
new file mode 100644
index 00000000000..55603886064
--- /dev/null
+++ b/drivers/md/dm-vdo/uds-threads.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "uds-threads.h"
+
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#ifndef VDO_UPSTREAM
+#include <linux/version.h>
+#endif /* VDO_UPSTREAM */
+
+#include "errors.h"
+#include "logger.h"
+#include "memory-alloc.h"
+
+static struct hlist_head thread_list;
+static struct mutex thread_mutex;
+static atomic_t thread_once = ATOMIC_INIT(0);
+
+struct thread {
+	void (*thread_function)(void *thread_data);
+	void *thread_data;
+	struct hlist_node thread_links;
+	struct task_struct *thread_task;
+	struct completion thread_done;
+};
+
+enum {
+	ONCE_NOT_DONE = 0,
+	ONCE_IN_PROGRESS = 1,
+	ONCE_COMPLETE = 2,
+};
+
+/* Run a function once only, and record that fact in the atomic value. */
+void uds_perform_once(atomic_t *once, void (*function)(void))
+{
+	for (;;) {
+		switch (atomic_cmpxchg(once, ONCE_NOT_DONE, ONCE_IN_PROGRESS)) {
+		case ONCE_NOT_DONE:
+			function();
+			atomic_set_release(once, ONCE_COMPLETE);
+			return;
+		case ONCE_IN_PROGRESS:
+			cond_resched();
+			break;
+		case ONCE_COMPLETE:
+			return;
+		default:
+			return;
+		}
+	}
+}
+
+static void thread_init(void)
+{
+	mutex_init(&thread_mutex);
+}
+
+static int thread_starter(void *arg)
+{
+	struct registered_thread allocating_thread;
+	struct thread *thread = arg;
+
+	thread->thread_task = current;
+	uds_perform_once(&thread_once, thread_init);
+	mutex_lock(&thread_mutex);
+	hlist_add_head(&thread->thread_links, &thread_list);
+	mutex_unlock(&thread_mutex);
+	uds_register_allocating_thread(&allocating_thread, NULL);
+	thread->thread_function(thread->thread_data);
+	uds_unregister_allocating_thread();
+	complete(&thread->thread_done);
+	return 0;
+}
+
+int uds_create_thread(void (*thread_function)(void *),
+		      void *thread_data,
+		      const char *name,
+		      struct thread **new_thread)
+{
+	char *name_colon = strchr(name, ':');
+	char *my_name_colon = strchr(current->comm, ':');
+	struct task_struct *task;
+	struct thread *thread;
+	int result;
+
+	result = UDS_ALLOCATE(1, struct thread, __func__, &thread);
+	if (result != UDS_SUCCESS) {
+		uds_log_warning("Error allocating memory for %s", name);
+		return result;
+	}
+
+	thread->thread_function = thread_function;
+	thread->thread_data = thread_data;
+	init_completion(&thread->thread_done);
+	/*
+	 * Start the thread, with an appropriate thread name.
+	 *
+	 * If the name supplied contains a colon character, use that name. This causes uds module
+	 * threads to have names like "uds:callbackW" and the main test runner thread to be named
+	 * "zub:runtest".
+	 *
+	 * Otherwise if the current thread has a name containing a colon character, prefix the name
+	 * supplied with the name of the current thread up to (and including) the colon character.
+	 * Thus when the "kvdo0:dedupeQ" thread opens an index session, all the threads associated
+	 * with that index will have names like "kvdo0:foo".
+	 *
+	 * Otherwise just use the name supplied. This should be a rare occurrence.
+	 */
+	if ((name_colon == NULL) && (my_name_colon != NULL))
+		task = kthread_run(thread_starter,
+				   thread,
+				   "%.*s:%s",
+				   (int) (my_name_colon - current->comm),
+				   current->comm,
+				   name);
+	else
+		task = kthread_run(thread_starter, thread, "%s", name);
+
+	if (IS_ERR(task)) {
+		UDS_FREE(thread);
+		return PTR_ERR(task);
+	}
+
+	*new_thread = thread;
+	return UDS_SUCCESS;
+}
+
+int uds_join_threads(struct thread *thread)
+{
+	while (wait_for_completion_interruptible(&thread->thread_done) != 0)
+		/* empty loop */
+		;
+
+	mutex_lock(&thread_mutex);
+	hlist_del(&thread->thread_links);
+	mutex_unlock(&thread_mutex);
+	UDS_FREE(thread);
+	return UDS_SUCCESS;
+}
+
+int uds_initialize_barrier(struct barrier *barrier, unsigned int thread_count)
+{
+	int result;
+
+	result = uds_initialize_semaphore(&barrier->mutex, 1);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	barrier->arrived = 0;
+	barrier->thread_count = thread_count;
+	return uds_initialize_semaphore(&barrier->wait, 0);
+}
+
+int uds_destroy_barrier(struct barrier *barrier)
+{
+	int result;
+
+	result = uds_destroy_semaphore(&barrier->mutex);
+	if (result != UDS_SUCCESS)
+		return result;
+	return uds_destroy_semaphore(&barrier->wait);
+}
+
+int uds_enter_barrier(struct barrier *barrier)
+{
+	bool last_thread;
+
+	uds_acquire_semaphore(&barrier->mutex);
+	last_thread = (++barrier->arrived == barrier->thread_count);
+	if (last_thread) {
+		int i;
+
+		for (i = 1; i < barrier->thread_count; i++)
+			uds_release_semaphore(&barrier->wait);
+
+		barrier->arrived = 0;
+		uds_release_semaphore(&barrier->mutex);
+	} else {
+		uds_release_semaphore(&barrier->mutex);
+		uds_acquire_semaphore(&barrier->wait);
+	}
+
+	return UDS_SUCCESS;
+}
diff --git a/drivers/md/dm-vdo/uds-threads.h b/drivers/md/dm-vdo/uds-threads.h
new file mode 100644
index 00000000000..e4c968e2930
--- /dev/null
+++ b/drivers/md/dm-vdo/uds-threads.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef UDS_THREADS_H
+#define UDS_THREADS_H
+
+#include <linux/atomic.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+#include <linux/wait.h>
+
+#include "errors.h"
+#include "time-utils.h"
+
+/* Thread and synchronization utilities for UDS */
+
+struct cond_var {
+	wait_queue_head_t wait_queue;
+};
+
+struct thread;
+
+struct barrier {
+	/* Mutex for this barrier object */
+	struct semaphore mutex;
+	/* Semaphore for threads waiting at the barrier */
+	struct semaphore wait;
+	/* Number of threads which have arrived */
+	int arrived;
+	/* Total number of threads using this barrier */
+	int thread_count;
+};
+
+int __must_check uds_create_thread(void (*thread_function)(void *),
+				   void *thread_data,
+				   const char *name,
+				   struct thread **new_thread);
+
+void uds_perform_once(atomic_t *once_state, void (*function) (void));
+
+int uds_join_threads(struct thread *thread);
+
+int __must_check uds_initialize_barrier(struct barrier *barrier, unsigned int thread_count);
+int uds_destroy_barrier(struct barrier *barrier);
+int uds_enter_barrier(struct barrier *barrier);
+
+int __must_check uds_init_cond(struct cond_var *cond);
+int uds_signal_cond(struct cond_var *cond);
+int uds_broadcast_cond(struct cond_var *cond);
+int uds_wait_cond(struct cond_var *cond, struct mutex *mutex);
+int uds_destroy_cond(struct cond_var *cond);
+
+static inline int __must_check uds_init_mutex(struct mutex *mutex)
+{
+	mutex_init(mutex);
+	return UDS_SUCCESS;
+}
+
+static inline int uds_destroy_mutex(struct mutex *mutex)
+{
+	return UDS_SUCCESS;
+}
+
+static inline void uds_lock_mutex(struct mutex *mutex)
+{
+	mutex_lock(mutex);
+}
+
+static inline void uds_unlock_mutex(struct mutex *mutex)
+{
+	mutex_unlock(mutex);
+}
+
+static inline int __must_check
+uds_initialize_semaphore(struct semaphore *semaphore, unsigned int value)
+{
+	sema_init(semaphore, value);
+	return UDS_SUCCESS;
+}
+
+static inline int uds_destroy_semaphore(struct semaphore *semaphore)
+{
+	return UDS_SUCCESS;
+}
+
+static inline void uds_acquire_semaphore(struct semaphore *semaphore)
+{
+	/*
+	 * Do not use down(semaphore). Instead use down_interruptible so that
+	 * we do not get 120 second stall messages in kern.log.
+	 */
+	while (down_interruptible(semaphore) != 0)
+		/*
+		 * If we're called from a user-mode process (e.g., "dmsetup
+		 * remove") while waiting for an operation that may take a
+		 * while (e.g., UDS index save), and a signal is sent (SIGINT,
+		 * SIGUSR2), then down_interruptible will not block. If that
+		 * happens, sleep briefly to avoid keeping the CPU locked up in
+		 * this loop. We could just call cond_resched, but then we'd
+		 * still keep consuming CPU time slices and swamp other threads
+		 * trying to do computational work. [VDO-4980]
+		 */
+		fsleep(1000);
+}
+
+static inline bool __must_check uds_attempt_semaphore(struct semaphore *semaphore, ktime_t timeout)
+{
+	unsigned int jiffies;
+
+	if (timeout <= 0)
+		return down_trylock(semaphore) == 0;
+
+	jiffies = nsecs_to_jiffies(timeout);
+	return down_timeout(semaphore, jiffies) == 0;
+}
+
+static inline void uds_release_semaphore(struct semaphore *semaphore)
+{
+	up(semaphore);
+}
+
+#endif /* UDS_THREADS_H */
-- 
2.40.1

