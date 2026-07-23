Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981C466B11
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839388; cv=none; b=t+vms/2wgBBDbLuRWPAAPq1nVMmM5iiobW9ahP00WIvMHnqOQ6I7gyI1/xXfoyN4t8FQ5V6Cj041S3E3+CTCFBIHF0JjLGGg5+LSq5S+k0WW2KXqAWwwdjlIiR1sSVucB5K/77Gq2sijmKn/CGQeqtwNomj6EUxAspNa/Pm7j94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839388; c=relaxed/simple;
	bh=IeQBFCH3bM4bVxRkUROK9805WYYXPr2VLMisCc8LPq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/kyaXHuee81ZP728OzKjdWkgTv3vNxTHZGBp7krzZgLg6Kcj9gNxJIEORrafO0I7rWvGjYmIrsG2cdNaWiYe97/x/r9xWspKFZLWvjJBj33H9B1tDIlX4MkKroNk4NZujovQbC2coTDYr+5GnMkaIn3QlKPVcbIEAjlP+IXGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=mF1+onUo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="mF1+onUo"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4720f3bf164so588735f8f.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839380; x=1785444180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xY1kaJm76bL7mULPuQYN6MgHSE4hk4KEujLtUR/lx4I=;
        b=mF1+onUoH8g5krZlDyx9lcBqRTRrF8paWBw3zaSjWmlVE6WvKJ0hEWSwfUYbccpbQ1
         t9YUnOrozr0YB0sILt9Ctur/Nz1zQ/+OXnwO4Yateq4zcnMQslQTbkXRAru/PCvt6s0v
         oJii8kk5FyPuMEupv9MF29Mgc1Y5C6bhNWmwe7p0TOW3xEArB6PLHLZqPweAU+ntzo1B
         ktrg4VEg0Gh8PWx+hQQgfsVKYPv7TvjDzrQV917gexA2Xy6m7/K6teAHHecYcbfbwQil
         nTYInJ/HyX7DpgOhTOvw6luyy1O0Q+pApnsCG6gVUm6a/fJMfcX/7HCemMP8nZ376T66
         QUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839380; x=1785444180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xY1kaJm76bL7mULPuQYN6MgHSE4hk4KEujLtUR/lx4I=;
        b=WOX2A5jOXl6uZQiKVM5N/NjXwk+ASJqXh/ewTLAn1vI1/Zou+gGJU2PvIb2sfLCe6T
         RrqG6SYinHxrNRwxO+Zu2JFMYISPK4EfEL1iE+QlabF34qFCOcsJAELefPInN33uW2Yf
         pZByntPAYbyYb96E2frk/5/l0eAREu+d17Va7WtOF1AskDA9d5a3p3d4cQof3wC88qTJ
         8audR5qGwiATv2escfSHMwcaUT6Oa7N8icAmEQgd0VGrr5AUnIdxyUIALn+HmmvN8h2j
         AS9EgG9CQH2sjDMDlOqm4cN57CEnvmko2fOFIPpAkJQw6TL4o3Jf11rotCEcPOTcJrBK
         aUDQ==
X-Forwarded-Encrypted: i=1; AHgh+RrS73Uk7LQvN2WOMfoyAkXlcpyXzHWREHuJ3Q5JRJxOQKFDMWQMQHB+47Qhuwt9+j1j0E3pggbo2BlaPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydL7DSty9yZwaKP9CcQMu5FR/QqmFlUwHtfAxeg5xCJhZ9474U
	2K6G1u4laoyEbLgzUkDB6cEc9FhCtXLSvLzP5dM8peG4cHYq2rC9srkO93w43KF6Sg==
X-Gm-Gg: AR+sD11TyGU2jJuWXI3l2qVtEHLiK97yvNn2hOL6W7QxXibL2LKOWTIH9WmhCcxDMvY
	a/PAeyVvYzGzsfl4yfZPrb7jBgpJ7O1+JwtI2IeykIobYh24Hkzl+ueMkXnHhtBPVgFuxvmWESJ
	Qhi/HNVwVwW3S3xQKmu4b9VX1yLM5QSD07B1kmstrEUwWc4gp9PGxsCDH9PX00aJ20NqNzkzDWN
	9lLB/qZ7SnW5V1BJscHB6pTBrtlujFUGm7/Yh7FWukvwGvlqR8d2CyzX4STHhTN3J5AErEoE7vh
	7ufPB6wwgz62oHMemSrh6z8YOLITbPXCLkwV9Y/kSKzD8/+UTg1UN3QJIQEZOYfbD5rQEIiu+jD
	+T6Pm05SfjLvvLJ3W9/Oe8cMdRqMZvSxS305V82JRIOR++1wJAP7lTrEqOxsyi5nzsZJ4XCHqAc
	hS+ZoF9cCOgAf2LXqQUFXHChGJjDossWmX+aZyR3WGepBZvwt1sg2X+/1mMor1pUKuRZwy+KQ0/
	FAZ6kvuN2FZjGSF2G2o6mldP5RD0qgMK33GkZI1cg==
X-Received: by 2002:a05:6000:2309:b0:47f:9208:9e4 with SMTP id ffacd0b85a97d-47f92080a4cmr4670984f8f.31.1784839379605;
        Thu, 23 Jul 2026 13:42:59 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:42:59 -0700 (PDT)
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
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 03/10] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Thu, 23 Jul 2026 22:41:59 +0200
Message-ID: <20260723204206.76930-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
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

Fixes: 69df9cfc7042 ("raid1: serialize the overlap write")
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

