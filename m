Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231381;
	b=tHhIaQILVvURWde9KQN3Ax6V989CErNe8/MXyEXPJswfaGxSozSCpengGhf3h64/zDmF
	 3tsITZNHBVdb/CORyuCEwZqUPvW9x69AwKr8qNlFZ6d8SsiGe9uGkHI6GtsvWb3PvXeMA
	 WDhAkAixO99kspBMSd8eGCJ5ypKpLx9ASp+fzur1Sj29DS2knIlQpul6aCWnc0Pmh563/
	 rQffGAOwFZQR2mK9rFPWKrHEUJWvJJoyDAPOTLf/ByBZR1+BfTv3TMb+6lQ78pg0V8IkR
	 hzPOZXjadZOp+T3ZYXpySsMCDAcRPQTIWQPM70W/Zl/2D5aQwjNpcPxcyck2I6W6GRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=oQ3ooPdt/wPI/xtrBTi+ygDk2pXxfpaEE12RHBI3Egs=;
	b=FTPBg5sr0wcdJe6xTrA+hyTA3WaqpyWlTCCjLFWuAU6xFsN/ws+1re9oHtve6ucav7NV
	 UWL1S6eH5KDiS017l6+WrMUzwoEHRkJaToMt0MJazQWzgpoeVtuBciUQ6xVgDmNZ0MjVk
	 qBfKdmpw2tmAnW6KjadDlV6eUui+zTPoyHs0ZPM/c4zm40QHdY8MXZ5SxBi0H/erpgI3H
	 vwGFzN9Yldt+3Hx4vYBL5T+77d9OA0+1YNyg384Skb6cmmIQu+/L+LZiJAv59e35I7i31
	 exeGsahM5cRmtqh2g7vrqQTGy69ZQWA65hEPelXwqSoblwiGaSvurxjyVos4fUsDAOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=G9440Fox;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E0606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 23:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 609E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=G9440Fox
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFPGr6r9Wzlfvpd;
	Wed, 28 Oct 2026 23:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793231374; x=1795823375; bh=oQ3oo
	Pdt/wPI/xtrBTi+ygDk2pXxfpaEE12RHBI3Egs=; b=G9440FoxGGVyUzOktsdNb
	HUb+nzwZZkG86jMl9P3QDW5FXjClApNqCl50WcsckfNFDIRnGTkyDtleXrssVTiy
	P4OTZlg7O3jfxQDUQe84nEhn0Fobor88MofVqf4JNCrcMT7dgV19+dcJcXvHokqX
	AyYFO2hRM7KR5TMf5TNpQE3k1+hZwmTxcWC081Gh2Zxv6aAHPRYfcicQqeIMROh9
	Um4fm5nAopdEB+JpbOsxbjdHpPMcRjtW2aJhf1hcxIAYLSc8e+bSyGrB7RGPx6ID
	eGPddFhusYzW+aHOvKB7fD9T1VTJJg2RsllA3RFpXazD1TLzT5snzPYd7+vRcbQZ
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ySmdM4F_6q6A; Wed, 28 Oct 2026 23:49:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFPGh3xW4zlfvq0;
	Wed, 28 Oct 2026 23:49:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 48/98] nvmet-tcp: rewind the iterator after non-data records
Date: Wed, 28 Oct 2026 16:49:11 -0700
Message-ID: <20261028234917.3067347-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-49-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-49-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/28/26 09:41, Jens Axboe wrote:
>  	case TLS_RECORD_TYPE_ALERT:
> +		iov_iter_revert(&msg->msg_iter, len);
>  		tls_alert_recv(queue->sock->sk, msg, &level, &description);
...
>  		if (queue->tls_pskid) {
>  			ret =3D nvmet_tcp_tls_record_ok(cmd->queue,
> -					&cmd->recv_msg, cmd->recv_cbuf);
> +					&cmd->recv_msg, cmd->recv_cbuf, len);

Rewinding msg_iter fixes the iterator advance, but TLS_RECORD_TYPE_ALERT
is still broken in two ways here:

1. In nvmet_tcp_try_recv_data(), cmd->recv_msg.msg_iter is an ITER_BVEC
   initialized with iov_iter_bvec(), whereas tls_alert_recv() in
   net/handshake/alert.c unconditionally reads union member
   msg->msg_iter.kvec->iov_base. For an ITER_BVEC, iov->iov_base aliases
   bvec->bv_page (struct page *), so tls_alert_recv() reads the first
   two bytes of struct page instead of the received alert payload and
   ignores fatal alerts whenever byte 0 !=3D TLS_ALERT_LEVEL_FATAL.
2. If queue->left =3D=3D 1 when a 2-byte TLS alert arrives (or a peer sen=
ds
   a 1-byte malformed alert record), sock_recvmsg() returns len =3D=3D 1,
   and tls_alert_recv() reads data[0] and data[1] without checking that
   2 bytes were received.

To fix this inside nvmet-tcp without cross-tree changes to
net/handshake/alert.c, nvmet_tcp_tls_record_ok() can extract the alert
bytes from a local ITER_SOURCE copy of the rewound msg->msg_iter via
copy_from_iter_full(), pull the second byte from queue->sock when
len =3D=3D 1 and !(msg->msg_flags & (MSG_EOR | MSG_PEEK)), reject < 2-byt=
e
alerts with -EPROTO, and pass a local 2-byte ITER_KVEC msghdr to
tls_alert_recv() so its tracepoint still works.

Note: patch 51/98 will need a trivial context adjustment around the
nvmet_tcp_tls_alert_recv() call in nvmet_tcp_tls_record_ok() (and
propagating MSG_EOR from rem_msg lets 51/98's nvmet_tcp_tls_drop_rest()
check work unchanged).

Here is a replacement patch (checked with checkpatch.pl and
syntax-checked with Clang; not runtime-tested):

---
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index c38ea3501ea5..e6eadfc35d01 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1173,8 +1173,54 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
=20
+static int nvmet_tcp_tls_alert_recv(struct nvmet_tcp_queue *queue,
+		struct msghdr *msg, int len, u8 *level, u8 *description)
+{
+	struct iov_iter iter =3D msg->msg_iter;
+	size_t n =3D min_t(size_t, len, 2);
+	u8 alert[2];
+	struct kvec kvec =3D {
+		.iov_base =3D alert,
+		.iov_len =3D sizeof(alert),
+	};
+	struct msghdr alert_msg =3D {};
+
+	iter.data_source =3D ITER_SOURCE;
+	if (!copy_from_iter_full(alert, n, &iter))
+		return -EPROTO;
+
+	if (n < sizeof(alert)) {
+		char cbuf[CMSG_LEN(sizeof(char))] =3D {};
+		struct kvec rem =3D {
+			.iov_base =3D alert + n,
+			.iov_len =3D sizeof(alert) - n,
+		};
+		struct msghdr rem_msg =3D {
+			.msg_control =3D cbuf,
+			.msg_controllen =3D sizeof(cbuf),
+			.msg_flags =3D MSG_DONTWAIT,
+		};
+		int ret;
+
+		if (msg->msg_flags & (MSG_EOR | MSG_PEEK))
+			return -EPROTO;
+		ret =3D kernel_recvmsg(queue->sock, &rem_msg, &rem, 1,
+				     rem.iov_len, rem_msg.msg_flags);
+		if (ret !=3D rem.iov_len ||
+		    tls_get_record_type(queue->sock->sk,
+					(struct cmsghdr *)cbuf) !=3D
+		    TLS_RECORD_TYPE_ALERT)
+			return -EPROTO;
+		msg->msg_flags |=3D rem_msg.msg_flags & MSG_EOR;
+	}
+
+	iov_iter_kvec(&alert_msg.msg_iter, ITER_DEST, &kvec, 1, sizeof(alert));
+	tls_alert_recv(queue->sock->sk, &alert_msg, level, description);
+	return 0;
+}
+
 static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
-		struct msghdr *msg, char *cbuf)
+		struct msghdr *msg, char *cbuf, int len)
 {
 	struct cmsghdr *cmsg =3D (struct cmsghdr *)cbuf;
 	u8 ctype, level, description;
@@ -1187,7 +1233,11 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tc=
p_queue *queue,
 	case TLS_RECORD_TYPE_DATA:
 		break;
 	case TLS_RECORD_TYPE_ALERT:
-		tls_alert_recv(queue->sock->sk, msg, &level, &description);
+		iov_iter_revert(&msg->msg_iter, len);
+		ret =3D nvmet_tcp_tls_alert_recv(queue, msg, len, &level,
+					       &description);
+		if (ret)
+			break;
 		if (level =3D=3D TLS_ALERT_LEVEL_FATAL) {
 			pr_err("queue %d: TLS Alert desc %u\n",
 			       queue->idx, description);
@@ -1200,6 +1250,7 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp=
_queue *queue,
 		break;
 	default:
 		/* discard this record type */
+		iov_iter_revert(&msg->msg_iter, len);
 		pr_err("queue %d: TLS record %d unhandled\n",
 		       queue->idx, ctype);
 		ret =3D -EAGAIN;
@@ -1228,7 +1279,7 @@ recv:
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
-		ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+		ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf, len);
 		if (ret < 0)
 			return ret;
 	}
@@ -1290,7 +1341,7 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp=
_queue *queue)
 			return len;
 		if (queue->tls_pskid) {
 			ret =3D nvmet_tcp_tls_record_ok(cmd->queue,
-					&cmd->recv_msg, cmd->recv_cbuf);
+					&cmd->recv_msg, cmd->recv_cbuf, len);
 			if (ret < 0)
 				return ret;
 		}
@@ -1331,7 +1382,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tc=
p_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
-		ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+		ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf, len);
 		if (ret < 0)
 			return ret;
 	}
@@ -1803,7 +1854,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_=
queue *queue)
 		return len;
 	}
=20
-	ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+	ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf, len);
 	if (ret < 0)
 		return ret;
=20
