Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205956;
	b=KqGAiFGPSUbN9+F6I7K4cH8JQEh6/irLZX3ZZ8TR36IbTg93Whf6GFdcZOm1JTqkzGtV
	 i9pYwXwen4v/pPQt2u7b3ZDJPwko3OY4TZzk68S6bECw7qhTFdlPW5tqXQeugn9oGu3at
	 JI+3Mf6H6tDW5UJjuaFDhFpXCcuUEvx7Ox9v4DIEILCNN3d8FeoitWBnJhNuidLbgUg4W
	 ltcMzgs63Qw8h6DXdtlm2NuO9v3EfZMeYyoJH6gMJG8nD4nQyuCjcyMgViyTC4ujwYebD
	 VM+R+ohMFOR6q+3KsCVu0UKGFlU0Ujlha2FDH8hWyqJ01uZaqQrYS+fE3209lrVGWOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GaOTmO/bbLtGMmtnPn+tjbW+1YjHOYPXeDO/srKr8RE=;
	b=gj9mnT3CJjnOtOdFfKlAEaqI4pzezqTW9FAdn3vcurvX9ryLl3df69XlvPhUPJam6mA+
	 MNJQIxe+6QfWCo5fBdFMjs8rOC6ntxdxEpIxckrE2VKoW+BkabsP0DHdbfAt74704u9RR
	 3t+Vg4Q0fe27kEyWlOjMVjIVtD5L3PIH0DLyQ7JtE5fdqOVRskqdKouTth/+LtZMYGONA
	 hNA74T5JqnDfv7nCElMXdOI/GAGjVjV27imgJYJmkvOtvA3LsQZbthte4awNnUeZesLnL
	 Z7JSmMWVw7KBrCt6ysAGyWNamy4W/ADVx9AiWQ/ut2GiYkqdZg8ISspG1sWMfA34sJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JPVETtOP;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0C606A321
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBD0C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JPVETtOP
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-85a5455bd3cso734323a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205955; x=1793810755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GaOTmO/bbLtGMmtnPn+tjbW+1YjHOYPXeDO/srKr8RE=;
        b=JPVETtOP6xrq1FZ+UyB5hL6D7QtC2mhbCA/s66TQGb0ewuaoeN4zdujlaJdlk4xbAv
         YTZGG1I3wOPE7bx9cNQaT9S92FMMBKd/uELYXP7dHpl4GxS/cMyP6Mm/BuLhdcRgj5ln
         MgyDBKGtc7hIxCQVLvXMKFEllBfyNBEPuy8EbZEfIpp+uY2erS4BmoPpme4CoTNHD45M
         zFFIIAtBrfAzRtXU9ugRW5V5x/rX9Yqad0IDXUNySiEcqVlBHBcnwdn+OgfxYrIFKa4v
         Gj1cXGZF3spg1siS12lUi58LkdhQB/XuWkezd8fWUInPJf0CGIwfxOH2ourJEYIqEeAR
         sbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205955; x=1793810755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GaOTmO/bbLtGMmtnPn+tjbW+1YjHOYPXeDO/srKr8RE=;
        b=HtgoABSrensMnuFX7Y+6oyS5rB5j3ztN+beUULgwpUAJ9PM4MZQjLoPes5wgXkiWad
         K/zHlSSUmpWv7VbuWnFSV6QfBDdOH5ULWNUzb54X/rjcDs3+6DmHHZRMevwJkqRj4ib3
         muYPH4zdfZ3tuCGDocR0UzRR2RwEDqY57pcfe0uyR6A0iO960wavJxQFG9fNQtNsUA4v
         Hc96H3t5xJ03RSwqTKdEswG9SbIqRqN/19qZn3nl/Hs1uF3qKvf67hn5HnppnwgwXwX9
         RZf1+f++ppUPL3rh9JyU7YKdkA10WFNUqiHAEiNzrVoPppI4bzBQx728xkLgtyFm1QIu
         OAow==
X-Gm-Message-State: AFq9FYJPZus32e/tVdI09DB6oLYSIaLj12V5anhFyFotLWw/HJ9GhJYD
	scPAHNtbB3KUxwbwT+h1D3d9DOJS0oIjtLAztlM2lxiz6pPpDVLEKCvVGAUVLO6IIyZMfnoDjtN
	DVVa7Uu8=
X-Gm-Gg: AYBFou3yocIRkRfWJzImmP69+lfXTUxzwJFRaauS89fvn8KBn0j6vizjE2RJo5Tdu98
	YuD3MDD1WwgWSmdDgh9ZLo+tpPDNAUug/yWuY2DesBC+3B1uT4cZqhLsG+xs/UY4ukiuH0ucmXp
	Opjh9duewlP9BkpMjXP3ei/GoMDI0A5iOpiCefSw0f+yioE1w+yhbt3y3Eu9BaZf1kNpLD75Qre
	ZS79ALgQk7ZC9zCncfkmhdVHE+y4fPVHWvHnsuI3Pdx4+sG1ClAHCNk7UCOayejQkr08E4RwMec
	3/biYpXkloooPN1TdGN2tBGYtsYV44WzDJOIwvXXq+E45TZ61rsgi5ODexY9tldynUqUNwfkS/2
	mTYI8d9zWBSjHMJuKLiDgT15z8VxizezpA8sK/8EQtXUyn9J/1MYpleCbkskmjzRDS+nDiaPqY0
	GQjjXpaupn2IKoq01fc/hBHbcVw+IlT4CvPzEdKZdT3BvCTIYK3sTUXbi/u3P6EUBI+tC55/gRl
	L4806+0ronBL07uJbNyu3E2SI/rM6jggZIt40aIAcef9brcvufjuqgC1MdWkZZhiC/wDwHQ4VNN
	ceA39YSFj1ANoWngkFqSRvWvKouXd/68oynlElXsESXlGkq4AEuqD5EfLM7YmrmXFDZYzHvPcg=
	=
X-Received: by 2002:a05:6830:2e05:b0:81f:b957:abba with SMTP id 46e09a7af769-85ab9876299mr3277432a34.23.1793205954735;
        Wed, 28 Oct 2026 09:45:54 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 77/98] nvmet-tcp: let the accept work come to an end
Date: Wed, 28 Oct 2026 10:42:20 -0600
Message-ID: <20261028164415.1262013-78-axboe@kernel.dk>
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

nvmet_tcp_accept_work() loops until there's nothing left to accept, and
anyone opening and closing connections fast enough keeps it running
indefinitely, since tearing down a dead connection takes long enough for
more to arrive. Whoever flushes nvmet_wq waits for it: removing any
other port of the target does in nvmet_port_release(), and so does
unloading the rdma and fc modules.

Accept a bounded number of connections per run and requeue the work. A
flush doesn't wait for work queued behind it.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/tcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 908614fa82b0..a0adcc7f0740 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -85,6 +85,7 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
+#define NVMET_TCP_ACCEPT_BUDGET		16
 
 enum nvmet_tcp_send_state {
 	NVMET_TCP_SEND_DATA_PDU,
@@ -2145,9 +2146,9 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
 	struct nvmet_tcp_port *port =
 		container_of(w, struct nvmet_tcp_port, accept_work);
 	struct socket *newsock;
-	int ret;
+	int ret, i;
 
-	while (true) {
+	for (i = 0; i < NVMET_TCP_ACCEPT_BUDGET; i++) {
 		ret = kernel_accept(port->sock, &newsock, O_NONBLOCK);
 		if (ret < 0) {
 			if (ret != -EAGAIN)
@@ -2156,6 +2157,9 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
 		}
 		nvmet_tcp_alloc_queue(port, newsock);
 	}
+
+	/* There may be more. Come to an end for those who flush nvmet_wq. */
+	queue_work(nvmet_wq, &port->accept_work);
 }
 
 static void nvmet_tcp_listen_data_ready(struct sock *sk)
-- 
2.56.0

