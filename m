Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205919;
	b=IwpDO+TC6ysOEWbT2NQ86uyXUyTrt4ngkxB1LIF3g/brsU5TzyGxCHHUekjlfaaee2jL
	 wVUEogCGOL+bCXDFxf8Mx2NrQQsI81zZxZzjZtO7ke7W3+KwdqxqIrumFXXs5P5Jw2V7B
	 gUAPhE+U8Q4OLPvofv6EpMQymk5aTQTgEclvkho7q0nqn8hDBjnQISttGBbdPIRAh87uX
	 uUG9oLV2T5Zde7IcElT/++0ruI8dhgvJZ6zFx//GG2cJIsBUFOSUMXNVAAtXC1AGIHO++
	 Qq2wkgeWgLLaj37nGv3+KjrzvZPVExbtaO2vWquLjbMJyS+ldbZIq0kPM78k7mpmMHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8OYqh8x5PImgjrLyR9IwWrD/Wf4bmSeLvTPR63MdN9k=;
	b=rphrHcULl/5L4NmoFoTq054PRbPXTJZZIptAx9eMzvWfDqnXKi5x4gN7vGzpIpr4XbPY
	 ZLz3q+Bvq9yzel6mRngZ/30w0uQBbIubfe3EEe99GAO2Lnrd0ehaXgOCVL+FyUlnLvADK
	 OO1FNYgf9VPLjcWO+cB9pNnGZNp5wmzAMOAOor5MN0KUmCAnfrvaev8nRoEcKEIZzRvU0
	 jN4uYGDbujy1UtO1feMjf1ohAk1LkAxehY/hNxf2wHYt9pbfNyrxiAoZ27/OthaEzUceO
	 GeSj2nWFP2C31a9zkT4eHgtcsp+LFyDrLo77Pq/6rDFH3H5rGfOkiU4H+TUImj8H21A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CL41FZNh;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577F606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2577F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CL41FZNh
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f84a55cc06so644603a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205918; x=1793810718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OYqh8x5PImgjrLyR9IwWrD/Wf4bmSeLvTPR63MdN9k=;
        b=CL41FZNhx7oVpczwJBIog8p8rUDi5d59i0OJW1JiXMHYbUA18xefDLerjIBtVBq6Mf
         ZVN41yu9E4KGugdJCkJx7tidXAD7dzmZaRwFnSkOM57nuoGh+imb3L9Xt4LHKPTdyhDn
         SfdxkAdVDKYuNPsUjKDhQyWgnl2CDjGxheTWZSlWYz5GDgCDt32+eh47HEIJm5jj9b66
         4X2LEvNzNcxYLsy4hHjiCu13edg7Wj62V+SXvLbEIcRywTki75NBz9qyWB7SlNG/HN9f
         aKlcrCBG8bayE2wGgLTm8dDwiAiIO3hSvdtu/HSxWK/Cx++vytowTEetqrLeedCf/t02
         E80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205918; x=1793810718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OYqh8x5PImgjrLyR9IwWrD/Wf4bmSeLvTPR63MdN9k=;
        b=AhyqmATzb6ATlaOsMkPDfmL6AoW45nt5LnVFfQ9qT0aTuyAAxTGVN8rCV68suL7xJR
         8uT4s+F9Yl0mb9E3W8WlNBTkIkoCT04+rXFPqqxKNi1OvxwdTypfMSkckBqd3c1hpbdO
         VLe3enTxz07vf2e4XL3ZejbiO6bjkfW14ZlpLX3fGVuq//A+RFA/9jErohFrv9s/U7zX
         5mqps4pzfRK0Xcd7sBRh8OyDmgQoHmlvnODRPvC6IBesY5+c5c+oOWYrbAm2+y3lSjrD
         W+w1byBUQLBJCCx7o8RamCUzA5cjKujqy2hWExtr/KbYadEO7glq2G+DRtFcpBfD+bEi
         UyKw==
X-Gm-Message-State: AFq9FYInnTYMR7HY/Be3+56ffrugqNJQ9Yf+6jjvmhJqS9T5cudJaltE
	VRZ2mApez1HdHENQZKQN7S/8DwPohMvYZd3run0U1Gpra54uZ6HqfW5pXbxj9x2/i9CJNzkaVuj
	6KEoV6Es=
X-Gm-Gg: AYBFou2U6vhuN5Z321UDlCUHB2jWamkdkebdsaq+/cI6YdaLjqdpz+Izb8Wm0iWRnC3
	pjb6QmLVIzhi24djx5RBr8ImC+TSUKRz8M8UFO9VecXImVdylQsi9b2KJbTp2SgZsElOEwQy64V
	YFEcf42vOnTIlyft1MkjUhOzjWWFz4t7NBObCyZQ8sHD/kJD8Zd9zzVyXk03Pe9An4afYn7RixB
	NAjcnPcUYpaduVmyMcQwXhlnPfwKLc4jPHCBFads+k5km8o1krk6Ptw60cSwwWYtqs0WAp0Fk8o
	AePMpftolRIiSxr5x1V7jpTJql2U1rG9XMfR0n3szllwVKWglezCNPWswxqYN3rqKxX1MGWVrOC
	YOetZ3lOycZYirnILR7f7a/EyZw1l7n+N0ZBa/ChWEDbLg3jKYaYkfu03UKVfIEyq2rH60Qdtmu
	Rr4PSvcJ5OeQFJuyGdlOYTNYfPpeOPpG6wVO+9PT5wd/Iw0wzDgUaj4XOmm2QCIyEBA4PTnI2zS
	+77BFjDdnB92xiaVTpcO/ykXeXDMg6oGRl32Ca1XoP8wK+7aPp5DxV9VCJtUow/t0RVpiVrjp3+
	GokcTm+YycAfcdRY2xVPK3cBH6fwZ07WWk0hAQHDLVX6rEuhnlZX/DWIfFYxIQwc8zFhPbn+xho
	qjQesVfhCwpVRCed2qTc=
X-Received: by 2002:a05:6830:2b26:b0:845:8d86:9f7f with SMTP id 46e09a7af769-85abf969183mr2589622a34.8.1793205918128;
        Wed, 28 Oct 2026 09:45:18 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 49/98] nvmet-tcp: ask for the TLS record type on every receive
Date: Wed, 28 Oct 2026 10:41:52 -0600
Message-ID: <20261028164415.1262013-50-axboe@kernel.dk>
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

nvmet_tcp_alloc_cmd() points recv_msg.msg_control at recv_cbuf once.
The first receive that stores a record type there advances msg_control
and leaves msg_controllen at 0 for the lifetime of the command. From
then on nvmet_tcp_try_recv_data() sees the record type of that first
receive: if it was an alert, all later data is dropped as alerts and the
queue stalls, if it was data, a later alert can't be reported and
tls_sw_recvmsg() fails with -EIO.

Set up the control buffer before each receive, like the other receive
paths do.

Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a0d942c34d3a..261672ab5c1f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1286,6 +1286,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 	int len, ret;
 
 	while (msg_data_left(&cmd->recv_msg)) {
+		if (queue->tls_pskid) {
+			/* The last receive has used it up */
+			cmd->recv_msg.msg_control = cmd->recv_cbuf;
+			cmd->recv_msg.msg_controllen = sizeof(cmd->recv_cbuf);
+		}
 		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
 			cmd->recv_msg.msg_flags);
 		if (len <= 0)
-- 
2.56.0

