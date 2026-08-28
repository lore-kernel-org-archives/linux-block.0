Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E5346C836
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925039; cv=none; b=s6kA3GMd4oIavrf0XOmzE4CnkiS5cxH73loJg2om+dKP3Is9FcPGPnz0NN+faODG/n5cyBLWwdlSMCXDKIIJQxGwrkJlvbbkQJocTb6nB2l4Eb+VKdQbvdY82tOmH/URfLWkem40/TnEPVaDllkkiwqcUNJ8Dhyc4V387qQYsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925039; c=relaxed/simple;
	bh=7uQC8VotJR36OCAn8vP8AVuyOk19WhdnG7o564CLv+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paGH2VHfsvj2ywRB8+50pJPegCw9Hvm4RXNQVI0KzhMNNVIdzdm8QS0godCIpYxMaLfiNPC6IwByJ4llYQDtmztBVK4wTlcnPhSH/t56rlQyBxTgMAyUFJXNAZSeMyC5j9g/KnBY+hBfZumfGZljaH9EMg6HmMvD2+puniGmfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=m8oEO6sy; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=BENa23yS; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="m8oEO6sy";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="BENa23yS"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SCY4Uw2064720
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=yBG7
	kFfJ+sRlQ+D9LSOXUuMG2++9TcA/Tr58AwqFz9o=; b=m8oEO6syDU/lforqWQoV
	FfMK75uf5kECsQx97X3vcOFcvCeZmSi4E07VeHFNEO4OFtjWPb9hXySL1+LC5o9j
	n/aP1gJy8HSx8VfzEYPAkpdLqQEMxns2fqtMTdb5gaja5n1CoCjXPCDLfPFtvtKr
	jdKdQIkbj0lyGlOfT2VqD/gDE7Zn0JId6wfyNCGze+rM1KFGo9Jk5vcrymFOGBmb
	eDSn4bwCmGK5orr2PUsJP7PiCQD+0c2nhUv0km7gwKdNs7wEHlmNifSHlgNNMTAy
	DjahGojPPIPVRS25w5XWdMADm/HhH9jgGz5uLQFLkFBcuGDUEWB/mdjWFIlj2APU
	HA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gasdf5qxn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:36 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90c8da50f8dso21152596d6.2
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787925036; x=1788529836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBG7kFfJ+sRlQ+D9LSOXUuMG2++9TcA/Tr58AwqFz9o=;
        b=BENa23yS1MiqNzuDDuRX3HH6GJfiS1ykrbqD+eAZNLKB6hZOABgxIZK07loLFfEvVj
         RRnkgDWpIUEYgtpWcSH1lamZ4eyDa8w/hhAh+HsLqspZW/hgDEIvjdeCFKbtHS1hQRoF
         wRjwcs86wX/Q5dNslzlQrORx01VOrWEX1RnC63jA4UR9jY2K/gE8LBSk+31chTvuM0on
         qBHJPimstvBibjw44Sn8w3m7ifHSJly1aHCZWR2GIhiMc2qmGqZ6MnWTqmrPW/9HiBhL
         iRziVCMg8OX3/v66+wfqE6myP0/AMQs+X6cBjM/8zlklMhVJ2xtWOFj9zhojXEpy+p/D
         h10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925036; x=1788529836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yBG7kFfJ+sRlQ+D9LSOXUuMG2++9TcA/Tr58AwqFz9o=;
        b=GXw4TkYPE7sz5zVxHQcdaktlXrEQFUUPBkpvI8ZfMZlLSa9t1C1dz0rL3mTXbS/LLj
         QyZbWl0f7TRyXVn0M0s7E981B7q8vpItwwORhLmLV1SbaATbH1CloALPJ14Df3n2WxXo
         2bq5z2bnitomJMheFDZbndEmjxqaWljf+tWqMHr2adI1ofL4SjhzchXz4avZsjV0HBbz
         bVeSsm9zJ+yqj+7Id7oylSpsu5zVZ/ePJ8UmbaDJLZpRRoe9kKbCvq0heVatIIH+EyOB
         HnX0TN9hi1HtIyQp1NjlMjTD+xapVvCY1jTTpCDM+CBJGHlSbmlXTyBUbY8Pol1eQDNz
         gpKw==
X-Gm-Message-State: AFuF++nQciXMAGUuMTReIqhxb0VFNbv8STK/yJqQzqcWuXgp6/H1+5fd
	td6eoim+WY5NYNm+Di/oLtgSjNMwNbmUYPQagbWVmasjd/95XrKmjLmorAug2kxGzIV5t/Hx16k
	DiAqLg8zEIRNI6JIS0jGlCuEvW90djRRz8qNuGAuXQnrM6PLLvAc1UVFOKQ/p
X-Gm-Gg: AR+sD11WPXBpz78YuxG0wVQPAXwn4P6gMFQD+dc2VJtlV88h4Bjj+KoHiYHHWbksYm6
	6wgk1Vge0WvYWZrLNHZbqZbpAoa84V4q+XINUjJwTHQ/l72lZD7SixsQrX+wpBCmHWDvOqhSKHa
	UVB/IAK1Z0LMVy8bqPLUcQY4PfLuhousDdKDbSEfqXF/13oi6MPFVrxoYGsLWZYVsMDG/38wnm9
	M55csaIKx3677d7Ji2tCKrlmHiQoj9TYUHEQINckO1qDGIUH0L2P2lP5WvaMIra9LsNKTx6xPZ/
	pcVF2WBgnTWAjjY1uD89rW4Epdk/mXp/GWD1l6nDonxgqHKoSAtT3GYRjlwIxsxMTD721VX1Jqy
	bb7JNFgco
X-Received: by 2002:a05:6214:2584:b0:90c:b415:cb32 with SMTP id 6a1803df08f44-90ce0c1d3ddmr88417826d6.6.1787925035715;
        Fri, 28 Aug 2026 06:50:35 -0700 (PDT)
X-Received: by 2002:a05:6214:2584:b0:90c:b415:cb32 with SMTP id 6a1803df08f44-90ce0c1d3ddmr88417176d6.6.1787925035204;
        Fri, 28 Aug 2026 06:50:35 -0700 (PDT)
Received: from [127.0.1.1] ([45.130.83.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4534ebesm15645116d6.48.2026.08.28.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:50:33 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 28 Aug 2026 09:49:55 -0400
Subject: [PATCH v2 6/7] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-blkdev-fixes-v2-6-32f3f40cebed@columbia.edu>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
In-Reply-To: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787925005; l=2734;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=7uQC8VotJR36OCAn8vP8AVuyOk19WhdnG7o564CLv+s=;
 b=dBdBQvsT1Eg2cEiskP/UEXYohc+3xoyjw8hNuV50R2Fc+vM1s6pMZ+Qjh/H/ndLhjWk++quGn
 LMLcwhnLW1dDi2Hoe024qu4r6t1A5HEq1zLzEa8HkQGinX/x5GKMKRk
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 9KQfu3ZPP6rvXeNEqxBhe9YT_HMiuB-O
X-Proofpoint-ORIG-GUID: 9KQfu3ZPP6rvXeNEqxBhe9YT_HMiuB-O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfX/kGOGe8+jZ6D
 j+48iYuBfcTPOdvSJ4XTDDlfn8eGsB3P5MPOPRysbNZrN3sDZDtiFCfWZlnXzHxPx7wgr1TXSbh
 cdTeWnqEaP7XyCbRES57yHehzFAS6vL6NzJCWmPfdTOVqXfDfwdy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfX4TLzKs5sneNm
 G+1BLqLYsaRuSxdhsLnD5oPgtsxKWOCakhX+z6QDXiyzu/1HVrk/v/D5u+6d2NE5w22TmTLDltG
 uvmLz1rvg+T1HNalMdpZ0aKGf282Ea/+Ki/jxRTF9C8TpDc1JvbUwuWLIKe8C147saCZ7aYG+u/
 QFaHjpBLGaKZ4M6oZ/FKQnOSJLfdY4FfVNEYAUaCVDR/RYsAnae6XjK2gfSjQG1Xy5qRQgJX5QA
 Z18ve0dWngRPUY5sksvnMY3NS5qMlBQReO26doYWgVIWzMzapvzoWg2Z4rywpliwxqZJLcH7Dcq
 wg0+CsP/6mF/WejuV3xUrscNPYH9eR9YLKfrDjgdncrnjw1Fp/2F+a4cw83wBYTiF68ILRYx0Fp
 uRTRc0IMinkOl2jBo8Z73Mgl/e4v7g9ia1/i5IVXRKsxIcRshyvldACB0HplxQZNixexp0F5qIK
 +pqw3hhpXIo5jBJbwfA==
X-Authority-Analysis: v=2.4 cv=W6IIkxWk c=1 sm=1 tr=0 ts=6a91922c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xDWFIMX55ayQNp92vt0S/Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=35irZU1t4opwmMTl3MoA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11888
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=10 adultscore=0 malwarescore=0 bulkscore=10 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280119

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

Unpin all pages of a dropped bvec with unpin_user_folio(), as
__bio_release_pages() does, and unpin the pages trimmed off the last
bvec as well.

Fixes: 20a0e6276edb ("block: align the bio after building it")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 898b2f5ef8c8..48fa6b9a6dba 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1196,6 +1196,11 @@ bool bio_iov_iter_set(struct bio *bio, const struct iov_iter *iter)
 	return true;
 }
 
+static unsigned int bvec_nr_pages(const struct bio_vec *bv)
+{
+	return DIV_ROUND_UP(bv->bv_offset + bv->bv_len, PAGE_SIZE);
+}
+
 /*
  * Aligns the bio size to the len_align_mask, releasing excessive bio vecs that
  * __bio_iov_iter_get_pages may have inserted, and reverts the trimmed length
@@ -1205,6 +1210,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 				   struct bio_vec *bv, unsigned len_align_mask)
 {
 	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
+	unsigned int npages;
 
 	if (!nbytes)
 		return 0;
@@ -1213,14 +1219,24 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 	bio->bi_iter.bi_size -= nbytes;
 	while (nbytes >= bv->bv_len) {
 		if (bio_flagged(bio, BIO_PAGE_PINNED))
-			unpin_user_page(bv->bv_page);
+			unpin_user_folio(bvec_folio(bv),
+					 bvec_nr_pages(bv));
 
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
 

-- 
2.39.5

