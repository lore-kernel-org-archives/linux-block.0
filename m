Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716D46E01C
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655972; cv=none; b=TZu1yGvVrcxVQW03iPVTveU5Dfu/G7nX7P79oD9DfNE/T/UD49QeHZYuFMkBadABDLkiQXPPOlPs+qkd+9puOsZvEiBZicGs0jpYxtmEvvTmNlZxlFAnO83IZXNCV1nMHXfueL4bORxi/CscBHTqsetjIzW1v6tt0Rr3dQlOzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655972; c=relaxed/simple;
	bh=cD3SxDgYRV4P07YCyZ3D6dpRoOb3a5AG7H6z997kprs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcFr4jxmvv+ZEppJFT2MokXS92hZOEQMFljN1B5dSsK9oDRnOmjJ3t97ElwAchdacfxM42inuQ5KzezqLetvrpIlgJCY4o9lz4zEsvImDxDP/tgrfpb+pq92xLIfmqM6PxGnpAPyPl0TTKcV5h+DJs1gaVTxzgla1GJxJwbmK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=oUIFIvsB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="oUIFIvsB"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47de008b020so3951241f8f.1
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655968; x=1785260768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWf575YMSf1W7NtVvbE0zlmvwqtjFzi0s/WGa1kQOeI=;
        b=oUIFIvsBg3mo3dDAlk47n4w5O0Cc3AJoV0IGlW9f+z1B/kGJvyG4I1Hw/QZ/nXXX+J
         q2aKBdDgrtO83PofGhUhWOvDjbW4R+YOwoBc2m6Q00HU/SpzdYEhI6YXSFmhDUhJZq1R
         M81sjSglpEZAb0JgqlOhxVFbuUIBXFxLijbvsebJG064/AFroA80Beuzcf/IUzYYPywr
         RBE88+0gxMagu80LRIepOWdR9XNFVLs4RFEQmmTg2sOo+hZNkOnqpDrqCnvIzFsw/1OH
         Srns4yMDUT20apg9S8/QtMhSr2hXVCtkT6p07X62clOjHgznrh0X8w6x3bCc5unicf4w
         zwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655968; x=1785260768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWf575YMSf1W7NtVvbE0zlmvwqtjFzi0s/WGa1kQOeI=;
        b=SoS1KywP0YUlarStGXWU6/owyNbA4U91YSYqZonLHGuV11bl6F4dNObH8RxJtNt8u+
         cfiBTE5HqIt0KIolV5FTr+dbT0O7oUIAfmEEcd2onkmjtd/yk/x/LjrvbWGUJPVcdgAL
         4rfElbYAp8tqihsQO9zmJ2j0WBbd8OgiSadc+ioo6mv8lD0crqt6idagecCXSWT9WWSO
         TEArD9ZCULGvt3s4Ij4VHYDX+Y9XD40/9a070bYCTx0tRvxISqEuzvfrSeiZKitKyizf
         idacNXWYAxeN7VFWi2/YKJtbuPJ3n6pREjgbOJRD076dRYGt49kZKelOjQW5QoaSoIJw
         lSEw==
X-Forwarded-Encrypted: i=1; AHgh+Rrjd3gR5kutVt33z2+Jvqa/N+0pJZa4blneqrjcQ01mbd5bnPI9FTHc4BMLKLrrjAL76RTd9scMjTWEwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0C2bufa2vq5Qt/1Ojn0qn2VBrdraZ3JQrfX6VlFol5SXXedsj
	6W0XpIRpl0FKLrfyeRjx+IL3/gVXW5wj/wtFc2SYKo9bOd8p6PrbtsU48atbT8VDVQ==
X-Gm-Gg: AR+sD11is0rNgKEVdg0DElC4t/9G05M0qeLNX1PiGWk339OL+XwtVuBKSL8X8Bh2poM
	HFjOx7dgbVbuKm9eBBqVOR6iFw7bB/I8wxVXK/2fVa2XUhZXyJYbxbe9qUErEs1a5K/+FBhLsBM
	T5291eJ1w07Yi5kEbpieNWI1PclTPDsDrrLEvYk0cwfgu3YdUEvV+gICzw/cHeemc3N+6VRQ34J
	Iffefa+bkezuH2ZcfI0O2tY3s88td+OolGDVVMc+sD1wQEMpRub3gfSe3o5ckzZ7qYPm+fNanzv
	Xp7zG/+6yJ+0czOxByT5MWsnBRrj450/jFfBEF+nOW+uWMQV/l+eqhZeZsY1+Vp6Bbiau+GvWxN
	IpvYum//czpWkQS4Ba0BktO55ixMlprJNlk5rVmohi66r3bMkCFwUGf1GzXSCoOnA12V+lxurz8
	DpuGxIy4CyLwBEMqyIfHYqnPdKZDtxcS4NY8d7oO2+JqDTsnc=
X-Received: by 2002:a05:6000:2903:b0:47f:7864:1b7b with SMTP id ffacd0b85a97d-47f840c596amr727053f8f.24.1784655967970;
        Tue, 21 Jul 2026 10:46:07 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:07 -0700 (PDT)
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
Subject: [PATCH v3 4/8] md/raid1: don't use write-behind for P2PDMA bios
Date: Tue, 21 Jul 2026 19:44:58 +0200
Message-ID: <20260721174502.111503-5-mykola@meshstor.io>
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

alloc_behind_master_bio() copies the bio's data with bio_copy_data(),
a CPU copy. P2PDMA pages are peer device (BAR) memory; generic code
must not assume CPU load/store access to them is safe or fast on
every architecture, and bouncing peer memory through the CPU defeats
the point of a peer-to-peer transfer.

Skip write-behind for P2PDMA bios: they are written directly to all
members, including write-mostly ones.  Ordering against write-behind
I/O in flight to overlapping sectors is preserved: the non-behind
clone path serializes on CollisionCheck rdevs (see the preceding
fix), which covers these bios like any other write that bypasses
write-behind.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 997f79c05db7..7d769b6460ca 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1523,6 +1523,7 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 	bool write_behind = false;
 	bool nowait = bio->bi_opf & REQ_NOWAIT;
 	bool is_discard = op_is_discard(bio->bi_opf);
+	bool is_p2pdma = md_bio_is_p2pdma(bio);
 	sector_t sector = bio->bi_iter.bi_sector;
 
 	if (mddev_is_clustered(mddev) &&
@@ -1575,9 +1576,12 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 		/*
 		 * The write-behind io is only attempted on drives marked as
 		 * write-mostly, which means we could allocate write behind
-		 * bio later.
+		 * bio later. P2PDMA bios are excluded: write-behind copies
+		 * the data with bio_copy_data(), a CPU copy that cannot be
+		 * assumed safe or fast on P2PDMA (device BAR) pages.
 		 */
-		if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags))
+		if (!is_discard && !is_p2pdma && rdev &&
+		    test_bit(WriteMostly, &rdev->flags))
 			write_behind = true;
 
 		r1_bio->bios[i] = NULL;
-- 
2.52.0

