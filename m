Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE739524E
	for <linux-block@vger.kernel.org>; Sun, 19 Jul 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458429; cv=none; b=eG6/8vHS6ztKrY65qyDwXjDOXNRFl0pywmQ+Tk+gCpFRk6IavI/Z+slvZt+8PJM90r+RFU/iG8gn49PvdZ17/GcVzBmILr6dgy53tcyuWi+HBDnhFj9uMg62c0wa7rKlgD2GtvhBeBO+2NyGhTD3Up+RTMqV6XnwWkmIEoFmoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458429; c=relaxed/simple;
	bh=ckOwh+/KVDM4Fp986EbTgYg+bPUMzv5VlFWjz/PbPJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cObero6HFz7Pp/Ook6TziptvortZbrC56jyJWtczl8soRR8kGy45o3aixQRYnJZw2eGi9NhLkiWVLfUWetnTLNcJnbDqkaJvx7zGQ8Wp4InLuoByo0Izpz97F+XENH+nI2sZbqEvre02EAGWIsU/8IJZlrHkpuCtjl5UdZ50vK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=JAFucgbw; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="JAFucgbw"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so37280475e9.0
        for <linux-block@vger.kernel.org>; Sun, 19 Jul 2026 03:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784458425; x=1785063225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2eFgBNGHZVs+4VEn+rFjG8dtsShNuRCRL19zmjqYsAk=;
        b=JAFucgbwqnuXms9cXGHT8sLvtkrldP4kQoLjBJrfyz5rDi2+4d5LG3rxQcsOb56Nlb
         44iYz5BRwf+XIY1G3w6CKTzBUP8cY1ivHuE8tcO2q/7xURPinrCs3IqfItPOmCv+jYYH
         CpattxbHEKF4zH1H5AYZAy2ZImrZbNxRyr1chBAVeu907UB150gQktRQsNlBo5SSfTzV
         /T2jMiUfEKKpppOUMn42Ox4DrZtiuAlSG3NlshP8/okOzvoJ/KQJBcCtdORJHBJjSMmT
         QedaBihhuQXXHk9pc3tU+g6LiDE37OrCjUyYoBU+lFcx7fkjakAetCNySuduRRuq4vCr
         Obuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458425; x=1785063225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2eFgBNGHZVs+4VEn+rFjG8dtsShNuRCRL19zmjqYsAk=;
        b=Ueq4DorMfSftAxP7lz+Dj3Jjler5pdFFC/Qu5fZf1UqIIEQkoN0VVA5V/QnwV8OOjp
         NHaW2VJwpmVf2lhAl0LzqAfkvP58IaRf9GsN/8pCPDk0/LtMeO8IbrCL85ErR9/iWmBl
         SnvCTJiPAVGqiOst6G2cJnvD/0DRiwZ3REgVetiQKsiZfxUhG4m/UWX1Qm4ETEGC9gYy
         A9pxtjhONiJXqNjpA7j+gNS5RL6pfgyfZx9NEGfm7BRuajGhy6zpxY+qB52DVJs1V/BV
         hsLhQFSFwTb/FqgtT/sb/AxheXIpKWZXGBF2je/GxXOOhmIS/q17ptyfEyUE+A8MjqXq
         B7MQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTV91ZcWlmCCV1GCFiFPk4ZyPE1N+gvBiCF1FfmmUXyR+ns1F7IONRywJ6n0Rcx+8VsN1+52YQpPAZgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0MBeJVE8O1VWtP9r1ZHqZa4ctePi6uMvzoeYhAbXxJ0pLqKwW
	BcN/pvbxWbdo5rf5+jUl5K+d9QW0FR24XbyJG/G1eleekCXV+wipB0EZnNPRQp/yV0ar07TAAmT
	YZlj8b9Ua
X-Gm-Gg: AfdE7clmIDZeYQOeHYI+phXToqFl3a7azFmoahfMxBzaLey+00G+uijBqf4HP6YY5pi
	HHvWCGMxzYj8fVD4tHd0VpIqgpKEp54fzrmERR2mu89kgDRl4Q7tzSVJEmfvart6lGT4UarFlLZ
	vJ4DjbO7cLefxnmDtNnddAVbjDUukzsQZSJWzMzZy3OPXXWbjmgrkS8f5rEMqFzTCYCZnvYypSv
	11st/vq1IhWbapxAPx1dw/327REE2aUD8w8PoBd2Fps8s7i8kKntJamxu+mJB7luFn3kLApHFaX
	Rq/wdHNvhKtk0aB9oTP8iYQ9kJ7et+MsvhBAlM+JVw82Fz55y5nEjuYv3Sueul6FgcGgVbsMZHj
	HbOcYdE/KpFn3psN7BOqwIIT1qcKIY1115kSCPWGMXvY8RoOoFSrTyae+FWcxcvvqqFIsjMBe
X-Received: by 2002:a05:600c:4585:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-4954a50b811mr100979195e9.26.1784458425036;
        Sun, 19 Jul 2026 03:53:45 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm197679575e9.3.2026.07.19.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:44 -0700 (PDT)
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
Subject: [PATCH v2 5/7] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Sun, 19 Jul 2026 10:53:25 +0000
Message-ID: <20260719105327.864949-6-mykola@meshstor.io>
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

narrow_write_error() re-issues a failed write in badblock-granularity
chunks, cloning from the master bio and resetting bi_opf to a bare
REQ_OP_WRITE. For a P2PDMA bio that reset drops REQ_NOMERGE, which is
the only request-level protection against the member queue merging
P2PDMA segments across pgmaps or with host memory (see the preceding
md_submit_bio() fix): the retry path would quietly reopen the hole
the submission path closes. Restore the flag on P2PDMA retry clones.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c  | 3 +++
 drivers/md/raid10.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 914fb86452c0..f562b6bd438b 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2573,6 +2573,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 		wbio->bi_iter.bi_sector = r1_bio->sector;
 		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0a3cfdd3f5df..f7ef903a3d4e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2831,6 +2831,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		wbio->bi_iter.bi_sector = wsector +
 				   choose_data_offset(r10_bio, rdev);
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 
 		if (submit_bio_wait(wbio) &&
 		    !rdev_set_badblocks(rdev, wsector, sectors, 0)) {
-- 
2.43.0

