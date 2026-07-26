Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C23A9002
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065573; cv=none; b=Xt9zS3gxKp45zX4zyqQJ1JqirgZ9Sq8k3tDUK6dOX60kHA+E136pVNvHwzw9Xpf0ZWp57B1OYl2lb0ZW9YZafCbveNz9hNp6LT216JHHBe8pFEGGTXN4nHZ3Ow1Pf6gyZQzxSx0XDeV2ojIAnQlsGgtmeQkdhOF/c6qeNoxTuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065573; c=relaxed/simple;
	bh=6JUXonkvhqCluPq91YNslI6Xc6PHhaJJ82TMx9QRo24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRpz3t6Q0eLkWB9Y+/3mAzlHvdE4J6CQZn3MPJQjoC5aFdr4HezJsXdAYT0frLhcjX7P5xgRGkXHAHAZK1QGDcSZmA5blv7XQh1qMHP88NS+nmzCWCTzPZylcH4WNCV1NQ0tTjnfxusOr4ifxp76bhwluc/2VkqKuqlz4+EDNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=UcKddbKk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="UcKddbKk"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1042006f8f.1
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065568; x=1785670368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=UcKddbKk+nkVTNd4kHsgAnXK+qu3602GkP3rsgzCLowWckJGUHML6/5jd1eQHErJv/
         SJV+xgbmbhpJbF8pxkBMpmdz2mxqUp0d4gfJZNyeNO7HSLV70Jjh5s1OLtjELA5Q7OTS
         MVclHgcL8qyU6s23t6NETabRZJorB2CdYaWL3S+6K7d4LmiAxn66bJpQnM8dXIK7/ajL
         gvdcMDsVQFpihPUj4XHQWDuGNp13dHMxHde4/ZduK5ji3SfPQlBZDpthP9tVlpaf6qBY
         85MD9Io6JiJ/UlyNC7ELTED36z2Gxwu+Z2WqzbBzPzYyEgzQAPzvoi4Kx3GWDZfXSLKS
         9TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065568; x=1785670368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=niZl0sRPP40wPmdl3X64xD4aSFpflo4qf/mzB2vyiAEeHs1e0jtBEgyLyQnF7ghQeS
         TZUMMUq+fP/UphIihSU8buEbuGXmREr3oxbMMuui4cqg6BaNd3mEGhKesrj1pG8p5bbN
         Qx3w3fPonCJ2xgTUgCUq+84LpBGRDyj4MQP+oM2rsILG2jSwd/BSRUj11WqSFdUvqzhJ
         /WRj+iFI/FKDbuo+4GKfG1wgrCZhrOwXJ0jI1fSMDILLouT+IQ8KbhhnM95YBq0hXDtA
         08uzIrckOjuRqhAh7yzJKRbeZrVr7D9Cw/ViPideeMcd8KAM/p/7Yw3XHMtb7Kx7jTxK
         y3Yg==
X-Forwarded-Encrypted: i=1; AHgh+RrytE2y1IIghbadr48UFq7qDC4BxrysAc2M6En+rgf9xVCvSJIIE+HHpXpGR2NTcqp7v/3+7W+JVGY6Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLv4JTNAPuD5B+KxKQtBtdctoctsdjTJ6Cd0lZWIRBN3c55wu
	3Xw7kIi9z0y4CgT01Dcf+ehoE8/HNC0Lh0QTsSYILg4engHcq16Zr7B67Lc/cHSIbw==
X-Gm-Gg: AR+sD10IrTSDtm/u3atoDMtNzIVfTYjxmsTh8lXDZNxNLTUjMvOjvieWHg4FLkNnDHE
	mGWZpIj9ruNZSIky9XNTNxcN/XHcXZbh+EldmabVMKVYv/ZKx6fDUeQ/J6aQhULhNkZW0hvn10e
	ubupxpv709tj8UwtSyP3sWQdqqGIwJyy7nU6jYusUM4ujEEfpZm7n/ehLXLc6UebHTnIk/L7Lgm
	UCyIdxErd5uuzBywkGcfHvDZ0f8UQYzWAN0ludS+Ez2VHVGRn+trGXyBDW6Q9a7ALKCTk2WWcDo
	4FMKqbVmV18XrtE0HTuc5m1pLCvHHUmXxDqFTsE0h9EBhQXQYNXVOZZPuzyLreIzgqJhNZ29jo/
	qGgn/9k+Accuicl/VWW4Q2VLXn+/l9VLyGpA3JZgFxOf9+BnMvFHikVqVfSoB1IgJ3PAnBacG8d
	o6i0WAOZsTB/kgP3592cmIKPT0sIw1EdFbVH3EpzUpnaoexjWVUN+bOpQ9K0Zk+F8gR1hfef/54
	CkHhtuP2JVOeEpFtKPwZSMJ76bklbDY9+nL0n3c4+dsw0Cr1+4+kHFxLonNph3EKQWcbcUl5FQ+
	FpKBdVf3jWX0taHICb91hLK8i4qawEya3XY=
X-Received: by 2002:a5d:5d09:0:b0:472:7dce:d8c7 with SMTP id ffacd0b85a97d-47f9fe9e8bbmr5988536f8f.36.1785065568316;
        Sun, 26 Jul 2026 04:32:48 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:47 -0700 (PDT)
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
Subject: [PATCH v6 06/12] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Sun, 26 Jul 2026 13:32:23 +0200
Message-ID: <20260726113229.2154269-7-mykola@meshstor.io>
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c  | 3 +++
 drivers/md/raid10.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f07edeac6e5a..19c4dec450de 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2561,6 +2561,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 		wbio->bi_iter.bi_sector = r1_bio->sector;
 		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 5b63175fb382..428bddddfe71 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2823,6 +2823,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		wbio->bi_iter.bi_sector = wsector +
 				   choose_data_offset(r10_bio, rdev);
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 
 		if (submit_bio_wait(wbio) &&
 		    !rdev_set_badblocks(rdev, wsector, sectors, 0)) {
-- 
2.52.0

