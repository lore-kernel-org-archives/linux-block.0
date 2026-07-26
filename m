Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E03A382B
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065565; cv=none; b=rJxJ4d2Ij6TkK2/Iu7Ua3j8qIULdoA24sADyv+8Ctgp8371ElINZnQmUmg0ElrZfntzb4RH80IyxGyKzlka//hHqC89nGBGJgoFixH3eGjvZ1IGDg2OBxk2q7OrG1pRHILAX5lbMV/UGDG30wMvCc1YF8YsdIGAac5picnDp+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065565; c=relaxed/simple;
	bh=rD6vL7WJH3OCucOsC8HBYYohWiKi/wQIj/76rbm0B/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT/AU2r0e7qBRroAAFBc324ZJTHHYOOswkdPJsg/C0EWBpOmRMcqdZGhioITtl5fMJHinaczU0E+gqRFMes+1f05+vZWJz33/8bmGvCZXTIu5JNfLXqgSMpRHp54eKMfu7AaL5Klnyocl2hoCgzhB0EvmYHKcKZP7orF2Pq5LOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=JEGOOfiK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="JEGOOfiK"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47db714766aso1443015f8f.0
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065562; x=1785670362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kpThYo2099okC/dCttBWDQwlmrc8IkfHjxPNABRRgtI=;
        b=JEGOOfiKjmdRgAn/rz27wkOqzxNLw/FYo9ETNFROQ2DvbC8peSFlKJWSB20Eso/uLc
         EKrR9KZFOaq64Lc+r2cuA7A+Ke0YhqsmZSwGkVwPNiUmYYz55E8WriTu7oh5C8Ilk9uB
         sNWafa6j1Qbvb1J7N97cyLpDirgi8g0si/PXNkdqQ6mD1x5FejTxdbgOxQgB3JqkL507
         mYBJ5PJnJj90slXI1sbIymIWfbTypjTcIcPc0KcXScp/rgzfYpw7+Oun6TN5l8xmNF1z
         GSzMEOdu817Y3lHj9KiZQRXOxhoKW9rJ24qdiSCD2C9SmToP0d/hHofpIvZGzH2TRA6x
         75rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065562; x=1785670362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kpThYo2099okC/dCttBWDQwlmrc8IkfHjxPNABRRgtI=;
        b=Fu831gPBfv96SW4iO7flpNgRTMgOeT6RNcfZitZkHBhZVuT/Y4aTkykgNuknBB2+lU
         PnVpH6YBQrjJ0Uc/ciniQRbDemGkorFOn0T/oF9lCifUfggOsjZjsgtVrQCoNtqOBixK
         BPBtQVHzmoaoh6fX/RMnzY0VwrTVZx6dAnJmGcCC+9ppHI5LaxR0vG15MVo4S00kHrm0
         mLzMZKbfFDJVhxAAPuJN/m6ZVdCpFLF1d2QM/31nqVmnBYmi6fCOGRg1UVd0ayb1nxk0
         VIHbSYNpYy8F1Dvv0Vxy5Otf9mSvg6qEmkc065uSk3hN5Ok1YULzqOVWVatkwXB8LwS6
         EIxg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0PeMdGZS8Hr1+LVwghunnV2QGtHi4WQ1m/yAAUaLD90myxWip8Hp7vlFmQvoj1EkFn2rnuRXR+sgB4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMpTbiBR41rii8ZwNoswoM/QCSrYVs+JTncmegGtNvSPU2W7W
	hnyqM4uFs6Rh/mPVrWmIVj5oxd01vV62hYLmYciO9hcYdI/GTDFnDbcxMlTcSj1cWw==
X-Gm-Gg: AR+sD10voeAJh4P8jRJYqwdNmBWPlYqGp3ouK7jd62po/JQy223MMKRu0QlAOKg6KyT
	b1zbQxQAG3PrHZyuihzYLouTjFGBtK755leWaEp9UInABMzBiqf6UZkVypvgxlWcIMYN1Yh4Q2j
	6Kalr5UmsARapBm/MU8l8988tAiFUvPD7IscBv8gZ1KqicF4yporsAmu5FlrgMUJtDvGhcOGmbL
	UJsiFmMucpm11p2PFwgE+IgMm+nT9NY9Ms40qB3JAQU6v08jo7rImbHXxv+ngECs6KZOJ1+WsXM
	iWmIbxboEEPl6Dpfl22nkZ4pRE83ipMdPi6Ju90X+tSbxoxQDH9yPU/2G4ANxcf01TV4xJrHLHo
	kXskIAX/brs5dauxINqrgYtPVtFyB1jcNAbgyluIuE/JE/Z/14luOybcb9hplqClJTfnUURNQGb
	xClogWIAG+X+dz0cA1g2CAQed7xA5T9AP8hoJGwlqEehRTVjYsVCpYSqSsET1ebcDO8e/LcLYvo
	wy6hm5W28q0eHVAcR6dZiB0ZrCObyZZoGIRCmOLjA==
X-Received: by 2002:a05:6000:2088:b0:47f:91e6:3729 with SMTP id ffacd0b85a97d-47f9cf160b0mr9458165f8f.24.1785065561564;
        Sun, 26 Jul 2026 04:32:41 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:41 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 03/12] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Sun, 26 Jul 2026 13:32:20 +0200
Message-ID: <20260726113229.2154269-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
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
test misses.  remove_serial() under the same condition.

An rdev hot-added under serialize_policy gets no serial tree at all,
because mddev_create_serial_pool() skips one that is not write-behind
eligible: the old gate dereferences NULL there, this one skips
serialization instead.  Martin Wilck's fix repairs that case at the
source, after which CollisionCheck is a strict superset of
MD_SERIALIZE_POLICY.

Link: https://lore.kernel.org/linux-raid/20260723112741.1206836-1-mwilck@suse.com/
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

