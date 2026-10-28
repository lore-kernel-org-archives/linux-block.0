Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205985;
	b=3hmdS50Ixh4H7XzetW3OooYEab5CS115USBq6CtKLhIz7PttFsgkQRyG9L/bkTnu0DZc
	 61GU9Du/hJtNhO79L/Q+GLXfMQDfTCx5+6nS87GxlAkcOH6H1Pkhb30i5DEue6N6vKC0e
	 VKmnoseLuPfH7HZhfwzUy0zY/1Y2N4Ke/kSBS3B5e7cVCDqMGxizexHyNOT4UEQjPaTM1
	 J6bb4E4KtIuzVfhu4b2ybiGhAsVnaMZZGwHIiOmOSEVGvAsOBFzHqOkIySCiOfR/cxzIm
	 WChluO43vzTcs1xULow9tHhKRPf/cRCfInI5BhxscP2dVBMTtzKmECeNlDwYE5cn22g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=weYgcu8mKXNQr92B1C0Qaaoo7PE0FKjrVVwXEWqleNE=;
	b=QNo31iZoyJiEUKwRl77OWBaytXt+7l5MlreYNKweEn7qDHzrunfhmGikxB2F5ei5upKm
	 gLnkbJXydIGYSKYjdaxtVr1CSvKBcwM1Bu5GWKwF8bT0yLVHCv+5P6qL8s70U13bRVbqL
	 uRwS385K1JQa0BPhxyF61z5LZvQsQEyMoMx4xLjqdLWONWl3JUIcC50oSQPjEuHsGyAUf
	 p7LwPmfHjQTX8wx24ut9SsYimRXQsh0HGDqAa8vcE3kgQ0t6p7m/HDyFi7QTUpKZuwfRf
	 CTzNi1v/z+NywvEs5MC9uC2Gfv7w43jCesiNHZ63cgwM8c/CCAEXk6sGEwT09Q8CNOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nRoq2n8L;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00BD60A3826
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B00BD60A3826
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nRoq2n8L
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6de1fd5f572so605494eaf.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205983; x=1793810783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weYgcu8mKXNQr92B1C0Qaaoo7PE0FKjrVVwXEWqleNE=;
        b=nRoq2n8LgsNIIZun7aNhN5ZM/Ln/Vlsx/S6EcF7Kg6iTxf/b/E1cTKgWEH+crsqvsn
         fAtxIOWsOYOa8LAp2pm7DfzLsj6npIqt/fsiAFk2WnYoVk8aTPLaq21BUrdAatwJBXgz
         veWrLDTwj8TjAMXpACdjEkOKW6TIARye7uzhpgrvVXP4r6F4cXTTK/2Td/EcKMeIGBcl
         +eBWq8cm35iYbihSaGy7/zjeK2xDvHayyWlDetB8QOivJmLRqDWYsM9IHHnuImn96BL4
         iPKsHYZ+JJDYgHV61YaZIdiBSJawna5dn/BNl5QwyKYRpMfCSUQJtqMSxcIaYCyBT7Da
         Y+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205983; x=1793810783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=weYgcu8mKXNQr92B1C0Qaaoo7PE0FKjrVVwXEWqleNE=;
        b=vLdtuHeXrA+bWurEE54SWgZaC8kY/vOxVNWDHIGySdli8d8TGXkCmTfhOBnQlJJX3W
         FIwWz6E6+ycWP9IWSE1sIa8QPLxWxWX7a1YVrCQIk6evGwukroVxPLiveCOm3nPbi//9
         RTXu1EX2VCQRktr+Ur7XAihtCgSGVUKU+9b5VF/kkTKqHp2GB7hNCNR8Q5V0C9xnbKdE
         jirTepZ/XBRfOTIla0AtHLmaXIKHnBeP3ZWmzpT3xODTVf+iiXNGmkEzpdKEyXUZUQHC
         OiveAgg/gXJkGLRnDTFGuRtY07lt/5u7rch18LCrtTlCjTmtCtODpTPvKW+5OLXT+DUF
         BHBQ==
X-Gm-Message-State: AFq9FYLrWSxlkvs2njPy8Wd2dfBEuZNqEuzsgGAOOLD3afrq8X6JZzHa
	T5HuDgUQ7qjHuLODsyB990Vwp0ACm0K2d13aVoOY1d3xp/sFy85YjngttOiT/x04ekcIp7WX8OH
	s9SUtpDE=
X-Gm-Gg: AYBFou2tmEvzXTGOJzGtFay+T7I7SPDgpR22m2C+4rNIYFyy5b1bmVa4ewRoEzyX0Ua
	MG3l36Om9DPI+Sgizvo8+C3Hr3ePphu8LjpNK6le1UYEvZzKDMYsxbGf5pYLjrjn8C7D1x+zeFt
	yQHFv1S8bTI60w8uqJW2ktyNoh7Z2p28yr4EtijlJaJ1bPFA8TimLBuqDrlV2cF9d51CCC+OkDq
	8JduvJOxxgbdNG9RXs+G5d1i/EL9C1tZsn9AlR0zhic8z0fSJiZvGkJfb2fya6or4Z4+sHeACC+
	BWygOTnbvA8Fip3bhYcApbEIlH3OnvbZWC0cpiRq9g9zJkoHXGth3uUAjOp+AFL7Ik7QXVCl5QC
	Rh2uxsfYBrtcGS/iZu2P3LE0r4Do+8QUj7L7PqZD8GSvY4JsgmWY0wqXPBB41ezgmF8BJOc8Tnr
	oteih73HG7ikYNakaCb2lJijVxBWHM8VXh0fejBX5P0qcyo2iEB007d5HeSWqdlRZmBl4QtnlHK
	BfD9eWEUy0I/mp7QYFpNW9Zcu3P4vl04MyBi3WvUzQJOR9uc5Tvmh+Yc1r4/7giim66980j9GUT
	MhFZRvJWNHArlGJEb+OvjWOuw0wAP0I4B96ieUGT3Stxsz7ixdfxpP9n+VXG/IQFpEsPvrW6dQ=
	=
X-Received: by 2002:a05:6820:3519:20b0:70a:d839:2b35 with SMTP id 006d021491bc7-713effff5e7mr1146154eaf.86.1793205983473;
        Wed, 28 Oct 2026 09:46:23 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 97/98] nvmet-rdma: hold sq->ref to post a T10-PI Read's SEND
Date: Wed, 28 Oct 2026 10:42:40 -0600
Message-ID: <20261028164415.1262013-98-axboe@kernel.dk>
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

For a read with T10-PI, nvmet_rdma_write_data_done() posts the SEND
after the WRITE completes, and by then the request has put sq->ref. So
nvmet_sq_destroy() doesn't wait for it, and the release work can reach
ib_drain_qp() before the SEND is posted. The SEND then goes in behind
the drain's own work request, nothing waits for it, and
nvmet_rdma_send_done() runs against a destroyed QP and freed responses.
Seen once as a use-after-free in sgl_free() with an SRQ over rxe.

Take sq->ref with percpu_ref_tryget_live() while posting the SEND, so
nvmet_sq_destroy() waits for it like for any other response. If the ref
is dead, release the response and post nothing, nobody is left to read
it.

Fixes: b09160c3996c ("nvmet-rdma: add metadata/T10-PI support")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 994a668f45d6..fe426a0f7e57 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -862,10 +862,23 @@ static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
 		rsp->req.cqe->status = cpu_to_le16(status << 1);
 	nvmet_rdma_rw_ctx_destroy(rsp);
 
+	/*
+	 * The request has been completed and its reference is put, so nothing
+	 * keeps the release work from draining the queue pair. While we hold
+	 * sq->ref it waits in nvmet_sq_destroy(), and the SEND is posted ahead
+	 * of the drain. If the ref is dead, nobody is left to read a response.
+	 */
+	if (unlikely(!percpu_ref_tryget_live(&queue->nvme_sq.ref))) {
+		nvmet_rdma_release_rsp(rsp);
+		return;
+	}
+
 	if (unlikely(ib_post_send(cm_id->qp, &rsp->send_wr, NULL))) {
 		pr_err("sending cmd response failed\n");
 		nvmet_rdma_release_rsp(rsp);
 	}
+
+	percpu_ref_put(&queue->nvme_sq.ref);
 }
 
 static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len,
-- 
2.56.0

