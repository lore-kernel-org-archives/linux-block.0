Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3E423E8A
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791691; cv=none; b=LhjRyaF3w2c1loP8gNYqL3Ns3I5c4iFoRTiT+fo6hLGcvoSyFO/5ifJtESGY7fyY9Q4UjOFOtfMfVjFPQ42i2cJUUagq01loq/8+ftEf3zGwBFGMV5Bfl8BIyDNzhGnCS3uu58zdBHJ76SHCac7GEZZyPjCy9BQEe52QuCdQvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791691; c=relaxed/simple;
	bh=KeIyb5xZKfQ4JDv9mZHP1us5dt4PFZ7cWzMj3sugzT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kj+ByV6bGCVZy95cwSr8WSqu1fNyQ9yFp0aEfJtp7Cfbg4/1amsvqILZd/9SWjcwa3kssKlzXQmYZf8zagQJJEL7+ETR5NBEdh0UNRW+PwSD9CiFp4HR3CX3bF2eZawZeE4smeJVT0TKOpTDDUOOJgfE56tWotah9bz8PAAxk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CJP6TYBf; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CJP6TYBf"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2cf49dc28ccso4964215ad.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785791686; x=1786396486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJFQX9w+WNzPqwmbcIl1aG5997/wz45rR1Xtro/0Q4Y=;
        b=CJP6TYBfcN/Uaf89CY3PdbjPLfAdnt+RGhjNDTw3BGowZ7jdHh7bFjF14ziieJ7nkP
         JFQUPK8RtMK2gFQuEygz0+s2Ad83s5DBNGv29GBumwzv9H598SeEa5NBxzQTVox8t4tG
         KxtVY46AKk7ZQPSOsuch3UY+btpIk6A3mKXJWWGEJPS5ylp+kCSJo4KAXeNMdixEjT5g
         tzwjTt3T5FeU7yRhXl3+CVMlNASM9yTW2fNVg8+UPWgbaFMWNLw51sU7PIapo1a/DhUb
         pDUjQEARJ3YWLxYAUWPMf9DZxA1SXrO/hLrXEoktBl45VxOJziR3BI7QFKNgL8D+iac3
         LdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791686; x=1786396486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OJFQX9w+WNzPqwmbcIl1aG5997/wz45rR1Xtro/0Q4Y=;
        b=LWfYfanHXJ6l7VaEnFte156jUpwiTChbTeoSIPd55CxcYwdqRZ6OwEth+QraaXEVdG
         2Z9hgQI+CIbjXegCbmlDSLFcX9TYS8HwEu5BmXaJz5p9u0cy5LAnaLWGw49We5Zj66Bu
         Fk22PNE2SKTewNwfxLCtjAGxMXmZk8Cfk3/PASb1RywqVii7rhavwD/VEFiuhcW2BuZQ
         qLLIqs1RakguyPkKtoGx2TzThWVXF/bZzJcTm6rhDsoZnwG594uwHJpgPvgvTVlHW6Dc
         +6ez814waY4CVHQxiknlpnGKADVTKkpa4myBocTyTl7L3yxzLlAhjDrUMcizWTZfoA4H
         PnQg==
X-Gm-Message-State: AOJu0Yz1dNf3bXYWY8a6ITdqmZj3zs0ak2MxBxZjh6kx8KCVPYE7pY2D
	v/q4v5I6hN4Z7/h/Ofid8/zDd0fcqSnDjrQgD0Gy5drg1uT1seVPy7+ozkN8RiBOdxJgFw+hBow
	WZiEAhIF9wuK4gjFs1lY2kCbfJNkpr8UHjFQBxK9wZTpwPKueAbGY
X-Gm-Gg: AR+sD11dXatTjphbHEGiVVj//g6I7lwyc5LcdFzKBbKydaj8sXNbWEWGvtuE8jRl6OV
	+LlIp/v4VFGOSXoWnPFfkIb4ckXRy37kDU7U9pCLlPRncOQlVz6U1bP82sL7R30iUoxgWmFCYAF
	SGpOtWoGcE61KLEXveTXaWMXqmYwnAUv7no8F6ZnlKp44zEBLvLNBUR1lnm6I647UBUiq4E3HbD
	0a+Ph6kI7N56vv6L+PdKVdqtuL6aKldWPGnEw0RU7kS5RMSl8rrc90KYMzAIux5ft2Vzx1KCpv4
	mFtJjPSE5WIxIVwd4BGiKap1Vi5Jgdwjb98uoKR+L8QOKC9uQ6i9SWrZMMQX9LF5fI0S0Hl88q1
	95pwkEbnNME2C030FOQ==
X-Received: by 2002:a17:902:dad1:b0:2c4:397:dd7a with SMTP id d9443c01a7336-2d05296eb89mr158008895ad.4.1785791686265;
        Mon, 03 Aug 2026 14:14:46 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d04b0fc2dasm4928015ad.32.2026.08.03.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:14:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 860DC43962;
	Mon,  3 Aug 2026 15:14:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 83074E4041D; Mon,  3 Aug 2026 15:14:45 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 6/8] selftests: ublk: add support for --io_desc_size
Date: Mon,  3 Aug 2026 15:14:38 -0600
Message-ID: <20260803211441.2538144-7-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803211441.2538144-1-csander@purestorage.com>
References: <20260803211441.2538144-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an optional --io_desc_size argument to the kublk add/recover
commands to enable UBLK_F_IO_DESC on the ublk device. The mmap()
arguments and ublk_get_iod() computation are adjusted accordingly.

Display the configured io_desc_size in the kublk list output for ublk
devices with UBLK_F_IO_DESC.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 29 +++++++++++++++++++---------
 tools/testing/selftests/ublk/kublk.h |  6 ++++--
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 5c4a1f18d0a3..0e3e2d74cc4d 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -350,10 +350,12 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
 			info->dev_id, info->nr_hw_queues, info->queue_depth,
 			1 << p.basic.logical_bs_shift, p.basic.dev_sectors);
 	ublk_log("\tmax rq size %d daemon pid %d flags 0x%llx state %s\n",
 			info->max_io_buf_bytes, info->ublksrv_pid, info->flags,
 			ublk_dev_state_desc(dev));
+	if (info->flags & UBLK_F_IO_DESC_SIZE)
+		ublk_log("\tio_desc_size %u\n", info->io_desc_size);
 
 	if (affinity) {
 		char buf[512];
 		int i;
 
@@ -398,26 +400,26 @@ static struct ublk_dev *ublk_ctrl_init(void)
 	dev->nr_fds = 1;
 
 	return dev;
 }
 
-static int __ublk_queue_cmd_buf_sz(unsigned depth)
+static size_t __ublk_queue_cmd_buf_sz(const struct ublk_queue *q, __u16 depth)
 {
-	int size =  depth * sizeof(struct ublksrv_io_desc);
-	unsigned int page_sz = getpagesize();
+	size_t size = depth * (size_t)q->io_desc_size;
+	size_t page_sz = getpagesize();
 
 	return round_up(size, page_sz);
 }
 
-static int ublk_queue_max_cmd_buf_sz(void)
+static size_t ublk_queue_max_cmd_buf_sz(const struct ublk_queue *q)
 {
-	return __ublk_queue_cmd_buf_sz(UBLK_MAX_QUEUE_DEPTH);
+	return __ublk_queue_cmd_buf_sz(q, UBLK_MAX_QUEUE_DEPTH);
 }
 
-static int ublk_queue_cmd_buf_sz(struct ublk_queue *q)
+static size_t ublk_queue_cmd_buf_sz(const struct ublk_queue *q)
 {
-	return __ublk_queue_cmd_buf_sz(q->q_depth);
+	return __ublk_queue_cmd_buf_sz(q, q->q_depth);
 }
 
 static void ublk_queue_deinit(struct ublk_queue *q)
 {
 	int i;
@@ -451,26 +453,27 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags,
 			   __u8 metadata_size)
 {
 	struct ublk_dev *dev = q->dev;
 	int depth = dev->dev_info.queue_depth;
 	int i;
-	int cmd_buf_size, io_buf_size, integrity_size;
+	size_t cmd_buf_size, io_buf_size, integrity_size;
 	unsigned long off;
 
 	pthread_spin_init(&q->lock, PTHREAD_PROCESS_PRIVATE);
 	q->tgt_ops = dev->tgt.ops;
 	q->flags = 0;
 	q->q_depth = depth;
 	q->flags = dev->dev_info.flags;
 	q->flags |= extra_flags;
 	q->metadata_size = metadata_size;
+	q->io_desc_size = dev->dev_info.io_desc_size;
 
 	/* Cache fd in queue for fast path access */
 	q->ublk_fd = dev->fds[0];
 
 	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
-	off = UBLKSRV_CMD_BUF_OFFSET + q->q_id * ublk_queue_max_cmd_buf_sz();
+	off = UBLKSRV_CMD_BUF_OFFSET + q->q_id * ublk_queue_max_cmd_buf_sz(q);
 	q->io_cmd_buf = mmap(0, cmd_buf_size, PROT_READ,
 			MAP_SHARED | MAP_POPULATE, dev->fds[0], off);
 	if (q->io_cmd_buf == MAP_FAILED) {
 		ublk_err("ublk dev %d queue %d map io_cmd_buf failed %m\n",
 				q->dev->dev_info.dev_id, q->q_id);
@@ -1706,10 +1709,11 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 
 	info = &dev->dev_info;
 	info->dev_id = ctx->dev_id;
 	info->nr_hw_queues = nr_queues;
 	info->queue_depth = depth;
+	info->io_desc_size = ctx->io_desc_size;
 	info->flags = ctx->flags;
 	if ((features & UBLK_F_QUIESCE) &&
 			(info->flags & UBLK_F_USER_RECOVERY))
 		info->flags |= UBLK_F_QUIESCE;
 	dev->nthreads = nthreads;
@@ -2067,10 +2071,11 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\t[-e 0|1 ] [-i 0|1] [--no_ublk_fixed_fd]\n");
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
 		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
 	printf("\t[--batch|-b] [--no_auto_part_scan]\n");
+	printf("\t[--io_desc_size SIZE]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
 
 	for (i = 0; i < ARRAY_SIZE(tgt_ops_list); i++) {
@@ -2144,10 +2149,11 @@ int main(int argc, char *argv[])
 		{ "batch",              0,      NULL, 'b'},
 		{ "no_auto_part_scan",	0,	NULL,  0 },
 		{ "shmem_zc",		0,	NULL,  0  },
 		{ "htlb",		1,	NULL,  0  },
 		{ "rdonly_shmem_buf",	0,	NULL,  0  },
+		{ "io_desc_size",	1,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
 	int option_idx, opt;
 	const char *cmd = argv[1];
@@ -2156,10 +2162,11 @@ int main(int argc, char *argv[])
 		.queue_depth	=	128,
 		.nr_hw_queues	=	2,
 		.dev_id		=	-1,
 		.tgt_type	=	"unknown",
 		.csum_type	=	LBMD_PI_CSUM_NONE,
+		.io_desc_size	=	sizeof(struct ublksrv_io_desc),
 	};
 	int ret = -EINVAL, i;
 	int tgt_argc = 1;
 	char *tgt_argv[MAX_NR_TGT_ARG] = { NULL };
 	int value;
@@ -2265,10 +2272,14 @@ int main(int argc, char *argv[])
 				ctx.flags |= UBLK_F_SHMEM_ZC;
 			if (!strcmp(longopts[option_idx].name, "htlb"))
 				ctx.htlb_path = strdup(optarg);
 			if (!strcmp(longopts[option_idx].name, "rdonly_shmem_buf"))
 				ctx.rdonly_shmem_buf = 1;
+			if (!strcmp(longopts[option_idx].name, "io_desc_size")) {
+				ctx.flags |= UBLK_F_IO_DESC_SIZE;
+				ctx.io_desc_size = strtoul(optarg, NULL, 0);
+			}
 			break;
 		case '?':
 			/*
 			 * target requires every option must have argument
 			 */
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 742c41d77df1..15b56ff45bb6 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -85,10 +85,11 @@ struct dev_ctx {
 	__u32 integrity_flags;
 	__u8 metadata_size;
 	__u8 pi_offset;
 	__u8 csum_type;
 	__u8 tag_size;
+	__u16 io_desc_size;
 
 	int _evtfd;
 	int _shmid;
 
 	/* built from shmem, only for ublk_dump_dev() */
@@ -185,10 +186,11 @@ struct ublk_queue {
 #define UBLKS_Q_NO_UBLK_FIXED_FD	(1ULL << 62)
 #define UBLKS_Q_PREPARED	(1ULL << 61)
 	__u64 flags;
 	int ublk_fd;	/* cached ublk char device fd */
 	__u8 metadata_size;
+	__u16 io_desc_size;
 	struct ublk_io ios[UBLK_QUEUE_DEPTH];
 
 	/* used for prep io commands */
 	pthread_spinlock_t lock;
 };
@@ -459,13 +461,13 @@ static inline void ublk_mark_io_done(struct ublk_io *io, int res)
 {
 	io->flags |= (UBLKS_IO_NEED_COMMIT_RQ_COMP | UBLKS_IO_FREE);
 	io->result = res;
 }
 
-static inline const struct ublksrv_io_desc *ublk_get_iod(const struct ublk_queue *q, int tag)
+static inline const struct ublksrv_io_desc *ublk_get_iod(const struct ublk_queue *q, __u16 tag)
 {
-	return &q->io_cmd_buf[tag];
+	return (void *)q->io_cmd_buf + tag * (size_t)q->io_desc_size;
 }
 
 static inline void ublk_set_sqe_cmd_op(struct io_uring_sqe *sqe, __u32 cmd_op)
 {
 	__u32 *addr = (__u32 *)&sqe->off;
-- 
2.54.0

