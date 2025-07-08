Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5774D8CE
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937540; cv=none; b=PShcAvAJQLuNhdhCxRr91XimM4GazXqiReaifPtSRXWwlWTRYr3Umx9V4ELS/KUe3gCRKDiPUhePI94oTX9XiZGVPmzg3LnTPNmHif/p3HVwzzzu5VTRySA0jVC8IWgZVxa50f7Hb/FNVbPTNopybxYnwHx2GLMyKnVtq/2o0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937540; c=relaxed/simple;
	bh=7vSn+g8oLJoF3KiAFPdCTPV17PU64AVawNU0675WFLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsiJ7A9dXmE3qqyhR9oEZnvM2RMB1eu58zeyccu3XZWoZ9+EJRg38iQUPMyWdGeZMHXwlAfkEwubUf7HgEErxMcPjNFKFj/Tq0jD3hqoo5op+OWJmwl+j1ePoTDOuvfP3urqaAhB+7a6n40pEQiCZ6qUyIOcK+sg8m4VUzTHBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSxiR9vD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSxiR9vD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooDfNDjC9S1TPqJes4/uRRfbtgOFxA49JrqVgC3iZEY=;
	b=gSxiR9vDEVcxQI9GcHMjNZOgeZp2XT40Pb0gQL6RuqIb8d6ZiqyVr/UIz4TTx7/ZuyTAxn
	P2ebGzHqqZ4ltD88Upxjgmg9yFp8SBbY+qBReJgLWDBpnwg/Qt229Trc5jframM0XAxaiI
	VkY0DvBl9YAvGVeATQTihtdoke7+TcM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-c_1DGvTQPZ6klLc8Fh1qFw-1; Mon,
 07 Jul 2025 21:18:55 -0400
X-MC-Unique: c_1DGvTQPZ6klLc8Fh1qFw-1
X-Mimecast-MFC-AGG-ID: c_1DGvTQPZ6klLc8Fh1qFw_1751937534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DEBE180028B;
	Tue,  8 Jul 2025 01:18:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 119C830001B1;
	Tue,  8 Jul 2025 01:18:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 16/16] selftests: ublk: add utils.h
Date: Tue,  8 Jul 2025 09:17:43 +0800
Message-ID: <20250708011746.2193389-17-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h | 64 +------------------------
 tools/testing/selftests/ublk/utils.h | 70 ++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/utils.h

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index c668472097ff..219233f8a053 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -29,13 +29,9 @@
 #include "ublk_dep.h"
 #include <linux/ublk_cmd.h>
 
-#define __maybe_unused __attribute__((unused))
-#define MAX_BACK_FILES   4
-#ifndef min
-#define min(a, b) ((a) < (b) ? (a) : (b))
-#endif
+#include "utils.h"
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
+#define MAX_BACK_FILES   4
 
 /****************** part 1: libublk ********************/
 
@@ -52,13 +48,6 @@
 #define UBLK_MAX_THREADS		(1 << UBLK_MAX_THREADS_SHIFT)
 #define UBLK_QUEUE_DEPTH                1024
 
-#define UBLK_DBG_DEV            (1U << 0)
-#define UBLK_DBG_THREAD         (1U << 1)
-#define UBLK_DBG_IO_CMD         (1U << 2)
-#define UBLK_DBG_IO             (1U << 3)
-#define UBLK_DBG_CTRL_CMD       (1U << 4)
-#define UBLK_LOG                (1U << 5)
-
 struct ublk_dev;
 struct ublk_queue;
 struct ublk_thread;
@@ -211,21 +200,6 @@ struct ublk_dev {
 	void *private_data;
 };
 
-#ifndef offsetof
-#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
-#endif
-
-#ifndef container_of
-#define container_of(ptr, type, member) ({                              \
-	unsigned long __mptr = (unsigned long)(ptr);                    \
-	((type *)(__mptr - offsetof(type, member))); })
-#endif
-
-#define round_up(val, rnd) \
-	(((val) + ((rnd) - 1)) & ~((rnd) - 1))
-
-
-extern unsigned int ublk_dbg_mask;
 extern int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io);
 
 
@@ -275,34 +249,6 @@ static inline unsigned short ublk_cmd_op_nr(unsigned int op)
 	return _IOC_NR(op);
 }
 
-static inline void ublk_err(const char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	vfprintf(stderr, fmt, ap);
-}
-
-static inline void ublk_log(const char *fmt, ...)
-{
-	if (ublk_dbg_mask & UBLK_LOG) {
-		va_list ap;
-
-		va_start(ap, fmt);
-		vfprintf(stdout, fmt, ap);
-	}
-}
-
-static inline void ublk_dbg(int level, const char *fmt, ...)
-{
-	if (level & ublk_dbg_mask) {
-		va_list ap;
-
-		va_start(ap, fmt);
-		vfprintf(stdout, fmt, ap);
-	}
-}
-
 static inline struct ublk_queue *ublk_io_to_queue(const struct ublk_io *io)
 {
 	return container_of(io, struct ublk_queue, ios[io->tag]);
@@ -458,10 +404,4 @@ extern const struct ublk_tgt_ops fault_inject_tgt_ops;
 void backing_file_tgt_deinit(struct ublk_dev *dev);
 int backing_file_tgt_init(struct ublk_dev *dev);
 
-static inline unsigned int ilog2(unsigned int x)
-{
-	if (x == 0)
-		return 0;
-	return (sizeof(x) * 8 - 1) - __builtin_clz(x);
-}
 #endif
diff --git a/tools/testing/selftests/ublk/utils.h b/tools/testing/selftests/ublk/utils.h
new file mode 100644
index 000000000000..36545d1567f1
--- /dev/null
+++ b/tools/testing/selftests/ublk/utils.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef KUBLK_UTILS_H
+#define KUBLK_UTILS_H
+
+#define __maybe_unused __attribute__((unused))
+
+#ifndef min
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
+
+#ifndef offsetof
+#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
+#endif
+
+#ifndef container_of
+#define container_of(ptr, type, member) ({                              \
+	unsigned long __mptr = (unsigned long)(ptr);                    \
+	((type *)(__mptr - offsetof(type, member))); })
+#endif
+
+#define round_up(val, rnd) \
+	(((val) + ((rnd) - 1)) & ~((rnd) - 1))
+
+static inline unsigned int ilog2(unsigned int x)
+{
+	if (x == 0)
+		return 0;
+	return (sizeof(x) * 8 - 1) - __builtin_clz(x);
+}
+
+#define UBLK_DBG_DEV            (1U << 0)
+#define UBLK_DBG_THREAD         (1U << 1)
+#define UBLK_DBG_IO_CMD         (1U << 2)
+#define UBLK_DBG_IO             (1U << 3)
+#define UBLK_DBG_CTRL_CMD       (1U << 4)
+#define UBLK_LOG                (1U << 5)
+
+extern unsigned int ublk_dbg_mask;
+
+static inline void ublk_err(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+}
+
+static inline void ublk_log(const char *fmt, ...)
+{
+	if (ublk_dbg_mask & UBLK_LOG) {
+		va_list ap;
+
+		va_start(ap, fmt);
+		vfprintf(stdout, fmt, ap);
+	}
+}
+
+static inline void ublk_dbg(int level, const char *fmt, ...)
+{
+	if (level & ublk_dbg_mask) {
+		va_list ap;
+
+		va_start(ap, fmt);
+		vfprintf(stdout, fmt, ap);
+	}
+}
+
+#endif
-- 
2.47.0

