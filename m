Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205947;
	b=Xz4ANmfvzOkKsBwdmuWzupnGWGIpU3VqiRUg3Iv0i3asdvvWsTIy2rROYZtf5ApfG9mv
	 uIz0Nyb8+rwqpABwsuDxWKhHx4yDB1Y1AxowR/R7pjdSEvPqjgN+nWu7eKraPLAoaKTWQ
	 DEZpA4J2icjRxrGqrXlRi291HTaGNG6jjBUKnhRJqQq8AKvypJkMYiTlqSncYBbWcP2VB
	 H5Q2f+D01ZvUn59Iz3/98n9/6565qr4g1bt7HEHNchXBwpywR+EqzvA5TTyyTS6TIa8q8
	 A3HM+uQxhOguwd3OrX6CvgbKpFWQ4cSA+eIKGVzvPOsXuE1lhUjaXKyeSVHdUu/QC3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WEQ3r4S0DQr0eyjHgxzXcVRIcL0VSwg1ay6nH0jSO18=;
	b=rVU03lNmwIv9lofuSZf4ufj/hUtW3iWUMdjEOPLgxUUv7gWCXwKcVWEfKUOKo4wNY+L2
	 5hQBsj473cUYGLgtNu45qz8P+4y+bCxGwcGVw0NSvldfCbX9SuqR/VKeKyRa+BIUhEzdS
	 SptJJWIPh4vI2EjClRKvjEW+sGg7D5vsAyGzsYS5AfNP50RR/jOBZTy7Y3JOJ+xuoikeD
	 /l8gwvDfWgrBm2t72hHMzekTJuQ+9c9ZQ3ICEFQbd+HJ28x4MPtBo8sPOGrI+8PjW5C8f
	 R5r/swxVWZ3MlVnzlge9wXBAj2RVK0D1a9XCDBrD7xnejPSOC89pvlqzFTGJwuGhOvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lcUUg6kT;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E81606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44E81606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lcUUg6kT
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-846566246e8so1081312a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205946; x=1793810746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WEQ3r4S0DQr0eyjHgxzXcVRIcL0VSwg1ay6nH0jSO18=;
        b=lcUUg6kTXhKfcuWlj6Kh4XcdxQKfqMssXEYeBY8rrnnjGXagNOJq6O95W69K7S8fcK
         ecxJCgm4FzADA0NqyFZSw5vxQldblBUhsNy1DQOhyz6jUL3Z9p7Fqj1lkWCUlo8w7+Pf
         uu/1AfrVzTCroczwcwTfygtw28lNoTg2FSW0pNxA+9D78ZqlXgKYDvf7UuutJ0ft1CpL
         5B9KukpfN+PxiwZM7Ix9M1Cwbh5IW5kHKPADukzSLz7czF16VWC6AiVOtI3Cwf8Ofo2i
         IRNTP8evV0dI15xMGDRn8Ukc3sDJubtu65HHr04U6HCLyhIWXt7Kq0MzWveIP7a67l7Y
         PM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205946; x=1793810746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WEQ3r4S0DQr0eyjHgxzXcVRIcL0VSwg1ay6nH0jSO18=;
        b=qSzzGpkjDw/Gib/aDCIBwTK8Up4Mr11jHFsFNpL019eW8P0ws2kBOsSYRO12usnnVm
         VjePwbokuiIkYc63B6ZSO7OpnWJNohazMJh64TCe2nZkIrxU7bSG6nksj8OfsQhvM2i6
         3MvU/eAoVqI0LLdNJLpwChLShXCS9iDkcX1//WrZh2jgwLDgEPUozl/Swg5GHcphukUF
         eT1vWtBBNp48IUMkpssdCzWM9I54kmEaree/WiOSp8ovbeSWpuckQdrSybo3Nh2JWTaq
         sU13k/wb78MfnPir3n3WbK+09KPDAugQwyTADhvnuhRjRJSeHMZV4jiZxdsyhrxqT1vx
         6hUg==
X-Gm-Message-State: AFq9FYIfctKAFB5L+ioybxEW3PBNmPd8aLT/t2sqQlh397wS4dQC4R8l
	j7688Yc5OCqqo+jtol8TexLrHb2vbMug8zNNM9l2kbP5vsQ1EW2JUE5o4BPx775awR9LeRilT12
	Zp6Zezqo=
X-Gm-Gg: AYBFou3PB8iynwl5fn3Ps53gVT7MiAGNZSr5jX2RtFJep5kv+D8Z2pMpcNofPDG+hF4
	VXdj5+SuBfWRXExaASrYm/kQA8jwCnEslZq8Xakj4ZhwsBTmPdnm5VkWfmgxHgQPkPR7MK0FoL7
	z4rs/Yc/pxFAZ5xDFOKaWViB1rUVOtR7Q3wdTMpiVWHywxM4+8b33JTWYcQ+QmiPBuLvTq9Q6d8
	w+vkIaUI8xrnHITBQvtp3/jW/KiVJ7poe13ltJ/iCyb2KZWzkavYnKloL9M9dwx7Y5YuRXeBM24
	BYWCY3+ZtlJDv7rGiy7jjp7qNq5frV+BIzjvIjA7IL9CtjycjQAVtSR69m9x5gbnXcdoU7ll+Gw
	rAQQ6Xjerngv6eyU7Plj6kB63qcxmRXLc5C8PmbZbE6EsMLKRLrDZHEGMkgVXcjp96gz1UMquUI
	LQNkpQfY8P9SxJAdCdJsAJLtZ4+i7H2TYgUnW4i6lPZxH0DH7YjruTaF4TSjJ7ZytgRNyIlfz2f
	z7LhHT51YGhC7baPR8uaNF05V+5VjhtrkgT293swzHncYjmmo1FIa4DwEQrTu9Z0Jk7cIynTKrn
	ohK9snHD7lDxlUlLgjNn/RiRSPR4KAVtpMm6kmmeBMIBE/Y9ta5wo8LFasnCZgFsw8/iJErKonE
	DLXTAu2D/Jp2EfX1jGHc=
X-Received: by 2002:a05:6830:268b:b0:83f:2c3e:e157 with SMTP id 46e09a7af769-85c1f2aa01dmr88953a34.9.1793205946269;
        Wed, 28 Oct 2026 09:45:46 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 70/98] nvmet-tcp: don't wait for the host in the accept work
Date: Wed, 28 Oct 2026 10:42:13 -0600
Message-ID: <20261028164415.1262013-71-axboe@kernel.dk>
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

On a port that offers TLS but doesn't require it,
nvmet_tcp_alloc_queue() peeks at the first bytes of a new connection to
tell an ICReq from a TLS handshake. That receive blocks until the host
sends something or closes, and it runs in the accept work, of which
there is one per port. A connection that stays silent blocks every
other connect on that port for as long as it's held open, no secret
needed. And nvmet_tcp_remove_port() waits for the accept work with
nvmet_config_sem held for writing, so an admin taking the port down
hangs there and no port of the target answers a Connect anymore.

Install the socket callbacks first and peek without blocking from the
io work, which data_ready() reruns. If it's a handshake, restore the
default callbacks for the upcall as before, and make the upcall from
one more run of the io work so no run is left that could steal data
from the handshake. The state change happens under state_lock and only
if the queue isn't already going away. The io work doesn't hold the
port like the accept work did, so note the keyring serial, which is all
the upcall needs from the port, at allocation.

A partially arrived header used to be taken for "no TLS", now the rest
is waited for. A silent connection still holds its queue, as on a port
without TLS.

Fixes: 70525e5d82f6 ("nvmet-tcp: peek icreq before starting TLS")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/tcp.c | 67 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index c8f0c52a1b95..3d24efe3b7c3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -140,6 +140,7 @@ struct nvmet_tcp_cmd {
 
 enum nvmet_tcp_queue_state {
 	NVMET_TCP_Q_CONNECTING,
+	NVMET_TCP_Q_TLS_PEEK,
 	NVMET_TCP_Q_TLS_HANDSHAKE,
 	NVMET_TCP_Q_LIVE,
 	NVMET_TCP_Q_DISCONNECTING,
@@ -176,6 +177,7 @@ struct nvmet_tcp_queue {
 
 	/* TLS state */
 	key_serial_t		tls_pskid;
+	key_serial_t		tls_keyring;
 	struct delayed_work	tls_handshake_tmo_work;
 
 	unsigned long           poll_end;
@@ -1496,6 +1498,8 @@ static bool nvmet_tcp_check_queue_deadline(struct nvmet_tcp_queue *queue,
 	return !time_after(jiffies, queue->poll_end);
 }
 
+static bool nvmet_tcp_tls_peek(struct nvmet_tcp_queue *queue);
+
 static void nvmet_tcp_io_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
@@ -1503,6 +1507,11 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 	bool pending;
 	int ret, ops = 0;
 
+	if ((queue->state == NVMET_TCP_Q_TLS_PEEK ||
+	     queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) &&
+	    !nvmet_tcp_tls_peek(queue))
+		return;
+
 	do {
 		pending = false;
 
@@ -1828,12 +1837,9 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
 	struct msghdr msg = {
 		.msg_control = cbuf,
 		.msg_controllen = sizeof(cbuf),
-		.msg_flags = MSG_PEEK,
+		.msg_flags = MSG_PEEK | MSG_DONTWAIT,
 	};
 
-	if (nvmet_port_secure_channel_required(queue->port->nport))
-		return 0;
-
 	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
 	if (unlikely(len < 0)) {
@@ -1955,7 +1961,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	args.ta_sock = queue->sock;
 	args.ta_done = nvmet_tcp_tls_handshake_done;
 	args.ta_data = queue;
-	args.ta_keyring = key_serial(queue->port->nport->keyring);
+	args.ta_keyring = queue->tls_keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 
 	ret = tls_server_hello_psk(&args, GFP_KERNEL);
@@ -1968,8 +1974,51 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	}
 	return ret;
 }
+
+/*
+ * TLS is offered, but not required: the first bytes tell what the host wants.
+ * Returns true if the queue goes on without TLS.
+ */
+static bool nvmet_tcp_tls_peek(struct nvmet_tcp_queue *queue)
+{
+	int ret;
+
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		if (nvmet_tcp_tls_handshake(queue))
+			nvmet_tcp_schedule_release_queue(queue);
+		return false;
+	}
+
+	/* ->data_ready() brings us back */
+	ret = nvmet_tcp_try_peek_pdu(queue);
+	if (ret == -EAGAIN)
+		return false;
+
+	/* The upcall wants the default callbacks */
+	if (!ret)
+		nvmet_tcp_restore_socket_callbacks(queue);
+
+	spin_lock_bh(&queue->state_lock);
+	if (queue->state != NVMET_TCP_Q_TLS_PEEK) {
+		spin_unlock_bh(&queue->state_lock);
+		return false;
+	}
+	queue->state = ret ? NVMET_TCP_Q_CONNECTING : NVMET_TCP_Q_TLS_HANDSHAKE;
+	spin_unlock_bh(&queue->state_lock);
+	if (ret)
+		return true;
+
+	/*
+	 * ->data_ready() may have queued the io work meanwhile, nothing does
+	 * from now on. The handshake must not start before that run is over,
+	 * so leave it to that run.
+	 */
+	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+	return false;
+}
 #else
 static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w) {}
+static bool nvmet_tcp_tls_peek(struct nvmet_tcp_queue *queue) { return true; }
 #endif
 
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
@@ -2039,14 +2088,16 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		sk->sk_user_data = NULL;
 		sk->sk_data_ready = port->data_ready;
 		write_unlock_bh(&sk->sk_callback_lock);
-		if (!nvmet_tcp_try_peek_pdu(queue)) {
+		/* The port may be gone when the upcall is made */
+		queue->tls_keyring = key_serial(port->nport->keyring);
+		if (nvmet_port_secure_channel_required(port->nport)) {
 			if (!nvmet_tcp_tls_handshake(queue))
 				return;
 			/* TLS handshake failed, terminate the connection */
 			goto out_destroy_sq;
 		}
-		/* Not a TLS connection, continue with normal processing */
-		queue->state = NVMET_TCP_Q_CONNECTING;
+		/* Don't wait for the host here: others want to connect, too */
+		queue->state = NVMET_TCP_Q_TLS_PEEK;
 	}
 #endif
 
-- 
2.56.0

