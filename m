Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83B45D91E
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792045168; cv=none; b=m59fBK1kDrboPKkGycyQgyX1jE4P5qgX9ZL28r8mh1mVncKetNeT+Go8uBUrlG7n4+Ae7VHcTp+ahTog6qnVbvDhThz0wg0OI2Lh6MAVK68WOSY+ffkWT8d9IcF08rXtvAH3c6cG2nqayyGYCAvRJCq6Hv0rZNtSgs7jaRMlhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792045168; c=relaxed/simple;
	bh=SnTqnSHnJf1SyEgRppnLJtdvwZ/K9QpTpMoFZTST/So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnrYqTPGrID3kvo2qse6+ecIeuYl775HszLnI8k5sYtReipIWmxNgDGP87/SJo6y5VHrATciPd6LmldN99LXo6dLPpLICgsylq1bekAH3pYLKrURSmpuXUz8qK3XymZgGN7lUlQf+V8wj5OeDzuOqzHHvzN4i56QpElT7l5Qcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMsEg9vs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMsEg9vs"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so154923a91.1
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 23:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792045164; x=1792649964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LKqK4HrH78W1MTYoSkDNokUsDBo14132TDZJAUlwXh8=;
        b=eMsEg9vsgz4JpZA/dQGmcIu7cuJhRpTt9bfXp/QLtE6wYb3AwFvj5xjTWMPOs90pPc
         jE6uZFmpKp104w+kZDOf7V5ZRLT2gpxeYShesAyn4HMOtY1iyWj3X60jla8tnX/Zy+9A
         1UR4iR8QOfZAmT6e5EXxja16F8HF8rUeJ6/M4OOztB9SNkCXc3CMVGph4MpXZwJ10v1j
         SOa8zryzSZrFcdBgxRsIpOyN9GtV/KNfzEne6ZnZSSJlN0TabAn+Q5nC+ExwBe33LoKW
         dpKAXHFm5eyP0BZv0aA2kmpJOn/vkmq2fvo7ikaX72ed9z4THTsBc2YHQwE4B2y1JeYm
         UhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792045164; x=1792649964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LKqK4HrH78W1MTYoSkDNokUsDBo14132TDZJAUlwXh8=;
        b=NCyRqu9k6HOLvZ/Gt7+8Usy3mjAFv+kJPO4wBM5vxJhr7V8tZ56cuZb+HDK3u7zX2A
         eEp5QbfNswYPTV5ZsXfAuoF+e+NALpXZsy9t+7bqjOsE1mVr4ebufRNCUvXcYcwhZ2Ro
         s18lR6hZXSNT51pjqTkjQiRvd40sWiP5mvUSZJDnKY2S/kk9dKh/9W1YNVO/41oBeHY7
         nLsKXkuUr0ji+MPXdECf6bBF9J6dmEXlKsVXLoaFN1RLTq0FUIjpPW5t3ESNoFpysau1
         w16uTUqR2I0WEmmbaNPFPck9+qjIl2wwCuEPcdMrBX/00uR+Ozus+3RgRZuPNpve63fF
         2ssg==
X-Forwarded-Encrypted: i=1; AKwUvBz8JsLGvoxNaP1LhMOwhLvDq7DYoc5vAfvRNgcOpa/vlFo1q8sHp4v4PF6yzw2C/a/phfv9aqtMeahMpA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLwfnfKP/Exd51LAoBb4RUxwcbVoMVmeujbmy0BCfGwHlsfpRWp
	m6PAr5/CIL9Pt00706wGK6OAEE+4SJ3JDB4fFaWjpZKS40Hv0OpNx46D
X-Gm-Gg: AYBFou1phTb9LdvtIOGujYEI6b0UejzXDGA2oKv4T3D4DaZokzXp05R1LbBj2qFAVuM
	u/Z1a4qQsYQlSZTgFVkPQCLRDHBMkuothn2C1Wij7YcFyEHG/RBQqO6vqYHHyyEsyU/wH81FQ+X
	SbbyQRP9xYwpVKuNtev6xAf7dx6etUwIg1lUpfssUPkNszGr+iju2bgg4fWSSGxJMqCeCVqSA6E
	TrXL/3mL0lqpN46m7T4R+hanv7Z64epoJeJTNzpjLsR4z9OsWisnpUSzADgXWdXLJ9Q7PXUk+fO
	LwCSvsG6C2xGuw+Ecl3hquHpDjpahfgmOTsaW7fzp6oHpfxB36sWYz4kqHva6g4oCqJ7ccyliMk
	ImZrzeLbUOo3RJMItGNKFvlnVHSefmNc86njPjjlsMqvHNbo+5rziAu07cmrLFdCxEQgpg/vokN
	HyySrPj3Jwf9vqqC//v2HCN2L4ipTfcIdCRpd5333gZzD7LsZLYi9NwKuh85YJG8T8X7pYz5Bad
	RtUtS7zLU8y
X-Received: by 2002:a17:90b:4b:b0:3a7:96d:feaf with SMTP id 98e67ed59e1d1-3ab3a9a0c59mr9385893a91.16.1792045163419;
        Wed, 14 Oct 2026 23:19:23 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9461d71esm2669111a91.7.2026.10.14.23.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:19:22 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH v2] iov_iter: validate extracted segment for bvec alignment
Date: Thu, 15 Oct 2026 15:19:07 +0900
Message-ID: <20261015061907.2713943-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iov_iter_extract_bvecs() validates iter_iov_addr() and iter_iov_len()
before iov_iter_extract_pages() selects the first nonempty segment and
limits it by iter->count.  The checks can therefore cover a different range
after a leading empty segment or iov_iter_truncate().

An unprivileged O_DIRECT preadv() reproduced the empty-segment case: an
aligned empty segment followed by a misaligned one completed 4096 bytes
instead of returning -EINVAL.  A truncated iterator has the same mismatch
when its full segment length is aligned but its remaining count is not.

Bound the normal fast-path length by iter->count.  Keep
first_iovec_segment() for leading empty segments so validation covers the
remaining portion of the segment available for extraction.

Closes: https://lore.kernel.org/r/20261012065520.1089147-1-4ncienth@gmail.com
Fixes: 14b007e17881 ("block: validate user space vectors during extraction")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Bound the normal fast-path length by iter->count while retaining
  first_iovec_segment() for leading empty segments.
- Cover the truncated-iterator case raised by Andrew Morton and Sashiko.

v1: https://lore.kernel.org/r/20261012065520.1089147-1-4ncienth@gmail.com

 lib/iov_iter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2072c04e99d052..d21082fb251bf7 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1022,7 +1022,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	return maxsize;
 }
 
-/* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
+/* must be used on a non-empty ITER_UBUF, ITER_IOVEC or ITER_KVEC */
 static unsigned long first_iovec_segment(const struct iov_iter *i, size_t *size)
 {
 	size_t skip;
@@ -1938,8 +1938,13 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		   iter_is_iovec(iter) ||
 		   iov_iter_is_kvec(iter))) {
 		unsigned long start = (unsigned long)iter_iov_addr(iter);
+		size_t seg_size = min(iter_iov_len(iter), iter->count);
 
-		if ((start | iter_iov_len(iter)) & mem_align_mask)
+		if (unlikely(!seg_size && iter->count)) {
+			seg_size = iter->count;
+			start = first_iovec_segment(iter, &seg_size);
+		}
+		if ((start | seg_size) & mem_align_mask)
 			return -EINVAL;
 	} else if (iov_iter_alignment(iter) & mem_align_mask) {
 		return -EINVAL;

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

