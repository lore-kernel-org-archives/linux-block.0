Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205972;
	b=Ew9TDIX4apE2Qy+WXVmxHLkcnHVmAPTyr0J+rvLjfHpN3e0ZqIQguQL6Gl7/EKWXKuFx
	 BVS4o+M66lisEV4G+jSu6DZwXJNrHyLv+Y5GyauVaOT2hffOxorT0WNIcFOSa4+AqX0sL
	 9YxBqNAUj4cSi33FxA6DfNGWgwgey9ir2zLfc7+sQuqyRoRrDMX8sedkrjWXZwIN1fz5T
	 Csj+FWwN0xIUZnkMcnIjyGpWZMBEZMoEzmLLgS/euuniYiAacWWZlkydUzsbOUwRW0ze+
	 G0ofNOTVtBi9IYaHHUeaY1acYyOvn3AIa9sINvT3yPzHsD3Uo7VFXR7wkHPI7nSAKQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cHaezSxCR5SckJScUYgP2Df1/pcfcAba5dQySooCGho=;
	b=jwZaZ9tWqpiIdeP6KXNqRdlWRBsAoEKNzW0i59Va+C1QLWNTd6b01UFRG5mxk2gpn+f6
	 ZGoE4OaMJpiwwr0MxZUtL077qipeol7bfMK9QT7yqIu1b8M31iiXaRY+igJSzkzXkf3aw
	 1thLEzI8+a14Puo4EAbzXiU5gdRvkzRwd4wkxWToo+9ZTehorFMT4/2149H4Adc+XasrN
	 BOb2XstUpOuQwh4RNxwG4OL9q9IgWVJb5Ocm+ROIZEEzBOBs/hR7VHmJp6z5XDVNljxsk
	 C0eWXh+S0mMWbemtdM3wXjeyKjyiRjRle4lByvcHNEysTPWGbdXTok6Qs9rFjvoEF/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dTJ4+slU;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060F60A260B
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D060F60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dTJ4+slU
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-846566246e8so1081764a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205971; x=1793810771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cHaezSxCR5SckJScUYgP2Df1/pcfcAba5dQySooCGho=;
        b=dTJ4+slU9bS5l6e5cEYKGRP64sdKw7vwdNWIwsMyn7+5NJeS8F/X8Dy8drgiK9dWJt
         uwdK+XfwUPRbAkOIAs/YpmbCPft3Ro8XLI9s7Pv3lw7G3xYJ9JEwlq3smvamE2VX+GMF
         fzcZK/cNlv7qr15Qi9GXB9lQH3smaUHtHvscKzVJZNHQVBvVBQE0DL5n9XW0LJSmVxgP
         FydDNsPrd9Cp8p5cwJhIlU/t5DM6p/knoRGCPI5BBdGbfXmFCoPA9yAE3uOMFakCf/W3
         CdOBgfvk3/vXayAlOq5KkB5JMq7pDO6uWHH9/lQnK9Co8xgpApQzW3wKD08r1V75z1HW
         yy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205971; x=1793810771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cHaezSxCR5SckJScUYgP2Df1/pcfcAba5dQySooCGho=;
        b=FK4YK9YXjozrGJcg//ZGPwQjw3VrNogj9Vtq1jWoGcEa+/xOoM73ly0e/g/qS/9UdY
         WKHmcryWkUG4e/Ed797dyc57DdTneijwum7TM+Yn4l1SFbBcOG71WN5NRzFxJP0zvKgs
         twnAnx+YwF0gdCx4xRZI1LGrAwIuFi6gsXNC+zjX7iIOpefW8AD0E8jupTcT4T1QM6Pb
         aL7WPG2/f8IgzeOXRNrSefsRyPHbAY72R9+GeGwf2MNqCgpH4L/YRCoMBluptn0ZZJpK
         dtrKYHTX25ve+aqajMCGl7pKktbiK+H/wwM5hH5VkIvz6GGswYMntB/Zbo7N3bjWB2Z4
         zf+w==
X-Gm-Message-State: AFq9FYJxWGoVIwoiAVn77xcUMX2haTHQNfrE0uWqbv1OVayiP+a3Gr5/
	xzZCqGBFa1DLdiDUAVfYxswdq19qwINYhCZND1bpQSfqVlPMcspswcexnasfQBK+w7HvFh9Ek+b
	SLm3UKo0=
X-Gm-Gg: AYBFou3bip1PL/pwvH3yle0WPtH2UOf04y6dfh+iKSJ3TlIPvfniXw2bDN+Jt9Aum2T
	rfme1nbzad8J496GCEQfWJHhvuO6vsMhYGFEGvA01GuUunUOw7n2lgHIcsrsh06D2DwaYGORODe
	X/GaX2wCmV1dymXp8/l1b+For9DRboWd8V7ZUujWaD/YU5FYeiflk6Q9BZkHFpCGwqlBJBTysiu
	yS5HW54xa2GSgcltxQ/cOT5w90xbY3vQ+C8vQehybKL/IUTnTgYHswbjNXVlRua+jYg7W8+FWmc
	d6xIVfHDPoeveHhgiTdCVJOsNUUdGtbgQp9aGn03YsQtPfqitpeEQK1xWHjoCDJ8tD8N5xkIQul
	XXodtoe0qs6WcjA0CefBFDHcToF+frxi3pHsJCmi8hDwpwz4Sff6YvKDHk88TSUwI+6J60glE47
	NDojdyA8n0niVzpNJ5DdWw/ESboLM5ZvdON49nBP6VIRLwA6Id0gCPtX4b1nrwhS+NC9tJLEpan
	rxr4EE/nENh0yrP3EAjeGA8SxJkszWfEtBTtMN6HY9qiYSZ5pIM3hk4gEKOAfsc8Z6LOB7C1i/6
	Xkjj2KhDlhlmC0Ws02Kt3hEfKKDGjhixuzelwpocfQU2pReF6E9fMOBvTaKR22KNZNqFbeFsLQ=
	=
X-Received: by 2002:a05:6830:680f:b0:81d:338f:fb44 with SMTP id 46e09a7af769-85c220763bamr44186a34.25.1793205970809;
        Wed, 28 Oct 2026 09:46:10 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 89/98] nvmet-rdma: reject queues larger than max_cqe
Date: Wed, 28 Oct 2026 10:42:32 -0600
Message-ID: <20261028164415.1262013-90-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

The host picks hrqsize and hsqsize in its RDMA CM connect request, and
nvmet_rdma_create_queue_ib() asks ib_cq_pool_get() for
recv + 2 * send + 1 CQ entries, up to 196607 for an I/O queue. The
pool limits each CQ it allocates to the device's max_cqe, so if the
request exceeds that no CQ ever fits and ib_alloc_cqs() keeps adding
CQs until an allocation fails. Those CQs stay until the device is
removed. rxe has a max_cqe of 32767, and one connect request from an
unprivileged process OOMs a 1 GiB target in under a second, with
nothing to kill that frees the memory.

Refuse a queue that needs more than max_cqe entries before touching the
pool. The connect is rejected with NVME_RDMA_CM_NO_RSC like any other
queue creation failure.

Fixes: ca0f1a8055be ("nvmet-rdma: use new shared CQ mechanism")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index b961d1c4aaa4..26ea4e1d62b3 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1286,8 +1286,17 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	 */
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
-	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
-				   queue->comp_vector, IB_POLL_WORKQUEUE);
+	/*
+	 * The host picks both sizes. Never ask ib_cq_pool_get() for more
+	 * entries than one CQ of the device can have: no CQ would ever fit,
+	 * and it would allocate new CQs until an allocation fails.
+	 */
+	if (nr_cqe + 1 > ndev->device->attrs.max_cqe)
+		queue->cq = ERR_PTR(-EINVAL);
+	else
+		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
+					   queue->comp_vector,
+					   IB_POLL_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
 		pr_err("failed to create CQ cqe= %d ret= %d\n",
-- 
2.56.0

