Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205918;
	b=ojRTdaQIkepJCjyFpy/+EKsNDZ5K6NsFfVvWm0EbyRooZ8ZMX9ViAI4boVPO/WJHcpgb
	 J2h6xDp42iyyl2XZu4izFF3rtgXKH8qso/lmAfELOtmaI5ZpVB8O+3cwiJ84hSWvsgkYd
	 CxTvcLpwKCfpE8yfqp0Nnwb8WRsWTvY+xnepDRWBrDyaJqFgxdeR9n4QH9JydkUZgWLhs
	 DeJuHkmYfX2LdNotCKeowmdXdLwsbW85/vJIlYs2zq3Ce5uZObaDqEPMgfjYiyICAf4sa
	 two66DhrWt0uX2wjoioNg0rTrliqSdwP6eGk65b9WAr81bJk0FQWd1CplkyFH5shl7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=buOhAhlccaWZL041PcF9AqPaavX1R63ngDpv9gVl4U0=;
	b=qm6ubZeAhHiou7wQpi+w8RHSrHD4BvGuAYMqbzVANOtqipKGDCIXCHMrS0PQghJ8Bsh9
	 n7xgDa1IxIH/bQ9llx13cD+qI539QNt/u5qc75JLrvFH2ZZKuQz7r37j+QlZr1ySk2JRn
	 jEqd0h8ZqzQ5W4GZbW6uJ7BYV7RbsgEkysb1N9qhNSeloe0IOVL71y0EtEm3tmTvbVXO5
	 I9N6GgeOhDyOLVmvA29ISe1lp6IOg1oV5ULba0Z381DHSBxYi5HyHA7qxSlP+96QoPKjw
	 SenRnvth+yGcLae81qO11HGY0Iwq8tyJjfEngSQXzae3gSyqfRYkxMRwMxkqZjGUfnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ecZdeGR7;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF069606A322
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF069606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ecZdeGR7
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8241a56cd70so808904a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205917; x=1793810717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=buOhAhlccaWZL041PcF9AqPaavX1R63ngDpv9gVl4U0=;
        b=ecZdeGR7hYu6JpKSGqpr4gE1hXMqnsNTK6oMUxC8uM8RB0Bwr4AYVvv1BM+Ame8D5t
         gZRmkSIoaO1ahMYCj47YBEzm37TU3Kj1vAFXOoVH/wCaY+1GXE12KlAhhLXLAZ8lohMU
         TI4GZLRXFmK2XJ33cPDTXCbCsbI82MK4MyNc7SapsAHuyMIMBiF4DkjQ++iAgQoMuysP
         5IBWdD3u9kQtUrDKheNvDlMGFJRWSFpVg59NQ+9q84KWhMuw6zKSxQh/0Vnq7fFzf5EY
         Q9IqFsFCr7CwQX1KEknOF6Yl98OnKnzNf/j/DubRWnZccaOMIWPd3DwyAiyzvPU4OJ3P
         CU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205917; x=1793810717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=buOhAhlccaWZL041PcF9AqPaavX1R63ngDpv9gVl4U0=;
        b=0hmOHSnaHbqS0YOkBEXKsJrboVe15OVEi5Eq96t97mHjdHWx1p1D9UAaVrTpBVNjl2
         EQLttSSm2u52ZZoOgj7tC9wLw6+EgmxEMxq3X+8hHB1jYL68WCffbJ8ASzRXiAmYxVCu
         mqmvxfgNZQ4AD2MxPtMzcCLsx40vbKd7m4O5+FUZpAnplRHHOucOEIs5a/pGEGXUhlbw
         KXwpKwVuIlwR1rnBLU5uY7rk3ZeBigdVi1i3wh1kKw/EE9W2U9194bP/0p3ee0ZFU3/K
         tnGhT9c++81hS83JaG5p6vZ+GocGN0YdhJG8kkAmU6D9PXqc1Yvu5hF0kgyFddAAdncv
         B3UQ==
X-Gm-Message-State: AFq9FYJFlHlZuSmmqqA9FacpIXMgA95MI0k3YD3rYtcrziOUk/XJaPUr
	wdWhATB53Bq+6O3n/5no3sNJzMhY65P/nSHzqVpLauibb0gugxju0fDBMe9uGuEsFrWGMXS8Inz
	JeDPgR68=
X-Gm-Gg: AYBFou3cn8foC2WkUMABXGG3tBU5He5dYAytGKwl3xAY/hCB7/56oqAPl4kR/kg3VdM
	Iv/8jjVFyc25YOeGfW2iZp4Phav8+7CpRpO2hDglIMyPLogUR48CgdLP0cZBx9ejGozuP+b5ADO
	sqO/6sRLOusSCghR14xj8ro/RYdb4h76H3YFlkRjGYN/aNtQsVuPQEZWfUW3YcEzAF4t1cT64AT
	QuKz/5w1f7ke37Gc/tCxWq4guH4uOpNF3gWVwQx6j3MakdmqDUBoU6kVhd9a5khA45m4UpFoICp
	btXRkNSrlJuQ9QaFPhSmG1JgvpzugG0zzV3p8/CD+cVnk9CWxtfkXHwqOS+WLal2UrNKGfZ03pu
	BGyOsFZWwdJDem6hEbTWQMuRkd7JqDlxRTB0cBU7mdyTHHzlrhdlMRInpwNA0zDyO7yEgjxxscn
	XZDcV7Erpv2bPXZG0djhxZ+4Hey9X8uDslOG8OiSIU4fPFfdRdKL5+PD8hRoj6abAwZqTUpP6O4
	+A2y2C6eEOFbmUoOze8qptFM+Z1IgbawHlorujkOXiel3Cx/f+FycL/7yT5fcunhZanACyfb00S
	I5jlyPEJlBQObuH13ymh/4kPCyo2HfdwjhOWYzqpAxOT0ogqWhOGLycPXYpK7JDVl1jkMV6SL+E
	=
X-Received: by 2002:a05:6830:44aa:b0:81c:37e2:2008 with SMTP id 46e09a7af769-85abff435b2mr2886936a34.14.1793205916854;
        Wed, 28 Oct 2026 09:45:16 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 48/98] nvmet-tcp: rewind the iterator after non-data records
Date: Wed, 28 Oct 2026 10:41:51 -0600
Message-ID: <20261028164415.1262013-49-axboe@kernel.dk>
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

A TLS record that isn't application data (an Alert, say) lands in
whatever buffer was waiting for a PDU header, command data or a digest.
nvmet_tcp_tls_record_ok() fails the receive and the bytes aren't
counted, but the iterator has already advanced. tls_alert_recv() then
expects the iterator at the start of the alert, and if the alert filled
the kvec it has stepped off the end of it:

  BUG: KASAN: stack-out-of-bounds in tls_alert_recv+0x33/0x170
   nvmet_tcp_tls_record_ok+0x139/0x1a0
   nvmet_tcp_try_recv_pdu+0x37f/0x12a0

Six bytes of a header followed by an alert from the host is all it
takes. For command data the following bytes are stored behind the
dropped record and the command runs before its data is complete.

Rewind the iterator by what was received.

Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/tcp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index c38ea3501ea5..a0d942c34d3a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1174,7 +1174,7 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 }
 
 static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
-		struct msghdr *msg, char *cbuf)
+		struct msghdr *msg, char *cbuf, int len)
 {
 	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
 	u8 ctype, level, description;
@@ -1187,6 +1187,7 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 	case TLS_RECORD_TYPE_DATA:
 		break;
 	case TLS_RECORD_TYPE_ALERT:
+		iov_iter_revert(&msg->msg_iter, len);
 		tls_alert_recv(queue->sock->sk, msg, &level, &description);
 		if (level == TLS_ALERT_LEVEL_FATAL) {
 			pr_err("queue %d: TLS Alert desc %u\n",
@@ -1200,6 +1201,7 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 		break;
 	default:
 		/* discard this record type */
+		iov_iter_revert(&msg->msg_iter, len);
 		pr_err("queue %d: TLS record %d unhandled\n",
 		       queue->idx, ctype);
 		ret = -EAGAIN;
@@ -1228,7 +1230,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
-		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf, len);
 		if (ret < 0)
 			return ret;
 	}
@@ -1290,7 +1292,7 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 			return len;
 		if (queue->tls_pskid) {
 			ret = nvmet_tcp_tls_record_ok(cmd->queue,
-					&cmd->recv_msg, cmd->recv_cbuf);
+					&cmd->recv_msg, cmd->recv_cbuf, len);
 			if (ret < 0)
 				return ret;
 		}
@@ -1331,7 +1333,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
-		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf, len);
 		if (ret < 0)
 			return ret;
 	}
@@ -1803,7 +1805,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
 		return len;
 	}
 
-	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf, len);
 	if (ret < 0)
 		return ret;
 
-- 
2.56.0

