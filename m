Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205966;
	b=XVHkyaausXrGOnWqnPIWLcVuLEGW/b+Le2xiTNIB5BJaBYzrr31p6jbC57zkiYHTIgCJ
	 3459Ous92LKlIOKtAPPwx82EltyNm3C/NaJp4we3SFqMbFEqh3hPhGbangTTji05FABUM
	 QOBLBzV0GfgDFjRCiz4GQclD9f4qBLBbiy7fvRtjVHKBKKRslrJaPYa6amJAJQ0l5q79M
	 ExwRf+i734RNUTeogO1emG7lS5tHVeHAiHktnAl2nEefzK1zT1NeWc9n8ip9Z7qsktE8r
	 6Em61t+EDvW+qcodGFSvvHHU8vLaf0MJp7W2myp6RtuLcMfQ9WwtAY0qzBCK60lshvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xZCZDR2pTFet0gG8xZHjIFWqqCSENLsF0Z16cImTshc=;
	b=PV772EpmM8nL6y6s92yqmf7HWC4BEgTYeNq0L+dH3L/aekLjoHcWPcH3o9YJ19xan0xL
	 Ia7YWfn2/RYy9Q39/4hOo5wji+ux4wvtOLNoz21uJgM2fKulq2Hpp80vUL3pVWsXekRAX
	 ial9XS7JKVvq88M+xOl8kTeLHACW2qQzw3szh3ZP0vn+y9W84GmOAMRV5y63qTYLjPtGg
	 FxTIu4eg4tvCnIJf1x1kEGSzxw0W5Mk9IXZj1s8g/a4RCnfZJjNiLkDCbu6Rq7kz1u7bM
	 h8m/mUS0Kmpl46gPrRZS9wxkImfexR8XD+Bi7bY1TF9VHa29zyR9ppWblYdAtxO2FDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TV0NksrE;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6F606A326
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB6F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TV0NksrE
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6df0b02fe91so1501930eaf.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205965; x=1793810765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZCZDR2pTFet0gG8xZHjIFWqqCSENLsF0Z16cImTshc=;
        b=TV0NksrEi8cJeHH5SbN/oVULTex0TYH2dpHuUZroE4gjKQN1yHJbkfVlCFiemuf071
         La5mZcdqHbIQArZO70kwg7C0Xn8eSS/KWpWbRP+gqA91zBhI41auOboKoRR7bvXxOf4T
         kZw/gcntkjzYPtbBXxQVrQjynbaO9sXT7vu20qklH8mlZrKVr0G4VO8xUudkdHwvowrW
         zJD/ZsI5+xDAMnjA0+LMzW0P+PMSzDrC1MDPtgIB238h2CCO5fj+NqvQ60T0UdpKnaSy
         GthuuelEtwacjj+MyJaOav2Nj1MYGHw/5vV9wR+de+CHoEdpaGDspOyWLuW4574OCILV
         qGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205965; x=1793810765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZCZDR2pTFet0gG8xZHjIFWqqCSENLsF0Z16cImTshc=;
        b=jl+qeRJH7Y3zvpSpWfpZRHwrd+po5Glxo/ZxXSHRaksmRZNrgDbYWzFmmqPuRtHHZY
         sO718cupwU3d2tVFPwOqsJiBCCCHYGTLE7kYUmrcd9e+fi6NHQrYLr4uhpX/NDLlxDjd
         bDidvss+jgZEkQ5m4vGJrrpFcjPcAYf9QIIqXHgbuP9fvBkzT2sm4WSTatwWqlh/aS0L
         LIF8zq5vMKJ4GFcaxkHyTTfSMFwafvEfU7FcW3NYSoeX11kuAX1YQc0JWT+4kDNGTb66
         XHXDPUmldsLRg5NVzBOrUZUqUrsf87C97Sxirr9k6wIpCNYzWdIk1anwLKZT+69DpZ+p
         du7Q==
X-Gm-Message-State: AFq9FYKmH8s8Zd7HIlj1WFml7jgxFkShCivfgdLDykIL+a/XWhLEL70f
	xefFWKwVR7WhBm39DLEt25WFTkSYkHSN5opy+6Mjxzfv31DsGkdg4WhpX6o41q1abY09uHveM14
	TDa8hxpU=
X-Gm-Gg: AYBFou2t1UDJomJ/vnEBnrFMyaHFRKd3IeIxer75Q7KjFhWjGiuVrAZ4OP46ulu2lVC
	pLkGngawRGT/+0kOC0AMslWkPg50fT4L+Ms6MtbjGecXkkWAPIHwGJEppZ0aYd7wevxZOazXIZi
	OII2B3EP40hn5oDeaX2RzZQGp1UkQ+VGddMIpzblPVovtZQvgR17s9aPKJRgnMLX0ThvR/iJ8pA
	SrGxw1Wqr89ELJBvPShEmTCf8Bxsl3ieGBjw+sHNOJfH7Vms50PLuyLhk28Qej5mGLp9SjQnX16
	HKNHUUQJ9chfMdEEPIa/s4vEQ3aDOyV44G6+58jMPEqmO0Q8xakw9/Tr1hO70L4x+PBHEhiOPtN
	FJ9wuQeFX0OAYZoirWAaA1xIqiJ6fBpq81Qdrovqvu96wZvgpn1dwgJJmCgL9zhBbvjjuPPxWfE
	6w0GCBvBk4+YZHBFqbpiPU7Sjqt2M2hqAKlibUWnt1niY2AOtExDuFUiszQMUSSOMilbwpN6vzN
	T6PCex3YIOlzFWVz9NRly60qm/6ZwAk2FoUfe64cO8e4B7FDx+28zFIauOfGTR8J+xrn6iyp+Sb
	1Uk7HonjiUAS78DiQj0ecc0q/s7/qu7E1BmUFM1D8J1flRACiALUIAjzlzZVQERDNotjKJqlkg=
	=
X-Received: by 2002:a05:6820:179b:b0:70b:8cd5:8925 with SMTP id 006d021491bc7-714ddecf865mr67368eaf.12.1793205965093;
        Wed, 28 Oct 2026 09:46:05 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 85/98] nvmet-rdma: take a device off the list last
Date: Wed, 28 Oct 2026 10:42:28 -0600
Message-ID: <20261028164415.1262013-86-axboe@kernel.dk>
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

nvmet_rdma_remove_one() disconnects the queues of a device and flushes
nvmet-wq, but since commit a3dd7d0022c3 it returns right away if the
device isn't on device_list. nvmet_rdma_free_dev(), run by the release
work of the last queue, takes the device off that list first and frees
the SRQs and the PD afterwards. A device removal in between finds
nothing on the list, returns, and the RDMA core frees the device under
ib_dealloc_pd().

Free the SRQs and the PD first and unlist the device last, so the
remove callback finds it and its flush waits for the release work.

Fixes: a3dd7d0022c3 ("nvmet-rdma: Don't flush system_wq by default during remove_one")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index c5970bd2dc29..a85e6fa71e0b 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1190,13 +1190,17 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 	struct nvmet_rdma_device *ndev =
 		container_of(ref, struct nvmet_rdma_device, ref);
 
+	nvmet_rdma_destroy_srqs(ndev);
+	ib_dealloc_pd(ndev->pd);
+
+	/*
+	 * Not earlier: nvmet_rdma_remove_one() waits for the release work that
+	 * got here only if it finds the device on the list.
+	 */
 	mutex_lock(&device_list_mutex);
 	list_del(&ndev->entry);
 	mutex_unlock(&device_list_mutex);
 
-	nvmet_rdma_destroy_srqs(ndev);
-	ib_dealloc_pd(ndev->pd);
-
 	kfree(ndev);
 }
 
-- 
2.56.0

