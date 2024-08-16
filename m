Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E97623
	for <linux-block@vger.kernel.org>; Sat, 17 Aug 2024 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723856599; cv=none; b=DrxxmBo6002D2/hjMAdYF8hXEhVgQSIX4uc/XceM8+H8R6xpA11J4Q+PYxC0rKyqbJHlG9kBAKcQtUCzQfr27V4RxMdwYxlR/YBadB/t7Bim5hTxzmsJgW1PtQn0wQJTwP0e4LLFGzIQvU65o627II9MaJ2gVyQE0OAs/BbTDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723856599; c=relaxed/simple;
	bh=IFXFmEQghC3eJN79jUx1uxEElicBlcP3RqZ6Cfu+jpc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=INhWLp00mtV2EV9CICn0P1uCEec+1CUe3D+l7FTKpyY7/qc6QFzr6uvHLJItyzKJNaFWQR8r5cGByNIrQ16WCKB/FY6ClPiENCGRIkkww/PWZ0GBSanYOY5OLpCobkGn7gEfe/5C/DIoqb7Gz2q/k0e5uOTKxcHqjePOLTJvGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RIyP0tM0; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RIyP0tM0"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240817010313epoutp036dd27354769cd57e4bba5ea3a66b5f5c~sXnBV4nsz1273212732epoutp03O
	for <linux-block@vger.kernel.org>; Sat, 17 Aug 2024 01:03:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240817010313epoutp036dd27354769cd57e4bba5ea3a66b5f5c~sXnBV4nsz1273212732epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723856593;
	bh=9rCl9mz325qPs6XDSzdyjCV7S4f7Q2K75LI6maGzTwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RIyP0tM0dv0FxcpWorC/gpjhUdJePkT28CAmNHvXHveTem35xclfYrAF89BhQBcpY
	 Ta33UXR0w/42fA2ZIDKhYXZI7VWy4yay0d7fOCJ2idQpt/Cm25cr7xwFswMYGXYjWN
	 riB9WaHhe/+H3jfGeyaXWkFOHmwIvTtv2xzOPRIs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240817010312epcas5p2e471b6e7fb982a0dccfbc587cc81254f~sXnAdYRnP2868928689epcas5p2Z;
	Sat, 17 Aug 2024 01:03:12 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Wm0wH2PXRz4x9Pr; Sat, 17 Aug
	2024 01:03:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.0D.08855.FC6FFB66; Sat, 17 Aug 2024 10:03:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240816184134epcas5p3b673a0619a2e696f845ee09ab7f5a087~sSZyh0ve20030500305epcas5p37;
	Fri, 16 Aug 2024 18:41:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240816184134epsmtrp2314d0bc5f353b59f1a985708532f6709~sSZyhKTcz1006110061epsmtrp2M;
	Fri, 16 Aug 2024 18:41:34 +0000 (GMT)
X-AuditID: b6c32a44-107ff70000002297-ca-66bff6cf353f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.E4.08964.E5D9FB66; Sat, 17 Aug 2024 03:41:34 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240816184133epsmtip1a7f99a59bd4aa8dd37b15838e0e0a501~sSZxhDF963096730967epsmtip1e;
	Fri, 16 Aug 2024 18:41:33 +0000 (GMT)
Date: Sat, 17 Aug 2024 00:04:13 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, kbusch@kernel.org
Subject: Re: [PATCH v2 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
Message-ID: <20240816183129.a2uwtlkbvddg5uxm@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240815163228.216051-2-john.g.garry@oracle.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTS/f8t/1pBhP28FmsvtvPZrFy9VEm
	iwu/djBaTDp0jdFi7y1ti+XH/zE5sHlcPlvqsWlVJ5vH7psNbB4fn95i8fi8SS6ANSrbJiM1
	MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdov5JCWWJOKVAo
	ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2P+r1ts
	BY3iFesXtTA1ME4Q7mLk5JAQMJE43nqcpYuRi0NIYDejxJ7XkxkhnE+MEp0L5zCCVAkJfGOU
	mH0tCabj4owuVoj4XkaJ42+0IRo+M0psbLjLDpJgEVCV+H57GlMXIwcHm4C2xOn/HCCmiICG
	xJFD0iAVzAK5Eit3LwCrFhZIlPh2vpUNxOYVcJZY+WENI4QtKHFy5hMWEJtTwE6iZ8V9VpBV
	EgIv2SUOrX7FBHGPi8SCxesZIWxhiVfHt7BD2FISn9/tZYOwyyVWTlnBBtHcwigx6/osqAZ7
	idZT/cwgxzELZEj0/FeCCMtKTD21jgniUD6J3t9PoHbxSuyYB2MrS6xZvwBqvqTEte+NULaH
	xInW/8yQMDnKKDFp/UbGCYxys5A8NAth3SywFVYSnR+aWCHC0hLL/3FAmJoS63fpL2BkXcUo
	mVpQnJuemmxaYJiXWg6P4eT83E2M4PSo5bKD8cb8f3qHGJk4GA8xSnAwK4nwPv2yN02INyWx
	siq1KD++qDQntfgQoykwdiYyS4km5wMTdF5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp
	2ampBalFMH1MHJxSDUw3fUR31/ncYLvgmX1mi4/kn5lF39/EPJLVNfkeFpPpq+JzRst7zsQc
	Xsk5q32mf7gbJf/jT6Otaex34xs7bPkFjjb/trNeN0FBteB+6OIKiQk/J6ZV/1Nhnn9+b3/B
	lFU+arvKm7nDlh+5YNnvt9DfgnMNr3yHqmlnD+9RL+ZJfsJ+F/Q/C7zZ37v6TUb6XEb/W5N0
	eSZkdzUI3Vpu+mabY8kDsb0CMzi3ZSnNzupo+bTC5u3tvTMWLV92bS9XNMsE+bPFdgXe22zq
	FXMdDBL6T6Yy/XQSuaspGqproW/4yXDBe7VJ7dd3Mx4X114krVb0YZv7i8RpvmdZLyzce79y
	VrBP+JX5Lr3npr/7802JpTgj0VCLuag4EQBexyt1GAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSnG7c3P1pBu+WClusvtvPZrFy9VEm
	iwu/djBaTDp0jdFi7y1ti+XH/zE5sHlcPlvqsWlVJ5vH7psNbB4fn95i8fi8SS6ANYrLJiU1
	J7MstUjfLoEr4/rMXtaCzSIVT6a+ZWpgvCPQxcjJISFgInFxRhdrFyMXh5DAbkaJa3unsEIk
	JCWW/T3CDGELS6z895wdxBYS+Mgo0fnAH8RmEVCV+H57GlMXIwcHm4C2xOn/HCCmiICGxJFD
	0iAVzAK5Eit3LwDrFBZIlPh2vpUNxOYVcJZY+WENI8TEQomuN79YIeKCEidnPmGB6DWTmLf5
	ITPISGYBaYnl/zhAwpwCdhI9K+6zTmAUmIWkYxaSjlkIHQsYmVcxSqYWFOem5xYbFhjmpZbr
	FSfmFpfmpesl5+duYgSHtZbmDsbtqz7oHWJk4mA8xCjBwawkwvv0y940Id6UxMqq1KL8+KLS
	nNTiQ4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJMHJxSDUwzd3pweb3V9N6663r6khqZX1P+
	/GG3Vm+IuXNl4u88py1+x+45PdxXcmLT1+xXXrlRCiVzCxSPy202LQ+bILJhZo5A7QzhAMdt
	xy3SZ604tmqPzNbTyyZsTG/ia6gs/P2JQdu5N+bnV+3GJVV3p9vucZpr+tr2+/ETG2/lGfdu
	8rywm6/K3vRi5imbkydWqBj/E5LIszb6oJ79m99ysn5C/01Fy+ZUdm2T5waTOnz61mx0W/GT
	84aAvMnZkjcHpb8uNLjX2moS+tt7ypX497NsI3Nj9HYuOvZDN3G2cv+JO/uvnn58kO379/c7
	WUWc+5c3P3rzXjtpcXXXn5QjnEKzjsstzJNfZnM95vQ3484gJZbijERDLeai4kQA1SHxndoC
	AAA=
X-CMS-MailID: 20240816184134epcas5p3b673a0619a2e696f845ee09ab7f5a087
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----rEVyOeUC1-Pd4ykAKehEErIJv_6LE1Y2HSCt3w26tRlypI58=_7f8e3_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240816184134epcas5p3b673a0619a2e696f845ee09ab7f5a087
References: <20240815163228.216051-1-john.g.garry@oracle.com>
	<20240815163228.216051-2-john.g.garry@oracle.com>
	<CGME20240816184134epcas5p3b673a0619a2e696f845ee09ab7f5a087@epcas5p3.samsung.com>

------rEVyOeUC1-Pd4ykAKehEErIJv_6LE1Y2HSCt3w26tRlypI58=_7f8e3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 15/08/24 04:32PM, John Garry wrote:
>As reported in [0], we may get a hang when formatting a XFS FS on a RAID0
>drive.
>
>Commit 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
>changed __blkdev_issue_write_zeroes() to read the max write zeroes
>value in the loop. This is not safe as max write zeroes may change in
>value. Specifically for the case of [0], the value goes to 0, and we get
>an infinite loop.
>
>Lift the limit reading out of the loop.
>
>[0] https://lore.kernel.org/linux-xfs/4d31268f-310b-4220-88a2-e191c3932a82@oracle.com/T/#t
>
>Fixes: 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
>Reviewed-by: Christoph Hellwig <hch@lst.de>
>Signed-off-by: John Garry <john.g.garry@oracle.com>
>---
> block/blk-lib.c | 25 ++++++++++++++++++-------
> 1 file changed, 18 insertions(+), 7 deletions(-)
>
>diff --git a/block/blk-lib.c b/block/blk-lib.c
>index 9f735efa6c94..83eb7761c2bf 100644
>--- a/block/blk-lib.c
>+++ b/block/blk-lib.c
>@@ -111,13 +111,20 @@ static sector_t bio_write_zeroes_limit(struct block_device *bdev)
> 		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
> }
>
>+/*
>+ * There is no reliable way for the SCSI subsystem to determine whether a
>+ * device supports a WRITE SAME operation without actually performing a write
>+ * to media. As a result, write_zeroes is enabled by default and will be
>+ * disabled if a zeroing operation subsequently fails. This means that this
>+ * queue limit is likely to change at runtime.
>+ */
> static void __blkdev_issue_write_zeroes(struct block_device *bdev,
> 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>-		struct bio **biop, unsigned flags)
>+		struct bio **biop, unsigned flags, sector_t limit)
> {
>+
> 	while (nr_sects) {
>-		unsigned int len = min_t(sector_t, nr_sects,
>-				bio_write_zeroes_limit(bdev));
>+		unsigned int len = min(nr_sects, limit);

I feel changes something like below will simplify the whole patch.

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -115,9 +115,13 @@ static void __blkdev_issue_write_zeroes(struct block_device *bdev,
  		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
  		struct bio **biop, unsigned flags)
  {
+	sector_t limit = bio_write_zeroes_limit(bdev);
+
+	if (!limit)
+		return;
+
  	while (nr_sects) {
-		unsigned int len = min_t(sector_t, nr_sects,
-				bio_write_zeroes_limit(bdev));
+		unsigned int len = min_t(sector_t, nr_sects, limit);
  		struct bio *bio;
  
  		if ((flags & BLKDEV_ZERO_KILLABLE) &&


Otherwise, this series looks good to me.

-- Nitesh Shetty

------rEVyOeUC1-Pd4ykAKehEErIJv_6LE1Y2HSCt3w26tRlypI58=_7f8e3_
Content-Type: text/plain; charset="utf-8"


------rEVyOeUC1-Pd4ykAKehEErIJv_6LE1Y2HSCt3w26tRlypI58=_7f8e3_--
