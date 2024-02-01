Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47442134F
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792922; cv=none; b=C1jDbzk9ELl3YxkqeXWam+fbUMyhZvVI1y7nvaJasDaIv53ilRD1S9n6xkX1TUHxTDnRPQYUzv4uU9hBo/o1YADqhqEzLlzc6uuaFUFGF0IDbZbf/Ry5/GBar085xQRzyx6hvjdPnUn82N854zvlm9GZ7QZ1ErBtmhT/e6UqETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792922; c=relaxed/simple;
	bh=4+H0p9SQtNEqrCrIryOaLUlRf1MJtevuOOiBa/BoBBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=iuJYb9AgVfGIP+BSGfSdANi0J74f7LMqrS9yktrv6RUOtE/hJ33Z+kQyhV2agG3cok+LRu9TpUsiMDseBgIbqNXraG8QLi6mxyaT2N5Sg7oHggKlPtWutZhY8mV6J96KCBb/hXW09FiMl3sT4WASGIYR1ZabIR9chfyn6Qn39ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BEAW0Q9e; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BEAW0Q9e"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240201130831epoutp03809241f88b51497811b75df2787feb0f~vvxwrhLmJ3113831138epoutp03c
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 13:08:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240201130831epoutp03809241f88b51497811b75df2787feb0f~vvxwrhLmJ3113831138epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706792911;
	bh=UJSP0vaanNwikG01nXvwMCU7tRROo2e99p0nU1Uum3g=;
	h=From:To:Cc:Subject:Date:References:From;
	b=BEAW0Q9enyvuc1FFzwcqHPeqWqhrMU/9df2cBrj96E3r67xrHdIy8ZWwX7hcKYcxp
	 AAadOB+CjmSfCPOyIC2ddPy7woqcdR+5Ci3c3znL0Kwq9kUQql4SxZLMrjEgTpTDe/
	 F909cHny8lAYfZfow8oI0+AHEixx8aRVo215BDeA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240201130831epcas5p3aeb0257db71d5dffd692d1a676562770~vvxwOtfKO1587615876epcas5p3x;
	Thu,  1 Feb 2024 13:08:31 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TQfNY1hVNz4x9Pq; Thu,  1 Feb
	2024 13:08:29 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	91.4E.10009.DC79BB56; Thu,  1 Feb 2024 22:08:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240201130828epcas5p10bd98bcb6b8e9444603e347c2a910c44~vvxuIiYPU2255222552epcas5p13;
	Thu,  1 Feb 2024 13:08:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240201130828epsmtrp1a7908ec15bd3ab9d4784e44b53e7dd64~vvxuH1G-o2514325143epsmtrp1Q;
	Thu,  1 Feb 2024 13:08:28 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-db-65bb97cdd11b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1B.2C.08755.CC79BB56; Thu,  1 Feb 2024 22:08:28 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240201130825epsmtip19275d0154f5ec41decaaac9259ea2538~vvxrecTdI2208822088epsmtip1F;
	Thu,  1 Feb 2024 13:08:25 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 0/3] Block integrity with flexible-offset PI
Date: Thu,  1 Feb 2024 18:31:23 +0530
Message-Id: <20240201130126.211402-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTU/fs9N2pBl/nc1isvtvPZnHzwE4m
	i5WrjzJZHP3/ls1i0qFrjBZ7b2lbzF/2lN1i+fF/TBbrXr9nceD0OH9vI4vH5bOlHptWdbJ5
	bF5S77H7ZgObx8ent1g8+rasYvT4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
	UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
	ToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGoblNjAW7uCqOvzvI3sA4gaOLkZNDQsBE4unO
	fsYuRi4OIYHdjBLHNr5hg3A+MUpMfPoeyvnGKLHhzxRGmJY9M5cxgdhCAnuBEq0WEEWfGSWW
	PfzH3MXIwcEmoClxYXIpSI2IQJLEx77zYL3MAjUSl++eBusVFrCX2Np8nQ3EZhFQlVj1oAWs
	hlfAUuLNp8VsELvkJWZe+s4OEReUODnzCQvEHHmJ5q2zmUH2Sgh8ZZfoWvqBGaLBRWL/ofdQ
	zcISr45vYYewpSRe9rdB2ckSl2aeY4KwSyQe7zkIZdtLtJ7qB7ufGej+9bv0IXbxSfT+fsIE
	EpYQ4JXoaBOCqFaUuDfpKSuELS7xcMYSKNtDYvrR6+yQ4ImVuLv6KPMERrlZSD6YheSDWQjL
	FjAyr2KUTC0ozk1PLTYtMMpLLYdHZXJ+7iZGcKrU8trB+PDBB71DjEwcjIcYJTiYlUR4V8rt
	TBXiTUmsrEotyo8vKs1JLT7EaAoM1onMUqLJ+cBknVcSb2hiaWBiZmZmYmlsZqgkzvu6dW6K
	kEB6YklqdmpqQWoRTB8TB6dUA1PgxP7V3U8FG+dxX3n0ZWegqv0Wm/WTWPZN8L7LNXHBAZ7D
	u5+KVv46NiV6/ra4mtI1XRxpnXebkxlbZh56vebdi8POv6NVkxquOGinX1l8psZl3xFzhodL
	vq5LCJrStvB62D5tf6P0/l2/FzHKzHeMUvXYx7Kn/gnH+se/L/Mv2H5qRfcU4zLRW4GX3igo
	B03PWvDD3fB0n9DNU43xHI9Tau/NErdS/RQiPeVLFVOySNjjBBduu+p8hlna9ULLfvxtOic0
	c8EqwbMa7ws9f+5uuNBZMzM4qpr7adqmGR2MNny/s/Lqso2OdmY7Puw6trrHLiV1+6xJiQEe
	VavXNr+5FsmiUWvUXfPzzFbxY0uVWIozEg21mIuKEwEYjqx/HgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO6Z6btTDd62q1qsvtvPZnHzwE4m
	i5WrjzJZHP3/ls1i0qFrjBZ7b2lbzF/2lN1i+fF/TBbrXr9nceD0OH9vI4vH5bOlHptWdbJ5
	bF5S77H7ZgObx8ent1g8+rasYvT4vEkugCOKyyYlNSezLLVI3y6BK+PQ3CbGgl1cFcffHWRv
	YJzA0cXIySEhYCKxZ+Yypi5GLg4hgd2MEm8fnWKCSIhLNF/7wQ5hC0us/PecHaLoI6PEtt3d
	QEUcHGwCmhIXJpeC1IgIZEh0/J7BDFLDLNDAKLHu9S6wQcIC9hJbm6+zgdgsAqoSqx60MILY
	vAKWEm8+LWaDWCAvMfPSd3aIuKDEyZlPWEBsZqB489bZzBMY+WYhSc1CklrAyLSKUTK1oDg3
	PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4pLU0dzBuX/VB7xAjEwfjIUYJDmYlEd6VcjtThXhT
	EiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTB17hfSUlzsZLcj
	YKpV34Xl5nNt3FTrnLlZs3da+/6PML1cPPGqm/JJxsl/7zmUPTOyCbc8ninX+L237KRr1erm
	U5MKDI5mHFnvy1rw4f4/jo0+sZwO3xbtm/l8xSL3XVtjigUbBZM9+KJ63Hh/Zd90PS+ruvPc
	l4awxJ9tLHoCTxZvfCfdqKaXLnPExCM/InbFqw1hbDM5jJ7fkuy4PaFb5Yl2zMGispybL/8q
	zky9tvFVduVdJ/aMQwnyDx5emPQj58eTIwvc9rIUe2y91fnrr+Utp6tdB0sNtlmcTu75ssr6
	c8J5ldhfxbtjJfmiXj67H9C7IiK6eg6j3fppdg3LCnffs9ih48N5y0rtf5USS3FGoqEWc1Fx
	IgAd4DER2AIAAA==
X-CMS-MailID: 20240201130828epcas5p10bd98bcb6b8e9444603e347c2a910c44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240201130828epcas5p10bd98bcb6b8e9444603e347c2a910c44
References: <CGME20240201130828epcas5p10bd98bcb6b8e9444603e347c2a910c44@epcas5p1.samsung.com>

The block integrity subsystem can only work with PI placed in the first
bytes of the metadata buffer.

The series makes block-integrity support the flexible placement of PI.
And changes NVMe driver to make use of the new capability.

This helps to
(i) enable the more common case for NVMe (PI in last bytes is the norm)
(ii) reduce nop profile users (tried by Jens recently [1]).

/* For NS 4K+16b, 8b PI, last bytes */
Before:
# cat /sys/block/nvme0n1/integrity/format
nop

After:
# cat /sys/block/nvme0n1/integrity/format
T10-DIF-TYPE1-CRC

Changes since v1:
- Reworded commit messsage in patch 2 and 3 (hch)
- Variable initialization order change (hch)
- Collect reviewed-by

[1] https://lore.kernel.org/linux-block/20240111160226.1936351-1-axboe@kernel.dk/



Kanchan Joshi (3):
  block: refactor guard helpers
  block: support PI at non-zero offset within metadata
  nvme: allow integrity when PI is not in first bytes

 block/bio-integrity.c         |  1 +
 block/blk-integrity.c         |  1 +
 block/t10-pi.c                | 72 +++++++++++++++++++++++------------
 drivers/nvme/host/core.c      |  8 +++-
 drivers/nvme/host/nvme.h      |  1 +
 include/linux/blk-integrity.h |  1 +
 include/linux/blkdev.h        |  1 +
 7 files changed, 60 insertions(+), 25 deletions(-)

-- 
2.25.1

