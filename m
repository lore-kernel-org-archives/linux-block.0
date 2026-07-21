Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A197646D56C
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655969; cv=none; b=HpjHMEBthhswZ8RBD0mXkaNkxKurCOX/P/NeYHJyBRSkPPtfxCaVJ0N+st9eC51IfXCXxVANsFOWjC7s8FT69thwsgKB0LbnG/zXVOQ3gh/aikyRZFfZF7UL1jrciv2gAOYSBOaYN3yqJs68nd28bJ9kpGrOVR/+mUgNhOQXSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655969; c=relaxed/simple;
	bh=hrTCMMr70YntHE8rHfpC3UJfjfd1U5mS3A9u7ATI3Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpyPvp238s+rSnGWNTO+RLJaztFoGhh3pdCAtE+NFXSuBcBsyfC74MiLvPsrglVel+zZduvkxgAAEazJzhDjVDeHEc1qxKl48VfYfY42K4EKm/4H5Pci0GFUQFTExGnzTSV7OgSVSNf8ZWnZE1/D4P+qWqqZudOXfSpdCkISgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=MnhgK+D0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="MnhgK+D0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso7667190f8f.3
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655966; x=1785260766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLcS/ETJPdW48ntvSy2VqAomcBgiATmYTCUKJMNlgIw=;
        b=MnhgK+D0jVt3+ATaByMqGtxcYbe71WAklsLkYbQhxrMZaCwgzYNT3aHKFTRkoVNwii
         fgMwGPTb6jPT5SBWRC4CmDhweLrQ+ncGrx27LpP8vn/ROytTD5noUlKp/4F8olifBqD9
         2Pl1nWmvOyjv96G8ddkLN1sumDxP06ApYiHy5alMfrN/hF/SdcsFRLxsN+qPNqB+5/mS
         6ffSR3qx2XZefTKfoLDbwgATTTPTeYZl/gP4rDxmc7vF/6QOdo6WcwutfQA637576wt0
         /z5DGIbaOVuFqSZMx9teep6Z363p8TYoW8xpugvIWBhRGFDCZARezjr2kSRc5vlKzMNH
         NldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655966; x=1785260766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GLcS/ETJPdW48ntvSy2VqAomcBgiATmYTCUKJMNlgIw=;
        b=QFVGkpCuo3xRV5NTla2v42mLRkYMv6XqrSm2QCdXORnlvPX1Y6y7fwfSiEDMODKRur
         KZOGJ+dujF5/gKj8xGZt0q6IYTcTVARnF1l+QSoxyk+8uTwtMtOkU53sjy03kcQO+4DG
         fN4T5CnkZDrNkc8Rg7Qw76bXKxLcpPiM2zeQ79j89E7M3Y0hkEAhZLDIAa4J5ZT6lf/J
         ZpQSQHg4dWXSbuL/M7nEOzUkhBDcvh1iIayC/6V2WCuXsjMpbSoZ76Uz/lQ4050Ago4k
         6wVViK1aP44bzTGQ0gZtE3gUZ/YqahB0GSfOjp0ihYrEuZcS8sX9zhAvrb9796+eo9u/
         oUgw==
X-Forwarded-Encrypted: i=1; AHgh+RoVWwXzmCiKN6v0D6GFJhFlBbvy4nuYOBYttUy84rbN6oyNizZgbnhatZ6pucOoWp/GW24zGWYROmeLgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGMJwfywCFzZW80RDaE2shYaYDT7xEJOByXRfYku9mhspVaOR
	HuqHQGzSK5y2dzLDEuzSW1gEMl/mwb7bsE6NSQNzeCeAh3IcAQHhHUdH/sLbFnG0yg==
X-Gm-Gg: AR+sD13UZCJdhuKTN2aa79FsrRp8eg6Vpeg6m27NH0c8UbpNg9ajSj6FCzoObAMBkUw
	+LEUJtHD7CgbH2Fp0nXbt21BheyBIxqNTeqjmnraj7rDPbmpzrl+x85Ry/yAcSWUic1j13zsX/e
	qcsZxqveoIjzrzsru81MAAqwDRwy2xeDPolTItqcp+dZ/B9KE5JeElIbsRw5uPStQNV2SzjMIYM
	yQ3H6Wyu4VbNNt45PIRp9bqXq1iwrw7OuvaPX9PflnIZ5MoWTf5u9Do5eAZYhOXOpGSzynhWZ2q
	bg9mt2020YUhcf2rD0o16Jfe4bpXksK8MvIeKdhE0fs1N7Y+9HAZUTL25x23k4Lhv92zq9IbFD5
	X+Ph+90bZtnFpVd1HV4vDQaTAiuPS6xhYIsoKZqLo28xp7fc9Tby1DOfqJxFk62mNMIxey9Wl+o
	I/wkadyiYR45VtU8QGnA6/qbwXn94XQ8Q7pbaagi704FN7V34=
X-Received: by 2002:a05:6000:27db:20b0:47f:4602:66e9 with SMTP id ffacd0b85a97d-47f6232e29dmr17004239f8f.40.1784655965889;
        Tue, 21 Jul 2026 10:46:05 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:05 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 3/8] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Tue, 21 Jul 2026 19:44:57 +0200
Message-ID: <20260721174502.111503-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A write that skips write-behind (full behind queue, a waiting
reader, failed behind-bio allocation) races the in-flight behind
write it overlaps: nothing orders the two on the write-mostly
member, and if the older behind data lands last the member keeps
stale data for sectors already acknowledged as rewritten.

Serialize on CollisionCheck, which marks exactly the rdevs owning a
serial tree: serialize_policy rdevs plus write-mostly members when
write-behind arms serialization -- the case the MD_SERIALIZE_POLICY
test misses.  remove_serial() under the same condition.  This also
avoids the old gate's latent NULL deref for rdevs hot-added under
serialize_policy (they never get a serial tree).

Fixes: d0d2d8ba0494 ("md/raid1: introduce wait_for_serialization")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afe2ca96ad8c..997f79c05db7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -564,7 +564,7 @@ static void raid1_end_write_request(struct bio *bio)
 				call_bio_endio(r1_bio);
 			}
 		}
-	} else if (test_bit(MD_SERIALIZE_POLICY, &rdev->mddev->flags))
+	} else if (test_bit(CollisionCheck, &rdev->flags))
 		remove_serial(rdev, lo, hi);
 	if (r1_bio->bios[mirror] == NULL)
 		rdev_dec_pending(rdev, conf->mddev);
@@ -1677,7 +1677,11 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 			mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
 					       &mddev->bio_set);
 
-			if (test_bit(MD_SERIALIZE_POLICY, &mddev->flags))
+			/*
+			 * CollisionCheck marks every rdev with a serial
+			 * tree; order against in-flight write-behind I/O.
+			 */
+			if (test_bit(CollisionCheck, &rdev->flags))
 				wait_for_serialization(rdev, r1_bio);
 		}
 
-- 
2.52.0

