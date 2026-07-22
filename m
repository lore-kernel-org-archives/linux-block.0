Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857638F957
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746752; cv=none; b=UX6Ij/zb67DxHguG//g8bU3BSWmS3bvkx53IndFnpSEPcqgwrdygO96vd0dy5gUUuotsy9LaPdsjVcbJRsFsqcY/JYVGDHSEg3j5GJjj9/d5EvwlzWtJ1slF2T2pSRYA2jhQykL4GAF3Z/eo8vV9BJyfS0nzrKXxAdo/yI46T3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746752; c=relaxed/simple;
	bh=hrTCMMr70YntHE8rHfpC3UJfjfd1U5mS3A9u7ATI3Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swPjZGkkkeGSOSUeJ6DmjuQh561jumhM/TiOzeL3/LZSIIoYmHUgT7keNjmmB3Mn0rTT7t5XzzEsUo2RzF3RY/uqoiCTS5eHyb70rSFrER987+4eDQBb9QuerugzU94pm12oSu/GccRGLJ0vCELuo+6Wyjof2leLJPWztChPNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=SCM4LtE0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="SCM4LtE0"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f75f7172so100317215e9.1
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746744; x=1785351544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLcS/ETJPdW48ntvSy2VqAomcBgiATmYTCUKJMNlgIw=;
        b=SCM4LtE0/HpN8EcuX55CGhXLzQF6CsoQYXwzal4P7HmkEvDIZZkJr5vC/kZovKCeL5
         PbzcFYqq0NevqxMdGWPlGgJNkm069JS2A0YXg+z/gRCj9mM8V8mTJ5g0OePRGhZahP2R
         WE1+kftU5H0VLSnCXfGtSkx5C5lJoWSsgahn9zwgXpEuuEgZuQwbsFRU9c/YuKlbGSmt
         ls30RVA7zLvvd4l2JiWbZKamN9xdgNZiryp5kbj9H5flxCjCwY1nLZRjB14Jy4PxFwTH
         wW+Mbb5hP/c+D2MkM3PGnESFAs905wfwpcYLmk/M1LL3WJLiy+rXXs9KPasSJz4m//Gf
         a2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746744; x=1785351544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GLcS/ETJPdW48ntvSy2VqAomcBgiATmYTCUKJMNlgIw=;
        b=h5WPSRrfCKz2CapgX08Xm82Ee9hiskTbPf0eJKcrpvpsIl8QDJEq0UNMAtcMD2BE5Z
         xsO2bPTnxJNicX1/b/jBgxEchApR+1W1etpR0fFdhXq+wtEQlGQYirePKuYO3qp/aS2e
         DhMnsKR+cSrrHMpm4pPlj56uvJyfarve55QfzFNo/Ogdf+inTx1sTAAXBCuUEkwhdcEj
         i1fFqWPhp3qiaWN1iow8hvXwNUHBBCg0NsaP+Z59f5KnTi+LSupYmcx1XhqeMgmEes2P
         Yf1ndmCsWzr5sgHP+dtbacvjtX50CZw1oLjWLSmSAx4h59Hi2TpKIMWhs5/tcxpEi7zZ
         VSUg==
X-Forwarded-Encrypted: i=1; AHgh+RodkKkcaFDgKeh3SUgmIwT9qpkx7gkQWMHnnJC5muL4D/oJWBT4fuxP5C7QAzZyVN4gL2hypaPC7VAIcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVS+p2B3zha/sPHuU2vSQw3eUegA/UoeH7zyYuneJWgv2O48Wz
	QcT71t33w62lrmd6jIHXo+mYqZWZPt7yfniyUyeuKJsJp+oRQsAmBZsqYQdgZZXriA==
X-Gm-Gg: AR+sD12MwkOACGHZTV9qxWUB9+/+VwiaVLqFXEdZh/rTrzlQz3ZyBj+pE9eA0Lc9zEK
	PYsWn/8OJFLuMT4LxHzyepiAclcR4qmi5Y/IlHOyO3J+xgxBH+mZTTuZ8qwTKjWBUB/bTt9XDhH
	1wxzAmqSbxycl9G1JFiCKR3G6CGqnAU8CtBR5Ysjt4AwVKYyB0OpaZz5BL5uJA3Rr0hw7wrGu16
	lxYhvplzFmopdcqv1/llo+otbSQLKXirLyoek3aW+Fp0UTrP5nHIaXKY33WiLHK0tsq/Y0FC4bj
	QVRGdXKV5Lmx9cRmePdd2fN/Vrphs8moY6tcaHSE71Pk4BysyjjGW8lflrIQMY774PWf2w4lo0R
	4eFCbhQbfAtEzF0L5EVZZW3DQ1sKhLbw2Boq0PdPx0fLaTliPdTAFww6xglT8XRBM+qXuRf1FOq
	thbb5+sQ2RwfHqEjV7aELraHWyTff8OfSynpOgoNuJXpcf0e4=
X-Received: by 2002:a05:600c:c84:b0:495:4811:d71c with SMTP id 5b1f17b1804b1-4954a3ed4bamr271393965e9.13.1784746744468;
        Wed, 22 Jul 2026 11:59:04 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:03 -0700 (PDT)
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
Subject: [PATCH v4 3/9] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Wed, 22 Jul 2026 20:58:35 +0200
Message-ID: <20260722185841.449934-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
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

