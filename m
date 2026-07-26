Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA733A6B6A
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065567; cv=none; b=MnGVR5xnQ5MKX41qiiNeKx4TlwcaT1iqvSMEaOBjEvWsxZKhUVE3xhgbGe9wfKxOII2cZAXh1B7JJFMqbWq/WHutlhWXThb5Bg57mnO8zdHewD94Bf6/3gBnhosXXEBzx/TVWNllHY0RQu0KKH0H/ATC9nCqhO+1aSWQw48sHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065567; c=relaxed/simple;
	bh=tb87IS5YwxWP0/pdiRmCvUCzVsNHu9wl18O2iixHy6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Txlnth7wSjCdv7Z6IQDEKeRwE2oLookQ81J2bC+K8TwA0fLv54PAedqTwC/qcf5GR14EyA4t9PKwRm76V1DXeFGlGo5uN1+QgOwTOUGhV+g8FcqKcSC2J9VwpfN6P6XnmfjkJTcSb/qAR6rljmY5ylDvFsYwkP2PR2Sv/pTwJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=TpwcYxJe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="TpwcYxJe"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso891456f8f.3
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065564; x=1785670364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=TpwcYxJesQJVNdh6uV4Kf05tdGbQJynu4uVnOM3oe8LfYWTjTXJqOYc8pEsAnzBk0l
         ofaSF2MIyiQh5duF8J2woPOMeof9YRL0KVhVosfa/Jq28u+dQdDykuAN9cKIo1/wahDQ
         uvlWNuJAo9frPMUOJE7lLgPMvO2YygsXROJxY66bSBKk9RVSbN7tEqRp+Jy0JbWQl69c
         +C0yXSwQ26ROF1YuvMG1EOkFvz8alOfnJLIuwyLYFNYrEqbedHNm4DtjoTWrVem+528e
         4/S0QRhv55lv2WqaeqSyonkIFPvWTAqgvW+w3R9CqWe2bksynNvNv5krBgydt0IgYdOZ
         NZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065564; x=1785670364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=IgGPU6OqXv057h4+JpI8su7OWfWS+KHGCNAKCdiq/Ztv/26Ngo8AFoIpV52kR26AM0
         /PowGIyHVX8ZzLPxmq9cKrb+AjIBRWDQ7mxLfOj14Uaw8FRh4QBib+Vsp61E/qAWJWBb
         fM1wlhOFmBNzaIHquwQ03+EtlCZ1hXOvFX7hmdzd511/2RSe8WVFhDZhhwbFtbuf1R+G
         OoZLF7wQlcr0W6qTIWYSejHINBAEwLSp1YVW9Zv8x/mYyQXLox/WMf0MNOdeVwFZfa/s
         Xgq1NZwl3b/qZuz0DqvfDy2khip/df3eP872z0PYBoBvuuAPxKa39c83hr3tgRaLNSvK
         TmmA==
X-Forwarded-Encrypted: i=1; AHgh+RqpzRGfnixg66Z9/ivqPyeaQ+2FN9v3OS0zd3uwxASvk7yyons5RB6anVphC0JhG4D5nvJMED6A8S20WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzajQvisSXJNckpkb5tLFWbgy37n+ZdV7P2z0ucYHRH6SS/yGzC
	Hdg7d1KIKbtE04NEHuLSG8So/lLXVO92xBdVBWWKDbCTG5Hf+6tAw6wyy/ViBi4ApA==
X-Gm-Gg: AR+sD12tseEaPXrUbrRQVos9OvXzMD1Xa3IEaOsxnc0MM+OufV7Wo6I+iuloEsq98Bk
	qKaPhlZfpHb1Ge6s6Z1gomx5QefKi3sHvKjEksAMs+5L7QiOB9JC3uabNnpEFaql4nCdzPnqgfw
	p5wjVmteZH6pIlGc9trDYc2YBUTbOR4yIv5mIy78Ygmwu1rZ6lsKO9m5HE/OwiZGtyTmtRU+hoT
	pgKXck5joTt4QCdOp5gcdMmCixRiTU+YK4xC5be2OM6yPACIQP7jLfaLD0PGoMs2wUBoLwwbLYn
	SkUgu1bSzY6t3I5lmcStXfd8Qi05+5b31A/X8UNJqToqtBs1hpn3HUyhbfQ6NbanGm6KxinWkBr
	WKn/o6KvVqIx3RlXnETFSuHzxAi08cnzaLYHZUVPnRJgvTw4vWoR793e1KsNFB4yDuLyonSRj5y
	v1SItUJ0HMNCWTyiPF6BQAcIAGJkeGr0QMoyzrIwvhkN7NvPlTuRK/Er7+9RYRvp303LHwsZQBp
	o5d+HZ1ZHusW3RkQ+GvfxNWtxrgZLHNW8mFv0udBQ==
X-Received: by 2002:a05:6000:40cf:b0:47f:77dc:b072 with SMTP id ffacd0b85a97d-47f9fc8fc9fmr7735691f8f.18.1785065563917;
        Sun, 26 Jul 2026 04:32:43 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:43 -0700 (PDT)
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
Subject: [PATCH v6 04/12] md/raid1: don't use write-behind for P2PDMA bios
Date: Sun, 26 Jul 2026 13:32:21 +0200
Message-ID: <20260726113229.2154269-5-mykola@meshstor.io>
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

