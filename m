Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74153B790
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GjtstJel"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240110080452epoutp045eea182e78211adc027cc67af460bac9~o7cXEqBU30872808728epoutp04f
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 08:04:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240110080452epoutp045eea182e78211adc027cc67af460bac9~o7cXEqBU30872808728epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704873892;
	bh=S+KOiZTLHnN10pHGd+CqaU6Z6pRUaOKOMAXg1yEtMts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GjtstJelsbbzr+ol+01UR35+lsnxer8IJ5Sawy0eJZTYUNTnNyEGeBt68gU0HLuUo
	 AysYtBhh4Fp6Bm0aTSm4e3jFu/N2spkALknN/7VSAkjxrh+32qVZMejQvx4/glWYTW
	 GVWm0HSKxtDw2P+zgZCMeHoi7pNi+5M4oZ0eEJ6I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240110080452epcas5p355298cb0c47d137f466de4346c656d54~o7cW0EpYn2374723747epcas5p3c;
	Wed, 10 Jan 2024 08:04:52 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4T90hM13qyz4x9QP; Wed, 10 Jan
	2024 08:04:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	92.AD.09634.2AF4E956; Wed, 10 Jan 2024 17:04:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240110080056epcas5p3b259d175ea77f96dd6dbf6403a53f480~o7Y7FYcqi1987219872epcas5p3U;
	Wed, 10 Jan 2024 08:00:56 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240110080056epsmtrp246d91e6fb3f11ff017b760d2b7ede44f~o7Y7EuwmR1885118851epsmtrp2N;
	Wed, 10 Jan 2024 08:00:56 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-da-659e4fa2a394
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A1.F4.07368.8BE4E956; Wed, 10 Jan 2024 17:00:56 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240110080055epsmtip13891e8c317589c109673d0bb004699e4~o7Y6VWUYK1966619666epsmtip12;
	Wed, 10 Jan 2024 08:00:55 +0000 (GMT)
Date: Wed, 10 Jan 2024 13:24:29 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Message-ID: <20240110075429.4hqt2znulpnoq35h@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b09c8885-9907-4616-bf80-68ca145a1eea@nvidia.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTXXeR/7xUg5t/bCzeH3zMarH3lrbF
	/GVP2S32zfJ0YPHYvKTeo7f5HZvH501yHu0HupkCWKKybTJSE1NSixRS85LzUzLz0m2VvIPj
	neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otL
	bJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjOOXjjNXvCTr6JtdXUD4ymeLkZODgkB
	E4n7h/YydzFycQgJ7GaUWP/8OpTziVFiT+s3KOcbo8S07/MYYVqe3n3CDGILCexllHjzMhyi
	6BmjxLEpt8ESLAKqEvOO3WPpYuTgYBPQljj9nwMkLCKgJ3H11g12EJtZ4DCjxLVrGiAlwgIW
	ErN2xYOEeQXMJM7OfMkIYQtKnJz5hAXE5hSwk2hauY0NxBYVkJGYsfQr2G0SAi/ZJWZf2cgC
	cZuLxNKGOawQtrDEq+Nb2CFsKYnP7/ayQdjlEiunrGCDaG5hlJh1fRbUY/YSraf6mSGOy5C4
	POMGVFxWYuqpdUwQcT6J3t9PmCDivBI75sHYyhJr1i+AWiApce17I5TtIbF2eT87JICeM0pc
	nfmdeQKj/Cwk381Csg/CtpLo/NDECmHLSzRvnc08CxhIzALSEsv/cUCYmhLrd+kvYGRbxSiZ
	WlCcm55abFpgmJdaDo/75PzcTYzglKnluYPx7oMPeocYmTgYDzFKcDArifAqfJ6TKsSbklhZ
	lVqUH19UmpNafIjRFBhvE5mlRJPzgUk7ryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs
	1NSC1CKYPiYOTqkGpgn7z9VFXX93MC9kX/T+Px7P/tW1XG1nFrX6cuaK8VaZz/yOUpP4KsMK
	dYrOti6znNn1b8JUnn26zzW/7urYsuoCe+u3CZ8imB5z3f2mvdMqJeHBxkNXt/pMepziFWiV
	9MPx+od5vDKt+Wkl/3XlcyeET97Fq5z/4IRRqqlTRfeaRPmlW44+/s3b8Wif9j6pr2k9r6dc
	4rty+vmtQPtl9edn9T4/dNj9Q/e0oNezN4U9uHC8dAPv9wP3Vs6dsTRD5tPLIDuziVOZr6c0
	nwuJMrMR2pM/oWRT1oqvV06sk+1nPz3Z5vJvcx61oh+Puz62GG63q9zUm7zoa42czU/JA8sY
	Vpt9mbD99lQVblmxZ7frlViKMxINtZiLihMBZ6ZHryIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnO4Ov3mpBu9nClu8P/iY1WLvLW2L
	+cueslvsm+XpwOKxeUm9R2/zOzaPz5vkPNoPdDMFsERx2aSk5mSWpRbp2yVwZTzo1i3o4qlY
	NOc4SwPjD84uRk4OCQETiad3nzCD2EICuxkl3h/PgIhLSiz7e4QZwhaWWPnvOXsXIxdQzRNG
	ictd69hBEiwCqhLzjt1j6WLk4GAT0JY4/Z8DJCwioCdx9dYNsBJmgcOMEteuaYCUCAtYSMza
	FQ8S5hUwkzg78yUjxMjnjBITW66xQSQEJU7OfMIC0WsmMW/zQ2aQXmYBaYnl/zggwvISzVtn
	g53GKWAn0bRyG1irqICMxIylX5knMArNQjJpFpJJsxAmzUIyaQEjyypGydSC4tz03GTDAsO8
	1HK94sTc4tK8dL3k/NxNjODw19LYwXhv/j+9Q4xMHIyHGCU4mJVEeBU+z0kV4k1JrKxKLcqP
	LyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1OqgWndx5+Orpwc0z5M2sQknb/h
	vorH+53rDfkr73A+Pfi+5VFm9f4HpoIGujsa7FR/tDCxuip+Yr4lLHtaqJ5X/dpV6Y5pD6fm
	cSUeetM2TTpoFoO67KHtjCy8s6uY/uwVN3l8TWqvluTK73r3VFqY429dZJcw0G8t/PZ2xs7m
	Tz9v89w/Xe6U+qzK/UXS8V45mW9arj6OMb/u7I8PWvHM0aL66PX/s9f+SPi+45b8PvHCCXpK
	24Unx4Z+D2ITbyoONuL73SzXqsJ1u9V4WVo2I7PRVSbn24ctAmaae05l28DHcY1/MkNkV7/o
	Q8vtFSUTpQ9trD9s3caq01F0XKDo8hTDf0u7FCdpHdOor350RYmlOCPRUIu5qDgRAKcj2Pru
	AgAA
X-CMS-MailID: 20240110080056epcas5p3b259d175ea77f96dd6dbf6403a53f480
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----o6g3D9Kf_pEVWJfJW0DeoWolS2HAZ7gmfypTH67GyMAruP7o=_d08ce_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6
References: <20240110035756.9537-1-kch@nvidia.com>
	<CGME20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6@epcas5p3.samsung.com>
	<20240110061719.kpumbmhoipwfolcd@green245>
	<b09c8885-9907-4616-bf80-68ca145a1eea@nvidia.com>

------o6g3D9Kf_pEVWJfJW0DeoWolS2HAZ7gmfypTH67GyMAruP7o=_d08ce_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 10/01/24 07:40AM, Chaitanya Kulkarni wrote:
>On 1/9/24 22:17, Nitesh Shetty wrote:
>> On 09/01/24 07:57PM, Chaitanya Kulkarni wrote:
>>> Trigger and test nvme-pci timeout with concurrent fio jobs.
>>>
>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> ---
>>> tests/nvme/050     | 43 +++++++++++++++++++++++++++++++++++++++++++
>>> tests/nvme/050.out |  2 ++
>>> 2 files changed, 45 insertions(+)
>>> create mode 100755 tests/nvme/050
>>> create mode 100644 tests/nvme/050.out
>>>
>>> diff --git a/tests/nvme/050 b/tests/nvme/050
>>> new file mode 100755
>>> index 0000000..ba54bcd
>>> --- /dev/null
>>> +++ b/tests/nvme/050
>>> @@ -0,0 +1,43 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-3.0+
>>> +# Copyright (C) 2024 Chaitanya Kulkarni.
>>> +#
>>> +# Test NVMe-PCI timeout with FIO jobs by triggering the nvme_timeout
>>> function.
>>> +#
>>> +
>>> +. tests/nvme/rc
>>> +
>>> +DESCRIPTION="test nvme-pci timeout with fio jobs."
>>> +
>>> +requires() {
>>> +    _require_nvme_trtype pci
>>> +    _have_fio
>>> +    _nvme_requires
>>> +}
>>> +
>>> +test() {
>>> +    local dev="/dev/nvme0n1"
>>
>> Should this be TEST_DEV instead ?
>
>why ?
>
My understanding of blktests is, add device which we want to test in
config files under TEST_DEV (except null-blk and nvme-fabrics loopback
devices, which are usually populated inside the tests).
In this case, if someone do not want to disturb nvme0n1 device,
this test doesn't allow it.

Regards,
Nitesh Shetty

------o6g3D9Kf_pEVWJfJW0DeoWolS2HAZ7gmfypTH67GyMAruP7o=_d08ce_
Content-Type: text/plain; charset="utf-8"


------o6g3D9Kf_pEVWJfJW0DeoWolS2HAZ7gmfypTH67GyMAruP7o=_d08ce_--
