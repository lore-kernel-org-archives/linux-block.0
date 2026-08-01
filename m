Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30652DECBA
	for <linux-block@vger.kernel.org>; Sat,  1 Aug 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599300; cv=none; b=jF57OLOFPP/IXogO11K0KLTJI/qyQXaaE5VokI1TNmCk/9ggDVZ31yG6Pmgpz26Wfj4YvwjkXkBUYxDBJShZbGKy3o3KyhQKABmDwXS/LFj6a/qKfW0d1huyt42qW0FPqfDDSfDztZWhdOJr4skxTIFhQ+Zx9djlCasPKGIfIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599300; c=relaxed/simple;
	bh=X3zRjuSdVBD5i7gQmFjvEEAtiBuCzXBqrfu9vE0MnhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By+0+46PIfYnxzl5j9vL/Pm4R0OhOB26yuvAEZzVdn86YOX8YttH4fYglzuo+NmYcGDIkZP8CobG/lh64UQwZKSYmg/m8mdz915mLUAF0rc2bgk1PcGb42dx6UaOzAjhfEhPoZqXi+uk10L0GoRVGTP/BpEtckUKQpyy7N33a8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5Yo/707; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5Yo/707"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cace91f112so21799385ad.0
        for <linux-block@vger.kernel.org>; Sat, 01 Aug 2026 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599297; x=1786204097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0GcIDTsY2CDASlyPqk465WOkbyFB/dgtSdtycnJJZM=;
        b=s5Yo/707MVtufZXlHpHeR9eOrEXTbwgJPhF30vx7pJGrFzN0hryZ/O84JB91C4DJFA
         TbHYUGYAXTW6nMuGTNQtbiGKzpYEL73jW/itojS9/HilH4tYfy2jMvI15KYkZhiECBud
         CMwX7/yc3W6yyRGL1mBGzkmfAnYZ3XwdGBpwe024v1IsKk4ZBqgr7shg2iNzUU12r/pG
         VTCGh7jP54IJsoHCaPyqt86UdTYcW9xsmoaMvH+qVR033WqEJ6V+aeAoXboHyY87aam0
         lWSJ+5dsyJmPYmlHC8trWpIu+mHIlM0FNORMvLLyxc/Zlayu05yoAXz/zvgDhti7Tz+C
         M7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599297; x=1786204097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R0GcIDTsY2CDASlyPqk465WOkbyFB/dgtSdtycnJJZM=;
        b=oOEnOw7GCiwaINehJ4GfUZ19O/R1n+tmADKeJ4iG7dZt1ktuhMUhCR5EMnYY/WaU0o
         C0uRMyuVlZx2y10IcjbZNfbIiW9KdrvLgiXmKZZGJAWxHwQ4Nf7qRXRZ0cJJLT4bLdiH
         9Xzqo9PcsZuONOpmpWCmWEo8gMpnqqt0MhzzOnd47n0AhTgO+L5Ba0erJFUEDj1nS5ZX
         JOqnVf74L1QklAwUeh/b+CkSgd9bR+X7fjpARNVfMTOCKh1vW7ScrcC8S9j6ltKZHn9O
         P4/pCDvR8RDd03E4LQHylSXjQydx3f2KNSaZMsdzW6vbaUazxx6Y9Bp5TjJor71pB3uN
         yB0A==
X-Forwarded-Encrypted: i=1; AHgh+RrUBzj9ArgFt5qIsbXHmWjs02P7kAWwJM/+IMGPe/T14uX4qwog9YiNb4pMSyNALZQux1aULcnofxJCcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT7MZ6VuYHcltXmzc8rz7ahqZkCgYpHLqfZ7t/X9j+B+1siAQS
	ueD6H2lKR7UVFPiluxfBux86EtEXxM4Q9hcVACAjMeDSfwSrA3G1UfeI
X-Gm-Gg: AR+sD11nYTjDR7lAiMdKD4N4eivr9HtcWJJfVXNRBvvla5NVuXFpZuYjXH9iiImQsja
	K/6yXWprkXJaEP8Qnc/vtrOhrTXXuckJCu9X0RYyuA1RH9J17xwvb07KN5V289OtXcMxYq6UonE
	e6F3nWclqfiVXL7zv8LQhXgFhBOYZ9lfiK1LODoOYlTfPctxbsR46ysvGSVgueiGTwBZGvElKyF
	AvczmPEbbqDooRlZZoKaqlfbcRZss1TYoKPuE2l/hdIwIsyNR0fI+vEFaSzYpHwF3D4emR/SeGd
	ez6SRgy2H6wut2HS79RowvoFphkcXJOxKiCfC6rVKZgiELoeDLSFaNjUqMe7iEV3hd2esXYAQh5
	kEnqJLGx6EeFXLIbemvu7Vn9gDRwX8jHRcfFplF/JTwhnxgw7JaDcs74h78wl5DWCo9Hrsb1xGY
	ssdZPhWX9QBT7Z1r+eyMrwcDAONJWwzEhqDxHQLHrQOjOpWFLR8sODXjYGBSH3h0OCCNOXAquY7
	UHnMUQJ3sr9C1mj9xVGVXbwtNahfRdTOGKEMthdJyINon4=
X-Received: by 2002:a17:903:22c3:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2d0521bcb54mr36749555ad.2.1785599297067;
        Sat, 01 Aug 2026 08:48:17 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:48:16 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 04/16] block: always adjust bi_offset on bio_advance_iter
Date: Sat,  1 Aug 2026 16:46:16 +0100
Message-ID: <64f559a1d1ac43880149de5950187beee6bc2aaf.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend bio_no_advance_iter() iteration to also increment the offset.
It's not currently needed because the currently listed request types
don't have a buffer, but will be useful once we add bios backed by
dma-buf, which don't have a bvec but work with a single range.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/md/dm-io-rewind.c |  6 ++++--
 include/linux/bio.h       | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-io-rewind.c b/drivers/md/dm-io-rewind.c
index 04f3fc8aeb6f..b22719c6411c 100644
--- a/drivers/md/dm-io-rewind.c
+++ b/drivers/md/dm-io-rewind.c
@@ -113,10 +113,12 @@ static inline void dm_bio_rewind_iter(const struct bio *bio,
 	iter->bi_sector -= bytes >> 9;
 
 	/* No advance means no rewind */
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size += bytes;
-	else
+		iter->bi_offset -= bytes;
+	} else {
 		dm_bvec_iter_rewind(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 /**
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0445ecba3b24..f9b8903c6a87 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -113,11 +113,13 @@ static inline void bio_advance_iter(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
+	}
 }
 
 /* @bytes should be less or equal to bvec[i->bi_idx].bv_len */
@@ -127,10 +129,12 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 void __bio_advance(struct bio *, unsigned bytes);
-- 
2.54.0

