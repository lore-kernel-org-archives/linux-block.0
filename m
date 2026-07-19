Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BA393DF1
	for <linux-block@vger.kernel.org>; Sun, 19 Jul 2026 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458424; cv=none; b=AdkvFr9cEhzJ9PacbIe4qS0MfJ7w3YuPir8dA/I886z/zE83hVJBsYoQNITzQzH/+ssdpNWwEbs3l2dRjFk17flbGMBfk9SiNk7IDQ/N/36CINb1Gk1Wwx6rLOGbGUFC72nFocIIPPDIR5wUzgN+RXKFvTAMPqi65bBGJ+VqXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458424; c=relaxed/simple;
	bh=RcnkLcv6uBny2kPlRJHtExCJJhAqkz60vxDTP6tEfQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZy0AkaYqWokbKb8emJnJjz26RZwW4wEmYd44nZX2IwAvMjhKuUqQII0qEi2M/TYhG/YFJaaxio6W6nOQmFYECiWdqHb41RDGuz+K9QftnFpPUjJ4f+UYpW2KbxVUlYjhKdsecRpJSHLGTEaaJn/tQih/Yi5M9tZ2fvd7sClKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=iNZFLepK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="iNZFLepK"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so63970985e9.1
        for <linux-block@vger.kernel.org>; Sun, 19 Jul 2026 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784458420; x=1785063220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wPPSB8e7R/CQvh84euJ6RH38MKEu1i6y4HBVSmJRVhc=;
        b=iNZFLepKnvAsq0juCcoWumRJg8mGfwZKiSYkEY7iYKb6HCFI+nwlM5dMrkSlpulB/W
         lG4DA583q9wxQGR780qk7oGdD+KvYUdRboKpW6Bh+x9dyKTVNR9lov1mY7apNAo2opTa
         Bz66dKi82M69rfpSZiml14/h0kMsQ2Y+983O3HmgEdDpy7admSBKp8aIM/uwNvsKGD5B
         8FyRXqFVrl504DikToQC6qNLvkCQfnG5Ll3o5v+aUmTo4GCx3Z/1VMRFAEP3YijzyKOR
         aQEXsGmZ8RK2jmubHlPxzUUlCz5jNqih6jLB81iA+gmgGN00+dQrhfXP9y8gKxG90jQz
         b8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458420; x=1785063220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wPPSB8e7R/CQvh84euJ6RH38MKEu1i6y4HBVSmJRVhc=;
        b=rOPa6bEX9IMN7PmbSBmydkz8szn4xG2PrJLiExh0dh2uUnnXMOgHJ30Aqj9XJQT04j
         zoeVMDaxETf9g42Zwi55cfSldNoQEBvLeOFXvYgES74kHa6lBBirnExFFDfMnSmYN9P+
         aZFHsHvmfBwL3cemqZhtWqyEvax5wmjnQZC+9HFXvbrJb9zmtXrwc+3LB0SbM6rAuIqp
         vRCzPX9/kGxVYLM+Gh5HJfT+BgpjLcjZQ7WPZnbW1oOlFDsEiSvYuGXfDZXkF4DhPHad
         9qlDWbCh6WZ4ClvKnrT9AhaxcGl1EifZRvlH4lT3h1nHg5iyv0jcUMVp2qW3ldVxoVhN
         bguQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr+e3Dlhgy49ptOJyMWu1mn+hG91cB+nfT5J345M127Zza23c4Gj0rE+oMsjjKQgcGRRUcCN1l1zFxSeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Lmq0UJ1CSITAhZXewFnFhtLv2fy6suwsC7PWfRmhlCNnjAoI
	HDlYW0ObsTr7kYKeFk9L5mM0evSFu++Vkm/GrfwAKq4OQndTiKklhZMNss/XuUOGFw==
X-Gm-Gg: AfdE7cmeeakSDrvTHOWa4N8y2Qo9RrorBM7Sr6NG2ETqHJhwVwZmsQoLwLkDPQ4a5is
	gjz7Dwgj9GgT4szeKQ0/1rAoNtfYkJGSDXbp067+KwWrNkln5njHzM7W1gvEDiUmW5aO1p7CPiM
	StHqwjvB/tCFc7s2PvID3Ri56/29V4LvjIroAQhOiXz5adAK8MRawfdxz4KY9vlRu1+PueeCOlb
	B/fcVrr1ZL4UVLXpVPJBq0W1wJRe0qAJj8nBDViEPz0rYUf23PAQP9S7TjFBsdHk0YE6nEVV+Pr
	BxaIfxo6j9lSFq1d2vqomIuW6A3+I0X3sZZ7GU2rzhZ8fOan6S+9YZmNfGJESun+k9SNpcZCeP9
	9KWDDJgaYMMZ9kjIwIdrET6CGrLyMoFeGBoSA4maSl5YpXlSEuKwc+A3YNJBZkg==
X-Received: by 2002:a05:600c:b90:b0:493:c42c:7e87 with SMTP id 5b1f17b1804b1-4954a50885emr97913395e9.33.1784458419927;
        Sun, 19 Jul 2026 03:53:39 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm197679575e9.3.2026.07.19.03.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:39 -0700 (PDT)
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
Subject: [PATCH v2 3/7] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Sun, 19 Jul 2026 10:53:23 +0000
Message-ID: <20260719105327.864949-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719105327.864949-1-mykola@meshstor.io>
References: <20260719105327.864949-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A write-behind write is acknowledged to the caller while its copy to
the write-mostly member is still in flight.  wait_for_serialization()
exists to order later overlapping writes behind it, but the non-behind
clone path only takes it under serialize_policy.  A write to a
write-behind array skips the behind path whenever the behind queue is
full, a reader is waiting on behind completion, or the behind bio
allocation fails (raid1_start_write_behind()) -- and then races the
in-flight behind write on the write-mostly member without any
ordering: if the older behind data lands last, the member keeps stale
data for sectors whose newer write the caller has already seen
acknowledged.

Gate the non-behind serialization on CollisionCheck alone.  The flag
marks exactly the rdevs that own a serial tree: every rdev present
when serialize_policy is enabled, and write-mostly members when
write-behind arms serialization, which is the case the current test
misses.  Take the matching remove_serial() at completion under the
same condition.  Discards take the same non-behind path and are now
ordered as well.  For an rdev hot-added while serialize_policy is
already enabled, mddev_create_serial_pool() never builds a serial
tree, so the old MD_SERIALIZE_POLICY gate sent it into
wait_for_serialization() with rdev->serial == NULL -- a latent oops
that the per-rdev gate avoids by construction.  REQ_NOWAIT writes
can wait here when they overlap an in-flight behind write, as they
already do on the behind path and under serialize_policy.

Fixes: d0d2d8ba0494 ("md/raid1: introduce wait_for_serialization")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afe2ca96ad8c..8172df882f26 100644
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
@@ -1677,7 +1677,14 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 			mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
 					       &mddev->bio_set);
 
-			if (test_bit(MD_SERIALIZE_POLICY, &mddev->flags))
+			/*
+			 * Order against in-flight write-behind I/O: a
+			 * behind write is acked early, and an unordered
+			 * overwrite could land first, leaving its stale
+			 * data on the member last. CollisionCheck marks
+			 * every rdev that owns a serial tree.
+			 */
+			if (test_bit(CollisionCheck, &rdev->flags))
 				wait_for_serialization(rdev, r1_bio);
 		}
 
-- 
2.43.0

