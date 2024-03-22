Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCA6F09B
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133858; cv=none; b=rNAz9J1hc9w7O0K9B526yXllx8EiyQlkwMhd11FsQZ/L2uAS4bZuC3JgxGC757fZFL7AZrmd5K9Fz8fqKXy2zsfUNftXfEILB1I2mZqXEqqGZCEbwTUtelRahTNLVWrqiZydcCKXENrxTi1tyVqSdzbAd8+ujxkZ3TKm/gTLMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133858; c=relaxed/simple;
	bh=48pCePYj4Wn+4kfxjgWMtKvFISCF5xBrRYDMznKjF0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=tQf7emDk042SOIjw6CzsacUKlvbfRo1w7SQWq0rehlJf+6DN7Di84w7ZjBCQadMSqbDVGXKPmYSvHncehF6DB0TODzdruBReqs1iIvVFhQsYyh/wvYVazGZr70CxvWCw0hXH/uFWkmwiioujNymUcA97NoB2TidB6bjF+hsKeso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ji4J6dcr; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ji4J6dcr"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240322185732epoutp03edd510def9ab86fb64d861a1f55f62fc~-Kyw7s9Hj2173321733epoutp03K
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 18:57:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240322185732epoutp03edd510def9ab86fb64d861a1f55f62fc~-Kyw7s9Hj2173321733epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711133852;
	bh=fwdrqB4Z3HAekTRf76Qr/oD9iZ1XSNsd8cRLTKNKgKE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ji4J6dcrhc0SVVtHC1f2h3aDTVskgfLo6ynr1TynlcBNCmsK1yMNyAOH9yoSo588H
	 YkSLXr7VTHuiOtbqrUpeEuEjpRIo33K2ZA7dHCMCPAtFspZlrPiP2SSaPqW4UA2ESL
	 xFPhK/+aD0chuGvRHtb/qzXmZkMYMw4RfUUxMmDg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240322185731epcas5p3fb1edd06668ad2dabb0cb84aaa2c3526~-KywBJuvO1692216922epcas5p36;
	Fri, 22 Mar 2024 18:57:31 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4V1WmB0Ppgz4x9Pq; Fri, 22 Mar
	2024 18:57:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	02.A4.09666.994DDF56; Sat, 23 Mar 2024 03:57:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240322185729epcas5p350c5054b5b519a6aa9d1b35ba3709563~-KyuWnapL3148231482epcas5p37;
	Fri, 22 Mar 2024 18:57:29 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240322185729epsmtrp12a6104559bd57c74c2ae60ced0bc2204~-KyuWCKIV0917909179epsmtrp1m;
	Fri, 22 Mar 2024 18:57:29 +0000 (GMT)
X-AuditID: b6c32a49-cefff700000025c2-36-65fdd499dad2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.32.07541.994DDF56; Sat, 23 Mar 2024 03:57:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240322185728epsmtip1a9a7508a8ebbd9148869d9d6d9263748~-Kys-qxed2074520745epsmtip1P;
	Fri, 22 Mar 2024 18:57:28 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: martin.petersen@oracle.com, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	anuj1072538@gmail.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 0/4] Read/Write with meta buffer
Date: Sat, 23 Mar 2024 00:20:19 +0530
Message-Id: <20240322185023.131697-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTU3fmlb+pBvdeWVh8/PqbxWL13X42
	i5WrjzJZvGs9x2Jx9P9bNotJh64xWuy9pW2x/Pg/JgcOj52z7rJ7XD5b6rFpVSebx+6bDWwe
	H5/eYvHo27KK0ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
	3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWl
	eel6eaklVoYGBkamQIUJ2Rnv/v1nKjggXLH10gzGBsa1/F2MnBwSAiYSu6ZNZuli5OIQEtjN
	KHH39n02kISQwCdGiS83yiDsb4wSi3pMYBref/rPCBHfyygx7WEORPNnRon9LXeBEhwcbAKa
	Ehcml4LUiAgESDz9fQ5sJrNAucSGdU0sILYw0Jz2++/B5rAIqEocevqACcTmFbCUuDO9iw1i
	l7zEzEvf2SHighInZz5hgZgjL9G8dTYzyF4JgUfsEstvb2WCaHCR2HL1NTuELSzx6vgWKFtK
	4mV/G5SdLHFp5jmo+hKJx3sOQtn2Eq2n+plB7mcGun/9Ln2IXXwSvb+fMIGEJQR4JTrahCCq
	FSXuTXrKCmGLSzycsQTK9pBoeDWBCRI8sRK3+s+xT2CUm4Xkg1lIPpiFsGwBI/MqRsnUguLc
	9NRi0wLDvNRyeEQm5+duYgQnRS3PHYx3H3zQO8TIxMF4iFGCg1lJhHfH/z+pQrwpiZVVqUX5
	8UWlOanFhxhNgcE6kVlKNDkfmJbzSuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1I
	LYLpY+LglGpgSuG6d2H+xqA/DWcSvXZt+FO7dor1Cd/Ua8dWBP2v9vTnb8yXF/4skLjd10Hi
	3II+s6fHzIK3OMvsSl1asEhbZn6MmIrQvcetjP0F0xsSvT6FHZpZIKx/0KV3uvAPhfjPv9Im
	FMlIvm0qDV2iMitpmab641+6C69mRFr/P71j8o+ct6lRjXKvQ9eyh/LUyDCYtpsGRyzq2yDX
	Zn1XWq3l5Z382MMqpZqfp+St2/d5d+SkFTU/FIUuGTRJSJ9LzfZ8NPv/qiNXp4hpv85Wunu7
	YNa9PTf1DmmmtW8rVNly8dTSLWd3nU01POp+ryKRMza8tDN6atyNv6nJlov9hM+uqrkjWvps
	+W7RYpZHjf6LlFiKMxINtZiLihMBm/vomRMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnO7MK39TDZ5PVLT4+PU3i8Xqu/1s
	FitXH2WyeNd6jsXi6P+3bBaTDl1jtNh7S9ti+fF/TA4cHjtn3WX3uHy21GPTqk42j903G9g8
	Pj69xeLRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGe/+/WcqOCBcsfXSDMYGxrX8XYycHBIC
	JhLvP/1nBLGFBHYzSmy7VQERF5dovvaDHcIWllj57zmQzQVU85FR4ue5VWxdjBwcbAKaEhcm
	l4LUiAiESCxrncAMYjMLVEv0bOxhArGFgea3338PNp9FQFXi0NMHYHFeAUuJO9O72CDmy0vM
	vPSdHSIuKHFy5hMWiDnyEs1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcZMMCw7zUcr3ixNzi
	0rx0veT83E2M4ODV0tjBeG/+P71DjEwcjIcYJTiYlUR4d/z/kyrEm5JYWZValB9fVJqTWnyI
	UZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMHp1QDU/2reZyvdn7tPtLm1NTx/Pv1k3zf+WX4
	Jn49fPqRymrtKvHC+Nf9eXpRdkeEAt9s/7wr/XVvxHfj7LWxRgf/H+Pf8bRx946ls/hV9zrp
	vtrxKFs342nx4VUd20Mf3PwXNTHj54xl01qZ2oNOzDKsafJaWs+R8ngDy8PETxf2OK9nTjr6
	4dqqt9tn7J6eGLJUzXfLbEaBlZUzllu3/Nj7aF5LV99h9fm33Ux5mCfwdXjEnrr/Juhp4esX
	RytKVr/NZFTSml8vLdLz3l7m+bZOjq4yrtWr+Wexb4qcdvPECVtX7wWFZ66cNuH4eEpg9zrb
	oiMf1mZOPnauMC2/UHl2znYz5c6Vnv3KJ6oDNJ4lMtoosRRnJBpqMRcVJwIAfSOYLs0CAAA=
X-CMS-MailID: 20240322185729epcas5p350c5054b5b519a6aa9d1b35ba3709563
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240322185729epcas5p350c5054b5b519a6aa9d1b35ba3709563
References: <CGME20240322185729epcas5p350c5054b5b519a6aa9d1b35ba3709563@epcas5p3.samsung.com>

This patchset is aimed at getting the feedback on a new io_uring
interface that userspace can use to exchange meta buffer along with
read/write.

Two new opcodes for that: IORING_OP_READ_META and IORING_OP_WRITE_META.
The leftover space in the SQE is used to send meta buffer pointer
and its length. Patch #2 for this.

The interface is supported for block direct IO. Patch #4 for this.
Other two are prep patches.

It has been tried not to touch the hot read/write path, as much as
possible. Performance for non-meta IO is same after the patches [2].
There is some code in the cold path (worker-based async)
though.

Moderately tested by modifying the fio [1] to use this interface
(only for NVMe block devices)

[1] https://github.com/OpenMPDK/fio/tree/feat/test-meta

[2]
without this:

taskset -c 2,5 t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -n2 -r4 /dev/nvme0n1 /dev/nvme1n1
submitter=1, tid=2453, file=/dev/nvme1n1, node=-1
submitter=0, tid=2452, file=/dev/nvme0n1, node=-1
polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=10.02M, BW=4.89GiB/s, IOS/call=31/31
IOPS=10.04M, BW=4.90GiB/s, IOS/call=31/31

With this:
taskset -c 2,5 t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -n2 -r4 /dev/nvme0n1 /dev/nvme1n1
submitter=1, tid=2453, file=/dev/nvme1n1, node=-1
submitter=0, tid=2452, file=/dev/nvme0n1, node=-1
polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=10.02M, BW=4.89GiB/s, IOS/call=31/31
IOPS=10.04M, BW=4.90GiB/s, IOS/call=31/31

Anuj Gupta (3):
  io_uring/rw: Get rid of flags field in struct io_rw
  io_uring/rw: support read/write with metadata
  block: modify bio_integrity_map_user to accept iov_iter as argument

Kanchan Joshi (1):
  block: add support to pass the meta buffer

 block/bio-integrity.c         |  27 ++++++---
 block/fops.c                  |   9 +++
 block/t10-pi.c                |   6 ++
 drivers/nvme/host/ioctl.c     |  11 +++-
 include/linux/bio.h           |  13 +++-
 include/linux/fs.h            |   1 +
 include/uapi/linux/io_uring.h |   6 ++
 io_uring/io_uring.c           |   2 +
 io_uring/opdef.c              |  29 +++++++++
 io_uring/rw.c                 | 108 +++++++++++++++++++++++++++++-----
 io_uring/rw.h                 |   8 +++
 11 files changed, 193 insertions(+), 27 deletions(-)


base-commit: 6f0974eccbf78baead1735722c4f1ee3eb9422cd
-- 
2.25.1

