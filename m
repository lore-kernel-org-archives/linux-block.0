Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205920;
	b=cpMeZUfLAwtXLb2jd2CvMeTU6ARqeqU8mitqRy8bdrV3KfkvFSgOHb5xwwtJ9uqFFduK
	 xKRjboEv2HkavRkytj8DAcPcRDpI+Afw3NQU8xVomlZjK/9RH47kx0mCjz1zUC3v6vGVp
	 gFywmCCvf98vQllwr/+ay8IPP44zOa7/JnWVbEFSFCMTD9hu2nWvjkwM5MHaKyu/8wW9X
	 pSWDLUwPSmh5Tnfhn/RodpMXuy9b90Ip6xjB1I4pmyZgbrdEiPOqkx9gko2iFjvVFC/Cx
	 abjaD3iZyPZnymrOZvRUrwyeqZOyThvsuryaMdmaV0hj7RUKsQBxO+fTnrz3xs9ELMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=03q1z/WhumVzt8w95WGZG2payDI3CpLLRhDHvVipzvA=;
	b=i6ZI8yM6TpCduOdQIjsaVCzrS+GS5eXKfGmBLMEIUYx8htgy0Fj35toKHANm/gCH3xtS
	 rxxX4vhkuqLPWm8dmkQi78Mhaxabi6gRqWIPpDoT4je2IZDQFe66nB0KGhpbYqi2tGu4k
	 hBB9QDL328oy9niV0VGmVzYzSAxfJUvNQge4Xf2SZ3qQ8TcyBwbfE9MqucMqjR14ShIQN
	 b74zIc8UozW0R+6xEJuMsC7NZQiBlSyFU0NPgdiumkcNkoCj72Y9+/0bbrO4YeSHeCHZg
	 0kV76BcRMwEaBBUpgeoRxFhZ0//y9Oiq6rhHppR2TgaEM3TLTRv/N75hz/8Al/VFShw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A7ZIEAED;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725B606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6725B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A7ZIEAED
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1411516a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205919; x=1793810719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03q1z/WhumVzt8w95WGZG2payDI3CpLLRhDHvVipzvA=;
        b=A7ZIEAEDUzfPjso658bDsq832qF4OSe/mClU2huPlNhOQXeqNpEQBomBRt9ioxxldx
         4ZlXqS+XycSrsIml5bvo/CMW2aG6u2gJcqWnI5Bf0moxnLvDBlmiBwBalv4yMo9xHRmA
         8wWC/ctYFWM8+Zy1pigtwYb/NNqL19N/AhxA9A5OwO5ol3bu2zAqFkJ8evhqaN0MkBCe
         3U0QR6XspdFEdkY4tEhnbo7gKvwtm21xbjoP8s7aJcCDhF8XV9W+lyKDrQ8mNQ+nb9zL
         RoG828J+RQN+5ZhPLmeER/Lb2IYsl0TkKORzFtfO6gzlpEzgoARv4/2mJmCh5PrAOsXr
         4HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205919; x=1793810719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=03q1z/WhumVzt8w95WGZG2payDI3CpLLRhDHvVipzvA=;
        b=zJkHqOsTqiseRVr7BRROzB1eda8SSIHaqCOcWREsk1ns7nAxmMOB9ofsojUN5HftwX
         iYhjX3Ba9XSG94XSW9Vh+j2o2p4FI1xotpp+RqaNCpB0rw4WkClO1rQjsYqZK4KnFat6
         wdjfnK9bykF9rl1X+mF4WPX6boANccJ8k6yxiHwiFtrE0CAb8FqnnsakeVUnZvnCXhvw
         vY7e8v6ffa9ZP5U2W60Esw9EpSnpcAk50CyllAt8/GBA3oGb7EZsPYd/l9e8O/D+FRa4
         OQVWDo+iknCalb3ukxbqdlz529evdcep0QoWYERBYf2i9WGuZbWxynJplTMCfVuVhu75
         JslA==
X-Gm-Message-State: AFq9FYKE2RLNjOO/sq8L6LVlPx/WlSM1gu4uwfJrfnEf2C9p3zv3EZTN
	ew3FUy1B82dcV+1LcamOhIiBHi0041cJAp1OxY+4ffCPkXUpfSVIwyUiW9jnipzhBcFXVMiGTiN
	ZN6WyvaA=
X-Gm-Gg: AYBFou20S5TcOsRLNtnxE7g3a1w5rZvUE2ZxdRmVhRY3QfDnk4gJecuVSd8vSAIP3Ib
	S4Hj2zu5I6ZWbC7J9d53SQs9Zy9mAzp8wAy+cbbVUEUTqT9zaZ3ux5F7xq8685VWxZUxKJHDnEQ
	fmtaQmhJwoeQeP/Id1NS3KLKdy18ARQRXBoJBfQ6DK7T2QXyCgJa9GkMIwCqyBMW7uME8xBa0Mg
	L1sZqSEQX/LCjdlhOjbD99LmUrRUeyakq4PXvBtchmwHMaHCw8mBnwi7scNmx19yDv6nzF5+amH
	DP6mSveSUbvmf4mFwJpBsYXmgcCAPVMulo3z4PfvHsXVkCGZimkdvNRH5i+JnGff5/2qurgdu7X
	5dFE2EmCcuXzLexEwmfg4DTIeiDpOOzL26HIgUC0YE3YIcxC5X/wR04MgqWiXfw928bdBAZGF+j
	i3C971bIsrqJOU0t+0aCBRDNlmOikrD3pjtV08TUnMIZuZb9nJAyAuWTkJVH9hp+b6R+xFLg6bG
	MVQaTmHbe/dxVrOGRDJu2KDuJXaszx6DtjgMsNjNfH+hGxAkHB1bpnka9RZ6wjaRlaZ3eAPFQmv
	dAzV82f66c0UT7IGPCgYDCcjLFo7qbEaXb59R0Lzrk44GWQCGOqzgCe9lccv+LxC7JQTf8BS9w=
	=
X-Received: by 2002:a05:6830:4110:b0:843:98dd:84e4 with SMTP id 46e09a7af769-85ab4e21711mr2733176a34.3.1793205919429;
        Wed, 28 Oct 2026 09:45:19 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 50/98] nvme-tcp: wait for an in-flight TLS handshake callback
Date: Wed, 28 Oct 2026 10:41:53 -0600
Message-ID: <20261028164415.1262013-51-axboe@kernel.dk>
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

If the wait for the TLS handshake times out or is interrupted,
nvme_tcp_start_tls() cancels the request and returns.
tls_handshake_cancel() returns false if the handshake already completed,
in which case nvme_tcp_tls_done() may still be running while
nvme_tcp_alloc_queue() tears the queue down. On the first connect that
frees the controller, including the queue array the callback writes to.

If the cancel lost, wait for the callback to signal completion before
returning, like the SUNRPC callers do.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7190eb10c248..d735994ee517 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1827,7 +1827,12 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		dev_err(nctrl->device,
 			"queue %d: TLS handshake failed, error %d\n",
 			qid, ret);
-		tls_handshake_cancel(queue->sock->sk);
+		/*
+		 * If the cancellation lost to handshake_complete(),
+		 * nvme_tcp_tls_done() is in flight and still uses the queue.
+		 */
+		if (!tls_handshake_cancel(queue->sock->sk))
+			wait_for_completion(&queue->tls_complete);
 	} else {
 		if (queue->tls_err) {
 			dev_err(nctrl->device,
-- 
2.56.0

