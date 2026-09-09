Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC145D92F
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991524; cv=none; b=ZEwhEt0UhGq95jn+Jh7IwMMiNgjEhthRohe3MqSi+2eNA1zPr/6LqvUXpEray+gmwHsTpH+AWBiUXPXb3xQgoIQziqpxmIftM+8n1uIfshSamVWJo3WNAXLihiisFGtTlqBvVyRPDscYc7vPJwxhtJ/DlIzeidTnq2hAhqn2vL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991524; c=relaxed/simple;
	bh=8sOl9Tikq+zc49svnUxUmgbqOF9i7Se4x0Ssb+suI4M=;
	h=Message-ID:In-Reply-To:References:From:Subject:To:Cc:Date:
	 MIME-Version:Content-Type; b=Ki77GFg6vkgGt3YaPNPtCZVTNFa/w5jdkMbydv45DhSSoFLYKG6VY5k1sd6ksApHl5V/vhmsVQjIiYcORdIMGU3UVOig1Ws6IjZzpDZXcyJFRiF1i0bB47VPWHeVixD8w2ykBr+URemLE/dTTS+7JYSB4b7ZiGoKaDW1xPT55Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CnrpPX7u; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=NXX0eJSf; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CnrpPX7u";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="NXX0eJSf"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689KZ0le2241465
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 18:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=T0r7
	0kRjbgwqQJBa4w0AIH8aVkNi7RMCwgx8DuykEvE=; b=CnrpPX7ucZKRFQjfW/hv
	9U8FtKoFX/ZHfYaRCinsQaSrs89pjGKVKHgUMuOVB+qlDrmYlhsYqPdqROP/9MUM
	WNptYv5MICU/f6nMToQaQHS6WpiDx44g9ufW8MM/sTldOwsopRbAPqvXOosBGGRR
	5jjWttvOxfGbkPTJJcf9sFr/JI7yxxCrO+DotXEdhjhvsbiRnL2SBRjP9sRY7RjA
	VxFEFBE5H/cVGmXrHw0YLLbZiu35sPMdcumKZ/LoNBob82FbWepZVquTXCljN4YV
	i2cqHxevnlRMoVN2IFEMUknW0jp+Zyt8Ec2JttZEKIxGfCQDF+bnkQvzwooyrPFb
	bw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcxyj35f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 18:05:21 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91037946caeso55885516d6.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788991520; x=1789596320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:cc:to
         :subject:from:references:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T0r70kRjbgwqQJBa4w0AIH8aVkNi7RMCwgx8DuykEvE=;
        b=NXX0eJSfCvmamZYXYkl4/mpieD1TOxUmoYBkqgSf95dB9DJw0JlyiNGqmtn/SDi4xD
         bZMU4ddotMCqOCU7NiifEPb59UYwzY9cMTcjn5qCMeE08znRZrasksFRNoKgGdkwFht0
         hFRB3Rk3n2dz4hM0PBb2zs+GrYpfab/XUAB5cmLoZBQt1c/w4r6IZVUx7qtrVgEZDcA6
         UbDPVz3YJhEsUeGUVh7Ezh00z+XBJwu65q2PWDeXPsNaJrApHKhvrKnn7Dg+6eZc8bpI
         /UR5gUkMtoVgceaGufPZAEYpwo3WSLgd5nKILmXvQUJto0RCu3wtWKhOKiuyPl96TLdU
         HiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991520; x=1789596320;
        h=content-transfer-encoding:content-type:mime-version:date:cc:to
         :subject:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0r70kRjbgwqQJBa4w0AIH8aVkNi7RMCwgx8DuykEvE=;
        b=SVD/UmRg893rsbmkR4KeKpbfX17ljFM8W0QcVmwZlpZ6mZVtxIFQ/KsUO942vy8bIU
         LE/MoFY6SWFPbbTTTWyiHpX+KF7YW6UP/6e2GPaE3Gp5PNELRr37rnrZbiRiBI4H2nnw
         FuyrWWLtJ//3htyXRykIYnW8zf5fJ3jyB/1zw8Xd2AvqdDTTPWTi7MYTkKM/RgtIIsUs
         9jPiY52D9oHhzyG24sIX/vThL7TY2DFiTxlDvj0DyBUen7oI4yw8RACl1IwxGKwFaH13
         h+mIx4T4MfdfDr2At7QSOg3y3lcHok543fODOM5cg1AGV2+T5Vo301RIoxWWNU8/5Oje
         jE7g==
X-Gm-Message-State: AFuF++ln8Aj+1OCMMzyhB/2/2xjEbMxfDe+BaOESDGyOT7SPMipjJJ0d
	Hotzaw9dyGTrj5NvAjiHjn4gpnEiDOnOWZ5ty1amSZ77SnAPzMjv0ftuAYiTjqTyogga2tkyuVm
	7xJfINHoWxH9ezm9DtydmkcmFciC8OeEKTqH1f9gdi/+HK/yIUePqK8srS3Uk
X-Gm-Gg: AYBFou1BxIygGycVNBdn8x5dU4hTuGtpEVEqw29bsC86kg8nvhsNiXShAghgkypZJ3J
	ewf9GIzHbQj+tod1qnjSlVsb5wiBuUQww7qgWkgrm2RN7iL3a+cQXVh5DW+OBz97cEit/rCsndw
	5KKjW6IQvqHDqOmsf0ZSa7q4rQ2mObgShoQCdqJzBzLtQX5UzGvWDXqF/cvB8uWuETRAMkenDsn
	g9fc/k45nLHl8FgoEet5qypB37YzmGHqseNFS9L1n1wch5kPIaZ236g+y7istzkCoOhiDEVBOBa
	S+ATc7ylEeoUBDnjJ9DURDSlxY1J3+TE7r6sz1GuiAubgSdB93zdvcZ9MFg3VfNU655gF/1oada
	GhM1VFDzYxkNyNtPkgQndCpPQ18AIK3XEqeadRLVYnw54biD0
X-Received: by 2002:a05:6214:2f0a:b0:90f:b8e3:78de with SMTP id 6a1803df08f44-9103ef59ea5mr535642336d6.16.1788991520045;
        Wed, 09 Sep 2026 15:05:20 -0700 (PDT)
X-Received: by 2002:a05:6214:2f0a:b0:90f:b8e3:78de with SMTP id 6a1803df08f44-9103ef59ea5mr535641566d6.16.1788991519547;
        Wed, 09 Sep 2026 15:05:19 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040693f75sm154018806d6.35.2026.09.09.15.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:05:19 -0700 (PDT)
Message-ID: <20260909-blkdev-fixes-v3-6-1a5222c6e8ad@columbia.edu>
In-Reply-To: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v3 6/7] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
Date: Wed, 09 Sep 2026 18:05:14 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=brnZl0ai c=1 sm=1 tr=0 ts=6aa1d821 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=FzqJyQ6YvfuMctRh2gUA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDI0OCBTYWx0ZWRfX/zfeI8aPRjfE
 ZWIZEGwNgBgKkaEdilI9A5IKqeBijZ4nFBuNoE2ZiRMqsYAm8vs73CDagrWTpzvQReqs3cvWx2y
 Utkpha4Ln7PS7NkyJvQVgU7VcvLyOFHJgzVoLwmff7qATOnJJ/Hl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDI0OCBTYWx0ZWRfX8JmcHhkRXBO2
 BuWkjWbeQ2RiwGAARoSlE+3xv2ykBpFPrP/WDYPR1bvfNhRTv3OY/ZOba80uWS1wVqYQutKoDXs
 BkmUfTLxiOpsoKg8watQmsLT+wgpp2cXqbKMXGEY5V3eU7qoCof7W1dBT3Mcl6xiPszzcbTOZDE
 jfMelFeioYRGYhwn8bsymccZzjaivt6Hi1Mgo2LixnBsNUYzUl1XsXzNREnQ6JKy60a+DYCUjNU
 ngucNif6rOzVvrxTLL85PFxC/e/R17QuRPDel1i3AibYvYfmSPzA8pNp6l6pp7pYEtYf1nUn2C7
 ljS4Yppn3N8HTuixOs42ZW72uPkqw5rgb0369ym2cGp+YtI1so+8C6YM5fBpu4LRowcZX9F55RR
 7onegFCLABds+hj2fWDlUbsPAlFBOFh44eh4uP3RU5zq9HxhjSGJDz02ShLJqdWdWAdNv8mG/Hv
 D3LPazYD1otuyk2jsDA==
X-Proofpoint-GUID: rkUJK681SliaQtv1kLD-aRlymXrogBzN
X-Proofpoint-ORIG-GUID: rkUJK681SliaQtv1kLD-aRlymXrogBzN
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=10
 malwarescore=0 phishscore=0 lowpriorityscore=10 bulkscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609090248

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
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 63e266d861f1..521c362ae9bf 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1196,6 +1196,21 @@ bool bio_iov_iter_set(struct bio *bio, const struct iov_iter *iter)
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
@@ -1205,6 +1220,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 				   struct bio_vec *bv, unsigned len_align_mask)
 {
 	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
+	unsigned int npages;
 
 	if (!nbytes)
 		return 0;
@@ -1213,14 +1229,23 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
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
+	 * bv_len, so drop the pins for the pages trimmed off here.
+	 */
+	npages = bvec_nr_pages(bv);
 	bv->bv_len -= nbytes;
+	npages -= bvec_nr_pages(bv);
+	if (npages && bio_flagged(bio, BIO_PAGE_PINNED))
+		unpin_user_folio(bvec_folio(bv), npages);
 	return 0;
 }
 
@@ -1503,17 +1528,6 @@ int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen,
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


