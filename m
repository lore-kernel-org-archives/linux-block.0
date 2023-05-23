Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAABEC7EE29
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 21:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbjEWVsD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbjEWVsC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD2D193
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrsCJvcOnQLDT1pN1F6XuJM1DaJa2Xi7lDJgcWRPoTk=;
        b=IEVW+NA9e1rkcP7sbtVYju2g9mauXj8sOnWTkbIUZ8sKFKSOqJn0iPzNzxUZdU0jsiu2eE
        4bCY36rrvrg3u8pdbYFEM2G1UR9PGrl/mxxEfS0DYBsHUjoY9PzEg+r5I+EXbQDI7KuVMt
        ocqs0Ita8nKDTUVUyW7aLqzttei+ZTg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-ji25NLOiOVa52tKhmgdL4w-1; Tue, 23 May 2023 17:46:53 -0400
X-MC-Unique: ji25NLOiOVa52tKhmgdL4w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62384132fe5so790046d6.3
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878413; x=1687470413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrsCJvcOnQLDT1pN1F6XuJM1DaJa2Xi7lDJgcWRPoTk=;
        b=dULq9s88ZF+Om0eAybHzV6YhLXj7msCbr1Ah8sVmfSvBOXqj5YpaN9UfMZEtYsmHJY
         ZXRTOe/IFIu2RRAJ/CnADWgMX2HzavwniC4xiKx575WSlQruutEnrUEGZBMvknVP3BjM
         R2LcuTomKItgV2Q9rtCL186QrLU+aukHA1IcDnHQvtm+3PZXT7SpJc0i1AaBxPXAO+AR
         1yqg9bYviYIOkHXTnpYMVp/6Gpj8jyln59gwL7/tZNxSbqi9XvcOAsXo6EKp5s68NuNp
         feQG/rO9SiZNQs0MvBu1hIAQQnG6v9l2iQvntYD/7eZmGwUh0MFTTUd+2xr9FHEiErLB
         82QQ==
X-Gm-Message-State: AC+VfDyo6ob7WI8v3Xs+BPeDzrjl6LIJFBFtf+f4xGtdvfI/rNnwJwz3
        CxRmmPHAlzPZTK65LkLWeMGqEYAytfuNaFmEy2+/aAIqjubFyQgJTTCnMp7jR4umsP4ouhG5Qws
        VGoZwAz9B3cWd+X9//dH1+mE=
X-Received: by 2002:a37:450f:0:b0:75b:23a1:8353 with SMTP id s15-20020a37450f000000b0075b23a18353mr5061980qka.78.1684878412648;
        Tue, 23 May 2023 14:46:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OwIrgRgTE0YXyEdYiG9jB2ebPfkBdami4RAXjzKlP0nMf35kDbbT8ayX3Ma8hWTYMIStqdQ==
X-Received: by 2002:a37:450f:0:b0:75b:23a1:8353 with SMTP id s15-20020a37450f000000b0075b23a18353mr5061968qka.78.1684878412368;
        Tue, 23 May 2023 14:46:52 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id f25-20020a05620a15b900b0075b196ae392sm1489722qkk.104.2023.05.23.14.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:46:52 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 37/39] Add vdo debugging support.
Date:   Tue, 23 May 2023 17:45:37 -0400
Message-Id: <20230523214539.226387-38-corwin@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523214539.226387-1-corwin@redhat.com>
References: <20230523214539.226387-1-corwin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support for dumping detailed vdo state to the kernel log via a dmsetup
message. The dump code is not thread-safe and is generally intended for use
only when the vdo is hung.

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/dm-vdo/dump.c | 288 +++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/dump.h |  17 +++
 2 files changed, 305 insertions(+)
 create mode 100644 drivers/md/dm-vdo/dump.c
 create mode 100644 drivers/md/dm-vdo/dump.h

diff --git a/drivers/md/dm-vdo/dump.c b/drivers/md/dm-vdo/dump.c
new file mode 100644
index 00000000000..0943357f98b
--- /dev/null
+++ b/drivers/md/dm-vdo/dump.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "dump.h"
+
+#include <linux/module.h>
+
+#include "memory-alloc.h"
+#include "string-utils.h"
+
+#include "constants.h"
+#include "data-vio.h"
+#include "dedupe.h"
+#include "io-submitter.h"
+#include "logger.h"
+#include "types.h"
+#include "vdo.h"
+#include "work-queue.h"
+
+enum dump_options {
+	/* Work queues */
+	SHOW_QUEUES,
+	/* Memory pools */
+	SHOW_VIO_POOL,
+	/* Others */
+	SHOW_VDO_STATUS,
+	/* This one means an option overrides the "default" choices, instead of altering them. */
+	SKIP_DEFAULT
+};
+
+enum dump_option_flags {
+	/* Work queues */
+	FLAG_SHOW_QUEUES = (1 << SHOW_QUEUES),
+	/* Memory pools */
+	FLAG_SHOW_VIO_POOL = (1 << SHOW_VIO_POOL),
+	/* Others */
+	FLAG_SHOW_VDO_STATUS = (1 << SHOW_VDO_STATUS),
+	/* Special */
+	FLAG_SKIP_DEFAULT = (1 << SKIP_DEFAULT)
+};
+
+enum {
+	FLAGS_ALL_POOLS = (FLAG_SHOW_VIO_POOL),
+	DEFAULT_DUMP_FLAGS = (FLAG_SHOW_QUEUES | FLAG_SHOW_VDO_STATUS)
+};
+
+static inline bool is_arg_string(const char *arg, const char *this_option)
+{
+	/* convention seems to be case-independent options */
+	return strncasecmp(arg, this_option, strlen(this_option)) == 0;
+}
+
+static void do_dump(struct vdo *vdo, unsigned int dump_options_requested, const char *why)
+{
+	u32 active, maximum;
+	s64 outstanding;
+
+	uds_log_info("%s dump triggered via %s", UDS_LOGGING_MODULE_NAME, why);
+	active = get_data_vio_pool_active_requests(vdo->data_vio_pool);
+	maximum = get_data_vio_pool_maximum_requests(vdo->data_vio_pool);
+	outstanding = (atomic64_read(&vdo->stats.bios_submitted) -
+		       atomic64_read(&vdo->stats.bios_completed));
+	uds_log_info("%u device requests outstanding (max %u), %lld bio requests outstanding, device '%s'",
+		     active,
+		     maximum,
+		     outstanding,
+		     vdo_get_device_name(vdo->device_config->owning_target));
+	if (((dump_options_requested & FLAG_SHOW_QUEUES) != 0) && (vdo->threads != NULL)) {
+		thread_id_t id;
+
+		for (id = 0; id < vdo->thread_config.thread_count; id++)
+			vdo_dump_work_queue(vdo->threads[id].queue);
+	}
+
+	vdo_dump_hash_zones(vdo->hash_zones);
+	dump_data_vio_pool(vdo->data_vio_pool, (dump_options_requested & FLAG_SHOW_VIO_POOL) != 0);
+	if ((dump_options_requested & FLAG_SHOW_VDO_STATUS) != 0)
+		vdo_dump_status(vdo);
+
+	uds_report_memory_usage();
+	uds_log_info("end of %s dump", UDS_LOGGING_MODULE_NAME);
+}
+
+static int
+parse_dump_options(unsigned int argc, char *const *argv, unsigned int *dump_options_requested_ptr)
+{
+	unsigned int dump_options_requested = 0;
+
+	static const struct {
+		const char *name;
+		unsigned int flags;
+	} option_names[] = {
+		{ "viopool", FLAG_SKIP_DEFAULT | FLAG_SHOW_VIO_POOL },
+		{ "vdo", FLAG_SKIP_DEFAULT | FLAG_SHOW_VDO_STATUS },
+		{ "pools", FLAG_SKIP_DEFAULT | FLAGS_ALL_POOLS },
+		{ "queues", FLAG_SKIP_DEFAULT | FLAG_SHOW_QUEUES },
+		{ "threads", FLAG_SKIP_DEFAULT | FLAG_SHOW_QUEUES },
+		{ "default", FLAG_SKIP_DEFAULT | DEFAULT_DUMP_FLAGS },
+		{ "all", ~0 },
+	};
+
+	bool options_okay = true;
+	unsigned int i;
+
+	for (i = 1; i < argc; i++) {
+		unsigned int j;
+
+		for (j = 0; j < ARRAY_SIZE(option_names); j++) {
+			if (is_arg_string(argv[i], option_names[j].name)) {
+				dump_options_requested |= option_names[j].flags;
+				break;
+			}
+		}
+		if (j == ARRAY_SIZE(option_names)) {
+			uds_log_warning("dump option name '%s' unknown", argv[i]);
+			options_okay = false;
+		}
+	}
+	if (!options_okay)
+		return -EINVAL;
+	if ((dump_options_requested & FLAG_SKIP_DEFAULT) == 0)
+		dump_options_requested |= DEFAULT_DUMP_FLAGS;
+	*dump_options_requested_ptr = dump_options_requested;
+	return 0;
+}
+
+/* Dump as specified by zero or more string arguments. */
+int vdo_dump(struct vdo *vdo, unsigned int argc, char *const *argv, const char *why)
+{
+	unsigned int dump_options_requested = 0;
+	int result = parse_dump_options(argc, argv, &dump_options_requested);
+
+	if (result != 0)
+		return result;
+
+	do_dump(vdo, dump_options_requested, why);
+	return 0;
+}
+
+/* Dump everything we know how to dump */
+void vdo_dump_all(struct vdo *vdo, const char *why)
+{
+	do_dump(vdo, ~0, why);
+}
+
+/*
+ * Dump out the data_vio waiters on a wait queue.
+ * wait_on should be the label to print for queue (e.g. logical or physical)
+ */
+static void dump_vio_waiters(struct wait_queue *queue, char *wait_on)
+{
+	struct waiter *waiter, *first = vdo_get_first_waiter(queue);
+	struct data_vio *data_vio;
+
+	if (first == NULL)
+		return;
+
+	data_vio = waiter_as_data_vio(first);
+
+	uds_log_info("      %s is locked. Waited on by: vio %px pbn %llu lbn %llu d-pbn %llu lastOp %s",
+		     wait_on,
+		     data_vio,
+		     data_vio->allocation.pbn,
+		     data_vio->logical.lbn,
+		     data_vio->duplicate.pbn,
+		     get_data_vio_operation_name(data_vio));
+
+	for (waiter = first->next_waiter; waiter != first; waiter = waiter->next_waiter) {
+		data_vio = waiter_as_data_vio(waiter);
+		uds_log_info("     ... and : vio %px pbn %llu lbn %llu d-pbn %llu lastOp %s",
+			     data_vio,
+			     data_vio->allocation.pbn,
+			     data_vio->logical.lbn,
+			     data_vio->duplicate.pbn,
+			     get_data_vio_operation_name(data_vio));
+	}
+}
+
+/*
+ * Encode various attributes of a data_vio as a string of one-character flags. This encoding is for
+ * logging brevity:
+ *
+ * R => vio completion result not VDO_SUCCESS
+ * W => vio is on a wait queue
+ * D => vio is a duplicate
+ * p => vio is a partial block operation
+ * z => vio is a zero block
+ * d => vio is a discard
+ *
+ * The common case of no flags set will result in an empty, null-terminated buffer. If any flags
+ * are encoded, the first character in the string will be a space character.
+ */
+static void encode_vio_dump_flags(struct data_vio *data_vio, char buffer[8])
+{
+	char *p_flag = buffer;
+	*p_flag++ = ' ';
+	if (data_vio->vio.completion.result != VDO_SUCCESS)
+		*p_flag++ = 'R';
+	if (data_vio->waiter.next_waiter != NULL)
+		*p_flag++ = 'W';
+	if (data_vio->is_duplicate)
+		*p_flag++ = 'D';
+	if (data_vio->is_partial)
+		*p_flag++ = 'p';
+	if (data_vio->is_zero)
+		*p_flag++ = 'z';
+	if (data_vio->remaining_discard > 0)
+		*p_flag++ = 'd';
+	if (p_flag == &buffer[1])
+		/* No flags, so remove the blank space. */
+		p_flag = buffer;
+	*p_flag = '\0';
+}
+
+/* Implements buffer_dump_function. */
+void dump_data_vio(void *data)
+{
+	struct data_vio *data_vio = (struct data_vio *) data;
+
+	/*
+	 * This just needs to be big enough to hold a queue (thread) name and a function name (plus
+	 * a separator character and NUL). The latter is limited only by taste.
+	 *
+	 * In making this static, we're assuming only one "dump" will run at a time. If more than
+	 * one does run, the log output will be garbled anyway.
+	 */
+	static char vio_completion_dump_buffer[100 + MAX_VDO_WORK_QUEUE_NAME_LEN];
+	/* Another static buffer... log10(256) = 2.408+, round up: */
+	enum { DIGITS_PER_U64 = 1 + sizeof(u64) * 2409 / 1000 };
+
+	static char vio_block_number_dump_buffer[sizeof("P L D") + 3 * DIGITS_PER_U64];
+	static char vio_flush_generation_buffer[sizeof(" FG") + DIGITS_PER_U64];
+	static char flags_dump_buffer[8];
+
+	/*
+	 * We're likely to be logging a couple thousand of these lines, and in some circumstances
+	 * syslogd may have trouble keeping up, so keep it BRIEF rather than user-friendly.
+	 */
+	vdo_dump_completion_to_buffer(&data_vio->vio.completion,
+				      vio_completion_dump_buffer,
+				      sizeof(vio_completion_dump_buffer));
+	if (data_vio->is_duplicate)
+		snprintf(vio_block_number_dump_buffer,
+			 sizeof(vio_block_number_dump_buffer),
+			 "P%llu L%llu D%llu",
+			 data_vio->allocation.pbn,
+			 data_vio->logical.lbn,
+			 data_vio->duplicate.pbn);
+	else if (data_vio_has_allocation(data_vio))
+		snprintf(vio_block_number_dump_buffer,
+			 sizeof(vio_block_number_dump_buffer),
+			 "P%llu L%llu",
+			 data_vio->allocation.pbn,
+			 data_vio->logical.lbn);
+	else
+		snprintf(vio_block_number_dump_buffer,
+			 sizeof(vio_block_number_dump_buffer),
+			 "L%llu",
+			 data_vio->logical.lbn);
+
+	if (data_vio->flush_generation != 0)
+		snprintf(vio_flush_generation_buffer,
+			 sizeof(vio_flush_generation_buffer),
+			 " FG%llu",
+			 data_vio->flush_generation);
+	else
+		vio_flush_generation_buffer[0] = 0;
+
+	encode_vio_dump_flags(data_vio, flags_dump_buffer);
+
+	uds_log_info("	vio %px %s%s %s %s%s",
+		     data_vio,
+		     vio_block_number_dump_buffer,
+		     vio_flush_generation_buffer,
+		     get_data_vio_operation_name(data_vio),
+		     vio_completion_dump_buffer,
+		     flags_dump_buffer);
+	/*
+	 * might want info on: wantUDSAnswer / operation / status
+	 * might want info on: bio / bios_merged
+	 */
+
+	dump_vio_waiters(&data_vio->logical.waiters, "lbn");
+
+	/* might want to dump more info from vio here */
+}
diff --git a/drivers/md/dm-vdo/dump.h b/drivers/md/dm-vdo/dump.h
new file mode 100644
index 00000000000..74ade5eab07
--- /dev/null
+++ b/drivers/md/dm-vdo/dump.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef VDO_DUMP_H
+#define VDO_DUMP_H
+
+#include "types.h"
+
+int vdo_dump(struct vdo *vdo, unsigned int argc, char *const *argv, const char *why);
+
+void vdo_dump_all(struct vdo *vdo, const char *why);
+
+void dump_data_vio(void *data);
+
+#endif /* VDO_DUMP_H */
-- 
2.40.1

