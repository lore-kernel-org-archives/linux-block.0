Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8D1624C3
	for <linux-block@vger.kernel.org>; Thu,  6 Feb 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850984; cv=none; b=Z9FGlusT/Ar6L0tPMQjuLpf/rLygPbp8XNtlaL6/m7hu5mngDR28YptbJFAebo5NioJHLz/x+G884doSWochCcDP8FE+ks4bSHMNIf9w4NpJfuu4KlmLNbVhXwR92zSpx9glxJN+ks7WBlTiH1mh1u5tHnkU2ml4xOwoHlq8aIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850984; c=relaxed/simple;
	bh=pG40YNFYPB2Sd2eT6s7SeFcu1Cw7iRiav0i7bgJvppY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 References; b=sIeJhQkYgwF0zh/5dEuA9junzkZLCA7VO6jo7lD6+Xs1hxSTxMdvGTOFCFuK43xhXZKE5z+cEKONBPonfOvnRjqjVRYWSMbsHS02nUguBcqG518Y+GLMpSHy6O3wZgCkRnzvwUgaO8d5EVXdNeMwFXsoticMGWz1Tz9znfM3zD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jySRTGGs; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jySRTGGs"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250206140934epoutp02663ddfc3e6d8534023b4eea8d58dbda1~ho7_MxDrE2363123631epoutp02b
	for <linux-block@vger.kernel.org>; Thu,  6 Feb 2025 14:09:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250206140934epoutp02663ddfc3e6d8534023b4eea8d58dbda1~ho7_MxDrE2363123631epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738850974;
	bh=bkX6YMoITlZ9JEAt2hOdiRNL8zUM/wKjbyk9IgfHscA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=jySRTGGsCFbS2VFdjmFYsaUFy7pa1y0rIiWWG4sYnjXhUYKez6bLKZ+N860TXMOrV
	 GqAZwmX40+onGbYdMVc0PYyVeIEkZRbKq1/QgCpGc3FUeguEagGAv3nR4c/Y23q1LN
	 +q0Uj2awWiYUT1hfpU3H2VQzBaKRN9VDFF/4iMMc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250206140934epcas5p1f8fa3ee835d7fd223e38e92a9d43bdbe~ho79-I9ye0515805158epcas5p1q;
	Thu,  6 Feb 2025 14:09:34 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Ypf9m1hqHz4x9Pp; Thu,  6 Feb
	2025 14:09:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	71.1F.19710.C92C4A76; Thu,  6 Feb 2025 23:09:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250206131945epcas5p23d932422bf2f172e132678b756516c0d~hoQe9iPCL0909909099epcas5p2g;
	Thu,  6 Feb 2025 13:19:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250206131945epsmtrp2484c4094ae8df20c613603cae6a11a32~hoQe85jLI0117201172epsmtrp2O;
	Thu,  6 Feb 2025 13:19:45 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-da-67a4c29c558a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	74.E1.18729.1F6B4A76; Thu,  6 Feb 2025 22:19:45 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250206131944epsmtip1330de980b19e15a0595d2d53845310ee~hoQeMv5JB2914529145epsmtip1U;
	Thu,  6 Feb 2025 13:19:44 +0000 (GMT)
Date: Thu, 6 Feb 2025 18:41:34 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, gost.dev@samsung.com,
	nitheshshetty@gmail.com
Subject: [LSF/MM/BPF TOPIC] Block IO performance per core?
Message-ID: <20250206131134.cqlq5fhem34eme2u@ubuntu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmuu6cQ0vSDT5cZ7O4eWAnk8XeW9oW
	+17vZbbY8aSR0YHFY+esu+wek28sZ/To27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8lMy8dFsl
	7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygjUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM
	/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzWX5uYCh7LVsxdPZm1gXGOZBcj
	J4eEgInE1mu/WboYuTiEBHYzSkx/3s0OkhAS+MQo8f6TAETiG6PE3ou3WWA6brXMY4dI7GWU
	+Pb9GzNExxNGiT9r1EBsFgEViZ5vB4GKODjYBLQlTv/nAAmLCKhK/F1/BGwOs0CAxKt3K5hA
	bGEBK4nL22azgdi8QPNbF/axQtiCEidnPgG7TkJgE7vE2skbmSCOcJG4N6cD6iBhiVfHt7BD
	2FISn9/tZYOwyyVWTlkBZZdIPP/TC2XbS7Se6meGOCJD4sW9R4wQcVmJqafWMUHE+SR6fz+B
	2sUrsWMejK0ssWb9Aqg5khLXvjdC2R4Sm2/fZYKEQ6xE0+yNzBMYZWch+WEWknUQtpVE54cm
	1lnAIGIWkJZY/o8DwtSUWL9LfwEj6ypGydSC4tz01GTTAsO81HJ4tCbn525iBCc7LZcdjDfm
	/9M7xMjEwXiIUYKDWUmEd8qaJelCvCmJlVWpRfnxRaU5qcWHGE2BUTKRWUo0OR+YbvNK4g1N
	LA1MzMzMTCyNzQyVxHmbd7akCwmkJ5akZqemFqQWwfQxcXBKNTCJcemHiu8PrUs0T+adY680
	4dqW+asu7FrJf+S8neHVlRfMK4Lnzn99YEWB2zwels99YlmO7fMVs+uk9HfquTDGBYSvEeeN
	uerc9ctkipxY4/PNO3SOmG1mVT/HJO1ie1n19ddoE9b61qeK6Vo1AVrX7+/v/747ZtPSGUGS
	55k8fs89UGHLNkvPNTVfpqpx7bnO2zp6B66UBbnIzX6sXvzm7CKtycc6E0qmha+0SZ96SjRF
	7vIF+f4ZubrZX5NN6pj9Azl+fFQ+5/DqWqWy2WNjY6vEl1Me6hZ+urpW8kXK3durwwQDstY6
	JBj7zdhp8qX0UvSVGSI5KSn2TPHyx/YeWnA9jLXnTLF0wI+InUosxRmJhlrMRcWJAEhJPQr/
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSnO7HbUvSDd4eULe4eWAnk8XeW9oW
	+17vZbbY8aSR0YHFY+esu+wek28sZ/To27KK0ePzJrkAligum5TUnMyy1CJ9uwSujKud59gL
	pkpXHP/cy97A+EKsi5GTQ0LAROJWyzz2LkYuDiGB3YwSJ+5uYIVISEos+3uEGcIWllj57zlU
	0SNGia6rHSwgCRYBFYmebweBEhwcbALaEqf/c4CERQRUJf6uPwJWwiwQIPHq3QomEFtYwEri
	8rbZbCA2L9Di1oV9rBC2oMTJmU+g6s0k5m1+yAwykllAWmL5P44JjHyzkFTNQlI1C6FqASPz
	KkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4HDU0tzBuH3VB71DjEwcjIcYJTiYlUR4
	p6xZki7Em5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomDU6qBqWnF
	HVGLGx3btvWebD1itFhpHfuWOZwvXTTltNZ1nmVhsv69Y8mn2OmXv/xXYw55l/ZvZX+xf7vv
	hiVRfvvYGGymZk0xPLe+/zW3J/fl4lbldnWRhobgbPWtszQvMhn4r1I2ZVAPm7vM0frez93t
	1rY2ZUpPOf8ESyy+1ZDyaJWhlNyCOXXs513ndC+8s9JixyRDC8fY7+t+XQ+JSX3r2ves7uwL
	bf7v0yrUTjve/rLuzfqJne1OjDfmLKwurl64K/yS25n1qhruuokL2JXLlBieL1RYf3nVwgUP
	18nvlVlnyBVg2fL5SPPS7HQbm4O3lTWE02z/n9tkwjfP4NmnPz13965v39UU/9Qlmz2iQ4ml
	OCPRUIu5qDgRAPfbfoO2AgAA
X-CMS-MailID: 20250206131945epcas5p23d932422bf2f172e132678b756516c0d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_338c3_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250206131945epcas5p23d932422bf2f172e132678b756516c0d
References: <CGME20250206131945epcas5p23d932422bf2f172e132678b756516c0d@epcas5p2.samsung.com>

------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_338c3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

Existing block layer stack, with single CPU and multiple NVMe devices,
we are not able to extract the maximum device advertised IOPS.
In the below example, SSD is capable of 5M IOPS (512b)[1].

a. With 1 thread/CPU, we are able to get 6.19M IOPS which can't saturate two
devices[2].
b. With 2 threads, 2 CPUs from same core, we get 6.89M IOPS[3].
c. With 2 threads, 2 CPUs from different core, we are able to saturate two
SSDs [4].

So single core will not be enough to saturate a backend with > 6.89M
IOPS. With PCIe Gen6, we might see devices capable of ~6M IOPS. And
roughly double of that with Gen7.

There have been past attempts to improve efficiency, which did not move
forward:
a. DMA pre-mapping [5]: to avoid the per I/O DMA cost
b. IO-uring attached NVMe queues[6] : to reduce the code needed to 
do the I/O and trim the kernel-config dependency.

So the discussion points are

- Should some of the above be revisited?
- Do we expect new DMA API [7] to improve the efficiency?
- It seems iov_iter[8] work may also help?
- Are there other thoughts to reduce the extra core that we take now?


Thanks,
Nitesh

[1]
Note: Obtained by disabling kernel config like blk-cgroups and
write-back throttling

sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -n1 -r3
/dev/nvme0n1
submitter=0, tid=3584444, file=/dev/nvme0n1, nfiles=1, node=-1
polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=4.99M, BW=2.44GiB/s, IOS/call=32/31
IOPS=5.02M, BW=2.45GiB/s, IOS/call=32/32
Exiting on timeout
Maximum IOPS=5.02M

[2]
sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -n1 -r3
/dev/nvme0n1 /dev/nvme1n1
submitter=0, tid=3958383, file=/dev/nvme1n1, nfiles=2, node=-1
polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=6.19M, BW=3.02GiB/s, IOS/call=32/31
IOPS=6.18M, BW=3.02GiB/s, IOS/call=32/32
Exiting on timeout
Maximum IOPS=6.19M

[3]
Note: 0,1 CPUs are mapped to same core
  sudo taskset -c 0,1 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -n2
  -r3  /dev/nvme0n1 /dev/nvme1n1
  submitter=1, tid=3708980, file=/dev/nvme1n1, nfiles=1, node=-1
  submitter=0, tid=3708979, file=/dev/nvme0n1, nfiles=1, node=-1polled=1,
  fixedbufs=1, register_files=1, buffered=0, QD=128
  Engine=io_uring, sq_ring=128, cq_ring=128
  IOPS=6.86M, BW=3.35GiB/s, IOS/call=32/31
  IOPS=6.89M, BW=3.36GiB/s, IOS/call=32/31
  Exiting on timeout
  Maximum IOPS=6.89M

[4]
Note: 0,2 CPUs are mapped to different cores
  sudo taskset -c 0,2 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -n2
  -r3 /dev/nvme0n1 /dev/nvme1n1
  submitter=0, tid=3588355, file=/dev/nvme0n1, nfiles=1, node=-1
  submitter=1, tid=3588356, file=/dev/nvme1n1, nfiles=1, node=-1polled=1,
  fixedbufs=1, register_files=1, buffered=0, QD=128
  Engine=io_uring, sq_ring=128, cq_ring=128
  IOPS=9.89M, BW=4.83GiB/s, IOS/call=31/31
  IOPS=10.00M, BW=4.88GiB/s, IOS/call=31/31
  Exiting on timeout
  Maximum IOPS=10.00M

[5] https://lore.kernel.org/all/20220805162444.3985535-1-kbusch@fb.com/
[6]
https://lore.kernel.org/linux-block/20230429093925.133327-1-joshi.k@samsung.com/
[7]
https://lore.kernel.org/linux-nvme/20250122071600.GC10702@unreal/
https://lore.kernel.org/linux-nvme/cover.1738765879.git.leonro@nvidia.com/
[8]
https://lore.kernel.org/linux-block/886959.1737148612@warthog.procyon.org.uk/

------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_338c3_
Content-Type: text/plain; charset="utf-8"


------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_338c3_--
