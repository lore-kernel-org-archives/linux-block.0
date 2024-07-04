Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17613DDD3
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074167; cv=none; b=JDLEGfTWWZ/33/VxwofUdc2bKBQsDXMpX6fkuhBH66zMR6+GU3di5A/7Z3BE5rGt7uKMuulFZG6TBitYDNhwza182jEZVcGPe4sIj0izYSmem6sxyHKMwV6Gm7HjbzOR9/oSUZm6tp4HorP5RvKiisMIZG6qHkYtpsrlW/Hstqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074167; c=relaxed/simple;
	bh=V8C+KAZbYCAJY4p/ep5Y00s+pRjPXbUpgqh/GKeewkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=a0F96yn5x6nUZCHHfNE7VkUJmMCgqDKsV2TpJonQ6F6DG4crjLyoxlVS1kDc7Y7cc2PqbeN7CdfOM0IZkhJwyif/7lCtO7ItTr3EAEgJ0afrvgeLClrP3pRyhBY/BsV/lvev4oqbiADsdv0VK4RuqsrlKUU5IZkjnSAZwl3syl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fHFkhS3T; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fHFkhS3T"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240704062237epoutp01c31622d5847d870e167ad0024dde8279~e7lUdEVWP2594525945epoutp017
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 06:22:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240704062237epoutp01c31622d5847d870e167ad0024dde8279~e7lUdEVWP2594525945epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720074157;
	bh=mhbOF680FWJEIiWD5gdTlHoxn7g9RmbBa7IQLXfMrCg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fHFkhS3TQ9n/rFGUcxnFE/sjfc1SL2+TY84Ay3k/tuY+xsWchIOK+Ox2nhDsFIBa/
	 TasTGAPfFsqxRR9NcmjbmJIDCpAWzwcNOk3P/y0E4PQeqxWGI6ONyn+P4NHXCWEB6R
	 mMNMoyerRtdTMSGheMhWYtGDI1gDzurOGSIABsUo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240704062236epcas5p2750e04c60398112baa208f41d7d2f7cd~e7lUO1Bc70221102211epcas5p2u;
	Thu,  4 Jul 2024 06:22:36 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WF6566cZ3z4x9QY; Thu,  4 Jul
	2024 06:22:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F3.BC.11095.AAF36866; Thu,  4 Jul 2024 15:22:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240704062234epcas5p1dd4ae6e7c91555b9573418d618086c1e~e7lSIpzns0903009030epcas5p1G;
	Thu,  4 Jul 2024 06:22:34 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240704062234epsmtrp1dd1f2907faa2e36214f53f8ea1d89d1d~e7lSIAwpO1106011060epsmtrp1i;
	Thu,  4 Jul 2024 06:22:34 +0000 (GMT)
X-AuditID: b6c32a49-423b770000012b57-de-66863faa19dd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D9.4A.07412.AAF36866; Thu,  4 Jul 2024 15:22:34 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240704062233epsmtip151471c35b060ef89d25024062b9aaff0~e7lROzykp3084030840epsmtip1f;
	Thu,  4 Jul 2024 06:22:33 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH] block: t10-pi: Return correct ref tag when queue has no
 integrity profile
Date: Thu,  4 Jul 2024 11:45:15 +0530
Message-Id: <20240704061515.282343-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmuu4q+7Y0gwuXjS2aJvxltlh9t5/N
	YuXqo0wWe29pWyw//o/JgdXj8tlSj903G9g8Pj69xeLRt2UVo8fnTXIBrFHZNhmpiSmpRQqp
	ecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAq5UUyhJzSoFCAYnFxUr6
	djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2Rkfmx8wFWzkqbjc
	+Y6pgXEnVxcjJ4eEgInEhx0vWLsYuTiEBHYzSpy6tQXK+cQo0dryhwnC+cYoce3/BBaYloaj
	n9ghEnsZJSbd2QTlfGaUmLdtJXMXIwcHm4CmxIXJpSCmiIC1xPvX4iC9zAJOElNONjCD2MIC
	MRLnmqczgZSwCKhKfGjUAgnzClhKTL+7hRlilbzEzEvf2SHighInZz5hgRgjL9G8dTYzyFYJ
	gV3sEv/n7YG6zUVi/+GJULawxKvjW9ghbCmJl/1tUHa2xINHD6BqaiR2bO5jhbDtJRr+3GAF
	uYcZ6Pr1u/QhdvFJ9P5+AnamhACvREebEES1osS9SU+hOsUlHs5YAmV7SByYNp0NxBYSiJVY
	3NfENoFRbhaSD2Yh+WAWwrIFjMyrGCVTC4pz01OLTQsM81LL4TGZnJ+7iRGc5LQ8dzDeffBB
	7xAjEwfjIUYJDmYlEV6p981pQrwpiZVVqUX58UWlOanFhxhNgaE6kVlKNDkfmGbzSuINTSwN
	TMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgkvVO73H9/GDhjuOLgra7ndb/
	xD3zC8/BmCVL1rPVJKUyej+6pPbenuM3x87IhQwrG/ZPyo7W3K+8ISwj75tPaVbJpUTJMgEj
	kcqnKTEXvQPrwpN05ZR8pzP8TVWcnZ3KJt21kfvDtIk3ujvjK+/ufH8kLF9/ipO22RWlNd91
	uZYkTW9K+7teTXrtmcDCHx8nPd4UnVd2+s/n2Sdl33nK++6tzeRsmG0sydl8trFSdrsc43In
	9iOqTdKOn5TU3ExmuEefOSK979avE1/6T1T/t/b/Id5gUXClSWP3soevFRS2ZyxfZ6O5KG3W
	q8cad3a8mmjo5/3/+yKzfR2qZv8CNjjWm7N/6vT8mvHsRrGZEktxRqKhFnNRcSIAoyryBfsD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSnO4q+7Y0g3MbJS2aJvxltlh9t5/N
	YuXqo0wWe29pWyw//o/JgdXj8tlSj903G9g8Pj69xeLRt2UVo8fnTXIBrFFcNimpOZllqUX6
	dglcGR+bHzAVbOSpuNz5jqmBcSdXFyMnh4SAiUTD0U/sXYxcHEICuxklVs35xw6REJdovvYD
	yhaWWPnvOVTRR0aJrX/esnUxcnCwCWhKXJhcCmKKCNhL3PtRAVLOLOAicX9tJyOILSwQJdGy
	7g0TSAmLgKrEh0YtkDCvgKXE9LtbmCGmy0vMvPSdHSIuKHFy5hMWiDHyEs1bZzNPYOSbhSQ1
	C0lqASPTKkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4EDU0tjBeG/+P71DjEwcjIcY
	JTiYlUR4pd43pwnxpiRWVqUW5ccXleakFh9ilOZgURLnNZwxO0VIID2xJDU7NbUgtQgmy8TB
	KdXAdJ1nMkO4cZrmtbgNe8+umzNrW3DCR+PfkzNv1TscPL0ojDXgl4f0tPa7e0p6jpkcMDqz
	3Wx9656qHVe2fG6sffu865CUqO5JH2+W/Nl3Q753zLfXv5Fqki3yIzq9Izqj3NVWdhNDoNu3
	32Eca8+XSJc7/eCvallscuIKj+zMY2UV80OylM2vvVjy/J+GxrxMOYH/68s+m9je+hPeM8tm
	XfanGPPUJ8dmll959O7uhYuvZY/uEtcNeWS48L5mZmPkAu4J29ew52f2/wrzrLd+6iMQ4VGi
	PO/I2rU8FV3PRIwYlZf9OytSXi0heq9vj/Wh1Ra9Z03t567/2i2kW99zjtHls0rLzIOLNzy4
	yhFuosRSnJFoqMVcVJwIAJpOmyezAgAA
X-CMS-MailID: 20240704062234epcas5p1dd4ae6e7c91555b9573418d618086c1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240704062234epcas5p1dd4ae6e7c91555b9573418d618086c1e
References: <CGME20240704062234epcas5p1dd4ae6e7c91555b9573418d618086c1e@epcas5p1.samsung.com>

From: Anuj Gupta <anuj20.g@samsung.com>

Commit <c6e56cf6b2e7> (block: move integrity information into
queue_limits) changed the ref tag calculation logic. It would break if
there is no integrity profile. This in turn causes read/write failures
for such cases.

Fixes: <c6e56cf6b2e7> (block: move integrity information into queue_limits)
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/t10-pi.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index 1773610010eb..2c59fe3efcd4 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -39,8 +39,11 @@ struct t10_pi_tuple {
 
 static inline u32 t10_pi_ref_tag(struct request *rq)
 {
-	unsigned int shift = rq->q->limits.integrity.interval_exp;
+	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
+	    rq->q->limits.integrity.interval_exp)
+		shift = rq->q->limits.integrity.interval_exp;
 	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT) & 0xffffffff;
 }
 
@@ -61,8 +64,11 @@ static inline u64 lower_48_bits(u64 n)
 
 static inline u64 ext_pi_ref_tag(struct request *rq)
 {
-	unsigned int shift = rq->q->limits.integrity.interval_exp;
+	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
+	    rq->q->limits.integrity.interval_exp)
+		shift = rq->q->limits.integrity.interval_exp;
 	return lower_48_bits(blk_rq_pos(rq) >> (shift - SECTOR_SHIFT));
 }
 
-- 
2.25.1

