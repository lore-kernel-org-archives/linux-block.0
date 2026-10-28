Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205917;
	b=USadQ1z1kwyaiju8u155urf7gdk+sHVATtXMiOI589Mo+7f3xdWmCsydohIuSvwofshD
	 xnXJo7hq4jR0h9D0yayuES5Cav2Qafa/3ZM9U5Lb9PB9D4f8j+nPLP2lIWCyyuLNMNzsK
	 njenyy1M+KB0BFKCh4fl4q7vkxmqYCTmI8Ov9J6WqVuHaO2IYL5WOnkPuPxE1jr2RNHCo
	 OdY1iMaEP50MTvWEbLB8QeLi+9DoungV/lECeHZ+HCm6YVFE2b+kutTYz2TpPi/9q0WDJ
	 dWaAb4qmZ9FOcc8OIl6FRAk1MAK9DzQe+f4BsI8f24PWJgNHFpTRuOm3cV11n6H+a0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ttwidjYGnCaoluECf2/+zg6rUR17fZ+FXhhQFZROSe8=;
	b=rBmm23Mt5Bdlnhi27eBT3CLT1GpIHxbmb2qYL7x4wHNKSu7RNkaoYyZ/YNx5L7NkSmHb
	 DzJzK03YjHqezVU1xxSVEhDL+bHZ6YoUCbiNIMxt0I4ZYn6RO39RLPTXDQiGZiyNWG4N1
	 YK1RPDIA9uP5OzpJnHQkSA9UKHtL3CCOKJcgyRJ4ywmTlGP6j6UzYPKLA9BPG2YyTrSpv
	 KDHluUxRpMMZ5lO5vLZ9mukx8kKdHenA8oQ1LNp9PV9BZF0ApwYEAVwh1Mzco7bg4vemK
	 5d3AofhqTy/3zdHytknj0sgEHT77XPOg9UWtOqF5K007OdbXbJNRhekVhEYEvnPQVxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="Kj+AI/dO";
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2506606A326
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2506606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Kj+AI/dO
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-854b6e2e41fso591871a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205915; x=1793810715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ttwidjYGnCaoluECf2/+zg6rUR17fZ+FXhhQFZROSe8=;
        b=Kj+AI/dOg7BCBHLKpn1OK/dF87O4kWJlbQ2WZ4k2X47GfPmpxZitPx00ywz8ndx4qe
         CcVE+lGnCp1ghVJfg7bxPW6f4QWcwL/tysbitLXWUpRzGNEew31R/6PRTv4E0C5cXMos
         m1HGo512/paOxjtEkg36PMz38FJG5xwpy3GLF1qwGa785dS0rmG68ImAteAxyo7MRzKy
         9ULXHMnOf26RWcT/Lny/EAyD1ExzGV5sA8GkT/kXVYqbRxZuvs7gxn8UK6HPTrBZ6KbM
         6/Sxr8CoeTxOeEmETzKrrDzJybyCsL3hNU7EGUcrGk+r88BEeIxNZ96Rs3YTjfYn0Qze
         m41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205915; x=1793810715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ttwidjYGnCaoluECf2/+zg6rUR17fZ+FXhhQFZROSe8=;
        b=BZiWUa2nIw1yyzfFMryJBEyJKrkz7cs5remAU+UstnP/9b2iZ/bGP3oX9NT/2o/l2g
         zo4c2EgVtpqY1KIS/2Ixl7eQZRnd2J8QHlOnv+xemPZhOr8UlLbVwvIGk7I5fBIeRhm4
         zV83rQ+2jRo5maVxKNFi0N2xhiYER5y3ava77Xd+nCTuTQ1zQTkl+qOWpYEacbpq/lIu
         S/Q8z9vS/WbJnW0C8NR1B8qx8ksf8qFK9asndufdv+gjbbW4GV3Ndi5Bb9R+px7oQ2pc
         IW2W29INcSVrS+1DjHPTm76ovHT8lT4Debni8cfY00O7fErSXITSAg3uGuZnUups/TyZ
         iH2A==
X-Gm-Message-State: AFq9FYJ1XOs5fZS/VbTxMTeBd0JOSKVVzBRhpjj2dp1E1RQZXZ1uLFDU
	pUq7JRTBFkO3KaeCJuDO6hK7KtArTs8WCWC7s6a9IB9Qe5UO+agr5ioDQBzwjlpz6SeKdfjtQM5
	ei9Hzrno=
X-Gm-Gg: AYBFou38lB6YXc4HN/3GCShjPI7QIbU4ULoUgK2OS32PQMSERNfte4W6iWcTjLVqoxU
	Pp0nphn/YrU3rnnD5knzL/26Ru6k3bFX+CFcMcpAphAvg7emBDd6UgbLUUZQH27oC88lri8VYbz
	k06jAc8PzER5eSKy9lTqrPTdYuzlULXrFf9INC/UQ9ve4xFJt41WPocofVNzx4hs/KES4yhpOgh
	sWPFtCvBP4LiC0xIuzR0g1p8EtOJ8FYaTdkTuunTebGK+H3yJthRDWkyX7VGfkRyk6bawSRSrPV
	mGGed4d3oE/3Hpynm2b7TPChAHHO9aJvx7H9fR9Xyg49MTu4qUv4PhtKapP/1iidIPOywmx40Cv
	nZ29XHIcmRmt1VIxu1dy/BXLe6eUS7swqxblCoG0sV4yxBYiSJ+PuibKBHKuymcZ5ixQP6wbMK6
	PxqL7meuEDM57E9drtFhFsUvtKvrmueFBhPq3q5+cu/nWcjtsh1cMRwukqAhdxS8SQRXaDy0PjN
	mINhhhI7sTdEMhNYEAhP0oQ519mIr7eWPm8cMPnuWSJTIdr04fZyRvQthV6dIqK8CRVU1JCLK4X
	Zw7jbnjmJIycUtH9dxnl9/8qbl4xAzUEvyTL6AsDiQsl8dMHFPLjQYNBpWdOx1o6kqrrxF/3rQ=
	=
X-Received: by 2002:a05:6830:230f:b0:814:57a9:4243 with SMTP id 46e09a7af769-85abdb098e0mr2587910a34.17.1793205915637;
        Wed, 28 Oct 2026 09:45:15 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 47/98] nvme: refuse metadata sizes above 255 bytes
Date: Wed, 28 Oct 2026 10:41:50 -0600
Message-ID: <20261028164415.1262013-48-axboe@kernel.dk>
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

The metadata size of an LBA format is a 16-bit field, but
blk_integrity->metadata_size is an unsigned char. nvme_init_integrity()
truncates: a 264-byte format tells the block layer 8, so the integrity
buffer is 8 bytes per block while the controller transfers 264, and a
read overflows it. 256 bytes becomes 0 and every request fails in
nvme_setup_rw().

Treat such a format like the other unsupported ones: capacity 0,
passthrough only.

Fixes: a48f041d91bf ("block: Reduce the size of struct blk_integrity")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af71d02b8476..69d3ba98d50b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1867,6 +1867,10 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	    !(head->features & NVME_NS_METADATA_SUPPORTED))
 		return nvme_ns_has_pi(head);
 
+	/* struct blk_integrity has eight bits for the metadata size. */
+	if (head->ms > U8_MAX)
+		return false;
+
 	switch (head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
 		switch (head->guard_type) {
-- 
2.56.0

