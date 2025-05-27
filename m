Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C75218585
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386901; cv=none; b=pAabaLgKx/rqlqTYvq5/urMEMLHY0AkWgcB9Og+f59zMeewDkjzs+WoWtx651a5yLPd2ePyM4MPmLDFY85wPabbGL1Up5Ab0wXTCvovHtzbvyoVvbQgBBfIXDxmYyhKnuFbt+ukw08VH7Ohieuqiw9O6I1uRqzCB0ls4+I6qRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386901; c=relaxed/simple;
	bh=3rHro1wLJE18Zb2D20GrmRpItAJxauLD4fDuCVGx4d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTk5rM25R9ORB5tdW7tQdQ8Am1Gp+lAVPDb+5kHSoTfzNNv3VCzXWzV7qFbiIGJxHLNDQ/qf4NMsaXcmBnXeuw6oZ3AOHB9Ax/XhH3rIZlYy2EaZ8TzDNMA6EOimsFNpajGQpfQK9jz2NURL5JB5qTw6bmFFtNdapeVXXGXeBsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dlwcW26P; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dlwcW26P"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-231e98e46c0so32556265ad.3
        for <linux-block@vger.kernel.org>; Tue, 27 May 2025 16:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748386897; x=1748991697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FChdrqJlvS/Um1q48dhiagGsD/x85+Wjka9h78yHhKk=;
        b=dlwcW26PUc9CtC3jTz6+i6bM/EiBbBApqtptz+bEHhPGgizxlRVJiLO9EsZOXVbgGJ
         KP6sZByid6SBH6BBctEc8SM8lJHYLlEA5qEtbS/L5viKjRjlZquJgr+mKEZs7Kwm2pKZ
         eQhagvYSOFTXNHpDWnDuYBcnd8FzcG7OzbHthpwKUduWXEetLiJm+umFxEhd0B0HXwil
         0diTwkFExqOCppsCY6Cr8V7gDDlFcOua2RHDI7TAJKubaTSQcEwSQLr52faeI43/dZnq
         DxE1+qoBENbFlVy2WDl7KqpWe/aICvoA0vBn0uocmjAqgRySAYxqLPJIv9nlFO/MIiLi
         5Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386897; x=1748991697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FChdrqJlvS/Um1q48dhiagGsD/x85+Wjka9h78yHhKk=;
        b=uUtDLIgnZv3SgOdvbJCjZhrJfPs2HUOqCYJWE4wsfjhE9pa9UQrzukMZzU988g42xu
         SvsQlJZMCs4z/+jM7beN5eEXwDM144dlEl4dtARVwQrRQOLeHO29HVt/HMY+nmyGBe8i
         SYqMtxxLfso2B85gkydSRBR4YBQ3G1YnisIbXWMr8cMuhuBuqAMCkKGhMn1c04uX0IGo
         vLzlowS/edFZbZl8TZU1RJ5sX/z8E/MWErUuKaDHCXgOXKL04ABcRW9lRabqUwHS73CI
         agf6LmFQ+Vr3nmYCXxLeQ4u8xtgl3l8cOILToYtWMB7gOPUZZPXKiTiEr5sJVHfLMl3S
         NEfQ==
X-Gm-Message-State: AOJu0Yz6Ne3Azmkbz6UR1/i9GtRrsyGBAupbhclQduLgvPz0Ooy3IVnO
	lmf+i1W5DGJhccu7Evb9iY3nsbg3HSVJsrWDHq73ZSjADg+1Dn1Bc6PVMKEbVNwMBAM66s+DJ2W
	gma+XV6JDd+Wa4c+vpdkdXK7ZUy1CA1yHY/kl3pO32iSO4hIcrXyq
X-Gm-Gg: ASbGncu65RqJitT2yeFnuSrAZbOIHKvnSAMDQ8qAxHYZcBlPBRP59wtNUsZLSO/fwNV
	KABY2o9b4caA/yxE/mlwedDZ6JWfFEqCbkQq0U8Pveokzu51LYVySGWhDm8UfRGWwbBGQbmTsrZ
	x54aEvGsZbUSHBPwwlLBSk1n+9nEpCdj+Z/na1cAJeRzdIJiv+02/pW9mZnPb9m1UcYXfKYWNP/
	AzeFHl5NlnT3G1kBL08loSHy5l2P3xHlqSDL6o9lSTzxTUVqat4j98FPufYCPouzZTBr0GfGATn
	5YT/GPpirfvRRIo6iVcxCoIFhUvrURc=
X-Google-Smtp-Source: AGHT+IFbfuQlBneUEKfWWOvzha1mRVIiwNYpGBloVO3yENVrmdBp/JXiof5qABJEZDQbX9t5JbmcF6RgSudg
X-Received: by 2002:a17:902:e80e:b0:22e:50e1:73e with SMTP id d9443c01a7336-23414f49fc9mr210199615ad.14.1748386896913;
        Tue, 27 May 2025 16:01:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-234cc258d87sm105465ad.106.2025.05.27.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 16:01:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 34B2A3406AF;
	Tue, 27 May 2025 17:01:36 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 275EFE539BF; Tue, 27 May 2025 17:01:36 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 27 May 2025 17:01:26 -0600
Subject: [PATCH v7 3/8] selftests: ublk: kublk: tie sqe allocation to io
 instead of queue
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-ublk_task_per_io-v7-3-cbdbaf283baa@purestorage.com>
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
In-Reply-To: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

We currently have a helper ublk_queue_alloc_sqes which the ublk targets
use to allocate SQEs for their own operations. However, as we move
towards decoupled ublk_queues and ublk server threads, this helper does
not make sense anymore. SQEs are allocated from rings, and we will have
one ring per thread to avoid locking. Change the SQE allocation helper
to ublk_io_alloc_sqes. Currently this still allocates SQEs from the io's
queue's ring, but when we fully decouple threads and queues, it will
allocate from the io's thread's ring instead.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/fault_inject.c |  2 +-
 tools/testing/selftests/ublk/file_backed.c  |  6 +++---
 tools/testing/selftests/ublk/kublk.c        |  2 +-
 tools/testing/selftests/ublk/kublk.h        | 16 ++++++++++++----
 tools/testing/selftests/ublk/null.c         |  4 ++--
 tools/testing/selftests/ublk/stripe.c       |  4 ++--
 6 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index 5deff76327b270d2d2d4553c394d95bf27ce8d7e..6e60f7d9712593403ac5547334c86967f0eab8d3 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -46,7 +46,7 @@ static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
 		.tv_nsec = (long long)q->dev->private_data,
 	};
 
-	ublk_queue_alloc_sqes(q, &sqe, 1);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), &sqe, 1);
 	io_uring_prep_timeout(sqe, &ts, 1, 0);
 	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, q->q_id, 1);
 
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 0e86123e309c77ad946eaca33a8f4680b688cd41..922a87108b9f7bae53098e74602c7b1f3e0246bc 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -18,7 +18,7 @@ static int loop_queue_flush_io(struct ublk_queue *q, const struct ublksrv_io_des
 	unsigned ublk_op = ublksrv_get_op(iod);
 	struct io_uring_sqe *sqe[1];
 
-	ublk_queue_alloc_sqes(q, sqe, 1);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
 	io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
 	io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 	/* bit63 marks us as tgt io */
@@ -36,7 +36,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 	void *addr = (zc | auto_zc) ? NULL : (void *)iod->addr;
 
 	if (!zc || auto_zc) {
-		ublk_queue_alloc_sqes(q, sqe, 1);
+		ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
 		if (!sqe[0])
 			return -ENOMEM;
 
@@ -52,7 +52,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 		return 1;
 	}
 
-	ublk_queue_alloc_sqes(q, sqe, 3);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index c3bb52953936134b7ddcf4632b57fdeb57d2d45e..1602cf6f07a02e5dab293b91f301218c38c8f4d9 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -599,7 +599,7 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 	if (io_uring_sq_space_left(&q->ring) < 1)
 		io_uring_submit(&q->ring);
 
-	ublk_queue_alloc_sqes(q, sqe, 1);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
 	if (!sqe[0]) {
 		ublk_err("%s: run out of sqe %d, tag %d\n",
 				__func__, q->q_id, tag);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 424e5d96775fe97b20ad8d5537e468477041ca04..64da26725fe1d840b4c61df38206fb3eecd06c22 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -124,6 +124,8 @@ struct ublk_io {
 	unsigned short flags;
 	unsigned short refs;		/* used by target code only */
 
+	int tag;
+
 	int result;
 
 	unsigned short tgt_ios;
@@ -289,17 +291,23 @@ static inline void ublk_dbg(int level, const char *fmt, ...)
 	}
 }
 
-static inline int ublk_queue_alloc_sqes(struct ublk_queue *q,
+static inline struct ublk_queue *ublk_io_to_queue(const struct ublk_io *io)
+{
+	return container_of(io, struct ublk_queue, ios[io->tag]);
+}
+
+static inline int ublk_io_alloc_sqes(struct ublk_io *io,
 		struct io_uring_sqe *sqes[], int nr_sqes)
 {
-	unsigned left = io_uring_sq_space_left(&q->ring);
+	struct io_uring *ring = &ublk_io_to_queue(io)->ring;
+	unsigned left = io_uring_sq_space_left(ring);
 	int i;
 
 	if (left < nr_sqes)
-		io_uring_submit(&q->ring);
+		io_uring_submit(ring);
 
 	for (i = 0; i < nr_sqes; i++) {
-		sqes[i] = io_uring_get_sqe(&q->ring);
+		sqes[i] = io_uring_get_sqe(ring);
 		if (!sqes[i])
 			return i;
 	}
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index c415bf839e87ba35bc87da523a32745584ee2ae4..9acc7e0d271b5ae52d6d31587cc5bfb63b19778d 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -60,7 +60,7 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	struct io_uring_sqe *sqe[3];
 
-	ublk_queue_alloc_sqes(q, sqe, 3);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
 	sqe[0]->user_data = build_user_data(tag,
@@ -82,7 +82,7 @@ static int null_queue_auto_zc_io(struct ublk_queue *q, int tag)
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	struct io_uring_sqe *sqe[1];
 
-	ublk_queue_alloc_sqes(q, sqe, 1);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
 	__setup_nop_io(tag, iod, sqe[0], q->q_id);
 	return 1;
 }
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 4fc45f42b02ecfe063d88d78644ffc142e122942..97079c3121ef8d4edc71891a289dd40658ce3f2a 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -138,7 +138,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 	io->private_data = s;
 	calculate_stripe_array(conf, iod, s, base);
 
-	ublk_queue_alloc_sqes(q, sqe, s->nr + extra);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, s->nr + extra);
 
 	if (zc) {
 		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
@@ -182,7 +182,7 @@ static int handle_flush(struct ublk_queue *q, const struct ublksrv_io_desc *iod,
 	struct io_uring_sqe *sqe[NR_STRIPE];
 	int i;
 
-	ublk_queue_alloc_sqes(q, sqe, conf->nr_files);
+	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, conf->nr_files);
 	for (i = 0; i < conf->nr_files; i++) {
 		io_uring_prep_fsync(sqe[i], i + 1, IORING_FSYNC_DATASYNC);
 		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);

-- 
2.34.1

