Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205925;
	b=sjibrnBbK5jVTzUPCFy3dcrgQD8oMPHWatoAIPpDtLEJI0Oa3G3zdsH4t13daT9in8jr
	 z+a4hnKdU0Fyp4QwyACgB5OqrVHvmfnCCykyhfmHkSN4OReXgVDHdAa4U//uNNzaZ4oHv
	 l+c2GHUM5hZgZM4ka6GlZKRn/T3o9v4ggOBviOchV7x1vtP/A1YScHeXskPHuu9ULptUo
	 rjHAOT54AqLvjZnTw1LscP5z45ygyvRhKMW1dDrc4R3ZpnaG8RklRl2zLZLvySgkwJkx7
	 bxy//6JlbkzfjJROfflvphH9k49cClVauYsVjBoLS4IkFRa1+KGMh7nWPloU+csaAaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QEaQJfEEIbY61jsxGwKVG7o/rTDRrUfEnv+2DqsWckI=;
	b=k+1Snc+VboN3B2cCXi0Bw5WOY0RX4iexMI3dsLNuNCanHQSnLd65BwRSeZ/ujsaRQPEI
	 vVWa444lb1OEWAj/I03GEC42x+vAyMk037aDepYt3Vl4f73DSCjAER2nENanD4kpN6lxQ
	 FKwxGCfjvcktjmQFFZdgLQTdHhT4/ifVdWKfdsVo5l9opkCcIgQfjqfgpE/wr2sqKQniB
	 ZHWH8HW1EzNnzgVXsSk1QD90DdWkD5qoxAjstRpKoXRhCT+SmO/0ZJ4GEIfJXU+XECsoY
	 0v6bPcUSm4C6+JuTbSBS0gXF6VepE6JOb7k/GepW6Y58KW56tAZ37e5NBy5YQTEhBrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tquE5M5Y;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5FA606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC5FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tquE5M5Y
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-833e671ee9fso1222748a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205923; x=1793810723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEaQJfEEIbY61jsxGwKVG7o/rTDRrUfEnv+2DqsWckI=;
        b=tquE5M5YAW58JN2/JrW7G6y56UQQnKV16K3nBJ8ZPNxcxX4NbTz+Q0XEFe8JEHz1xu
         +oFekw90x6QlTPs4MCgmHMb3JCnmkRfoui0PjTjH2Qz8kdJcEuONoHO7Ro7XljBuyP3J
         UnnCQzUcebdH/b/JwQiFn7WeusunNM8BQZ0/YJ/bXPirUO3de4jjVJPrEQ9CH4CWYqvO
         fcWB/eYesk+gZz4KhhuXmVjh2aUAb7PQFlveTglpp24uc58LiA0m6gAQ6Z5PzfrcO45J
         qTHA3lhkp3sWBkdm6GnTUaejh4DeWfKtE2c5LfvpOzEiSplc8Q97uZn4T3O15OW34zdc
         6O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205923; x=1793810723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEaQJfEEIbY61jsxGwKVG7o/rTDRrUfEnv+2DqsWckI=;
        b=2K2yima1rpVOq43XEKlLO8CWlwglV2DFod9ncDMMZqhZjyRRFZuKJBALkO77PBqTd0
         CyH8FgSK+1GrcFK1SdrFtUS7Mbc2N3WY12iN3us8QgZvp7wzcu2A1JhBusyFSLQhdLII
         eLtwJZNY5oXz1Zpe9aav58cSTMOyAqM6gbIt8Q2EFojN5/xU9JPVY2r9f/QINddQGoxB
         yzCUbHW3rPYyCAK0zhj+VOwUaFsGi3PgCxYX8RrxuijU/b2uAmu7UkzJDtHb88QVOtAL
         BvISzVEzeuwEzyTB/z0o8eYcsQcmZt+N6yegFqs8Rw4w6ADCXSbXeyszm+h0BAwwsbkU
         7Kbg==
X-Gm-Message-State: AFq9FYIw7i9odWGBrPCSrzghfkh24FoLJcMwDlSRTEujZ5LX5wntnA3w
	FBldMJGGAAxfIXS78OqGx+L3y1yOslJ7VuEIXCBxm0+kJT0xN1cnZ8SEVnLfZX8Jd1swxqiY2b6
	+z09kie8=
X-Gm-Gg: AYBFou3XepXfiJEDb8bHSgYTyXaTuBd4D9LepceaD5nOyCuvmhbmn9poUqxUyaYtMIM
	84XB2t0VnjgeI0j6FfmZAJralaJLB1vAwqDZwSGNA/GMn9VMERrFRuKAD+7LRlaxvz6lGKXqeSP
	Dr6Phy3D9SWj2mcHHf7FVTFcDM59w4znpSmJsKj+CClQxp3tiSvuJJYQinMRRGbBv8CWmxXOu2h
	U0E1dfiJH7H+7SOpVv0exen8ZudKVxYdZJzO5vsY/HLAFYrHpK2nm1z/p6D0hpCgEib60uoCJLc
	mp7EsyelZagsS0ok1A6db/VMakztinVr6Z7P6lZQ8Q8v7XyvMraizSgvxGXw3tPTYVmfzloWuWg
	6+Sn/M8IVwXSvGDIAd7HcsVkZ4/8wYT30b+PlJsUqKIOOAkJUKl8XOZ/zoUZjlC+sbUfAgVaJ5V
	F+DUw1sB/wXiho9DodH11x7MY+NtGd8pkRbf66N9xCtt3hhAKHicmwA13uDFVZr1WdioFP4DzWv
	yzgMZhvKj3jxh5xPVmU+AzG6A+N/o7AMgMzcjY6HJPHc3ZH07XhGOuQVIO66RLFcWYd57LQ/SLK
	3U4Kzg7SpDE7kXpsjiA6h34fwW5AGjcsq6fmGtjwPe11zG4W7rlTNrg88UByJUNEX8c/lV+fGw=
	=
X-Received: by 2002:a05:6830:2649:b0:822:40fc:2eaa with SMTP id 46e09a7af769-85ac11bf133mr2729148a34.27.1793205923640;
        Wed, 28 Oct 2026 09:45:23 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 53/98] nvme-tcp: don't get stuck on a TLS control record
Date: Wed, 28 Oct 2026 10:41:56 -0600
Message-ID: <20261028164415.1262013-54-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The host receives with read_sock(), and tls_sw_read_sock() won't hand
out a non-data record: it puts it back and returns -EINVAL.
nvme_tcp_io_work() bails on the error and finds the same record again
next time, so nothing behind it is ever read. One warning alert or
NewSessionTicket after the ICResp kills the queue: commands time out and
the controller resets. The Linux target sends none, but others may.

Fetch such a record with recvmsg() instead. A fatal alert starts error
recovery, anything else is dropped whole, with a log line, and the queue
carries on. io_work and a poller may both see the record, so a bit makes
sure only one of them deals with it, and that one retries read_sock()
afterwards.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/tcp.c | 87 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 98c55fba53c6..87ecee0665c7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -95,6 +95,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_TLS_CTRL	= 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -1418,7 +1419,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	return ret;
 }
 
-static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
+static int nvme_tcp_read_sock(struct nvme_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
 	struct sock *sk = sock->sk;
@@ -1431,6 +1432,90 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
+	return consumed;
+}
+
+/*
+ * read_sock() leaves a TLS record that is no data where it is, in front of
+ * all that follows.  Take it out of the way.
+ */
+static int nvme_tcp_recv_tls_ctrl(struct nvme_tcp_queue *queue)
+{
+	struct nvme_ctrl *ctrl = &queue->ctrl->ctrl;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+		.msg_flags = MSG_DONTWAIT,
+	};
+	u8 ctype, level, description, data[2] = {};
+	struct kvec iov = { .iov_base = data, .iov_len = sizeof(data) };
+	int len;
+
+	/*
+	 * io_work and a poller may both have met the record, and recvmsg()
+	 * would take data as well.  Only one of them goes on, and he looks
+	 * again: nobody else removes such a record from now on.
+	 */
+	if (test_and_set_bit_lock(NVME_TCP_Q_TLS_CTRL, &queue->flags))
+		return 0;
+	len = nvme_tcp_read_sock(queue);
+	if (len != -EINVAL || !queue->rd_enabled)
+		goto out;
+
+	len = kernel_recvmsg(queue->sock, &msg, &iov, 1, iov.iov_len,
+			     msg.msg_flags);
+	if (len < 0)
+		goto out;
+
+	ctype = tls_get_record_type(queue->sock->sk, (struct cmsghdr *)cbuf);
+	switch (ctype) {
+	case 0:
+	case TLS_RECORD_TYPE_DATA:
+		goto fail;
+	case TLS_RECORD_TYPE_ALERT:
+		iov_iter_revert(&msg.msg_iter, len);
+		tls_alert_recv(queue->sock->sk, &msg, &level, &description);
+		dev_warn_ratelimited(ctrl->device,
+				     "queue %d: TLS Alert level %u desc %u\n",
+				     nvme_tcp_queue_id(queue), level,
+				     description);
+		if (level == TLS_ALERT_LEVEL_FATAL)
+			goto fail;
+		break;
+	default:
+		dev_warn_ratelimited(ctrl->device,
+				     "queue %d: TLS record %u dropped\n",
+				     nvme_tcp_queue_id(queue), ctype);
+		break;
+	}
+
+	if (!(msg.msg_flags & MSG_EOR)) {
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+		iov_iter_discard(&msg.msg_iter, ITER_DEST,
+				 TLS_MAX_PAYLOAD_SIZE);
+		sock_recvmsg(queue->sock, &msg, MSG_DONTWAIT);
+	}
+	len = 1;
+out:
+	clear_bit_unlock(NVME_TCP_Q_TLS_CTRL, &queue->flags);
+	return len;
+
+fail:
+	queue->rd_enabled = false;
+	nvme_tcp_error_recovery(ctrl);
+	len = -ENOTCONN;
+	goto out;
+}
+
+static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
+{
+	int consumed = nvme_tcp_read_sock(queue);
+
+	if (consumed == -EINVAL && nvme_tcp_queue_tls(queue) &&
+	    queue->rd_enabled)
+		consumed = nvme_tcp_recv_tls_ctrl(queue);
 	return consumed == -EAGAIN ? 0 : consumed;
 }
 
-- 
2.56.0

