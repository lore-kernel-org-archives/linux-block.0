Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205953;
	b=fsINK2pHVX8fdSDjGwOqJATHNCaoFxCf+0EiaI+77XcjODiGx2H0O9DYzux5F/N09Ihe
	 97BmVJjBsRKmaFuIzCKBbpbguwjGwS3mH2p02A24cWOkptpAuFVxXLDg/lbAViExjLNPH
	 UVVfHxVit+GD/31eDE+aue3g8iw521oVcq/pg4B1d+f1gyT/f8cCJDF2V1Z5JU5+5VePP
	 2NTmNVUUzRfv0fPRPmLiTl5eaqliFkI6V+xTMbfOgdjUBFUIVdJUjyrSzRP/Jgmo4SbJA
	 dv1DqdRsdkwGQBaIMNIIQa8I0hZj0mCmp9JEAGJbSzT/PSetN+U9XUFdZ74qChEyWfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wLrW1fe0BLlmqySJPVK+vEPqFevObDHYLzu83wDZCVw=;
	b=yq6eGgtISy6K7i95N1QDrktlebiQ80r+MkcmGW9UALSY/dPx6ZyZJVMc2Sl62+f6ZR8a
	 9L4k9pZ9GrBQRCHc2TqaaQoTo+fg2cdrdb1K2RqCRJWLjTywP3b5zYGhl61uZq19Py18Z
	 5An5cDlGZ7sdF34qI/7zqMZYvOvuajeJ75AhXMjkdQ4B7ftWk9hXKdryBPKKXmSOLgHwj
	 kyQi1wg/T+ym0uGRJx1yEpwode1T2tZN//2ivdGwJB2k7WE/Cm0DYBPINmQD6CIuy9B1v
	 syAEhff0SoPiSCe9Lje056ZDwhozgE/R/Rzb1v7QWPCTzqAkk0s9URns9YKsepPH7Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MMpxA6rz;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C908606A326
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C908606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MMpxA6rz
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-823b938464fso825975a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205952; x=1793810752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLrW1fe0BLlmqySJPVK+vEPqFevObDHYLzu83wDZCVw=;
        b=MMpxA6rz4Pozy6+RKyOxaKAi5X2N9oJ2ovVhRhLrGbnaZTc4RJVwaCLYgfFmcAYGwc
         ZNQd1Pg5cPB0noAofba85i4piNrF9nl69PXXyXOaFMuc+MEhM7ouH/AsMajBMDLltbsw
         cneyW53QDz8tBDMMP2xj0NajiBOkkAcCGAuNJk16yMxt0LdQRRHCwFPEvpox0hI7ueJL
         CeqzSFzGOqXjvtimSNLyDs1H8254I/cYQhdAFs53j4Frm4jkiRMZvK4YxryIqqiT1tAS
         6MRRhgSVZv4AjkojWQNTUmOFzTFYsmKqvxJQBz8y9ZJduUI8RXex6Z4Sy5BRknExp/60
         UodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205952; x=1793810752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wLrW1fe0BLlmqySJPVK+vEPqFevObDHYLzu83wDZCVw=;
        b=nmFy+ewLpvBpsBYpumEaXdKNDDRxu1W6CCmk/UuQla340/eYTiqiafbN4BZdK0WdtG
         rIL0ecwgeMIBaRy2jmLdEPKWxZE4aLjUz/s4ZXND/+t081e5lTeAAKDz+J0MHEFMdFIW
         MELLs/TahPOdpyG+iddpWs9RTPFdsXwq++QdkvP8YgQBqT7GZdTRr4IVu2sR6QoyAUfu
         LluFN+q7boW97vy//z0JWY6rrxLfvjWSvHtgIcL3JYLvTg5+xHjNKI4G/4d24vXh5Nfn
         47wJkxcTM+sSgkuUWl8B5nfS7gAv80aYUGaqK22HvN+F+Cqvumy2leyxdl6qIKLFLl8C
         JSRw==
X-Gm-Message-State: AFq9FYJ8ZfW6oe+06mHgH3iTjZ+ijgbKEmyfLPmHu9cWxlFnCJX6Z9IH
	K/i2VaMGwcb4Fej1fkQMP5ykpWtjuRqQXXP9ictnKROnD6JR5Z9UqGKBGGdOEs7C9urlbaEBr74
	yen2drBk=
X-Gm-Gg: AYBFou0BYNW45MtqU7DrSHRdgxJxLlr8BwOeSWJpU0W6xsimqOf+0N3FJI7+4yK21RE
	eYdPqzjWZoUQblX+7nh2sq/7Csi5peeXwW4s+NLNcLD7EDpJnv95ThvqGcm3wt+GJX1/fnZ4Z/u
	cYbpX6MfrR5FQstCRHye3m9japRBUlQl8qONVj/FhlRoyAZ1cZmFblv0yG+HlI388SwOxo3GgCW
	Cw4PRGZpDpeTXt7hGCgqTAWaRhM6KNRBn0ZpGhpMBAsD22PcWrgf69XIuAOQ+catB+CrvTmQHi6
	BiezV4z4mcbDCXeFslu8h8M6j7TNnhJnyTg2lPQbTi0rLRuijx9KG75bzYSy8L9JXJ1kbPwLMTw
	qdKV08u7LZXOrYWf1kbd3zfbv4tmtIZlRebjhSd6bDEE4iV+6jw2HHhi2AwZ8nVR3Ln51tXWolw
	ene6W69IM1lR+i+LDsOMaokq+hutZ1A8FWs5qx5hTZ27fx1+9iOEI6SJAml+bAd82i0LSBNL1Bb
	BGaH2TL7ptl2lVA/OL2kutgX8bFN+Ba+6S93xhThpw5z5ZTdVdJuqcTE93OAI+9UY2KF6jCgRay
	wbXomXSuTt3cM3sFEBK4ix4JNA3VUkj+ZUOODXnNRvxnDM4vTm1Qa6xLnqP+QLrOZlXzGQHeJWh
	fIC/YoTNTixTh0jPKyKM=
X-Received: by 2002:a05:6830:3490:b0:822:ce5a:4ab with SMTP id 46e09a7af769-85ab9d504femr2871661a34.26.1793205952463;
        Wed, 28 Oct 2026 09:45:52 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 75/98] nvmet-tcp: hold the queue while the TLS timer is armed
Date: Wed, 28 Oct 2026 10:42:18 -0600
Message-ID: <20261028164415.1262013-76-axboe@kernel.dk>
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

nvmet_tcp_tls_handshake() hands the queue to tls_server_hello_psk() and
arms the timeout work afterwards. The reference it takes belongs to the
handshake and is dropped by nvmet_tcp_tls_handshake_done(). If the
handshake already ended by then, the callback found no timer to cancel,
and if it failed because the host closed the connection, the queue may
be gone as well. The timer is then armed in freed memory and fires
there. Anyone who can reach a TLS port can start a handshake and close
the connection, it just takes a quick tlshd.

Hold a second reference until the timer is armed, and arm it under
state_lock only if the handshake is still in progress. The callback
changes the state under that lock before it cancels the timer.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/tcp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 0b70d3647e28..908614fa82b0 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1955,6 +1955,8 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 		return -EINVAL;
 	}
 
+	/* One for the handshake, one to keep the queue until we are through */
+	kref_get(&queue->kref);
 	kref_get(&queue->kref);
 	pr_debug("queue %d: TLS ServerHello\n", queue->idx);
 	memset(&args, 0, sizeof(args));
@@ -1969,9 +1971,15 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
 		pr_err("failed to start TLS, err=%d\n", ret);
 	} else {
-		queue_delayed_work(nvmet_wq, &queue->tls_handshake_tmo_work,
-				   tls_handshake_timeout * HZ);
+		/* The handshake may be over, then nobody cancels the timer */
+		spin_lock_bh(&queue->state_lock);
+		if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE)
+			queue_delayed_work(nvmet_wq,
+					   &queue->tls_handshake_tmo_work,
+					   tls_handshake_timeout * HZ);
+		spin_unlock_bh(&queue->state_lock);
 	}
+	kref_put(&queue->kref, nvmet_tcp_release_queue);
 	return ret;
 }
 
-- 
2.56.0

