Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205930;
	b=U7UA7CzWA87s73/NZyOG80u1ng8lQslfUKLJOQKUMutLCvSxDP5iXLK7ZhUtcg7pLo56
	 /5aWfNkPqgFcmtDVyg5bwONq9KJpYJjL39RZ+tWCSA9IywReuWCcoLeHcEqCCoQ6UPMoi
	 cT7XV2yD/nFhG6AjuXo90//UPBnFHIbeWqGFi8ObnEndKMmh3hDCHTbD2dTBkFiUtvF5O
	 64+i/Ap8+Fnh/Pf8rQAa5ZVN0Xlvfu2fybHUrFaHkrQ0XRxcanJ/aKFan1cht2yHOpjmz
	 KlvqwVzm1FACa5G6xitZSxeUrlwpSaL8ZlMnQ9VqKCp9phY3HBOzVnmpeK+raVD6duQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Kw6hlJlUz1H1awk4MapK55p+HFEzrVNfUFOayv/6HwQ=;
	b=AG0CyS8pFv1jvrBXVf+v9Rt9gt26N3KlFTFOlq08peZNBPX8gJC4GxWNCvW+BbGK992x
	 eHdum2mbeg2iAnZ0MTrcmVIrbuSppYECzh5/zlkeheMv09EjVZlGAsCNsSswhBURP+QVB
	 o9pUPStuCAfQIPFrLCcIs2D3Cqi1TfuluUWTJrVnwXc4MYFr0ZorTtofU5nDlvsZNFUjl
	 nr27JBfbL5Y1BgfDLWWh5AxKicDTYUY3PgKU56OAz6bNWA3eInbU8nIXQT4inXHJv0KV1
	 MGUlonVQ2syd3Pk7ZvuX9r6GnsbdR/BO6KYBJoI6CxDSqklzgnJh6Yju6sTVw4tC3CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ayZmbKpa;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE4606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6AE4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ayZmbKpa
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-84e513877a3so1112039a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205929; x=1793810729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kw6hlJlUz1H1awk4MapK55p+HFEzrVNfUFOayv/6HwQ=;
        b=ayZmbKpaUA1JpAtYjQ6XN29KcxsLlkdhdRCrjWpL97u6H0meFV9N3bLsbw8rvUkX4p
         eI6dyRZbR9F+QW5MbxYquGcckhbXod41SgMYfdnfWOS4hs4SPctlIcLS1JS3gZyVm3w5
         OmzPa9onfhPATfoIeboaLrTHx5SAo0iDD7Ku+MpuhB1wYNrfiUCV5j3YpODciNJ83pbi
         Yam9Ke+pDNSckRwFIbC/zT072OZD0OHH05YKZiBKpkC9d3kYExXh1AdwNaVyuV8LYhDf
         Le48ZnfKNZO2v9GSwi3Hv3cjSRJUEPHvkovKrZ/dQKvVnAGYaNEYNepHzNkmqKJquzXA
         zegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205929; x=1793810729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kw6hlJlUz1H1awk4MapK55p+HFEzrVNfUFOayv/6HwQ=;
        b=wrxjdK1OFqxawd886gN3C/Qy/OM952A6yMpq4Nh71qu+C9fQHPIP+UjfLi6ZVZH2U0
         GTc4GWGMb4qHgYjyYntNp/C6Nd34/hRuC7BhJSguwO65Ja2/4fb8O5OgKcg0xzOztTLG
         jC0AugBSUrX1NxNljfSLbnS4KMXxH9ZC5wS/kB7G1tgEciKGtd5Gma7e3S/ZHYKZrrfI
         cQBIaFCsLPA3AaSTtV9q+GVJ8Qnc7c0SoPsfnm3ubitsN7NnIsmh/xEoklg6PHwnQ1hQ
         6DSDNtI9NZhYwr8o0Z2A2Oc0Ca1LSW7z2N1+PLpM1Wk7BB1oR/A8aVP34q76TdVhJu/W
         HgXQ==
X-Gm-Message-State: AFq9FYIyOvmVtykwJ60rOSrWJey0iWmzQpIAba4ulwSBPaSBmsTnBK+M
	mWU2Ho1irw/VHhn5ZgyiC1rymJJ7AztPPkDOREcTg9AzIIBulojhjqNNaZJ4GXBqpn9z0nP+wCA
	zYQX2NAQ=
X-Gm-Gg: AYBFou1niVtYjxJRk1mX0DCqWbRgeIhRrrXx/eYYsIgSargI0bKxa+hA/oT6G7o+gsp
	pA2+Mqz2DyqROZhAbMDvicnJ8NpRvn/Y4af+iF0NOpTH2b4M+7J4yDYs0dIVwomjJZOOVPfQ4WP
	uZZeATpnfbvFYx5kQkQnP+r2lnCHOzzlbohnUZ50ltoSrSgRV0g5/wfej7UVzvxMNfOjZQ/oG/z
	Ul+nL7Xdwrc27c9T24QWzXMYOmvSBvTowLm9+t2+4dGOj2peC1zcVMxc06ofnyELZE1MuOlly5O
	XghqDdDpegMO44Y43h5EoHWffM2+5P13qEDTIxX1I1MLq+wWqrsaM+62UR163Nz40lQ5yIhYP1J
	47xb0CFfvoORehdQgneCCiVaeFUcctN9F8Y34emEAk1MWAIu0gNNZC/U9aj4L9vcvz6pMDaz3LO
	45E5ZfEGQ0PgdLUz72CL16AHczf5GhtbvO9W3DL6KAnRIyQW8MSeGUFyBo8kqzaTV6Ojv0LG8Ak
	SG/fQKzN9ny8DmVRtcE94tMJSFKcWpC0A7jp6BBLfd8+xoxPHo4CpFIHX+qxzejT+riD0r8GFJX
	yZHAJ9aHEFbzu3jAGBkU4UjQkSvR+RM4pB/I+0HXUiQWmALIle4qX0prwwzpHK4uNY8o0wME/8B
	a8X9sWXoMeNG2jnTHXFc=
X-Received: by 2002:a05:6830:4492:b0:845:8d86:9f81 with SMTP id 46e09a7af769-85c1eabf036mr87190a34.6.1793205928677;
        Wed, 28 Oct 2026 09:45:28 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 57/98] nvme-tcp: don't send SIGPIPE to whoever submits I/O
Date: Wed, 28 Oct 2026 10:42:00 -0600
Message-ID: <20261028164415.1262013-58-axboe@kernel.dk>
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

nvme_tcp_queue_request() tries to send inline, so the first PDU of a
command goes out in the context of the submitting task, and none of the
sends pass MSG_NOSIGNAL. Once a connection is down and error recovery
hasn't stopped the queue yet, tcp_sendmsg() returns -EPIPE and
sk_stream_error() sends SIGPIPE to current. A lost connection that the
driver would recover from transparently instead kills whatever is doing
I/O on the namespace: with 16 dd processes and a connection cut every
other second, a few die within a minute.

Pass MSG_NOSIGNAL, like nbd, drbd, ceph, cifs and sunrpc do.

Fixes: db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq context")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/tcp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index be3938c3cb6f..c9531e653a2c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1249,7 +1249,8 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 	while (true) {
 		struct bio_vec bvec;
 		struct msghdr msg = {
-			.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES,
+			.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL |
+				     MSG_SPLICE_PAGES,
 		};
 		struct page *page = nvme_tcp_req_cur_page(req);
 		size_t offset = nvme_tcp_req_cur_offset(req);
@@ -1308,7 +1309,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	struct nvme_tcp_queue *queue = req->queue;
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
+	struct msghdr msg = {
+		.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SPLICE_PAGES,
+	};
 	bool inline_data = nvme_tcp_has_inline_data(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
@@ -1349,7 +1352,9 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	struct nvme_tcp_queue *queue = req->queue;
 	struct nvme_tcp_data_pdu *pdu = nvme_tcp_req_data_pdu(req);
 	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_MORE, };
+	struct msghdr msg = {
+		.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL | MSG_MORE,
+	};
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
 	int ret;
@@ -1384,7 +1389,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 	size_t offset = req->offset;
 	u32 h2cdata_left = req->h2cdata_left;
 	int ret;
-	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL };
 	struct kvec iov = {
 		.iov_base = (u8 *)&req->ddgst + req->offset,
 		.iov_len = NVME_TCP_DIGEST_LENGTH - req->offset
@@ -1696,7 +1701,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	struct nvme_tcp_icresp_pdu *icresp;
 	char cbuf[CMSG_LEN(sizeof(char))] = {};
 	u8 ctype;
-	struct msghdr msg = {};
+	struct msghdr msg = { .msg_flags = MSG_NOSIGNAL };
 	struct kvec iov;
 	bool ctrl_hdgst, ctrl_ddgst;
 	u32 maxh2cdata;
-- 
2.56.0

