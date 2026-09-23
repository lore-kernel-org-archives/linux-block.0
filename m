Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068246A5FE
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207838; cv=none; b=p1Q0RD//TSUQezpX9gFakPv5INo4xAeOvLndHoq7LmynD6IiCmXkk7Y/dPzPeCvdrhDLVFy14+4FD1YIG6JYuaA/DeIx0WUGjHmE9mGpdIRttx8aHa2frzdjjEJxGc8E/CmCkKdDAUTUMaCQZvUQMWzk/kfSkO0bZYVvpAPuO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207838; c=relaxed/simple;
	bh=X3wzWg0roOO1ptF7ZnClA9IB/TZQgfMHMl8KC4TDQ/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vg1VwHGSpbYYeT/THKE80XIH3b2n3IOz5v9Vb+rXPdrzMgA0WUtplZcgm4fRjvWGPNxHAnU2OlJy0pD+sJoKcadyAZX0ZM9j8ggbIFkleSQLtUc4Blzgiu7IBbdEkfr2f+7ObpWgkp1/vyYKniBSlTnvQO2ip6vXtQ0qCGvamQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Z2MCRHl/; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=c6cIKits; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Z2MCRHl/";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="c6cIKits"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNEMOp047246
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=n4kk
	5mXgXhks+NNWJaLVIMvxQ7me08UQy0+SMcJDZMs=; b=Z2MCRHl/vKPc2LHq6tNc
	XiYQw6yOkzNTqDAp9gtSovJ+djDIR3yIu281WzCBIw4w/sMK3Muaqvq1LRmKhXQi
	DtjBf6/AEDdzb+NfGS07pop80K3LJxY6DsdPJ+tqhOh0DDvx5BSjUCpUKV3z/VFr
	95l8DwW75vkML3Uth12IMdTz3+vDwOY8DYG4qqR3LyQHyzOf06mVk3Jjs4eI8MSk
	aIHlLOV1H7BmPnz2YPW5KJiqDiBc/26ruL+xDJXiAoTlByG6IdSSlCF/SrcfSAgm
	pdc6gzxfeNofkDGwmbuHljjPtrXokS+tZtR9Qjdlvb1lE6sWRgTz7JsE6QJUqFc8
	nQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvhrem5mg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:57:07 -0400 (EDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so2743965a91.1
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 16:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207827; x=1790812627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n4kk5mXgXhks+NNWJaLVIMvxQ7me08UQy0+SMcJDZMs=;
        b=c6cIKits6iwQFGkTJ60ZxJN6j3pf3uceVMo/ZtV6fdV2Ad0LUdS16FL5ywz/IS/0Kl
         +jSzhMrLzLI4RqbXFTS+dQ2zpqoRHRXsPocgDSy7zxU0R1EfbmPUDuZMyLTheZbaMGv2
         KZezOqg0/Brwlu0TPCwygk/W4utF5WzuwDdDqvm+y//4bzA2mNqMJJczw68iUtHgmTim
         2V4IO7vreo+OzAIKc49bvnQ9xD8AiOtSuQiPgy498DTmEZHITB+j+OTdRsGGmHcZhXVi
         +YHcA2VOZ2vmbGr8HDnHYJjm+tLdWl6zmXzeLJJkeQzgUYvF9c7S55NvRDsxjfL1ZhA/
         BKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207827; x=1790812627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4kk5mXgXhks+NNWJaLVIMvxQ7me08UQy0+SMcJDZMs=;
        b=t4td1/HIIHvEf/zjy1G8SgORR5yUZNxifNHLzYJjWIKYUaE5WrZm7OfPKz1B2EQqP6
         nfyAvJeiO+mOQh7tqDdDUvo/MUhc9NSwHyaXgSEESV77+D2cXDaLRZ0CCcDnnoA94QJW
         +AeS1TljTXlV34NnagIwMOOaU4Kv1v4SdOqxFXaTB/PVAaJ4JV9hn262/ExT90+/nSui
         x7byCupIB9DYD0eL3gZV3Cn1NvYa1ieP+udybFwLgxdyiruC+Bua1cqm3B9A0x35z6DJ
         oQ5sYsVEMuRCks6gtKONLO/cJXND4f3P88XpYr5xHSTVR0i3egAtmn3bVUO+Bx/TN+eg
         p89Q==
X-Forwarded-Encrypted: i=1; AKwUvBzYxuP0mwixt5zz0BEovuhpyq6SDZj4dbAvM9GyZw+GuWaVazCdSzGfbheksc9XIXK4tbzaitnwiDsunQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k6xGk0/tmPC0QssIMa6mcTxLEfx0beXAvgF1qr0v+SGSsiGev6
	IdLKTjPeR7pHh/OsVtksu33phrAglACqOZNoQ6APvD9t+HyN/7pJHxSawHYvIwBo1hU0vWDzT0S
	uoPaGpS9M+6Ddq83wZd+e2FQhp2ev9CaywjGpvegZXu+MggH5w0I6euOjGH+G
X-Gm-Gg: AYBFou0jIKGkiSBX5hvi7a0SjujLHUxYrcU2qnDuhCWzIrPue0JWEcaXt7aUPskq6A+
	b3cKwPp8r99Du5obFE9MQpr6YyGVzUQrKCDjaCubsJ9c6t2nzEr3r5C2cKZ/4kmA8+LJ0m1yhmk
	RI/US9fbOvDOb1iCEk29311YGwwIAxXPjKn4Mxxyn8zN7MA+mitt+TwuBnqDB2aZ/Xymwf+0BzE
	V+8hscGhn1F/RZpqL9J1U+Jgto+QHvqlNuR8OhGGx2K/9w2IZo2FkUOw4F07PQtdC+QgX52Kd5I
	f+XYnSc0J07jrBZlXM3hyGdUkHZNt+MUEVohcU+CapNyqtHd4QErZ3amPqY9AJixFro1VL48BGX
	hHnaeSRdANMSKb0nZhVHUwtAQ9D0ueYsyNPVJhM/aygPkYw==
X-Received: by 2002:a17:90b:48c1:b0:3a0:4023:bb09 with SMTP id 98e67ed59e1d1-3a09896f0fcmr599646a91.56.1790207827109;
        Wed, 23 Sep 2026 16:57:07 -0700 (PDT)
X-Received: by 2002:a17:90b:48c1:b0:3a0:4023:bb09 with SMTP id 98e67ed59e1d1-3a09896f0fcmr599623a91.56.1790207826584;
        Wed, 23 Sep 2026 16:57:06 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:57:06 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:41 -0400
Subject: [PATCH v5 8/9] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-8-89e60d66eb38@columbia.edu>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
In-Reply-To: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.garry@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=3797;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=X3wzWg0roOO1ptF7ZnClA9IB/TZQgfMHMl8KC4TDQ/E=;
 b=g4+/LTObucWvEWYZXfmJp4B6cmRKAbNTyAz0wKbmoGjCkzwVFz7bDsWDkVVnaWn5uqvP88rn4
 zjtaC1yXvB/Dk3xu1zozB9M+ot0fQCoFlZVvmBYL6IjksSdLpbLuexF
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: xUDAtzEbTCCLZB5bCntvSEv2dFxmwD0O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX2ZA/XdrjV6zI
 Ilxhmx7sgNPbgofQwpr+hv9J88MnlJYusDzaJg9dn7pfnoCWMYFy9IP66LiJjh2XK1b8ztu2TNX
 02/kinwpVFIfuX1IcDvFJGcWUhfDA6DeTeg6/59vqTGbzoQu2tLTLfxUpNTS+FeHHaOINa3DWDa
 BTUI7nAjpvIoYh2Ky/eBjxO5QU+X+KJy1JofbSg4AmLwgYJHpYLL4db5LuyfE6/GbxR2MkBdONJ
 Q7NCyw7HJ0xEIdjPFbiOS6bDLh38cN+EKwc5a873RP8KYc/zx4XtbDtiexDv7xNWt9bs7SGKGYo
 XndShdbtmKeHmQKHMwJbR+ct/lsMETDSJZ0ln2uMS3QtW7OWKbNEueFbbtExArAycv39+2hcKid
 NjAgiCbOq+QlCzt1M5IRkQlM+zf6e2kd0NAE8XHoYGGh5QPrsV20w/YG6vwXkF48B8UOJtGzvWs
 tDZJs/8zggjm/zRzwDQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX49/lNWHryO7s
 Tf0DpUyh98iTEADoF5TjFGhSPoJBlhEhFal2o9ty09CPO8vq9ePCBDNEMj/I7SWBkr1eIdagkJR
 VksXg69RF2//is7Sqk1rlaGdJJBFrUZg5wFg8D12KA+B+0seRpRo
X-Authority-Analysis: v=2.4 cv=J/A/fwnS c=1 sm=1 tr=0 ts=6ab46753 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=FzqJyQ6YvfuMctRh2gUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: xUDAtzEbTCCLZB5bCntvSEv2dFxmwD0O
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 malwarescore=0 phishscore=0
 suspectscore=0 lowpriorityscore=10 bulkscore=10 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230100

bio_iov_iter_align_down() drops trailing bvecs with unpin_user_page(),
but a bvec built by iov_iter_extract_bvecs() can span several pages of
one folio, each with its own pin. All but the first pin leak.

The partially trimmed bvec has the same problem. Shrinking bv_len does
not release the pins for the pages cut off by the trim, and
__bio_release_pages() only unpins the pages bv_len still covers at
completion.

Both issues occur only with a logical block size above PAGE_SIZE and a
large folio backing the user buffer. On a device with a 64K logical
block size, an O_DIRECT pwritev() from a hugetlb mapping that ends 16K
past a block boundary leaks one huge page per call, whether the
remainder is its own bvec or the tail of a larger one.

Unpin all pages of a dropped bvec with bvec_unpin(), and unpin the
pages trimmed off the last bvec as well. Move bvec_unpin() up and split
its page count into a helper so both sites share it.

Fixes: 20a0e6276edb ("block: align the bio after building it")
Assisted-by: Claude:claude-fable-5
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index dff84c0b54bd..50b9f303c351 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1197,6 +1197,21 @@ bool bio_iov_iter_set(struct bio *bio, const struct iov_iter *iter)
 	return true;
 }
 
+static unsigned int bvec_nr_pages(const struct bio_vec *bv)
+{
+	return (bv->bv_offset + bv->bv_len - 1) / PAGE_SIZE -
+		bv->bv_offset / PAGE_SIZE + 1;
+}
+
+static void bvec_unpin(struct bio_vec *bv, bool mark_dirty)
+{
+	struct folio *folio = bvec_folio(bv);
+
+	if (mark_dirty)
+		folio_mark_dirty_lock(folio);
+	unpin_user_folio(folio, bvec_nr_pages(bv));
+}
+
 /*
  * Aligns the bio size to the len_align_mask, releasing excessive bio vecs that
  * __bio_iov_iter_get_pages may have inserted, and reverts the trimmed length
@@ -1206,6 +1221,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 				   struct bio_vec *bv, unsigned len_align_mask)
 {
 	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
+	unsigned int npages;
 
 	if (!nbytes)
 		return 0;
@@ -1214,14 +1230,24 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 	bio->bi_iter.bi_size -= nbytes;
 	while (nbytes >= bv->bv_len) {
 		if (bio_flagged(bio, BIO_PAGE_PINNED))
-			unpin_user_page(bv->bv_page);
+			bvec_unpin(bv, false);
 
 		if (!--bio->bi_vcnt)
 			return -EFAULT;
 		nbytes -= bv->bv_len;
 		bv--;
 	}
+
+	/*
+	 * __bio_release_pages() only unpins the pages still covered by
+	 * the trimmed bv_len. Count the pages spanned before and after
+	 * the trim and unpin the difference.
+	 */
+	npages = bvec_nr_pages(bv);
 	bv->bv_len -= nbytes;
+	npages -= bvec_nr_pages(bv);
+	if (npages && bio_flagged(bio, BIO_PAGE_PINNED))
+		unpin_user_folio(bvec_folio(bv), npages);
 	return 0;
 }
 
@@ -1503,17 +1529,6 @@ int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen,
 	return bio_iov_iter_bounce_read(bio, iter, maxlen, minsize);
 }
 
-static void bvec_unpin(struct bio_vec *bv, bool mark_dirty)
-{
-	struct folio *folio = bvec_folio(bv);
-	size_t nr_pages = (bv->bv_offset + bv->bv_len - 1) / PAGE_SIZE -
-			bv->bv_offset / PAGE_SIZE + 1;
-
-	if (mark_dirty)
-		folio_mark_dirty_lock(folio);
-	unpin_user_folio(folio, nr_pages);
-}
-
 static void bio_iov_iter_unbounce_read(struct bio *bio, bool is_error,
 		bool mark_dirty)
 {

-- 
2.39.5

