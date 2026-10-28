Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205922;
	b=cDNek3VGie0ss9fAtn3sDlR4P0pC0th0fgV3ebwS/YMbLXdxAvD7L6uya5grhomfIlDW
	 uw/d6g1v3fVi24jTPdLRr7Dx4/BixOIvYLJQWuvMlUw+nttd+A7XlqcOzNBFZZwSWFZLn
	 ICxMHdRVjRj2Nf/jqz9spwBUASGeI4axbeIr7XGMZmamJ1VgJa+qnl6zHc0Himdv2qp4o
	 RSXrrln6b+pBr5Gw+tiAFWEgcc5QhMD1xO8eCh1R0HhL535DPBMnke+ikbfcBz0kSVN87
	 Uzm2qWXfwzQszSdGCwur7Ct9B5Z5rs/Oykrh71VjdOwBq3fXSzelUOkpzlKkQ7jK4oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=foesBgzirKIx8HER6QCbpGJxNC3/8NTW0fPjhd/QnHQ=;
	b=ccTyd/nhZiugWZM1Tb9wp50YskkNuRuyGZpkgZKj5BLf6zLoX7Z697jacQxxWG2jURZy
	 0pPIvSsR4A7xEiB9pIwIes3UChnlWSj/wzdpYabbQjk9X0g2IsPgI/Oi3jh4TMvp6mvyY
	 jxXz0KKqEH+7hBEL+j7eiZXDO6wDmOA32ljTOJYQx2DbgujX/ZyHd7rrYX+5i8T/ZQvvz
	 VJWrdSW3wToGR61E6Aj8/J9yg2HbQ3ReOq63kC/dw6449OR6pA6SxOXVwSmxsnMs0B8v9
	 TLjq296WjEC7+/FNwq+WOKclDpgC54+xQ9YEYteFvF28GbGuiVTArjKvXNHVrDwsT/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kb330+9V;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B72606A32A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B72606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kb330+9V
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8479f46ecd8so569016a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205921; x=1793810721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=foesBgzirKIx8HER6QCbpGJxNC3/8NTW0fPjhd/QnHQ=;
        b=kb330+9VJ0DH9JGkWBwwSVPyOIx968WePaGEi4AUD3JnxPsP5UpIibZbfUK2C7CXk1
         Gh9+BpPPH5puH7vGklmC2vW5pF4Z4IIQFaDtr3zTpgE7bKTNoFW9MSQYOY3KxmUNFY6X
         fUdBUfUUj+AW6Bcn0Qx0outkrWv8j/Mz2u1eUwatrJS8lyPvAaqeZqYdnfSstI1qg9DQ
         Xo8Xb5nai+a3s0vuRbR20zm2sh0a1NpH9PeKdR5McHMu2Nyq3reZnxatYtQyfD1gxDLX
         0N7RZA0TQn4MLWnk5SlvkOORTASElyXQh22VVA8DaS0ZgsTVU96oXaNd6iAIsEIpVGhE
         0VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205921; x=1793810721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=foesBgzirKIx8HER6QCbpGJxNC3/8NTW0fPjhd/QnHQ=;
        b=XJX0pta2Md+efI4M49wr9HTNx5PqRjBHtr8+Ci+LxRCE7zOMTSUpg5LAisMMR6F3f6
         UryOGkC4wDpU4wmgtoVX6VK20Oq/CL3iGVEA7ij96OQfW7GRj9qNm5d1YVNaAQ+0NLiL
         Fe76sYF1tG9O24myk6aHBctJ9I8pABU+x4NTvFDVns78KzVS/Vi9UWV0bgd87yi3t7oB
         F3TnzToJQDWIDdAaayqinlL4dk9Dbdk07UMy5Sm0aRaYv876EjhQYAZvFchhiB9SdlxU
         651dEKoPTryua33OxsJcDH1PehZxgmmTmtRl1GKByjgYf56W2lLCaiNEwlh90bnV/UnL
         F0og==
X-Gm-Message-State: AFq9FYLyKHyhGwp9esycka7BZCx9op5kOymuRDPku85v/xnBDaWNDYr7
	nxZA656VaM3BHDm4vd+J/9wMVCo1GVwbAWAcSeB37CRPQKZXD8IZlXgDTn9SV28XcuAfWYZ3G7J
	XuXBB96I=
X-Gm-Gg: AYBFou0hmCG1gyfccL1vLRCciXEYJIwAcxM00FgXXmkjFPG7KETiu6ESEUV1bWyEQoC
	/UN/V9XOpa0EEX0+uKykyUGULesCrI+2TShIM52oIJrV8uhzV7oWYumprxANpytD+7VURGe7rIl
	xVYWcLJMsFdD9zKYkn0p15mIdQacQMDH6k8cG3aOf020jtL4PSp1+stq8P1Lr1kbTzi5irzMd/q
	59oxo3NqnGh3Ny0XJ6O82e7ZOLKEtleZj5LBL7AghkNC6WVnyUYO4p8kQmby/UsJ/Dh5E2HzK2L
	mkExpgMibivZZ8eYSI3gbA8oVh3MsA4ltnol1ED7GFgkAIbBREbBxGSKMbAjRG7bRhsW7Kuc5oX
	IXnPsf+pQVQ+guv+w1sgp3YoVQp3YeTwAOxtSqoGeScC+YQrvUF2zGO2Ki3/rxxnw3ARK/5Ori+
	vOT7QSpE3L+yrDQ1gVvuXRBNt8AssntYpsqQnjhwbwUdFQREXrYI7StIEtIAGGIR0KGil+ahkyz
	NZYiXz8Ji2KvrVpOs4NnONq6kq3dR7DkGExHR1m0L7Pn2/rOStdP9B1R9q0SEWVVFuOW+Cn+vtv
	VlINMbCwMu0LvzLB4nHo0Uzb7OHboi/TxAmfTMBUBkvRZwd7g9vgA0tDVJfNoL/5ESklbp+BnQ=
	=
X-Received: by 2002:a05:6830:2e10:b0:835:63b5:8b7b with SMTP id 46e09a7af769-85ab9873be4mr2567183a34.10.1793205920689;
        Wed, 28 Oct 2026 09:45:20 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 51/98] nvmet-tcp: look again after a short read with TLS
Date: Wed, 28 Oct 2026 10:41:54 -0600
Message-ID: <20261028164415.1262013-52-axboe@kernel.dk>
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

The receive helpers return -EAGAIN both for a short read and for a
dropped non-data TLS record, and nvmet_tcp_try_recv() takes that as
"socket empty" and waits for the next data_ready. On plain TCP that's
right. tls_sw_recvmsg() stops where the record type changes though, so
what follows an alert or a handshake record may already be queued and
nobody looks at it until the host sends something else.

Return 1 in those cases so nvmet_tcp_try_recv() counts it against the
budget and tries again until the socket itself says -EAGAIN. While at
it, drain the rest of a dropped record using MSG_EOR instead of pulling
it in PDU-sized pieces, and ratelimit the messages since the host
controls how many there are.

Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/tcp.c | 54 +++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 261672ab5c1f..a2a5f39d2bb7 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1173,6 +1173,24 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+/*
+ * The buffer took as much of the record as the PDU still wants, which may be
+ * one byte.  The rest comes with the type of the record, never with that
+ * which follows: throw it away at once.
+ */
+static void nvmet_tcp_tls_drop_rest(struct nvmet_tcp_queue *queue)
+{
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+		.msg_flags = MSG_DONTWAIT,
+	};
+
+	iov_iter_discard(&msg.msg_iter, ITER_DEST, TLS_MAX_PAYLOAD_SIZE);
+	sock_recvmsg(queue->sock, &msg, msg.msg_flags);
+}
+
 static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 		struct msghdr *msg, char *cbuf, int len)
 {
@@ -1190,26 +1208,38 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 		iov_iter_revert(&msg->msg_iter, len);
 		tls_alert_recv(queue->sock->sk, msg, &level, &description);
 		if (level == TLS_ALERT_LEVEL_FATAL) {
-			pr_err("queue %d: TLS Alert desc %u\n",
-			       queue->idx, description);
+			pr_err_ratelimited("queue %d: TLS Alert desc %u\n",
+					   queue->idx, description);
 			ret = -ENOTCONN;
 		} else {
-			pr_warn("queue %d: TLS Alert desc %u\n",
-			       queue->idx, description);
+			pr_warn_ratelimited("queue %d: TLS Alert desc %u\n",
+					    queue->idx, description);
 			ret = -EAGAIN;
 		}
 		break;
 	default:
 		/* discard this record type */
 		iov_iter_revert(&msg->msg_iter, len);
-		pr_err("queue %d: TLS record %d unhandled\n",
-		       queue->idx, ctype);
+		pr_err_ratelimited("queue %d: TLS record %d unhandled\n",
+				   queue->idx, ctype);
 		ret = -EAGAIN;
 		break;
 	}
+	if (ret == -EAGAIN && !(msg->msg_flags & MSG_EOR))
+		nvmet_tcp_tls_drop_rest(queue);
 	return ret;
 }
 
+/*
+ * A receive from a TLS socket ends with the record, or where the type of the
+ * records changes.  There may be more behind a record that has been dropped,
+ * and nobody will tell: have nvmet_tcp_try_recv() look again.
+ */
+static int nvmet_tcp_tls_again(int ret)
+{
+	return ret == -EAGAIN ? 1 : ret;
+}
+
 static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
@@ -1224,6 +1254,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (queue->tls_pskid) {
 		msg.msg_control = cbuf;
 		msg.msg_controllen = sizeof(cbuf);
+		msg.msg_flags &= ~MSG_EOR;
 	}
 	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
@@ -1232,13 +1263,13 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (queue->tls_pskid) {
 		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf, len);
 		if (ret < 0)
-			return ret;
+			return nvmet_tcp_tls_again(ret);
 	}
 
 	queue->offset += len;
 	queue->left -= len;
 	if (queue->left)
-		return -EAGAIN;
+		return queue->tls_pskid && len ? 1 : -EAGAIN;
 
 	if (queue->offset == sizeof(struct nvme_tcp_hdr)) {
 		u8 hdgst = nvmet_tcp_hdgst_len(queue);
@@ -1290,6 +1321,7 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 			/* The last receive has used it up */
 			cmd->recv_msg.msg_control = cmd->recv_cbuf;
 			cmd->recv_msg.msg_controllen = sizeof(cmd->recv_cbuf);
+			cmd->recv_msg.msg_flags &= ~MSG_EOR;
 		}
 		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
 			cmd->recv_msg.msg_flags);
@@ -1299,7 +1331,7 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 			ret = nvmet_tcp_tls_record_ok(cmd->queue,
 					&cmd->recv_msg, cmd->recv_cbuf, len);
 			if (ret < 0)
-				return ret;
+				return nvmet_tcp_tls_again(ret);
 		}
 
 		cmd->pdu_recv += len;
@@ -1340,13 +1372,13 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 	if (queue->tls_pskid) {
 		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf, len);
 		if (ret < 0)
-			return ret;
+			return nvmet_tcp_tls_again(ret);
 	}
 
 	queue->offset += len;
 	queue->left -= len;
 	if (queue->left)
-		return -EAGAIN;
+		return queue->tls_pskid && len ? 1 : -EAGAIN;
 
 	if (queue->data_digest && cmd->exp_ddgst != cmd->recv_ddgst) {
 		pr_err("queue %d: cmd %d pdu (%d) data digest error: recv %#x expected %#x\n",
-- 
2.56.0

