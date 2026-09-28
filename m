Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5064C9DF8
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602373; cv=none; b=K7SJ/4ei1bEMwVyVK05LI9CaogvysKzXZqLFTkEvqCMgfAdAUJ2FhkhEFyQz0pwMcdIWU07BnKgdWB08aNsoBx8RpObU80aAmSxsoKHXno87izIFsIr86tTtFWufxTeVF5HXd+CIDZSrHUmvSeh1uuQy0ETll2hspbYpSFsLE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602373; c=relaxed/simple;
	bh=io+mbOBr0Rt7TH/wdx/lZ5oAtsvxfyuCrmFKA9OR3tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6lrcu2sYpuHx6p5u7vX4khSXQJCAJX1fKEi1pOQvZmeSFl/wl+TcJ0V64FO6TeAcOeixWnQkG9I53eBvDiAZbtNmokV/ABKC/Ek7/2T0bqIq0TCqgEmPpQsUe24Ea5dGHIUG8BL5OKiuO+BqeZMBOOIF4dA4N1fHRoz6Q9aHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aw3XFRZT; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw3XFRZT"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so2731298f8f.2
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602368; x=1791207168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OcUXv3wgMOdU2Q5PfJeVzuf4KJvyhVvGu/xuChutEvA=;
        b=Aw3XFRZThrnFfZ4NNrryBnBx8rKYreyC+wG6xeLdRp72/nQBOP2LLNpSBikDWaAqUg
         B1Cc2nsr0YNiHZuzqepaE4qOdLBRkPtZ/q2lECdNi96tOaIOUhljX+piUy9R/ZDij2zv
         EJpQ0nTCs03EX6n0tFfjAO0LaxQYLe0Vbf2A4wlUxsMqgHOOfc4MHDOm82alsW56zirU
         u0vcOZs8uyUGHl3hWmI5ayUV05BUfIGbJdq+lnkQ/IBDDaFxYSaku1GxlrroHfTOPswe
         sg68AfqotYirUkk5Teg7eA4xEUmGb1HcmEqxmwwEtyYmw8nk+T6yLamjdbQ9pRm96Dkh
         snAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602368; x=1791207168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OcUXv3wgMOdU2Q5PfJeVzuf4KJvyhVvGu/xuChutEvA=;
        b=LPEHxUszVhIOLkrZt5X9pH41JjiFo6XlUBYeDb85qA8ZATJmgLygCXR9S0wGV6N/03
         oqb4iLJ/VAZ45dGN1Y5Vn7oLJw/XlwpS1gIQ5aByRAudTtldgqCjbWL1WMJ1/N10jor+
         1qSh1R0zVr6Ur2vCbentWpSpxIyrfKZPsA3oKksX1qn+Oq7FrAsI+g48o3WgExOIT2aW
         67ctoosKWsgB5eeRyN+kq67DFGDDw49iBv6lbYO0ZN62FED16Jz4VqMpkQ890yP3VbOa
         oZ9Ytf3kjaUpDpGb/BSVGobzVoqtrL47nvVCqTyb2Gs4nM7Qh67q9q9bxBRmGnveILX3
         iweQ==
X-Gm-Message-State: AFq9FYIUzthfFFJS7zfhOtLnaj+rGz9OEqzU9rZu1J2Ie2GycA0c9RBX
	ViMBh4Xit2gd+0YnHufyWF522knDEHgVRD7q5T3LUPzJdQC7ZJwp38I0H8fNY1X0
X-Gm-Gg: AYBFou2RYHEhxMftV9MCKrZ7ft0xGhE4u2jHUwU4a81SSatXx/zKb8IgqLCfV+J4JB2
	/qeQYKeCMHSVk34QLyz5yVIC7UwmagEQcyPlR2Yif5CzKUoUJPcMHYbauUQfYfCd53xVDTzoPHH
	vfBPTo7QVjMA9Ei9vI2PF+JbfGrQwL/YYk/qcM0eIQ/A6b4cCCv2DOhxxoCRNewanInZ0/e0VqE
	duzkSJ6y5VPjD+zDdkw8KIgLunZ+qzN8GSg0q82BkEN/YIiIeTa+upq++DyhU3AcZbV8UluFggv
	q/PQ4DaDzPCvXVxjaXjni0Km7p3jN0UNb20CnTPe5cdoVtRkUJrF49MjyVKJjBvqmiEMi95d77g
	iqj+qP3oqFjjXYqrp8ysoPee5hiP7dtyttPi7S6qyeeXMivNWjoXZzBxGDLjVi9Jg5FR871AZ9Q
	UVrZu8un7IPeekwIU4a+hrcsb1rtIK262LdFGda2tj+hk+zUstgjkRKhjBV6cv8QDVDzSJRvFbD
	BJiefuTYzmMLYXHObtJ3xyXviV7NnLuVKKofmj6j0e+JVYioQSze+4mXyf1hg==
X-Received: by 2002:adf:e19c:0:b0:487:11c3:b004 with SMTP id ffacd0b85a97d-488719760c4mr23422853f8f.52.1790602368298;
        Mon, 28 Sep 2026 06:32:48 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:47 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v7 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Mon, 28 Sep 2026 14:32:19 +0100
Message-ID: <39b4cb178513b33726c8d2ee0824f7324e84828e.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
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
index 75f8086351c0..10ece05cbf43 100644
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

