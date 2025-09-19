Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578CC2EC55B
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276691; cv=none; b=qy0fPEECqvjZ5HBDbwQst9oH+RGIhP0kA68nCAgwSxH9SJkOIuFibSkxFCZ2qUiyJM0vMMUTaj3U3T+1QQGPw2DeGAel4bKXFitjhDVZMzOLL+aZSnxCOpgxQxeKDOwfrsxaQpu/7y4/aW7EGjNDZXPdrI9MBwn7ThUEwWTvAZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276691; c=relaxed/simple;
	bh=xbLMS/sclqTSmHfuOJxF8qU0K2pCP2b/ulLeTYiQ+y8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=hx8Fq9tWVu2AFgbu/emDSaE6BRvT+87/xgrvpqpnnpxTOLhwQ/Hfz0uVeA8ZqcFOnYWggH8zMWL7ypeF9Cn1aRcvUGnGWRl/N2ea5VOYW5kgImkn84h3I0aYVya9BVx1FuvvhfxByYaqM6XXoH96NcFoklsEFXsMwlSUE8oJtmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j5hhrciz; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j5hhrciz"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250919101118epoutp03b1b80ab9d3bb85ce70c48157bda0ee49~mp1LgCH3m1051510515epoutp03H
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 10:11:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250919101118epoutp03b1b80ab9d3bb85ce70c48157bda0ee49~mp1LgCH3m1051510515epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758276678;
	bh=Bkj4dcD/M7hT3lU2Es5p2AxuyQV/hchGBcyAtNe4yhE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=j5hhrcizVw19sPG0BNf00cTbk6SsXeVVm4Up6gLsHmkvsTlNuEllXMTlJWaImwwaR
	 b7vMBHPC2ZfNtVlQ83s+au/U3pzmS2ZTTjacGRWKUkM62n63V6NAfN06dyzwB/VNL+
	 0LgDHuyHtiwe8IgcwHli5GPGnaVLyZ+hi9X5NFRI=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250919101118epcas5p4cc7e36f35e81ab854656a948e2f5f823~mp1K-Wh2e2201822018epcas5p49;
	Fri, 19 Sep 2025 10:11:18 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cSpF13F2Sz6B9m6; Fri, 19 Sep
	2025 10:11:17 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250919101117epcas5p3db87ea9641b5694dc0a44a24d7b898fb~mp1Jvoe1x0305903059epcas5p37;
	Fri, 19 Sep 2025 10:11:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250919101114epsmtip102aa7a93a7137bf7f124e828d9717dc9~mp1HI8Zlq0187301873epsmtip1U;
	Fri, 19 Sep 2025 10:11:13 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
	hch@infradead.org, martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [blktests v2 0/2] io_uring PI interface test
Date: Fri, 19 Sep 2025 15:40:26 +0530
Message-Id: <20250919101028.14245-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250919101117epcas5p3db87ea9641b5694dc0a44a24d7b898fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250919101117epcas5p3db87ea9641b5694dc0a44a24d7b898fb
References: <CGME20250919101117epcas5p3db87ea9641b5694dc0a44a24d7b898fb@epcas5p3.samsung.com>

Hi all,
This series adds test for io_uring PI interface.
Patch 1 is a prep patch and moves helpers from tests/nvme/rc to
common/nvme
Patch 2 adds the test for the interface

Anuj Gupta (2):
  common/nvme: move NVMe helper checks out of tests/nvme/rc
  block: add test for io_uring Protection Information (PI) interface
    using FS_IOC_GETLBMD_CAP

 common/nvme            | 41 +++++++++++++++++++++++++
 src/.gitignore         |  1 +
 src/Makefile           |  1 +
 src/ioctl-lbmd-query.c | 65 +++++++++++++++++++++++++++++++++++++++
 tests/block/041        | 70 ++++++++++++++++++++++++++++++++++++++++++
 tests/block/041.out    |  2 ++
 tests/nvme/rc          | 41 -------------------------
 7 files changed, 180 insertions(+), 41 deletions(-)
 create mode 100644 src/ioctl-lbmd-query.c
 create mode 100755 tests/block/041
 create mode 100644 tests/block/041.out

-- 
2.25.1

