Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9928384CED
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746760; cv=none; b=nWgrQScbsEG/k7rlsZ62P+6hAp47yZrQ2Fe19J4NqTAgJ9G0RiNFsaL+qxMvz8NgA2wyNdDsw0GprNxtvao8pkXc3OPhybLSGkVkx/Zxf38BpoWzvGEOr/m9eFhjUNgctVR1gU4pS6MbT0GuutSJXFCPbFy+i79Rvr923v/dk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746760; c=relaxed/simple;
	bh=6JUXonkvhqCluPq91YNslI6Xc6PHhaJJ82TMx9QRo24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urmiuuQBcg38yt3/WKO4IsyZlskN1n27KmOllsfLvaJUBdpwV2H6hSnrnk+aRJD4GOBu8/M0wAnAhk2NUyRMIofRavVHh2nUeE9Vn7fDIQiHR+GDIn5vdaZLKkB4Jp1wnI0BlQQ3WnoiyGV2Uegtq4lgOxHhR3waRrcn0DpMrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=Ai0g5NKB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="Ai0g5NKB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49557167508so44945965e9.1
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746751; x=1785351551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=Ai0g5NKBb/WoSwM4WCinC9gL5DuAa88xLuEC4hRIs96ghwRQmvDlMLh5VL8zWotpFo
         JLjmRiIu37BjI3rhd4Ubw4snBPwDFxkD6abowchkrUjNFOey/CJUVv59O8K2o34bXApT
         4wCOv64ZNQn2gEcUXAlJfmTzBq/ChFOvz0KDkCMfXy+BPORDQH/yJVd8q4o1hH5eyKUb
         S/BWDDtTklXRRcmxmHW3gZoCTvjMSA7HKGVHZyrsR6bfdDbQLne1R7K151Fu6TuNRAWt
         gNTwsano4qKf9TqettAQaDaizTf9HGlyParu20USjlWCEDbIz720Sk/FeTdSzuha7whc
         pl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746751; x=1785351551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=TXGfdqAGJ08BHPsfI0KX1HNncRfZcPdEDakKybfI+/ehrTdyJ4OO4p/WqQg4N1yBrF
         PD8r/MAXOJmS4SYLI0DPz3x1ZLUHMuC9E6a09VDSoDMYYcAXgcdol2Nox6IZzX/clf1R
         FrtDqBfUEuMjFZg9AH/mgkHxXIWRQZtVjD1nd3FZlyGD6ZSvy8ZCrmZMxWH+eieKUSHA
         p2Xc1gmTCuZc1S9mgU04gOyISrNtK5sMZj74srNmcxRc+uebaJCeObEOjxN023qgVH9f
         G/1UG0thErVVEXr6U9mVnyTkN+5DrdtqNeBnFvZtTHRqmaG/9UOMk3/dUXt3H5p/CwoN
         8GeQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNp0MGp5Bhu7vPIMLYXGb4Jkr9ZqUU8IYPY0tWA9o3/yxTxO3yQUYoAUU7JacQktGoSABHl4xapaaeog==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfoqXvX+oYogkWrF78h0zO54qnJUMnO3MibWIRKfLHqxGMuER
	iezAvMJ4js1Mw6bZdyF5stt5VQ9oTOQJ1bzbeq1fXPVEx5rp/cp0GyWng76rA2RgNw==
X-Gm-Gg: AR+sD11wZBG0TMSH36uIqIR/5gVQu36lQtHYR59Yzmdgz5Ac4oJ+e3vfYoEGD8sxb7L
	TsDH5an+gcewNeiMftFYL1s+uaFQXxtOZZx1aWcm2S/zYnTHa8T/cdi4LrJHCxRt2YxPKa5FT0m
	zD1GSS8/Al/1FBu3ktxj8H2O5PWfpQMurkNn31pljyUU631tF45sJ/OmKLii9ObwYrgGfJC2ql0
	ngaNlNqDJY+VUuIrelvaDrvu0yvRWgZzE5ghE1cnBN1AmyrO1IyDv0Rk+45ba8fdw2k5uo/xHYC
	DRCSAbqPGhArTu+PMySaubzGPrQk/QuT634OI5bxZcPBTLj4wvQ2xEuHwueQVCbNq50sPUBCO2Z
	GNIqwqt4/lN5VM0oNTHj+uU3lH2j7z/+Ns+9cTq9/aHBQgfzTCmU/F/61Wfor9fNJSy6GlTWX/H
	sHsnasEZVMdWj2Kn8ks8WnWazzNVXqajCSCsa1jYKfX7eOVFQ=
X-Received: by 2002:a05:600c:1551:b0:495:5858:e163 with SMTP id 5b1f17b1804b1-4955858e1damr203016475e9.27.1784746751519;
        Wed, 22 Jul 2026 11:59:11 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:11 -0700 (PDT)
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
Subject: [PATCH v4 6/9] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Wed, 22 Jul 2026 20:58:38 +0200
Message-ID: <20260722185841.449934-7-mykola@meshstor.io>
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

