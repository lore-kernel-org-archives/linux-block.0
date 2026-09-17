Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD892DE709
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610948; cv=none; b=FaIQdc7piLDWiuKerKs2EervFhbZChjE/NxyP1H1ehiBFrVllna4GMihY+ZJihcnWR47/p++CTPfro3zLtZkVAhkabB9Azit8azcpn/xoFHSdRlmKL66SndFiyGCzCGnmdWRH86bTQK296b+CaDuqVUHiI2vLQyidopwPuSg1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610948; c=relaxed/simple;
	bh=r7KETro03mbh2peL23HRgFmmLN8WkJ36j9hxUY7twcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRUeJLnfal+mZxKRamJhIRr0pyfC8Zul1a+gmMaMbh2n2GJkW7R1FHl6pVRJSjgiflCkiytUbPVtpmoZTC7IdeHihFyGITeS4ylUj+7cdioOpKZGVdpRNZJ8fHcHaRApTWIIlpC3QgD6s4I+6jmdbLYDkMLy6f6pd2l1l/jqOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=V2Pu+x7P; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="V2Pu+x7P"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-804f7045f3eso117582a34.2
        for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 19:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789610946; x=1790215746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HjEqzoruK2cVKHsNbOug1YqWgRo+jMvoWK8u9zqqC1s=;
        b=V2Pu+x7PKL/dEbo3W+iMapSwU4J4J4ayk0WOx8aDHkal7LkuSl7hwJNt646KuZzNtw
         VLHejUvKS8znN0FFtfYUyezu348Vt16Rr1+g80qCR+PCXjCOfS6vyLrP7PzvEkyQgMfa
         +q3uv6UiAOd2oURXdNgqOA21+sdLRA41lxv/8NU31g6bzqWd9WchchsNhdNVF/17Qtpn
         RmjjXfe9fzYnjec9WgQO/RCpLK0a7f7wES8ROzs+B6YN2kAGdQll3+8Ko80/uZSJr89M
         xvoC99fjqpe5XeihvPixge+2D6KfqgogHLSE/x1QrFfJqwdSZ0URuQaTJ4kfqjiSmkVb
         J56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789610946; x=1790215746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HjEqzoruK2cVKHsNbOug1YqWgRo+jMvoWK8u9zqqC1s=;
        b=YEYUxzJ0XvcgN6V3ZSXSzKw4ejTqy2hJWdRvNZRnEIDP+iAtcbT3/KfEyh3aqCSPaP
         l8CYctEXgZkXbH2E1B+kdH2yVJCb41NL8S/g3hDoRPJdZh1Fu9ThzM+WagKDV8LNQ130
         iJ0WioXDeKjW0s1nUuZbeOKNwnONzTJCmuehT2M2kmJnc38ey7TojKg7fjY+P1IFBqlG
         k+w7vtsBtmvnrd+zowL+LewsW6QL4b56LWSfN8Kvd65tPjtp+gDDU+MnSzYowINFeX4+
         7PZPjeK9jojlYhWGeykfsFetwbhbGqUmp/eDJqRUpvP62CKDT9UJhrU9WF6aQi3p7hqv
         mByQ==
X-Gm-Message-State: AFuF++k/h5KSDUJtG2cFTkvdNjoov46NTtSPJ64QH0gDpPY6HNsGrV/J
	WfZfnbOlLTdDv1ztncI4a4Vneeo+6sZEJXemZ9Kfq0fVQoHOC59Dn5LlZ3q4No0EaDkhHbCCBCP
	qHoyREP3uhC2n5k7dw57Knyj/sUNpAGlSBYAmphpI9wtS/03nMwCV02cWr/aqkJf7qWu0MaKkSj
	78qqwf+c1fxD5DQOBm9BLeOVj5+LW5Qvk6wa0+P59K76tw94W3X8+9DbxhGA==
X-Gm-Gg: AYBFou0/sPLuh+Ixw2lXJewZQao5TqKinoKFg0VqJW5aQS7iw/nsM8sysQGO/W/rVAW
	+VEzcS3ksttVfV8nzllZa9SszQaDarRoA1oXpZIPJWpzd71k+GdWfvqF8eEfOXFrM+gMbFZshdl
	xLhIrSVR1lEm6VPY4OWzHLzaT06vrt+anWbK21rl+T/xmfzK/amTS6JXha5zC97JKprHg2RcpqU
	V/BWMd2/0ih9LZ2BAsIeEpW3IxfqNNjOM6f9o5yfQENBly61zocx4ixgWeEcB7Hzr7IMGQF8AF0
	BZTNFUD89XWxBj5I/tbADG0+J29tIohSTXnV7pGTGdPBd7Tjzi7ZNUvgrYsmkj4AMu4+vjWuBrF
	rGiD8Lh/xgI4DHy9oB4NgW+bpS0O3m5GDKLPrZEIr0LGcANb3kTFFf5pf0iSKugaO/r8m3KjZPJ
	7hHh21PuR/nwKnTu3HLSfmQ/OTfi8F8DTR5HAyM99qVGOaAaLygTdqSZyQ+XbYNU6Q9/PdYBlvd
	ZjEwg7WWYPhlhp0PhsvRbIYOmbPRg7fkInSRZQ=
X-Received: by 2002:a05:6830:2695:b0:7fa:ab72:9e02 with SMTP id 46e09a7af769-80b2f5d9272mr5300245a34.26.1789610945235;
        Wed, 16 Sep 2026 19:09:05 -0700 (PDT)
Received: from dev-mkhalfella.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-80c46cb6675sm1862569a34.16.2026.09.16.19.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 19:09:04 -0700 (PDT)
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
Subject: [PATCH blktests 3/5] src/miniublk: add the inject command
Date: Wed, 16 Sep 2026 20:06:23 -0600
Message-ID: <20260917020752.1672578-4-mkhalfella@purestorage.com>
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

Add a CLI command which arms a delay on a running device:

    miniublk inject -n dev_id -o {read|write} -d delay -c count

It sends one INJECT_DELAY datagram to the device's control port and
waits for the reply, so it returns only once the daemon has armed the
request. A test can therefore arm a delay and start IO immediately
without racing the daemon.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 src/miniublk.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/src/miniublk.c b/src/miniublk.c
index 8dc2a56..2dbd4aa 100644
--- a/src/miniublk.c
+++ b/src/miniublk.c
@@ -48,6 +48,7 @@
 
 #define UBLK_CTRL_PORT_BASE	61000
 #define UBLK_CTRL_MSG_MAGIC	0x6b6c6275
+#define UBLK_CTRL_RCV_TIMEO	3
 
 enum {
 	UBLK_CTRL_CMD_PING		= 0,
@@ -1561,6 +1562,114 @@ static int cmd_dev_list(int argc, char *argv[])
 	return 0;
 }
 
+static int cmd_dev_inject(int argc, char *argv[])
+{
+	static const struct option longopts[] = {
+		{ "number",		1,	NULL, 'n' },
+		{ "op",			1,	NULL, 'o' },
+		{ "delay",		1,	NULL, 'd' },
+		{ "count",		1,	NULL, 'c' },
+		{ "control_port",	1,	NULL, 0},
+		{ NULL }
+	};
+	struct timeval tv = { .tv_sec = UBLK_CTRL_RCV_TIMEO, };
+	struct ublk_ctrl_msg req = {};
+	struct ublk_ctrl_msg rsp;
+	struct sockaddr_in addr;
+	int dev_id = -1, op = -1, delay = 0, count = 1;
+	int ctrl_port = -1;
+	int fd, ret, option_idx, opt;
+
+	while ((opt = getopt_long(argc, argv, "n:o:d:c:",
+				  longopts, &option_idx)) != -1) {
+		switch (opt) {
+		case 'n':
+			dev_id = strtol(optarg, NULL, 10);
+			break;
+		case 'o':
+			if (!strcmp(optarg, "read"))
+				op = UBLK_IO_OP_READ;
+			else if (!strcmp(optarg, "write"))
+				op = UBLK_IO_OP_WRITE;
+			break;
+		case 'd':
+			delay = strtol(optarg, NULL, 10);
+			break;
+		case 'c':
+			count = strtol(optarg, NULL, 10);
+			break;
+		case 0:
+			if (!strcmp(longopts[option_idx].name, "control_port"))
+				ctrl_port = strtol(optarg, NULL, 10);
+			break;
+		}
+	}
+
+	if (dev_id < 0 || op < 0 || delay <= 0 || count <= 0) {
+		ublk_err("%s: -n dev_id -o {read|write} -d delay -c count are required\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	if (ctrl_port < 0)
+		ctrl_port = UBLK_CTRL_PORT_BASE + dev_id;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		ublk_err("%s: can't create socket: %s\n", __func__,
+				strerror(errno));
+		return -errno;
+	}
+	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_port = htons(ctrl_port);
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+
+	/* connect so that a missing daemon shows up as ECONNREFUSED */
+	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		ublk_err("%s: can't connect to port %d: %s\n", __func__,
+				ctrl_port, strerror(errno));
+		ret = -errno;
+		goto out;
+	}
+
+	req.magic = UBLK_CTRL_MSG_MAGIC;
+	req.cmd = UBLK_CTRL_CMD_INJECT_DELAY;
+	req.data[0] = op;
+	req.data[1] = delay;
+	req.data[2] = count;
+
+	if (send(fd, &req, sizeof(req), 0) != sizeof(req)) {
+		ublk_err("%s: can't send to port %d: %s\n", __func__,
+				ctrl_port, strerror(errno));
+		ret = -errno;
+		goto out;
+	}
+
+	if (recv(fd, &rsp, sizeof(rsp), 0) != sizeof(rsp)) {
+		ublk_err("%s: no reply from dev %d on port %d: %s\n", __func__,
+				dev_id, ctrl_port, strerror(errno));
+		ret = -errno;
+		goto out;
+	}
+
+	if (rsp.magic != UBLK_CTRL_MSG_MAGIC) {
+		ublk_err("%s: bad reply from port %d\n", __func__, ctrl_port);
+		ret = -EPROTO;
+		goto out;
+	}
+
+	ret = rsp.ret;
+	if (ret)
+		ublk_err("%s: dev %d rejected the request: %d\n", __func__,
+				dev_id, ret);
+out:
+	close(fd);
+	return ret;
+}
+
 static int cmd_dev_help(int argc, char *argv[])
 {
 	printf("%s add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id] [--control_port port] \n",
@@ -1577,6 +1686,9 @@ static int cmd_dev_help(int argc, char *argv[])
 	printf("%s recover -t {null|loop} [-n dev_id] [--control_port port] \n", argv[0]);
 	printf("\t -t loop -f backing_file \n");
 	printf("\t -t null\n");
+	printf("%s inject -n dev_id -o {read|write} -d delay -c count [--control_port port] \n",
+			argv[0]);
+	printf("\t delay the next <count> <read|write> ios by <delay> seconds\n");
 	return 0;
 }
 
@@ -1915,6 +2027,8 @@ int main(int argc, char *argv[])
 		ret = cmd_dev_help(argc, argv);
 	else if (!strcmp(cmd, "recover"))
 		ret = cmd_dev_recover(argc, argv);
+	else if (!strcmp(cmd, "inject"))
+		ret = cmd_dev_inject(argc, argv);
 out:
 	if (ret)
 		cmd_dev_help(argc, argv);
-- 
2.55.0

