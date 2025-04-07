Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE1253F0D
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031809; cv=none; b=cvTccjEyUxXqkSzeka/MTWurGIUTh5Mmm9K4zIkwt5dzXOlvkOAradR5+nzeC5kzDNsDpe9T2oVTsnXYLLmH/1+Ex/EkmJoKgSh4xyG6Er8o9QND0/eoITv6pTtMXq11XguiaFx320p87svSrINvqhwVkAa/2mle+bzVIEdJj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031809; c=relaxed/simple;
	bh=AqVLJzp+k9sKIx1lFAtIGJO/vdKumpDq+hH08XWyyao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCm6BOV6yHvTWaGwh1j19RShPqgSAZR+P7fPU4VYBB0hHwLRBSaGtvH9CB6SBB4hZK0bGbeSazqkcM4Gwa2Z/7+MzrGX2uCQzJcAA0zcN3jg4niHm7yy9WxVZFJPYBK/Wy3U9W1ATncvI4uqTU2P601AOFAHQpJX/J0udF5tEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8xTCS5q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8xTCS5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CR5/NcCOUu7uSNDryNPBGPUUmiW6o1YhCyLYh3mx2Y=;
	b=e8xTCS5qGV5JYqvpChUzPGNeCgYTokjNDvupTKfD8yR5QA3tdjvJg2RsGS3UIReBscxSWl
	/xlANrE7Z+HhaaEGHXCV2xzLmhHDliRGP63CN3xbogD9H2kWunazj0MIsedtnMWz/PHem0
	yzBMIG6nw7r2Pc5eM2QVFiga67CZ704=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-pyLoih-QOmWs9P7CMEqJzA-1; Mon,
 07 Apr 2025 09:16:41 -0400
X-MC-Unique: pyLoih-QOmWs9P7CMEqJzA-1
X-Mimecast-MFC-AGG-ID: pyLoih-QOmWs9P7CMEqJzA_1744031800
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5288F180AF50;
	Mon,  7 Apr 2025 13:16:40 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DE1D19560AD;
	Mon,  7 Apr 2025 13:16:38 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 11/13] selftests: ublk: support target specific command line
Date: Mon,  7 Apr 2025 21:15:22 +0800
Message-ID: <20250407131526.1927073-12-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Support target specific command line for making related command line code
handling more readable & clean.

Also helps for adding new features.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c  | 59 +++++++++++++++++++++++----
 tools/testing/selftests/ublk/kublk.h  | 20 +++++++--
 tools/testing/selftests/ublk/stripe.c | 28 ++++++++++++-
 3 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 11cc8a1df2b8..2e1963bee21c 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -5,6 +5,8 @@
 
 #include "kublk.h"
 
+#define MAX_NR_TGT_ARG 	64
+
 unsigned int ublk_dbg_mask = UBLK_LOG;
 static const struct ublk_tgt_ops *tgt_ops_list[] = {
 	&null_tgt_ops,
@@ -1203,12 +1205,25 @@ static int cmd_dev_get_features(void)
 
 static int cmd_dev_help(char *exe)
 {
-	printf("%s add -t [null|loop] [-q nr_queues] [-d depth] [-n dev_id] [backfile1] [backfile2] ...\n", exe);
-	printf("\t default: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
+	int i;
+
+	printf("%s add -t [null|loop|stripe] [-q nr_queues] [-d depth] [-n dev_id]\n", exe);
+	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask]\n");
+	printf("\t[target options] [backfile1] [backfile2] ...\n");
+	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
+
+	for (i = 0; i < sizeof(tgt_ops_list) / sizeof(tgt_ops_list[0]); i++) {
+		const struct ublk_tgt_ops *ops = tgt_ops_list[i];
+
+		if (ops->usage)
+			ops->usage(ops);
+	}
+	printf("\n");
+
 	printf("%s del [-n dev_id] -a \n", exe);
-	printf("\t -a delete all devices -n delete specified device\n");
+	printf("\t -a delete all devices -n delete specified device\n\n");
 	printf("%s list [-n dev_id] -a \n", exe);
-	printf("\t -a list all devices, -n list specified device, default -a \n");
+	printf("\t -a list all devices, -n list specified device, default -a \n\n");
 	printf("%s features\n", exe);
 	return 0;
 }
@@ -1225,9 +1240,9 @@ int main(int argc, char *argv[])
 		{ "quiet",		0,	NULL,  0  },
 		{ "zero_copy",          0,      NULL, 'z' },
 		{ "foreground",		0,	NULL,  0  },
-		{ "chunk_size", 	1,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
+	const struct ublk_tgt_ops *ops = NULL;
 	int option_idx, opt;
 	const char *cmd = argv[1];
 	struct dev_ctx ctx = {
@@ -1235,13 +1250,15 @@ int main(int argc, char *argv[])
 		.nr_hw_queues	=	2,
 		.dev_id		=	-1,
 		.tgt_type	=	"unknown",
-		.chunk_size 	= 	65536, 	/* def chunk size is 64K */
 	};
 	int ret = -EINVAL, i;
+	int tgt_argc = 1;
+	char *tgt_argv[MAX_NR_TGT_ARG] = { NULL };
 
 	if (argc == 1)
 		return ret;
 
+	opterr = 0;
 	optind = 2;
 	while ((opt = getopt_long(argc, argv, "t:n:d:q:az",
 				  longopts, &option_idx)) != -1) {
@@ -1272,8 +1289,26 @@ int main(int argc, char *argv[])
 				ublk_dbg_mask = 0;
 			if (!strcmp(longopts[option_idx].name, "foreground"))
 				ctx.fg = 1;
-			if (!strcmp(longopts[option_idx].name, "chunk_size"))
-				ctx.chunk_size = strtol(optarg, NULL, 10);
+			break;
+		case '?':
+			/*
+			 * target requires every option must have argument
+			 */
+			if (argv[optind][0] == '-' || argv[optind - 1][0] != '-') {
+				fprintf(stderr, "every target option requires argument: %s %s\n",
+						argv[optind - 1], argv[optind]);
+				exit(EXIT_FAILURE);
+			}
+
+			if (tgt_argc < (MAX_NR_TGT_ARG - 1) / 2) {
+				tgt_argv[tgt_argc++] = argv[optind - 1];
+				tgt_argv[tgt_argc++] = argv[optind];
+			} else {
+				fprintf(stderr, "too many target options\n");
+				exit(EXIT_FAILURE);
+			}
+			optind += 1;
+			break;
 		}
 	}
 
@@ -1282,6 +1317,14 @@ int main(int argc, char *argv[])
 		ctx.files[ctx.nr_files++] = argv[i++];
 	}
 
+	ops = ublk_find_tgt(ctx.tgt_type);
+	if (ops && ops->parse_cmd_line) {
+		optind = 0;
+
+		tgt_argv[0] = ctx.tgt_type;
+		ops->parse_cmd_line(&ctx, tgt_argc, tgt_argv);
+	}
+
 	if (!strcmp(cmd, "add"))
 		ret = cmd_dev_add(&ctx);
 	else if (!strcmp(cmd, "del"))
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 5b6b473e1c9a..96a5eff436b3 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -61,6 +61,11 @@
 struct ublk_dev;
 struct ublk_queue;
 
+struct stripe_ctx {
+	/* stripe */
+	unsigned int    chunk_size;
+};
+
 struct dev_ctx {
 	char tgt_type[16];
 	unsigned long flags;
@@ -73,14 +78,15 @@ struct dev_ctx {
 	unsigned int	all:1;
 	unsigned int	fg:1;
 
-	/* stripe */
-	unsigned int    chunk_size;
-
 	int _evtfd;
 	int _shmid;
 
 	/* built from shmem, only for ublk_dump_dev() */
 	struct ublk_dev *shadow_dev;
+
+	union {
+		struct stripe_ctx  stripe;
+	};
 };
 
 struct ublk_ctrl_cmd_data {
@@ -117,6 +123,14 @@ struct ublk_tgt_ops {
 	int (*queue_io)(struct ublk_queue *, int tag);
 	void (*tgt_io_done)(struct ublk_queue *,
 			int tag, const struct io_uring_cqe *);
+
+	/*
+	 * Target specific command line handling
+	 *
+	 * each option requires argument for target command line
+	 */
+	void (*parse_cmd_line)(struct dev_ctx *ctx, int argc, char *argv[]);
+	void (*usage)(const struct ublk_tgt_ops *ops);
 };
 
 struct ublk_tgt {
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 179731c3dd6f..5dbd6392d83d 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -281,7 +281,7 @@ static int ublk_stripe_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 			.max_sectors = dev->dev_info.max_io_buf_bytes >> 9,
 		},
 	};
-	unsigned chunk_size = ctx->chunk_size;
+	unsigned chunk_size = ctx->stripe.chunk_size;
 	struct stripe_conf *conf;
 	unsigned chunk_shift;
 	loff_t bytes = 0;
@@ -344,10 +344,36 @@ static void ublk_stripe_tgt_deinit(struct ublk_dev *dev)
 	backing_file_tgt_deinit(dev);
 }
 
+static void ublk_stripe_cmd_line(struct dev_ctx *ctx, int argc, char *argv[])
+{
+	static const struct option longopts[] = {
+		{ "chunk_size", 	1,	NULL,  0  },
+		{ 0, 0, 0, 0 }
+	};
+	int option_idx, opt;
+
+	ctx->stripe.chunk_size = 65536;
+	while ((opt = getopt_long(argc, argv, "",
+				  longopts, &option_idx)) != -1) {
+		switch (opt) {
+		case 0:
+			if (!strcmp(longopts[option_idx].name, "chunk_size"))
+				ctx->stripe.chunk_size = strtol(optarg, NULL, 10);
+		}
+	}
+}
+
+static void ublk_stripe_usage(const struct ublk_tgt_ops *ops)
+{
+	printf("\tstripe: [--chunk_size chunk_size (default 65536)]\n");
+}
+
 const struct ublk_tgt_ops stripe_tgt_ops = {
 	.name = "stripe",
 	.init_tgt = ublk_stripe_tgt_init,
 	.deinit_tgt = ublk_stripe_tgt_deinit,
 	.queue_io = ublk_stripe_queue_io,
 	.tgt_io_done = ublk_stripe_io_done,
+	.parse_cmd_line = ublk_stripe_cmd_line,
+	.usage = ublk_stripe_usage,
 };
-- 
2.47.0

