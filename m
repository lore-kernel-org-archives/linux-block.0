Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A052B253B58
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654593; cv=none; b=C2cdkxtUiqr1ds9MIWDDeY7/8AOo6ncIo9tJNVRWN80TUAjOg0Sqpyw764DaMPHoRZqbZPjzeL1clUKXdsqAeVL5afb6LgzN+cVnAdkZk25+bsNqNQqLE4+FMhNyL/ebRbW4ptfNgSA9Oz7t26rz+zcpybAE+G53AjTwllXqgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654593; c=relaxed/simple;
	bh=g57xPpNHLevi0pEAQ+HHFNzlQ6DEIURGZsF2OieLGCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fH8k/ib+u9BRnFIHCrOyBGyHLoCmpOtDbqpBOSFb6GClMuhIceeLvP1ucHI9GXIgEJjEvpf/9TYXZq9oXbRGShjZ84dGjT3MfMtvch2eR/KLKcxX/VlC9XSOUiOFH92IZt/hpqGjHlmmBVSjmizf9psAduy0es4Sq5Odui6VNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EiGS+yxN; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EiGS+yxN"
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3d965c64d53so1351205ab.1
        for <linux-block@vger.kernel.org>; Wed, 07 May 2025 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746654590; x=1747259390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u02qlRMbJOaeV7FtbgomQH2ETSCl2yD2yTctn7xKE8s=;
        b=EiGS+yxNOVdFFwXM74Pg6hi6jAm6aOCw6j+R8kbCXEIjNgRPKKPYntD/KZwLXrl03N
         fZ9sNfIecZ4GqSlM/SO1evwslSJ8RskZMZOdKkVPfBL9gQcy6FsatmQzh9cjMvvBXp0r
         JrDz73Pyn9AZJd3gqI8Zk6mUP5fVEA5ty22Ov5OhGZeD1URwVKDtZEgnKR4Sb8oadDWw
         PYUUPA7V7d/OPR2/T+6Zuwdhr4T1jOvzuMeS15kzdLQUXZQtKiTnv2OjMu91yWKrmRn9
         9I4kbFN/+KlGq95EEk4haKK0LQWmxkcTFe+DMKLZJ4VGSLUSQhqcI+bZWUpT1WYdlZl4
         tOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746654590; x=1747259390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u02qlRMbJOaeV7FtbgomQH2ETSCl2yD2yTctn7xKE8s=;
        b=Dr+Tq/OtbN96e2pHNMqFHhz8B0OaVauxej4/xYkuXg53TsCpfnIfBtIpYDeHB9TP45
         QFcIjaS/kYZyVSaF/nkuhktzIuTHTZtzEwB822c3dDZKSs0Nx8jb7L4VP88HqqkQR44p
         1EIWorUP6zjxMSakCxGwVi8ChmyZgaQVhTVhRKISxMpBjfLfyYCBU67cfwc4zFIWjC1k
         VuXrmbcUY47fAfOXgGSHEyfoafkxH1me2edmRkkZFRkjFUF2Y8Uz3ARk9J9v6aLV0tbZ
         6L7tPz5kNJaiuOg1cMEixavYhZLlrdPyjogBmoT6FvpAhB1y1JIJL2rxAtJn0wNeuO/r
         7Zlg==
X-Gm-Message-State: AOJu0YyPfjCBW1orIhKiP7AoqaKu7u+IGs8mnInggs7l1ehUg0P2lsj3
	GBSB8rBWci9HhJDdSLIUCDjj0AoKvU7mn/dAQiDm3NiPQXXnPVZDpr6kZhLh3yRL/jPsSXoMjJf
	q7wHiyo3JDZa9jFVDmz4AYMEnTJLe1981
X-Gm-Gg: ASbGnctb2Q1YhxaKIcrYptMjhyenDGRtdmUkp8nuXs7FhakVovaU4WFWdmkqJEgpS2b
	SlYAuvFT4sI088B+JR7IeOHPwaWoZUoCfCLhmNUAeLIOglLfUZh+XyKMFBc4cMsENEvE97mOny2
	WXdnCQMcJIP0j7c8TCOENvOhtx1idqBa1IpDvFJ/iHEMok10Sp0+7CwsIuli0YjTN81//sMkuGy
	km+Rb6GYqlCr91hAyjR3DdXWZlTm6PfXmKmErc86jbPM2vFvMu69lWbCrG5Dy9Gk9y9KFz07Zd9
	eF6mceNASegoKFU9cNhhxWdEWIaKudJVaF1ocIfZVjWtzw==
X-Google-Smtp-Source: AGHT+IG5OuR/oYC3er3Pl3D1UKI6zu/vHXm2RrUm8RHoys5nuKhu6NZChunWQfPKl6rjMXV8SCouigscTSbl
X-Received: by 2002:a05:6e02:160e:b0:3d8:1d7c:e190 with SMTP id e9e14a558f8ab-3da7855c11emr18490515ab.7.1746654589691;
        Wed, 07 May 2025 14:49:49 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f88a916b2dsm2201783173.30.2025.05.07.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:49:49 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 47227340994;
	Wed,  7 May 2025 15:49:49 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 405CBE40E88; Wed,  7 May 2025 15:49:49 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 07 May 2025 15:49:37 -0600
Subject: [PATCH v6 3/8] selftests: ublk: kublk: plumb q_id in io_uring
 user_data
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-ublk_task_per_io-v6-3-a2a298783c01@purestorage.com>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
In-Reply-To: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Currently, when we process CQEs, we know which ublk_queue we are working
on because we know which ring we are working on, and ublk_queues and
rings are in 1:1 correspondence. However, as we decouple ublk_queues
from ublk server threads, ublk_queues and rings will no longer be in 1:1
correspondence - each ublk server thread will have a ring, and each
thread may issue commands against more than one ublk_queue. So in order
to know which ublk_queue a CQE refers to, plumb that information in the
associated SQE's user_data.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/fault_inject.c |  2 +-
 tools/testing/selftests/ublk/file_backed.c  | 10 +++++-----
 tools/testing/selftests/ublk/kublk.c        | 17 +++++++++--------
 tools/testing/selftests/ublk/kublk.h        | 23 +++++++++++++----------
 tools/testing/selftests/ublk/null.c         |  6 +++---
 tools/testing/selftests/ublk/stripe.c       |  9 +++++----
 6 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index 94a8e729ba4c8f8bf8faa313655a738e480533c7..6bc8ee519b483ba6a365dccb03ad389425eefd3b 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -43,7 +43,7 @@ static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
 
 	ublk_queue_alloc_sqes(q, &sqe, 1);
 	io_uring_prep_timeout(sqe, &ts, 1, 0);
-	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, 1);
+	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, q->q_id, 1);
 
 	ublk_queued_tgt_io(q, tag, 1);
 
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 6f34eabfae9796cf8862f262358cf230d26ed55b..69991ac7a0a947acba7b23ac89348936a3fcef75 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -22,7 +22,7 @@ static int loop_queue_flush_io(struct ublk_queue *q, const struct ublksrv_io_des
 	io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
 	io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 	/* bit63 marks us as tgt io */
-	sqe[0]->user_data = build_user_data(tag, ublk_op, 0, 1);
+	sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 	return 1;
 }
 
@@ -44,7 +44,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 				iod->start_sector << 9);
 		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 		/* bit63 marks us as tgt io */
-		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, 1);
+		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 		return 1;
 	}
 
@@ -53,17 +53,17 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
-			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, 1);
+			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 
 	io_uring_prep_rw(op, sqe[1], 1 /*fds[1]*/, 0,
 		iod->nr_sectors << 9,
 		iod->start_sector << 9);
 	sqe[1]->buf_index = tag;
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
-	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, 1);
+	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
 	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
-	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, 1);
+	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	return 2;
 }
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 842b40736a9b81507960bba21a246c8b5d3bddee..d0eaf06fadbbb00c0549bba0a08f1be23baa2359 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -579,7 +579,7 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 	else
 		cmd->addr	= 0;
 
-	user_data = build_user_data(tag, _IOC_NR(cmd_op), 0, 0);
+	user_data = build_user_data(tag, _IOC_NR(cmd_op), 0, q->q_id, 0);
 	io_uring_sqe_set_data64(sqe[0], user_data);
 
 	io->flags = 0;
@@ -625,10 +625,11 @@ static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
 		q->tgt_ops->tgt_io_done(q, tag, cqe);
 }
 
-static void ublk_handle_cqe(struct io_uring *r,
+static void ublk_handle_cqe(struct ublk_dev *dev,
 		struct io_uring_cqe *cqe, void *data)
 {
-	struct ublk_queue *q = container_of(r, struct ublk_queue, ring);
+	unsigned q_id = user_data_to_q_id(cqe->user_data);
+	struct ublk_queue *q = &dev->q[q_id];
 	unsigned tag = user_data_to_tag(cqe->user_data);
 	unsigned cmd_op = user_data_to_op(cqe->user_data);
 	int fetch = (cqe->res != UBLK_IO_RES_ABORT) &&
@@ -679,17 +680,17 @@ static void ublk_handle_cqe(struct io_uring *r,
 	}
 }
 
-static int ublk_reap_events_uring(struct io_uring *r)
+static int ublk_reap_events_uring(struct ublk_queue *q)
 {
 	struct io_uring_cqe *cqe;
 	unsigned head;
 	int count = 0;
 
-	io_uring_for_each_cqe(r, head, cqe) {
-		ublk_handle_cqe(r, cqe, NULL);
+	io_uring_for_each_cqe(&q->ring, head, cqe) {
+		ublk_handle_cqe(q->dev, cqe, NULL);
 		count += 1;
 	}
-	io_uring_cq_advance(r, count);
+	io_uring_cq_advance(&q->ring, count);
 
 	return count;
 }
@@ -708,7 +709,7 @@ static int ublk_process_io(struct ublk_queue *q)
 		return -ENODEV;
 
 	ret = io_uring_submit_and_wait(&q->ring, 1);
-	reapped = ublk_reap_events_uring(&q->ring);
+	reapped = ublk_reap_events_uring(q);
 
 	ublk_dbg(UBLK_DBG_QUEUE, "submit result %d, reapped %d stop %d idle %d\n",
 			ret, reapped, (q->state & UBLKSRV_QUEUE_STOPPING),
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 81fb5864ab722380d7aaca3450b5c642d0c95a16..34f92bb2c64d0ddc7690b2654613e0c77b2b8121 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -49,7 +49,8 @@
 #define UBLKSRV_IO_IDLE_SECS		20
 
 #define UBLK_IO_MAX_BYTES               (1 << 20)
-#define UBLK_MAX_QUEUES                 32
+#define UBLK_MAX_QUEUES_SHIFT		5
+#define UBLK_MAX_QUEUES                 (1 << UBLK_MAX_QUEUES_SHIFT)
 #define UBLK_QUEUE_DEPTH                1024
 
 #define UBLK_DBG_DEV            (1U << 0)
@@ -190,12 +191,6 @@ struct ublk_dev {
 #define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
 #endif
 
-#ifndef container_of
-#define container_of(ptr, type, member) ({                              \
-	unsigned long __mptr = (unsigned long)(ptr);                    \
-	((type *)(__mptr - offsetof(type, member))); })
-#endif
-
 #define round_up(val, rnd) \
 	(((val) + ((rnd) - 1)) & ~((rnd) - 1))
 
@@ -209,11 +204,14 @@ static inline int is_target_io(__u64 user_data)
 }
 
 static inline __u64 build_user_data(unsigned tag, unsigned op,
-		unsigned tgt_data, unsigned is_target_io)
+		unsigned tgt_data, unsigned q_id, unsigned is_target_io)
 {
-	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16));
+	/* we only have 7 bits to encode q_id */
+	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
+	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
 
-	return tag | (op << 16) | (tgt_data << 24) | (__u64)is_target_io << 63;
+	return tag | (op << 16) | (tgt_data << 24) |
+		(__u64)q_id << 56 | (__u64)is_target_io << 63;
 }
 
 static inline unsigned int user_data_to_tag(__u64 user_data)
@@ -231,6 +229,11 @@ static inline unsigned int user_data_to_tgt_data(__u64 user_data)
 	return (user_data >> 24) & 0xffff;
 }
 
+static inline unsigned int user_data_to_q_id(__u64 user_data)
+{
+	return (user_data >> 56) & 0x7f;
+}
+
 static inline unsigned short ublk_cmd_op_nr(unsigned int op)
 {
 	return _IOC_NR(op);
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 91fec3690d4ba0cc1e4b0231dff6fdad411b5ecc..8e8e3c27329bf3fa7aeaaef2150bfbe4b22fcd94 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -52,7 +52,7 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 	sqe[0]->user_data = build_user_data(tag,
-			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, 1);
+			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 
 	io_uring_prep_nop(sqe[1]);
@@ -60,10 +60,10 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
 	sqe[1]->rw_flags = IORING_NOP_FIXED_BUFFER | IORING_NOP_INJECT_RESULT;
 	sqe[1]->len = iod->nr_sectors << 9; 	/* injected result */
-	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, 1);
+	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
 	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
-	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, 1);
+	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	// buf register is marked as IOSQE_CQE_SKIP_SUCCESS
 	return 2;
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 5dbd6392d83de29faeac97b4f8e3e99afd791282..057d3132aa0d556c649f502a7d738be03207c1f3 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -142,7 +142,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 		sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 		sqe[0]->user_data = build_user_data(tag,
-			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, 1);
+			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 	}
 
 	for (i = zc; i < s->nr + extra - zc; i++) {
@@ -161,13 +161,14 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 			io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);
 		}
 		/* bit63 marks us as tgt io */
-		sqe[i]->user_data = build_user_data(tag, ublksrv_get_op(iod), i - zc, 1);
+		sqe[i]->user_data = build_user_data(tag, ublksrv_get_op(iod), i - zc, q->q_id, 1);
 	}
 	if (zc) {
 		struct io_uring_sqe *unreg = sqe[s->nr + 1];
 
 		io_uring_prep_buf_unregister(unreg, 0, tag, q->q_id, tag);
-		unreg->user_data = build_user_data(tag, ublk_cmd_op_nr(unreg->cmd_op), 0, 1);
+		unreg->user_data = build_user_data(
+			tag, ublk_cmd_op_nr(unreg->cmd_op), 0, q->q_id, 1);
 	}
 
 	/* register buffer is skip_success */
@@ -184,7 +185,7 @@ static int handle_flush(struct ublk_queue *q, const struct ublksrv_io_desc *iod,
 	for (i = 0; i < conf->nr_files; i++) {
 		io_uring_prep_fsync(sqe[i], i + 1, IORING_FSYNC_DATASYNC);
 		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);
-		sqe[i]->user_data = build_user_data(tag, UBLK_IO_OP_FLUSH, 0, 1);
+		sqe[i]->user_data = build_user_data(tag, UBLK_IO_OP_FLUSH, 0, q->q_id, 1);
 	}
 	return conf->nr_files;
 }

-- 
2.34.1

