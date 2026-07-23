Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC7844E652
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839394; cv=none; b=IAW7dwhp1t3g8AOSmZA+OKH3Xa/6HX77wTpQ7WoHgK5C+ANOX0u3CzjtZX34vRKAqOfkZIKOwcMjKoGQ5OMHMQKv+D4N6d86We6RCEnLZ32GIRpsLHOukc5Fx+JPQ91LaH7mqukZQ4dtk0t0Pd2+o8LEnfFKCjI9sA8MYbe9Q+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839394; c=relaxed/simple;
	bh=6JUXonkvhqCluPq91YNslI6Xc6PHhaJJ82TMx9QRo24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfF0wdZ4gUVwP+E2niw4SB6k5TdUzrKhAfEgxi2Sls8Mar9W0FFUI76+4tkNhtKz/im6Ra0Yg5Zkn0x6kdPm+7cBZSKUVoGgX2rAWt0Ua7F7yUaf947nnUsbhWHx7m8rsxmp+TaVQmFuDbdQCpoUg0gSt4kcJP899iC7NxrYh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=b9TCH004; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="b9TCH004"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4728c12ba97so667172f8f.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839387; x=1785444187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=b9TCH004kM7Ijzlq2L+uYapxZbsJtgiPIoccs97iLOok/j4G0z9BoSi7OGTZzfNraM
         9nBbybkLeR3kaqz8qibH9iQR2/+3QMIg8k9UtqWVXdcUsUBX4RdymARurgQLc9PBz+tX
         cU1oMcOcw42w0OxGq4UZ131+iaLE2py0jzPsTM1peGRNz2HSGRqdZT2XUA1zms+v/aFP
         RSKb39m9qHn/9kGElrHMfdLkSFCt2vA+ObV319T3/Q3iv30jBdhCVHMR7mKE0DXcTuWe
         tR1+ya8cQ5UblTusXMB+XkhJKb/d+KQIXTWrnGw3X47bbkfgMA0AmX7SlpGUHEbpPpM4
         +F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839387; x=1785444187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=SguAvJ9GAmGVdG4YIe7mlVX2I1nKf3FlLAJjS6MZC+uN40LzUqwaSTmNK9CCjHd4Dp
         TSlFPICUrQp9Aqz5oq7yZHME1u3I6K709FyHu0HCZGaOvoAVYqo5Gc1hPaCGuc4xIgSI
         78qhVAcb/6m4rFo+Qta688xanojfI4TrDDJKKG0TMdX2BqMdETGcuZw4wT+qFJl3V8nz
         y5IVHrHlm/VsLHwroTxsEmGqDeEOD+OdAMiZsKWzGEnxJpvAUj7WN2i8CN8CdT0sxoGP
         k2nTFwe5HUPYxif7a+tHpAy/B1cWkltBbA+nxs0ZFP6H0RH+gKcR1MARsjgotFS748py
         4Y5A==
X-Forwarded-Encrypted: i=1; AHgh+Rosei0sOrVysp12+zCK/lUYAbgyUNWw5RIkGWPcW2IbyLX/PJBOWCTS4tBUjj+ZYl8BDPU79cKLmXQrwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jaIYtXkWJVrRds+zUi2WRSLZkJ/7U+TiWQziWO9P3dVLKVx6
	jOGtG/tgeQHFmsGcZ54xXfgNdxRTEQezGEaFTBEX14ToxZZX6hfUyAKzLBPm9EOKyw==
X-Gm-Gg: AR+sD13qnFJ7aAtvtlV3feH155mU3FgMX8VgRife4KMpGHTq4Gio3NmzODV3BwrLg4E
	Lt/TIgOxHuQVawspr9UAOHoXm+1HrToAWJ1oOOF0sdlcVQR7db1cz0N1BfG3i4D1FGvWuR4duBx
	uQlNYZpMO6AbwQ6axmYqNhx/usDOK71Lc2UZZ0QBeGNWruP6U4Gywuag2VZMELE6/T65p36F+xm
	REdAe4087zf75irOhO0AIF7N30+4gr5GZE07w/oTIO/zypzEjaNsWZ/dCl0IYQeOKFjIyJEGom0
	48Gvbd7+0hT+QxxyHB+FUAn5EihLZDUJONZOUCUvMH0BHR+oFLIFckRHKHJpSRShybKRJeWL4QK
	x4DRlhRyuqa+Id/1QidtbS96YWRU4ijuVZk7wj9CvBBeVEJYK5MyihFEL5qdK5CV8bZ3RVmN3cn
	CdfM/ShVl+DiC1iNvZebpY2Y/++p1OiIQUObKHhnBsx8qp1Uu+jxip6mMQObl8OK9O89iRzl9we
	BjZH3ETgJZdNjUXPQ3532Hud1VyWMpu+CWGHeLm4A==
X-Received: by 2002:a05:6000:611:b0:47f:25b1:e7b6 with SMTP id ffacd0b85a97d-47f8dc7a211mr5521629f8f.30.1784839386364;
        Thu, 23 Jul 2026 13:43:06 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:05 -0700 (PDT)
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
Subject: [PATCH v5 06/10] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Thu, 23 Jul 2026 22:42:02 +0200
Message-ID: <20260723204206.76930-7-mykola@meshstor.io>
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

