Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919B377EB8
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610940; cv=none; b=DYtawo72oUtzSGTIokKMd0hiRRpnP/CJUPnjzUmyqOwVyrc4bza7XwjslMM34skV/KNFKSSLAeCdhzxPqkrCmaf6a+RI8gr7gEon1hEtHtAoV5cQKEJHfYlNZWwzU8/tlZyUNXkYFNBIebpRo8aWsWYzW6v9uQh/ivYfVMG3V8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610940; c=relaxed/simple;
	bh=zqV5Xtx/JGhaIuf+8WX8+LcAhoX+WkaIwB77AhdLqyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyEAH1XB6t83uWRj2bQr2+3q1vJDceS6eoKyox4agaC4thxq6srM3ZzsAWngTJv7t6ltZuLISzJ+9HXSFb20qZxftrDc9vtOWh2cHWwhr4ja2LD7Nchgg/0FYMFeIvH4cm6z+rvhatwNOulXd4eUJv3WzGF6xDfWAzCAduc+AAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Y6rwsHnV; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Y6rwsHnV"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-7fcb425fc2bso212029a34.3
        for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 19:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789610934; x=1790215734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANcIDhCuQ9ESTa9GEkc2CmmdyNV+bk4MBxWQhWfy/dI=;
        b=Y6rwsHnV4+m46xaGZ3Fn89mooxm8MfUAXCIP6/XrCyD7RJywuf0RXyX4uRl91cdyik
         YpSEqvE2c15liDMr0hNX+GMx1Xap8uU3U7lHRDSU/RVp3EF/Ue0lTFh2eHgX0PSHPW2e
         mMQDmy95uuwSsx2YOldcz/4PkdfgXZ1U6HV8uiG/iQE3EZrDxOqsG1Oq2WX4tcdKz8uc
         Df/KheqpGT17tjjb1ro7kbX6YlKBD0kNa+FM7G0Y8Vb38oOumCSniszVkrm/kGeGuYjw
         zDeIllvJjUxFHgTo4M/nJB3JW54oKi8MZuUJvtWVIG3w/yE3JWBlDPYZLJp/MLP0vDS9
         8SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789610934; x=1790215734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ANcIDhCuQ9ESTa9GEkc2CmmdyNV+bk4MBxWQhWfy/dI=;
        b=UFRgyWeiTxzpmXqx2RxMsbp6l69PeCW+88GSEs4VhSNTI5aa4htd0ixzlIuNnKGuSz
         IEkpc2LhCt563TWZNRiirKFkfBR+hZ5rdCrXErbGtmj1eahgrqqL1zYhLp5aMA3NB+ni
         ceBWWp4sNeGjRCv9NT0SVoThzrQdgfuOihABQIZ4JxQqr2qrv1Dgoyk3aVuUJFIjuZY5
         4TU9PVp4Fx0Ls6T5Uo1BLgD0FXqwlkeDDIu+9aiDYId7btBRNdMf1QCJF7x/jkGJd3WS
         RuTUOTwXcG2FxRrp7JCRc6JeAXLpz3/Z7u7m8zL6XKXDy2EbOjgT7zM/ub113OuhNue9
         AdNA==
X-Gm-Message-State: AFuF++mdN4Gq0Mmafg5GZpy5ZkRVh/DtLNdPQKA6PPegfllvt4fB3iRS
	orFV1FoWQDbusIRQaWp99l5kDwmWCtEfal+QIAfK/1n2RHjPsg4r9EtvaLfl2GK17Ch6CpQ3AnG
	8KFY+77bGpcqNsjSN2mv6iTA2jmVD0JHk1TH/quk5I/5kfHcZJMw+zzm8//YvgcOZsECNOjkQk/
	eZ8RLg340pYGDBfI5Ss0bbIFLqrD3bkZzJ8xwW+gKhDoKKQzrQ4R6V5kSwVQ==
X-Gm-Gg: AYBFou3lhSk6yB/GLx1nk0dHyHhofEb5gQfoMaiq1PUurS4QyYOWxcCq7B8ebge04wV
	XbYAux2rTI3UuZCWDtrZtr+8oEwAHm0WdBKZ/aoLgoux0P87B6Rwam6eE5AqG+l30K5ZNktzGrI
	APqwujrswObS8v7NEayfjRYwJAFOn8/LLghhSqhN2zYvvngY4kkW4dAExOmoXS6QGUDam4PnLoe
	OonTKoX7TTfZ4S9LhPsKZk/bj8MfH2bp6EOALn8nvo8QeLb7Wf4RIc3DwiPnDy8HLANyM8/4Rev
	AzFc0kEazKYVR1NFCHhhBlGecVSuBW6FtD2Du+Xcl0ViBaNNtJloHkbbfpT5qUz4+lDH8+pa76y
	1KYYbpvsaLYlctHz80rkZc+MRDDUjI3JfJwMIzc4uAn0X0YfGRnx+xGYW+j7l6kGPQPChFYmdci
	T4DWGD8UMlp2yTIqbmU/++lOXVEmTG3mvNcx8Upi2OYaN8ga3Ghvb6lk44vKeSCkrlNVC38yrc6
	COQfDRy95hHi8D7/AfcG11n9XjmZPeOjhlYXQw=
X-Received: by 2002:a05:6830:25d0:b0:809:e731:cac7 with SMTP id 46e09a7af769-80b2eb534demr5868810a34.29.1789610934345;
        Wed, 16 Sep 2026 19:08:54 -0700 (PDT)
Received: from dev-mkhalfella.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-80c46cb6675sm1862569a34.16.2026.09.16.19.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 19:08:53 -0700 (PDT)
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
Subject: [PATCH blktests 1/5] src/miniublk: add a control channel to the daemon
Date: Wed, 16 Sep 2026 20:06:21 -0600
Message-ID: <20260917020752.1672578-2-mkhalfella@purestorage.com>
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

There is currently no way to talk to a running ublk server. Every command
goes through /dev/ublk-control and is handled by the driver. Also, the
daemon only blocks on its per-queue io_uring.

Give it a loopback UDP socket served by a detached thread, one reply
datagram per request. The only command so far is PING, which returns the
device id and exists to exercise the transport. The port defaults to
61000 plus the device id. --control_port on "add" and "recover" overrides
it, and 0 disables it.

The listener is detached and never joined. It blocks in recvfrom() until
the process exits, and ublk_dev_unprep() closes the socket without
waking it, which is harmless because the daemon exits immediately
afterwards.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 src/miniublk.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 2 deletions(-)

diff --git a/src/miniublk.c b/src/miniublk.c
index b0c308b..30bd7f5 100644
--- a/src/miniublk.c
+++ b/src/miniublk.c
@@ -22,6 +22,8 @@
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
 #include <liburing.h>
 #include <linux/ublk_cmd.h>
 
@@ -43,6 +45,22 @@
 #define UBLK_DBG_CTRL_CMD       (1U << 4)
 #define UBLK_LOG		(1U << 5)
 
+#define UBLK_CTRL_PORT_BASE	61000
+#define UBLK_CTRL_MSG_MAGIC	0x6b6c6275
+
+enum {
+	UBLK_CTRL_CMD_PING	= 0,
+};
+
+struct ublk_ctrl_msg {
+	__u32	magic;
+	union {
+		__u32	cmd;
+		__s32	ret;
+	};
+	__u64	data[3];
+};
+
 struct ublk_dev;
 struct ublk_queue;
 
@@ -114,6 +132,10 @@ struct ublk_dev {
 	int ctrl_fd;
 	bool use_ioctl;
 	struct io_uring ring;
+
+	/* daemon control channel, 0 means it is disabled */
+	int ctrl_port;
+	int ctrl_sock;
 };
 
 #ifndef offsetof
@@ -486,6 +508,7 @@ static struct ublk_dev *ublk_ctrl_init()
 	int ret;
 
 	dev->use_ioctl = true; /* use ioctl opcodes by default */
+	dev->ctrl_sock = -1;
 
 	dev->ctrl_fd = open(CTRL_DEV, O_RDWR);
 	if (dev->ctrl_fd < 0) {
@@ -607,6 +630,109 @@ static int ublk_queue_init(struct ublk_queue *q)
 	return -ENOMEM;
 }
 
+static int ublk_ctrl_msg_handle(struct ublk_dev *dev,
+		const struct ublk_ctrl_msg *req, struct ublk_ctrl_msg *rsp)
+{
+	switch (req->cmd) {
+	case UBLK_CTRL_CMD_PING:
+		rsp->data[0] = dev->dev_info.dev_id;
+		return 0;
+	default:
+		ublk_dbg(UBLK_DBG_DEV, "%s: unknown control command %u\n",
+				__func__, req->cmd);
+		return -EINVAL;
+	}
+}
+
+static void *ublk_ctrl_sock_fn(void *data)
+{
+	struct ublk_dev *dev = data;
+	struct sockaddr_in peer;
+	struct ublk_ctrl_msg req;
+	struct ublk_ctrl_msg rsp;
+	socklen_t peer_len;
+	ssize_t len;
+
+	for (;;) {
+		peer_len = sizeof(peer);
+		len = recvfrom(dev->ctrl_sock, &req, sizeof(req), 0,
+				(struct sockaddr *)&peer, &peer_len);
+		if (len < 0) {
+			if (errno == EINTR)
+				continue;
+			ublk_err("dev %d: control socket recv failed: %s\n",
+					dev->dev_info.dev_id, strerror(errno));
+			break;
+		}
+
+		if (len != sizeof(req) || req.magic != UBLK_CTRL_MSG_MAGIC) {
+			ublk_dbg(UBLK_DBG_DEV,
+				"%s: dropped %zd byte datagram\n", __func__,
+				len);
+			continue;
+		}
+
+		memset(&rsp, 0, sizeof(rsp));
+		rsp.magic = UBLK_CTRL_MSG_MAGIC;
+		rsp.ret = ublk_ctrl_msg_handle(dev, &req, &rsp);
+
+		if (sendto(dev->ctrl_sock, &rsp, sizeof(rsp), 0,
+				(struct sockaddr *)&peer, peer_len) < 0)
+			ublk_dbg(UBLK_DBG_DEV, "%s: reply failed: %s\n",
+					__func__, strerror(errno));
+	}
+
+	return NULL;
+}
+
+static void ublk_ctrl_sock_init(struct ublk_dev *dev)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_port = htons(dev->ctrl_port),
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	int dev_id = dev->dev_info.dev_id;
+	pthread_t thread;
+	int fd, ret;
+
+	if (!dev->ctrl_port)
+		return;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		ublk_err("dev %d: can't create control socket: %s\n",
+				dev_id, strerror(errno));
+		return;
+	}
+
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		ublk_err("dev %d: can't bind control port %d: %s\n",
+				dev_id, dev->ctrl_port, strerror(errno));
+		close(fd);
+		return;
+	}
+
+	dev->ctrl_sock = fd;
+
+	/*
+	 * The listener is detached and never joined. It blocks in recvfrom()
+	 * until the daemon exits, and goes away with the process.
+	 */
+	ret = pthread_create(&thread, NULL, ublk_ctrl_sock_fn, dev);
+	if (ret) {
+		ublk_err("dev %d: can't start control thread: %s\n",
+				dev_id, strerror(ret));
+		close(fd);
+		dev->ctrl_sock = -1;
+		return;
+	}
+	pthread_detach(thread);
+
+	ublk_log("dev %d: control socket listening on 127.0.0.1:%d\n",
+			dev_id, dev->ctrl_port);
+}
+
 static int ublk_dev_prep(struct ublk_dev *dev)
 {
 	int dev_id = dev->dev_info.dev_id;
@@ -621,6 +747,8 @@ static int ublk_dev_prep(struct ublk_dev *dev)
 		goto fail;
 	}
 
+	ublk_ctrl_sock_init(dev);
+
 	if (dev->dev_info.state != UBLK_S_DEV_QUIESCED && dev->tgt.ops->init_tgt)
 		ret = dev->tgt.ops->init_tgt(dev);
 
@@ -635,6 +763,11 @@ fail:
 
 static void ublk_dev_unprep(struct ublk_dev *dev)
 {
+	if (dev->ctrl_sock >= 0) {
+		close(dev->ctrl_sock);
+		dev->ctrl_sock = -1;
+	}
+
 	if (dev->tgt.ops->deinit_tgt)
 		dev->tgt.ops->deinit_tgt(dev);
 	close(dev->fds[0]);
@@ -968,6 +1101,7 @@ static int cmd_dev_add(int argc, char *argv[])
 		{ "queues",		1,	NULL, 'q' },
 		{ "depth",		1,	NULL, 'd' },
 		{ "recovery",		0,	NULL, 'r' },
+		{ "control_port",	1,	NULL, 0},
 		{ "debug_mask",	1,	NULL, 0},
 		{ "quiet",	0,	NULL, 0},
 		{ NULL }
@@ -978,6 +1112,7 @@ static int cmd_dev_add(int argc, char *argv[])
 	int ret, option_idx, opt;
 	const char *tgt_type = NULL;
 	int dev_id = -1;
+	int ctrl_port = -1;
 	unsigned nr_queues = 2, depth = UBLK_QUEUE_DEPTH;
 	int user_recovery = 0;
 
@@ -1000,6 +1135,8 @@ static int cmd_dev_add(int argc, char *argv[])
 			user_recovery = 1;
 			break;
 		case 0:
+			if (!strcmp(longopts[option_idx].name, "control_port"))
+				ctrl_port = strtol(optarg, NULL, 10);
 			if (!strcmp(longopts[option_idx].name, "debug_mask"))
 				ublk_dbg_mask = strtol(optarg, NULL, 16);
 			if (!strcmp(longopts[option_idx].name, "quiet"))
@@ -1047,6 +1184,9 @@ static int cmd_dev_add(int argc, char *argv[])
 		goto fail;
 	}
 
+	if (ctrl_port < 0)
+		ctrl_port = UBLK_CTRL_PORT_BASE + dev->dev_info.dev_id;
+	dev->ctrl_port = ctrl_port;
 	ret = ublk_start_daemon(dev, false);
 	if (ret < 0) {
 		ublk_err("%s: can't start daemon id %d, type %s\n",
@@ -1066,6 +1206,7 @@ static int cmd_dev_recover(int argc, char *argv[])
 	static const struct option longopts[] = {
 		{ "type",		1,	NULL, 't' },
 		{ "number",		1,	NULL, 'n' },
+		{ "control_port",	1,	NULL, 0},
 		{ "debug_mask",	1,	NULL, 0},
 		{ "quiet",	0,	NULL, 0},
 		{ NULL }
@@ -1076,6 +1217,7 @@ static int cmd_dev_recover(int argc, char *argv[])
 	int ret, option_idx, opt;
 	const char *tgt_type = NULL;
 	int dev_id = -1;
+	int ctrl_port = -1;
 
 	while ((opt = getopt_long(argc, argv, "-:t:n:d:q:",
 				  longopts, &option_idx)) != -1) {
@@ -1087,6 +1229,8 @@ static int cmd_dev_recover(int argc, char *argv[])
 			tgt_type = optarg;
 			break;
 		case 0:
+			if (!strcmp(longopts[option_idx].name, "control_port"))
+				ctrl_port = strtol(optarg, NULL, 10);
 			if (!strcmp(longopts[option_idx].name, "debug_mask"))
 				ublk_dbg_mask = strtol(optarg, NULL, 16);
 			if (!strcmp(longopts[option_idx].name, "quiet"))
@@ -1126,6 +1270,9 @@ static int cmd_dev_recover(int argc, char *argv[])
 		goto fail;
 	}
 
+	if (ctrl_port < 0)
+		ctrl_port = UBLK_CTRL_PORT_BASE + dev->dev_info.dev_id;
+	dev->ctrl_port = ctrl_port;
 	dev->tgt.ops = ops;
 	dev->tgt.argc = argc;
 	dev->tgt.argv = argv;
@@ -1309,16 +1456,18 @@ static int cmd_dev_list(int argc, char *argv[])
 
 static int cmd_dev_help(int argc, char *argv[])
 {
-	printf("%s add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id] \n",
+	printf("%s add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id] [--control_port port] \n",
 			argv[0]);
 	printf("\t default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)\n");
 	printf("\t -t loop -f backing_file \n");
 	printf("\t -t null\n");
+	printf("\t --control_port default %d+dev_id, 0 disables the control socket\n",
+			UBLK_CTRL_PORT_BASE);
 	printf("%s del [-n dev_id] -a \n", argv[0]);
 	printf("\t -a delete all devices -n delete specified device\n");
 	printf("%s list [-n dev_id] -a \n", argv[0]);
 	printf("\t -a list all devices, -n list specified device, default -a \n");
-	printf("%s recover -t {null|loop} [-n dev_id] \n", argv[0]);
+	printf("%s recover -t {null|loop} [-n dev_id] [--control_port port] \n", argv[0]);
 	printf("\t -t loop -f backing_file \n");
 	printf("\t -t null\n");
 	return 0;
-- 
2.55.0

