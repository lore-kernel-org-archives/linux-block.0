Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BB4642D
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081089; cv=none; b=Uu00VMMbo0n5jWiHothoYpk4mrbIlBRCn8FwGI/54U7zZp4v6FqpL/YiYf3dKfHImFSVDtLszP7RamxxSLSZGwM8gRnqQ4lAOXCfoIRlaxpVGz6qYm3Si2nudQ4eZmedR3QxjBxKJbApbPyCkfmkKChbkbnhXgez1+kpI6ciIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081089; c=relaxed/simple;
	bh=8UCyATdmCf4Wg3lvWtWiZgV1zL8jxHXPssxnXLwqAw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=dKOoUAILcpphQv2HAg1GJVhQg29WDeKNyvAnrBL44ckHL3NxIaghY6lZqTiMy3JDWzUQaALtbhGqi4nYSdBWU35FLFTmHZGduxv0m/S831WbPWgK8h8qRL+ejHMM/WnOGqgEj7u7Wm7mIXITT3h/Cz0+gAcLu9t7KoZ8l9qg7JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AyP/S/TD; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AyP/S/TD"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240819152444epoutp041a3787f9f97a38897c6b67916e0e5934~tKpydB-1A1924519245epoutp04x
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 15:24:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240819152444epoutp041a3787f9f97a38897c6b67916e0e5934~tKpydB-1A1924519245epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724081084;
	bh=VBSIUIS2dNnNU2iuJm2bZHuMNHTSpGTfXGsUCUAnCkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AyP/S/TDNH6C+na6yGd49fT2zghNtnp5uuYbFvKk9SgA5zYGKTa1Yknkl8PaDOMks
	 q5P1IfRmhNj4Zr3HOC9V0VTke9D2o3Bjo1h0zdJzxzsltFIzh2nZCcUBEwFAb37/o8
	 uLg+UStCcMAkAY+FVtHFSnLZ4EupFZ+nzTmR1i40=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240819152444epcas5p4bcd43c4e436a804b4bad698ce73bf989~tKpyGCBXn0281902819epcas5p48;
	Mon, 19 Aug 2024 15:24:44 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WnbxQ33lyz4x9Pq; Mon, 19 Aug
	2024 15:24:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.48.09640.AB363C66; Tue, 20 Aug 2024 00:24:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240819152304epcas5p2a721edc9c03788203f104563bb8b5a52~tKoVZOzZX0348003480epcas5p2U;
	Mon, 19 Aug 2024 15:23:04 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240819152304epsmtrp2330a89808dd4e56f646a91f326e080ef~tKoVYn_KD3274532745epsmtrp2B;
	Mon, 19 Aug 2024 15:23:04 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-52-66c363ba7503
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.B3.07567.85363C66; Tue, 20 Aug 2024 00:23:04 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240819152302epsmtip1328f45dbad889572ff037d24fe2345bf~tKoTneSCj1579315793epsmtip1p;
	Mon, 19 Aug 2024 15:23:02 +0000 (GMT)
Date: Mon, 19 Aug 2024 20:45:41 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, kbusch@kernel.org
Subject: Re: [PATCH v2 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
Message-ID: <20240819151541.7bhzx6fmoayuy6gu@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5d2f21e4-1496-4d03-9c31-cfc57fc9c8c7@oracle.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmpu6u5MNpBpOahCxW3+1ns1i5+iiT
	xYVfOxgtJh26xmix95a2xfLj/5gc2Dwuny312LSqk81j980GNo+PT2+xeHzeJBfAGpVtk5Ga
	mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
	kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnfH78GyW
	gj0yFfOv/mFtYNwq0cXIySEhYCLxcvd6FhBbSGA3o8SMgzldjFxA9idGiUuzVrJCON8YJWZf
	62WG6Vjc0sEOkdjLKHF8z0wWCOczo8Tm6f1gs1gEVCUmrt/N1sXIwcEmoC1x+j8HiCkioCFx
	5JA0SAWzQK7Eyt0L2EFsYYFEiW/nW8GqeQWcJT789wUJ8woISpyc+QRsIKeAncTDrQ+ZQTZJ
	CPxklzi7cgoTxD0uEkcn7IayhSVeHd/CDmFLSXx+t5cNwi6XWDllBRtEcwujxKzrsxghEvYS
	raf6mUEWMwtkSDS+roIIy0pMPbWOCeJOPone30+g5vNK7JgHYytLrFm/AGq+pMS1741QtofE
	idb/zJAg2cwksaiplWkCo9wsJA/NQlg3C2yFlUTnhyZWCFteonnrbGaIEmmJ5f84IExNifW7
	9Bcwsq1ilEwtKM5NTy02LTDMSy2Hx3Zyfu4mRnDa1PLcwXj3wQe9Q4xMHIyHGCU4mJVEeLtf
	HkwT4k1JrKxKLcqPLyrNSS0+xGgKjKiJzFKiyfnAxJ1XEm9oYmlgYmZmZmJpbGaoJM77unVu
	ipBAemJJanZqakFqEUwfEwenVAMT3yfH63Gz9Jfq6zLcKYuK8efZtnWZhZ+ktcfBdclBcy9O
	OBjypDWK81ij79k/fb1Gx/I3ONyNqP+vv53V4vD1hy8ce9SNDutvXS3Hu23v+9y2uTkTb+49
	3VbvLlikO2uuntKUZwV1MkKBjIHPBDdf3xHUuuKVT0B+TvMqOf/0LLkuvxnOrYdbp3dX39ui
	4XDsS5tc4P7KXxW1bWxcX27WWyoKPubiit7rLbA+kF3r1Q01BYaNlffENb9ckL1YPCd3k/vJ
	Ve3231KEliVtvevmpyGkvGn566RJd1fLqLsci0j4dujC/sjj+3wFMtpqmNk/zdXsyfx6+HYi
	U1+FLP+m6d9dhBvc+JeEcn7+mKjEUpyRaKjFXFScCAAud3EvJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnG5E8uE0g6Zd0har7/azWaxcfZTJ
	4sKvHYwWkw5dY7TYe0vbYvnxf0wObB6Xz5Z6bFrVyeax+2YDm8fHp7dYPD5vkgtgjeKySUnN
	ySxLLdK3S+DKuH51AWvBWcmKy2uPszYwPhbtYuTkkBAwkVjc0sHexcjFISSwm1HixdzT7BAJ
	SYllf48wQ9jCEiv/PQeLCwl8ZJTYddsJxGYRUJWYuH43WxcjBwebgLbE6f8cIKaIgIbEkUPS
	IBXMArkSK3cvAOsUFkiU+Ha+FayaV8BZ4sN/X4itm5kkVt9rYAWp4RUQlDg58wkLRK+ZxLzN
	D5lB6pkFpCWW/+OACMtLNG+dDXYYp4CdxMOtD5knMArOQtI9C0n3LITuWUi6FzCyrGKUTC0o
	zk3PTTYsMMxLLdcrTswtLs1L10vOz93ECI4DLY0djPfm/9M7xMjEwXiIUYKDWUmEt/vlwTQh
	3pTEyqrUovz4otKc1OJDjNIcLErivIYzZqcICaQnlqRmp6YWpBbBZJk4OKUamA7yBquGXra1
	qGc8ddLv+3OrV80Kc1epsTtX1z6bvXE782tekT55lU0Be2vmNLgennzQ4u9+VWW/PUbefyxr
	3SXTJFa+uv9M/NOqy46TF9qXTu9YL8MqoxPhdsHifOXRU5+Yg/+zZ1bucGqbsyw1dXOs/2z3
	k8XBSaotL4rXZ2hzfJ5llNnwSmNTMKOPpOG5b8cq20/xfosVZzlS+emi1BYz5dmKXC9PrX99
	sfdT+rt57IdZjy36e73/I0PyrXg7i4Os86Y8eLlz1rmyXwb2YpmhBXKL9z6Yn2+8K30H33/D
	fT4X99d1ChVcDvb18zqluGtNRojm8+nTOXz4Tr+4cypi65wv4m03JHezf1/gVqnEUpyRaKjF
	XFScCAC7ub9/8gIAAA==
X-CMS-MailID: 20240819152304epcas5p2a721edc9c03788203f104563bb8b5a52
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----TNlpQu-kfgoLB5GQfjX3R1ST3uXYbJH1t.riwqCLJ0wh797m=_b1333_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240816184134epcas5p3b673a0619a2e696f845ee09ab7f5a087
References: <20240815163228.216051-1-john.g.garry@oracle.com>
	<20240815163228.216051-2-john.g.garry@oracle.com>
	<CGME20240816184134epcas5p3b673a0619a2e696f845ee09ab7f5a087@epcas5p3.samsung.com>
	<20240816183129.a2uwtlkbvddg5uxm@nj.shetty@samsung.com>
	<5d2f21e4-1496-4d03-9c31-cfc57fc9c8c7@oracle.com>

------TNlpQu-kfgoLB5GQfjX3R1ST3uXYbJH1t.riwqCLJ0wh797m=_b1333_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 17/08/24 04:33PM, John Garry wrote:
>On 16/08/2024 19:34, Nitesh Shetty wrote:
>>On 15/08/24 04:32PM, John Garry wrote:
>>>As reported in [0], we may get a hang when formatting a XFS FS on a RAID0
>>>drive.
>>>
>>>Commit 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
>>>changed __blkdev_issue_write_zeroes() to read the max write zeroes
>>>value in the loop. This is not safe as max write zeroes may change in
>>>value. Specifically for the case of [0], the value goes to 0, and we get
>>>an infinite loop.
>>>
>>>Lift the limit reading out of the loop.
>>>
>>>[0] https://urldefense.com/v3/__https://lore.kernel.org/linux- 
>>>xfs/4d31268f-310b-4220-88a2-e191c3932a82@oracle.com/T/*t__;Iw!! 
>>>ACWV5N9M2RV99hQ! KNrgu0c216k_Y_2RLxTasjxizyhbN8eKD61JwIwDxT5OJJDamER6hw1nvf5biNMqQLaLl9PqC2qRUDdHlrGF7g$
>>>Fixes: 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
>>>Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>Signed-off-by: John Garry <john.g.garry@oracle.com>
>>>---
>>>block/blk-lib.c | 25 ++++++++++++++++++-------
>>>1 file changed, 18 insertions(+), 7 deletions(-)
>>>
>>>diff --git a/block/blk-lib.c b/block/blk-lib.c
>>>index 9f735efa6c94..83eb7761c2bf 100644
>>>--- a/block/blk-lib.c
>>>+++ b/block/blk-lib.c
>>>@@ -111,13 +111,20 @@ static sector_t 
>>>bio_write_zeroes_limit(struct block_device *bdev)
>>>        (UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
>>>}
>>>
>>>+/*
>>>+ * There is no reliable way for the SCSI subsystem to determine 
>>>whether a
>>>+ * device supports a WRITE SAME operation without actually 
>>>performing a write
>>>+ * to media. As a result, write_zeroes is enabled by default and will be
>>>+ * disabled if a zeroing operation subsequently fails. This means 
>>>that this
>>>+ * queue limit is likely to change at runtime.
>>>+ */
>>>static void __blkdev_issue_write_zeroes(struct block_device *bdev,
>>>        sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>>>-        struct bio **biop, unsigned flags)
>>>+        struct bio **biop, unsigned flags, sector_t limit)
>>>{
>>>+
>>>    while (nr_sects) {
>>>-        unsigned int len = min_t(sector_t, nr_sects,
>>>-                bio_write_zeroes_limit(bdev));
>>>+        unsigned int len = min(nr_sects, limit);
>>
>>I feel changes something like below will simplify the whole patch.
>>
>>--- a/block/blk-lib.c
>>+++ b/block/blk-lib.c
>>@@ -115,9 +115,13 @@ static void __blkdev_issue_write_zeroes(struct 
>>block_device *bdev,
>>          sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>>          struct bio **biop, unsigned flags)
>>  {
>>+    sector_t limit = bio_write_zeroes_limit(bdev);
>>+
>>+    if (!limit)
>>+        return;
>
>Just this?
>
>If yes, then __blkdev_issue_write_zeroes() does not return an error 
>code, so can we tell whether the zeroes were actually issued?
>
I failed to see this.

>Furthermore, I would rather limit points at which we call 
>bio_write_zeroes_limit()
>
>BTW, I am going on a short vacation now, so I can't quickly rework 
>this (if that was actually required).
>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------TNlpQu-kfgoLB5GQfjX3R1ST3uXYbJH1t.riwqCLJ0wh797m=_b1333_
Content-Type: text/plain; charset="utf-8"


------TNlpQu-kfgoLB5GQfjX3R1ST3uXYbJH1t.riwqCLJ0wh797m=_b1333_--
