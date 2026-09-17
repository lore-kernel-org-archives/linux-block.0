Received: from mail-oi2-f20.google.com (mail-oi2-f20.google.com [74.125.231.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055037D114
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610944; cv=none; b=Jf4XG9taGo2ZXBgZg3ziB3bQbH41YskXrp+fLZ+qk6iAQZTYfMeUFg1rNxXDuW8knlIi1pI7n7W/k2OnjA0Nsk4ygB4LWVWG6tnL2SiOZsIfHcZE5G6EHiT65b3I2n+yVhBfgrM3Sol1iVNTQoA/R0a6wBDVWDs0bVyu21c40ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610944; c=relaxed/simple;
	bh=js/SLrsKRsJYF6BnEVFNxFyAI2hTwCt6MIGivA/pqfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfywukUROmyWw76/Q/cPM5MacQWrfnYkXKbhc+e3k9OfNxcMCLkJWTlo6Ju8VQBSRM92XjBNzq+JXVR7ItwCh41WzuUpSKAYHGtKF4cgRu7yyifsUL7ZyZbPBc5YHRTPDcqnSPon128jWkcFvNk5v2rjzHcBIc4Nbv0K2Pu/lCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NLqF5gVu; arc=none smtp.client-ip=74.125.231.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NLqF5gVu"
Received: by mail-oi2-f20.google.com with SMTP id 46e09a7af769-7f4f1354076so64906a34.1
        for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 19:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789610941; x=1790215741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWsIfPcWZeg9t2z3OkcKGAkqw8Gv/ELNDs8zkCsdwkM=;
        b=NLqF5gVutBwCoNi9i83vnlmHkIX35P/JaKhQtfYB9C6otCOIvlZpa5j6hTZCVefrw6
         bb9Gfpd0ZzQ+eloo9Jv1c3IlqrQcg0snLIphUtfRQNO51NCGbHoTxVTwsFNcePwad1Av
         v/ZzgIOQkbJI/oWMOnOoIiRAdFkgYPxpvqG51jgnWGPzLQKdnzhfR0MxYkH16jJyF8r/
         m4SME/BHkQDeHYtbwto82U87ZgdNd2dfkKubXwavcDQr5CuOVQvpEpqRqjomvXEKuT3l
         b4VD5A1u6aGHNUEKexRLAxU2Kvop6PtF1UOS6Fk8K30eSLi9WZcCfxX/h0EjEBHhIUHn
         S8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789610941; x=1790215741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWsIfPcWZeg9t2z3OkcKGAkqw8Gv/ELNDs8zkCsdwkM=;
        b=F/VmdHfk9vl1T0BXWX8msqTjOdgEHzRJlMRabtTAU3NfgjSmTJhELHiduXe5KSpHXx
         BQ1sSVbbv9kqjqklOWdBBPKxcYL4ucLCIc/zJPKgamyWKqYRMqIggZso8zr3z8WhTdYY
         SnrTNp7HIehmuGcrM8Q9qHBN1qTLRMdDPDvRSF12kpu1G1ewaIb4V4eUIZ0retuTISOs
         QjURTnSgl2X8Nt1mKa6q+WIav/yAkQYpQoqWW8X9orKP8LmreCXjG5uWyZOL/Po7qa5N
         1uk0LXWPD1Vcu3x6p1IPdMpJGxi3wp2qb3XZF51DqSffOJKJuvVUIqepbrzGslpOqHHg
         wE6w==
X-Gm-Message-State: AFuF++nmwT67o9hr17DVurlXeYR+kS6VALLUGni+U1lyEVnwMfRdo/bp
	R+ENUQrzdsCQ9XBPd2cy2+H4kdxKluRf64TNQ+/r6Ta/ca5NDoLpEVPkMo3JPsp8e+nJwmLStZc
	hsilufQG7kHgJlMFF+7sdZnRZqenp0s2qZ5dY3qKloRQTOK5Z4wM01f19LibHyV/mbETalTH3xo
	OgQX552ShDU/8VAWJkumbhSvgaVz91RCjK2ENo28Hp7gE5FLTTUVj4Aot+tw==
X-Gm-Gg: AYBFou0IAzErG5SW57s5CWCj3KpQtOIKCTGbqBOHTQSt/CBJjmjnj9A/idjFqXdHqMz
	i3wvyWnZDrgfWobqbXJMFTHIgyLDUCoX/sXRPxkFJTBrx+tD549VkwyI/PRNa65a/kL14JOsZgg
	oc4PcUmj3dk+WIYjx3FyY4Ems1jPouz/xJkwe/J3Ab770n/9vnNelk40rMuQ7fHI4DTj9dQP5MN
	iwBIC2AVR0YNVyLU/+cKkDmN/sEcs4yVuTUN5VXaXd65BGsP1ClQjNk/I+QiQQebe3S18kXgyg7
	P+Vcwcpaq2ZlZccvODDnJESRhC38IWmo6SVDKcXS84iP3qzm01m6qdE+0sAANrwWAt6GnQnmHYR
	bqczstdQjaKqH8lpsEOP7Ev5g0KfnBzmB7jcGCtQOWmZOsKLkRd/CoHKVTF0xeXtswQGeMDticP
	+xgUwbOa8wU4U3TfvpoqCdKmVB0fCnG9bep+gMip++w0VEGFWZQqssdrNsot3dEGUPyLxi0MS3P
	/ay9iaC5BTAeZI8XiYR3Z+MKycBUcGNX/hqZRE=
X-Received: by 2002:a05:6830:909:b0:804:e0e8:1a86 with SMTP id 46e09a7af769-80c4b70bb4bmr1513890a34.1.1789610940328;
        Wed, 16 Sep 2026 19:09:00 -0700 (PDT)
Received: from dev-mkhalfella.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-80c46cb6675sm1862569a34.16.2026.09.16.19.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 19:08:59 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Jesse Taube <jtaubepe@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH blktests 2/5] src/miniublk: add IO delay injection
Date: Wed, 16 Sep 2026 20:06:22 -0600
Message-ID: <20260917020752.1672578-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917020752.1672578-1-mkhalfella@purestorage.com>
References: <20260917020752.1672578-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests that exercise error handling in a block driver stacked on ublk need
a way to hold an IO back without failing it. Add an INJECT_DELAY control
command which delays a given number of reads or writes before they are
issued to the target.

The delay is an io_uring timeout on the same ring rather than a sleep in
the queue thread, marked with UBLK_DELAY_MARK in tgt_data to tell its
completion apart from a real IO. It is counted in io_inflight to be
waited for.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 src/miniublk.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/src/miniublk.c b/src/miniublk.c
index 30bd7f5..8dc2a56 100644
--- a/src/miniublk.c
+++ b/src/miniublk.c
@@ -19,6 +19,7 @@
 #include <limits.h>
 #include <string.h>
 #include <errno.h>
+#include <stdatomic.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
@@ -49,7 +50,8 @@
 #define UBLK_CTRL_MSG_MAGIC	0x6b6c6275
 
 enum {
-	UBLK_CTRL_CMD_PING	= 0,
+	UBLK_CTRL_CMD_PING		= 0,
+	UBLK_CTRL_CMD_INJECT_DELAY	= 1,
 };
 
 struct ublk_ctrl_msg {
@@ -84,6 +86,8 @@ struct ublk_io {
 	unsigned int flags;
 
 	unsigned int result;
+
+	struct __kernel_timespec delay_ts;
 };
 
 struct ublk_tgt_ops {
@@ -136,6 +140,10 @@ struct ublk_dev {
 	/* daemon control channel, 0 means it is disabled */
 	int ctrl_port;
 	int ctrl_sock;
+
+	atomic_int inject_op;
+	atomic_int inject_secs;
+	atomic_int inject_count;
 };
 
 #ifndef offsetof
@@ -190,6 +198,13 @@ static inline unsigned int user_data_to_op(__u64 user_data)
 	return (user_data >> 16) & 0xff;
 }
 
+#define UBLK_DELAY_MARK		1
+
+static inline unsigned int user_data_to_tgt_data(__u64 user_data)
+{
+	return (user_data >> 24) & 0xff;
+}
+
 static void ublk_err(const char *fmt, ...)
 {
 	va_list ap;
@@ -509,6 +524,7 @@ static struct ublk_dev *ublk_ctrl_init()
 
 	dev->use_ioctl = true; /* use ioctl opcodes by default */
 	dev->ctrl_sock = -1;
+	dev->inject_op = -1;
 
 	dev->ctrl_fd = open(CTRL_DEV, O_RDWR);
 	if (dev->ctrl_fd < 0) {
@@ -637,6 +653,26 @@ static int ublk_ctrl_msg_handle(struct ublk_dev *dev,
 	case UBLK_CTRL_CMD_PING:
 		rsp->data[0] = dev->dev_info.dev_id;
 		return 0;
+	case UBLK_CTRL_CMD_INJECT_DELAY: {
+		int op = req->data[0];
+		int secs = req->data[1];
+		int count = req->data[2];
+
+		if (op != UBLK_IO_OP_READ && op != UBLK_IO_OP_WRITE)
+			return -EINVAL;
+		if (secs <= 0 || count <= 0)
+			return -EINVAL;
+
+		dev->inject_op = op;
+		dev->inject_secs = secs;
+		/* arm the count last, the request becomes visible at once */
+		dev->inject_count = count;
+
+		ublk_log("dev %d: delay next %d %s io(s) by %d secs\n",
+				dev->dev_info.dev_id, count,
+				op == UBLK_IO_OP_READ ? "read" : "write", secs);
+		return 0;
+	}
 	default:
 		ublk_dbg(UBLK_DBG_DEV, "%s: unknown control command %u\n",
 				__func__, req->cmd);
@@ -773,6 +809,66 @@ static void ublk_dev_unprep(struct ublk_dev *dev)
 	close(dev->fds[0]);
 }
 
+static int ublk_inject_claim(struct ublk_queue *q, unsigned int ublk_op)
+{
+	struct ublk_dev *dev = q->dev;
+	int secs;
+
+	if (dev->inject_count <= 0)
+		return 0;
+
+	if (dev->inject_op != (int)ublk_op)
+		return 0;
+
+	secs = dev->inject_secs;
+	if (secs <= 0)
+		return 0;
+
+	if (atomic_fetch_sub(&dev->inject_count, 1) <= 0) {
+		/* another queue took the last one */
+		atomic_fetch_add(&dev->inject_count, 1);
+		return 0;
+	}
+
+	return secs;
+}
+
+static int ublk_delay_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	unsigned int ublk_op = ublksrv_get_op(iod);
+	struct ublk_io *io = &q->ios[tag];
+	struct io_uring_sqe *sqe;
+	int secs;
+
+	secs = ublk_inject_claim(q, ublk_op);
+	if (!secs)
+		return 0;
+
+	sqe = io_uring_get_sqe(&q->ring);
+	if (!sqe) {
+		ublk_err("%s: run out of sqe %d, tag %d\n", __func__,
+				q->q_id, tag);
+		atomic_fetch_add(&q->dev->inject_count, 1);
+		return 0;
+	}
+
+	io->delay_ts.tv_sec = secs;
+	io->delay_ts.tv_nsec = 0;
+
+	io_uring_prep_timeout(sqe, &io->delay_ts, 0, 0);
+	/* bit63 marks us as tgt io, tgt_data marks us as the delay timeout */
+	sqe->user_data = build_user_data(tag, ublk_op, UBLK_DELAY_MARK, 1);
+
+	q->io_inflight++;
+
+	ublk_dbg(UBLK_DBG_IO, "%s: dev %d q %d tag %d: delay %s io by %d secs\n",
+			__func__, q->dev->dev_info.dev_id, q->q_id, tag,
+			ublk_op == UBLK_IO_OP_READ ? "read" : "write", secs);
+
+	return 1;
+}
+
 static int ublk_queue_io_cmd(struct ublk_queue *q,
 		struct ublk_io *io, unsigned tag)
 {
@@ -896,6 +992,16 @@ static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
 {
 	unsigned tag = user_data_to_tag(cqe->user_data);
 
+	/*
+	 * A delay timeout completes with -ETIME. It is not a real io, so hand
+	 * the tag back to queue_io() instead of completing it.
+	 */
+	if (user_data_to_tgt_data(cqe->user_data) == UBLK_DELAY_MARK) {
+		q->io_inflight--;
+		q->tgt_ops->queue_io(q, tag);
+		return;
+	}
+
 	if (cqe->res < 0 && cqe->res != -EAGAIN)
 		ublk_err("%s: failed tgt io: res %d qid %u tag %u, cmd_op %u\n",
 			__func__, cqe->res, q->q_id,
@@ -937,7 +1043,8 @@ static void ublk_handle_cqe(struct io_uring *r,
 
 	if (cqe->res == UBLK_IO_RES_OK) {
 		ublk_assert(tag < q->q_depth);
-		q->tgt_ops->queue_io(q, tag);
+		if (!ublk_delay_io(q, tag))
+			q->tgt_ops->queue_io(q, tag);
 	} else {
 		/*
 		 * COMMIT_REQ will be completed immediately since no fetching
-- 
2.55.0

