Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE41D63F0
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635979; cv=none; b=D1A6nIuB+Ts9H7V/FumsNTNNhPOEhcWmw3hzcZTHfNqVCvu67mjn9ugI9KCAqJctjrRles7Jh0WV2x/XB23oB6Q/x5jMFFd/OpR76+k0MslmScQw9J9QjqqR9q3tfyXCYoyGNrO6XwowDJvHGFAZBLAMiTR0UQF1T+aT400Dz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635979; c=relaxed/simple;
	bh=nB+gT2Gxo6S43Q0rZ/T7hWuqn/RA7hMEHTZygG+eY7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptbhWgMNlJixgFHvewUop6asm2yWWawM38dTeV+qHlDW0zYTI1hTo33/hX324Kwhflp3GH9ktxCw1Vo+LmbP44A0Bmqt7HdmL3Y1rsXcs/a/IpE7ObZtn4oaeDeN1sfe6yS62l4qJKFdfl0R0+qU50XT3xj2Q44DS5i7cZ919uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFHgy3Ci; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFHgy3Ci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742635976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11OFVDVv9pfRPr9s5s+ZAK9EBnpAdPFBHLctb7ycvE0=;
	b=iFHgy3CiFcayuo7c9kXCx1RN3Mlivo6GiTCkXoZlHuftRPJJzGFZ0mzgsTabXrDvuDTdgt
	HVWvUbelxAo6/fv+ljTk7X5PHcIjsW/CI4k+uWSQuAtBQnt7ZKIrsh5jgluedqRl7xhv3V
	ig0rH00b73sQdNIviCZLHEnywSFUcVg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-aiusEV2lMP6jVHFejuJ5vg-1; Sat,
 22 Mar 2025 05:32:54 -0400
X-MC-Unique: aiusEV2lMP6jVHFejuJ5vg-1
X-Mimecast-MFC-AGG-ID: aiusEV2lMP6jVHFejuJ5vg_1742635974
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D972B19560B1;
	Sat, 22 Mar 2025 09:32:53 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C950E180A803;
	Sat, 22 Mar 2025 09:32:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/8] selftests: ublk: prepare for supporting stripe target
Date: Sat, 22 Mar 2025 17:32:13 +0800
Message-ID: <20250322093218.431419-6-ming.lei@redhat.com>
In-Reply-To: <20250322093218.431419-1-ming.lei@redhat.com>
References: <20250322093218.431419-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

- pass 'truct dev_ctx *ctx' to target init function

- add 'private_data' to 'struct ublk_dev' for storing target specific data

- add 'private_data' to 'struct ublk_io' for storing per-IO data

- add 'tgt_ios' to 'struct ublk_io' for counting how many io_uring ios
for handling the current io command

- add helper ublk_get_io() for supporting stripe target

- add two helpers for simplifying target io handling

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/file_backed.c |  2 +-
 tools/testing/selftests/ublk/kublk.c       |  6 ++--
 tools/testing/selftests/ublk/kublk.h       | 34 +++++++++++++++++++++-
 tools/testing/selftests/ublk/null.c        |  2 +-
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index a2e8793390a8..e2287eedaac8 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -123,7 +123,7 @@ static void ublk_loop_io_done(struct ublk_queue *q, int tag,
 	q->io_inflight--;
 }
 
-static int ublk_loop_tgt_init(struct ublk_dev *dev)
+static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	unsigned long long bytes;
 	int ret;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 0080cad1f3ae..2dd17663ef30 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -381,7 +381,7 @@ static int ublk_queue_init(struct ublk_queue *q)
 
 #define WAIT_USEC 	100000
 #define MAX_WAIT_USEC 	(3 * 1000000)
-static int ublk_dev_prep(struct ublk_dev *dev)
+static int ublk_dev_prep(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	int dev_id = dev->dev_info.dev_id;
 	unsigned int wait_usec = 0;
@@ -404,7 +404,7 @@ static int ublk_dev_prep(struct ublk_dev *dev)
 
 	dev->fds[0] = fd;
 	if (dev->tgt.ops->init_tgt)
-		ret = dev->tgt.ops->init_tgt(dev);
+		ret = dev->tgt.ops->init_tgt(ctx, dev);
 	if (ret)
 		close(dev->fds[0]);
 	return ret;
@@ -666,7 +666,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	ublk_dbg(UBLK_DBG_DEV, "%s enter\n", __func__);
 
-	ret = ublk_dev_prep(dev);
+	ret = ublk_dev_prep(ctx, dev);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index eaadd7364e25..4eee9ad2bead 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -94,11 +94,14 @@ struct ublk_io {
 	unsigned short refs;		/* used by target code only */
 
 	int result;
+
+	unsigned short tgt_ios;
+	void *private_data;
 };
 
 struct ublk_tgt_ops {
 	const char *name;
-	int (*init_tgt)(struct ublk_dev *);
+	int (*init_tgt)(const struct dev_ctx *ctx, struct ublk_dev *);
 	void (*deinit_tgt)(struct ublk_dev *);
 
 	int (*queue_io)(struct ublk_queue *, int tag);
@@ -146,6 +149,8 @@ struct ublk_dev {
 	int nr_fds;
 	int ctrl_fd;
 	struct io_uring ring;
+
+	void *private_data;
 };
 
 #ifndef offsetof
@@ -303,6 +308,11 @@ static inline void ublk_set_sqe_cmd_op(struct io_uring_sqe *sqe, __u32 cmd_op)
 	addr[1] = 0;
 }
 
+static inline struct ublk_io *ublk_get_io(struct ublk_queue *q, unsigned tag)
+{
+	return &q->ios[tag];
+}
+
 static inline int ublk_complete_io(struct ublk_queue *q, unsigned tag, int res)
 {
 	struct ublk_io *io = &q->ios[tag];
@@ -312,6 +322,28 @@ static inline int ublk_complete_io(struct ublk_queue *q, unsigned tag, int res)
 	return ublk_queue_io_cmd(q, io, tag);
 }
 
+static inline void ublk_queued_tgt_io(struct ublk_queue *q, unsigned tag, int queued)
+{
+	if (queued < 0)
+		ublk_complete_io(q, tag, queued);
+	else {
+		struct ublk_io *io = ublk_get_io(q, tag);
+
+		q->io_inflight += queued;
+		io->tgt_ios = queued;
+		io->result = 0;
+	}
+}
+
+static inline int ublk_completed_tgt_io(struct ublk_queue *q, unsigned tag)
+{
+	struct ublk_io *io = ublk_get_io(q, tag);
+
+	q->io_inflight--;
+
+	return --io->tgt_ios == 0;
+}
+
 static inline int ublk_queue_use_zc(const struct ublk_queue *q)
 {
 	return q->state & UBLKSRV_ZC;
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index b6ef16a8f514..975a11db22fd 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -2,7 +2,7 @@
 
 #include "kublk.h"
 
-static int ublk_null_tgt_init(struct ublk_dev *dev)
+static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
 	unsigned long dev_size = 250UL << 30;
-- 
2.47.0

