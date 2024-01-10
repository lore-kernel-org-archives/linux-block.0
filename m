Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7290ECE
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sixSWGRM"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240110064141epoutp042d264c565f3eae33012cfe29debe7dcb~o6Tu90zk62153621536epoutp04R
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 06:41:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240110064141epoutp042d264c565f3eae33012cfe29debe7dcb~o6Tu90zk62153621536epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704868901;
	bh=9ICR0AiEO9nLmOdDowMW8WTl+ZJU0wMxGlV8a3aoEAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sixSWGRMRwaIF8dPychvx93VvDqOc6q44N9H/EPMhEDVjzbh3+MmHceV3qVY8StZq
	 6coU+s/DSYAyTVFLIc6eP8N799hDe9QJA2joEZ9BYzqxdQ/KaIZRtUEUB1GpuI5x4q
	 pPeHw5pa54F7V8Kv/CgGyN+fYbqze2WU2Hi3BKFM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240110064141epcas5p318892bf044461e2f616be03b7e492696~o6Turel001869518695epcas5p3S;
	Wed, 10 Jan 2024 06:41:41 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4T8yrN1SnXz4x9Q8; Wed, 10 Jan
	2024 06:41:40 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4E.E9.09634.42C3E956; Wed, 10 Jan 2024 15:41:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6~o6EJIlslc0192901929epcas5p3z;
	Wed, 10 Jan 2024 06:23:50 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240110062350epsmtrp22775cb1bb59578b1b8bf4e1bdedb20cf~o6EJH6oLM2777227772epsmtrp27;
	Wed, 10 Jan 2024 06:23:50 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-dc-659e3c2457e9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	CA.7D.18939.6F73E956; Wed, 10 Jan 2024 15:23:50 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240110062349epsmtip19fa2195f80deeba2404a99179ecd4c8c~o6EIV4TWk2408524085epsmtip1L;
	Wed, 10 Jan 2024 06:23:49 +0000 (GMT)
Date: Wed, 10 Jan 2024 11:47:19 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Message-ID: <20240110061719.kpumbmhoipwfolcd@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240110035756.9537-1-kch@nvidia.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTQ1fFZl6qwaRmLounV2cxWey9pW0x
	f9lTdot9szwdWDw2L6n36G1+x+bxeZOcR/uBbqYAlqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B4
	53hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygfUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
	W6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IyN29+yFZwXqni3ezNTA+N5/i5GTg4J
	AROJO/sbWLoYuTiEBHYzSszcvYkVJCEk8IlR4uiFVIgEkP3g4gF2mI6jm2YyQyR2Mkp8vfOb
	EcJ5xijxqXMiWDuLgKrExW+dTF2MHBxsAtoSp/9zgIRFBNQlph7oASthFoiTOPT7IzNIibCA
	hcSsXfEgYV4BM4nfMxewQtiCEidnPmEBsTkFjCU2Xf/GBGKLCshIzFj6lRninkvsEpOec0HY
	LhLNu2+zQtjCEq+Ob4G6WUri87u9bBB2ucTKKSvYQE6WEGhhlJh1fRYjRMJeovVUPzPEbRkS
	D9cvg2qWlZh6ah0TRJxPovf3EyaIOK/EjnkwtrLEmvULoBZISlz73ghle0isXd7PDgmfNkaJ
	k+++MU1glJ+F5LlZSPZB2FYSnR+aWGcBw4VZQFpi+T8OCFNTYv0u/QWMrKsYJVMLinPTU4tN
	CwzzUsvh8Z2cn7uJEZwatTx3MN598EHvECMTB+MhRgkOZiURXoXPc1KFeFMSK6tSi/Lji0pz
	UosPMZoCo2ois5Rocj4wOeeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPH
	xMEp1cCkeueu1P6OpEo3iUlBGncFzkv8ffhVLulb34qnDxbbtH9gMPlY/iTx64bvbzZV3dvz
	tXef0ezVhRreQTO5P//ZJHlh9d/jZ88x83l+mKoloZAby6pwjTu97KfT9egPTKvnKptaGcz8
	blIQveVYlsHBjklS0dwfXiybzu6Xc2K5h5Xj5EQn7VUTfV9elHJ7eGzqc/fcd6s1RHrrDv4t
	rdYWsZ97o3fzhgWMl5m4BRvVFivPk9GauUDQt7SgzFn4Zb73guzlqes3VHp0unWvZwqQP/CL
	q5XnmMUfMSfJ+L6P68qPT5eXCrJ41pecEnUi7YPs++9W/dnhXVeYV0xsTq6dx/fSKcetJdk3
	9mDg3QQlluKMREMt5qLiRACL1DHPFgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnO4383mpBt938lk8vTqLyWLvLW2L
	+cueslvsm+XpwOKxeUm9R2/zOzaPz5vkPNoPdDMFsERx2aSk5mSWpRbp2yVwZdx5+pS5oFGg
	ov3zHMYGxtm8XYycHBICJhJHN81k7mLk4hAS2M4ocbjvNztEQlJi2d8jzBC2sMTKf8/ZIYqe
	MErc33aOCSTBIqAqcfFbJ5DNwcEmoC1x+j8HSFhEQF1i6oEeVhCbWSBO4tDvj8wgJcICFhKz
	dsWDhHkFzCR+z1wAViIkYCTRtr+fCSIuKHFy5hMWiFYziXmbH4K1MgtISyz/BzadU8BYYtP1
	b2DlogIyEjOWfmWewCg4C0n3LCTdsxC6FzAyr2IUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQI
	DmStoB2My9b/1TvEyMTBeIhRgoNZSYRX4fOcVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yjmd
	KUIC6YklqdmpqQWpRTBZJg5OqQamHvUp9yrCbmnaCFZPVwlimf/VYBXDnFuJGaHmfc0qRU8d
	f9zuWGtyz/ewNNuknz9sNx6LX6nmHbPAU+ZhRsjewsB4B4srarPigwsk5GpFvS7v3MZzd9fN
	I4y7fToNT5XfbFEovz898uSBLftZdGOvrpj58UVRxgIeU/YL23RKWB9KT74e1qXNYHo5XbVV
	MHBl1oKOL08fbq/yM57Xt9fOP/T0hPNrip7d2H+DpSLBucxpp9kOm487uc0+Mp25tiNJpaXn
	uOEa7X2amWl+9VeqIi1j1rm3ScqIh7kWM3BNPGWbyqj6b1LE0b9nt5g98Hz6K4Ov2GrKPh23
	yVO8qr/aS3KEB5l1n0jz3f+m2FaJpTgj0VCLuag4EQDx3K150wIAAA==
X-CMS-MailID: 20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_cfae1_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6
References: <20240110035756.9537-1-kch@nvidia.com>
	<CGME20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6@epcas5p3.samsung.com>

------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_cfae1_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 09/01/24 07:57PM, Chaitanya Kulkarni wrote:
>Trigger and test nvme-pci timeout with concurrent fio jobs.
>
>Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>---
> tests/nvme/050     | 43 +++++++++++++++++++++++++++++++++++++++++++
> tests/nvme/050.out |  2 ++
> 2 files changed, 45 insertions(+)
> create mode 100755 tests/nvme/050
> create mode 100644 tests/nvme/050.out
>
>diff --git a/tests/nvme/050 b/tests/nvme/050
>new file mode 100755
>index 0000000..ba54bcd
>--- /dev/null
>+++ b/tests/nvme/050
>@@ -0,0 +1,43 @@
>+#!/bin/bash
>+# SPDX-License-Identifier: GPL-3.0+
>+# Copyright (C) 2024 Chaitanya Kulkarni.
>+#
>+# Test NVMe-PCI timeout with FIO jobs by triggering the nvme_timeout function.
>+#
>+
>+. tests/nvme/rc
>+
>+DESCRIPTION="test nvme-pci timeout with fio jobs."
>+
>+requires() {
>+	_require_nvme_trtype pci
>+	_have_fio
>+	_nvme_requires
>+}
>+
>+test() {
>+	local dev="/dev/nvme0n1"

Should this be TEST_DEV instead ?

>+
>+	echo "Running ${TEST_NAME}"
>+
>+	echo 1 > /sys/block/nvme0n1/io-timeout-fail

nvme0n1, I think this hard coding can be changed

>+
>+	echo 99 > /sys/kernel/debug/fail_io_timeout/probability
>+	echo 10 > /sys/kernel/debug/fail_io_timeout/interval
>+	echo -1 > /sys/kernel/debug/fail_io_timeout/times
>+	echo  0 > /sys/kernel/debug/fail_io_timeout/space
>+	echo  1 > /sys/kernel/debug/fail_io_timeout/verbose
>+
>+	# shellcheck disable=SC2046
>+	fio --bs=4k --rw=randread --norandommap --numjobs=$(nproc) \
>+	    --name=reads --direct=1 --filename=${dev} --group_reporting \
>+	    --time_based --runtime=1m 2>&1 | grep -q "Input/output error"
>+
>+	# shellcheck disable=SC2181
>+	if [ $? -eq 0 ]; then
>+		echo "Test complete"
>+	else
>+		echo "Test failed"
>+	fi
>+	modprobe -r nvme
>+}
>diff --git a/tests/nvme/050.out b/tests/nvme/050.out
>new file mode 100644
>index 0000000..b78b05f
>--- /dev/null
>+++ b/tests/nvme/050.out
>@@ -0,0 +1,2 @@
>+Running nvme/050
>+Test complete
>-- 
>2.40.0
>


-- Nitesh Shetty

------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_cfae1_
Content-Type: text/plain; charset="utf-8"


------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_cfae1_--
