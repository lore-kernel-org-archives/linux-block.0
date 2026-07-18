Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE81E2834
	for <linux-block@vger.kernel.org>; Sat, 18 Jul 2026 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784391984; cv=none; b=qFrGyzxwZjuVkLP7tcYsVEI9LiHtJQG/NOmroKEz3LoIIXBaqh7MGDCyChE9eZr93ShzS5oGkzkxlpNC9Qq3c7V+9RTGyMxEBMJYEAFVTt1qUtYAWJzIbmb6zdT0xKJmOoRzf5cAHfOPYXNYpuKl6K5UcOpPibaV3ff24YX2210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784391984; c=relaxed/simple;
	bh=SmuOn8Uxw8XZnxg47IbvGapBEh1SrF66f7V9e1FGwgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed403ICaNepkQ682CaNoIMuJoxRpRMC5EjtDGOavrbK2kHa1HefvLglEnocGmh3+i6LkivwDuPRKuA+9QAoo52CEQ7vUpempdhPecvedObpUK9b5SS4XQHkNozVTqEtu8FhOCGlaSaCFJN+tw9asdF8HXZMeDdHSjz3G/pbwi74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=QAcSNHXR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="QAcSNHXR"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso1251575e9.2
        for <linux-block@vger.kernel.org>; Sat, 18 Jul 2026 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784391981; x=1784996781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=95R+xIP/87RyRb0dz+s7R+IaY6bqD6sOy0TrsJCA7Fk=;
        b=QAcSNHXR7WJ8lkEc1DCyHf8bkHY2j6tNo2m/A1JddgbVd55sspZVEr/ZvfDHZZHaTJ
         dvhFfMWHO8cLD/Qr++X44q4PoP5dAE0nuovSogtsp1HNJp1fgaC4xMUWgS2uu3+hcIZR
         9G1GqBdTCT1Qh/iit0Q2yoTLqBJuzinVb+Qa27A4HH9Pw5qJh4Wk8uGppINWvReA0xa3
         M6B+nQEsu7u1uHpgw2223OCsHGKHQ90lQto6gvxxEAZ1I1vFelss9cy2KEYsg10SPEgB
         uy8PbEwJ1e5SdKdqzQgS6uxgP7A1pyPnxbeQwSCMorxdVrNgB5HygORPPahjkrRw4DAQ
         PB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784391981; x=1784996781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=95R+xIP/87RyRb0dz+s7R+IaY6bqD6sOy0TrsJCA7Fk=;
        b=CrDDqajNtxGFTKL1ZwNsm7Uc8tfPEzp3B8Nyf+MUh1S8DzN5jS1ZG7wcr3wRXKMuIt
         Itq55l26RfNlYdl4GmNwB7XJDla5Rzc2Y3h+kyOCRplW0W5JvBRY4RUWDsEj4sHF0YRx
         0EdWtW5rjUTl/6IB9Xm8u6Rz0MnrikBNBfsEFRiWdWlutjE8aPzOKd8qTVojpQpFg51x
         v1IFKKV5khAhRTO+s37JsZjZE4coOmnp1TZ068NMlNDp72/5TH2xzTN2Kk7mb0j0N/7J
         HJvl2QozUeLvo9Evtf7SEfDpSi3zeZyTKcM+GZ8aDlIEK83zDL8Tueskjw/NI0nymOe3
         +8Tw==
X-Forwarded-Encrypted: i=1; AHgh+RoWdHixa6TvbD7/Xlt1lLIpFwtsf0eabHAqayxH90Oa1+uM9Qn9oKPOn7iykscxCyEQM5XV0xbK+O3LXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDU/+U3qdNbjPKyq1qGOeOWJH6RVnnXJnrBLwOnaQoJm4oLO94
	bRZxTHToVmmhEfLqDZyyIDKQgZ8/AI+BwSTlgU+ydgHOvUOZR8o/Ws3u5QmUUZoNAQ==
X-Gm-Gg: AfdE7clAalqSNVNAL50kPRQW9dLvpe1ZQyhqElPPYp8U6JoPl5eDd4Dy+4uzpai0IOr
	yqUd9/enPM5JsYb+g3UFqDKIf9y/5ya7VRfnRALkn5pk1fmAtKEwmnCAATjX/hJ4E0z6xebc065
	B5Oi3TstGnBmJ/hqQrvA5WfQbe7YX8paCiK1WymuuQkP5+k3VhpSbPxc3QGrwnZyzfdmlWex2Wp
	etLyD9aVLpfiJT096nGSxPOR0pZV3kCs/jQQIk+LvGxH1TNepyoqiaktK4LqvEVDiMoGu1Ez4a0
	nrK3FcsD82TETbOOzJw0MXXth5Fb44Pp8OmxTtdpM+OkITg7JlFKncSH3Pu/kEy9bN/CvO6ZwaH
	hYbsyHEZM6OPBxH5WAZDIHuXo2zAlwuu0YeHntcVrV9LDec4RIhnLVS/aUyxlTg==
X-Received: by 2002:a7b:c054:0:b0:495:401d:9f4f with SMTP id 5b1f17b1804b1-4954a40513fmr53645805e9.25.1784391980997;
        Sat, 18 Jul 2026 09:26:20 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm266444085e9.14.2026.07.18.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:26:20 -0700 (PDT)
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
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: [PATCH 3/6] md/raid1: don't use write-behind for P2PDMA bios
Date: Sat, 18 Jul 2026 16:25:44 +0000
Message-ID: <20260718162547.448892-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718162547.448892-1-mykola@meshstor.io>
References: <20260718162547.448892-1-mykola@meshstor.io>
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
members, including write-mostly ones.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afe2ca96ad8c..57f64e890102 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1575,9 +1575,12 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 		/*
 		 * The write-behind io is only attempted on drives marked as
 		 * write-mostly, which means we could allocate write behind
-		 * bio later.
+		 * bio later. P2PDMA bios are excluded: write-behind copies
+		 * the data with bio_copy_data(), a CPU copy that cannot be
+		 * assumed safe or fast on P2PDMA (device BAR) pages.
 		 */
-		if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags))
+		if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags) &&
+		    !md_bio_is_p2pdma(bio))
 			write_behind = true;
 
 		r1_bio->bios[i] = NULL;
-- 
2.43.0

