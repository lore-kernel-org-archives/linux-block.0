Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD842E407
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109145; cv=none; b=RiVMvQrLP/TKJBBLYNmVCroZ/jOIz8czlvc0FCfdVveP0dmq6cjbu/vmy4d16mdaX5nd0J4WvVwCyvVEzBMDC1J9WrT1Q8Q5d6H6Ny7cXeefrrr5RNLr7jzwdcmsNFdSHC/Hp9jvReoH7pzCkHA48Hri4p9uN9OJAgJ1d1QTK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109145; c=relaxed/simple;
	bh=CP7ven0borOj5jWhhvoyM5B2jniHvPuxsvzcdkGssSQ=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=b0vsnzyJvmaKZszhhsYbfIC3iBxbiuOlllYr4yimORkp7qr5/oceAkVyIv3qchzUvXefGu0OWo/c0pqJyeLklZy8aE1w0rHaEG85fLcuLPMsDDLnzZPqUtrGPaaTpQ0ZKtp5NTKAF32Nc+ehf8Nid4HInLWNMWBBd7txhtY9MoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OccR1Vuw; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OccR1Vuw"
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260911064531epoutp0272e8f8447a6a1aaac0ef266bf7e567e0~UMUamJBLx3113431134epoutp02P
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 06:45:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260911064531epoutp0272e8f8447a6a1aaac0ef266bf7e567e0~UMUamJBLx3113431134epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789109131;
	bh=P+llzaQn350lX1SLVgk5HtRhDecvte+vu6LLr8bCXio=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=OccR1VuwRdQkmU0pYvkQUCmmZ1hWtFK5kkiatatrd47/ruegGmKr+gVXhUeT9eB+b
	 bQmeRhCAHL1J7/YQN3UmFqJfHFwuULDCH8BlP7hNX1BLAhKc6jQAaFvpC9jlw6g6ld
	 FJMFtgWKES1tld0WyUzEjklixg1g9s4P0Ls4xHA8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20260911064531epcas2p3f6d5e28fd8fe6991e38f2044b0fb7ecb~UMUaMFHrv2830228302epcas2p31;
	Fri, 11 Sep 2026 06:45:31 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.207]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hh4mp4CMJz2SSKf; Fri, 11 Sep
	2026 06:45:30 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH 0/2] block: write streams on partitions
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From: Keoseong Park <keosung.park@samsung.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
CC: Jinyoung Choi <j-young.choi@samsung.com>, Jeuk Kim
	<jeuk20.kim@samsung.com>, Yunjae Jo <yunjae00.jo@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SSDR Gost Dev
	<gost.dev@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b@epcms2p4>
Date: Fri, 11 Sep 2026 15:45:29 +0900
X-CMS-MailID: 20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b
References: <CGME20260911064529epcms2p4791af8edd7c24d1a44b24e77c95c3f0b@epcms2p4>

bdev_max_write_streams() returns 0 for any partition, so nothing on top
of a partition can use write streams today.

A partition already gets its own view of the device: the file system
sees sectors from 0 and blk_partition_remap() turns them into disk
sectors. The first patch does the same for write streams. A partition
gets a subset of the disk's streams and exposes them as its streams 1 to
N, so a file system on a partition needs no change, and the remap
translates them to the streams reserved for that partition - two
partitions can both write with stream 1 without sharing a stream on the
device. The idea comes from an earlier patch by Christoph [1].

The second patch adds /sys/block/<disk>/<partition>/write_streams.
Writing N reserves N of the disk's streams for the partition, writing 0
gives them back, and the IDs come from a per-disk bitmap so that two
partitions never share one. The count can only be changed while the
partition is not open, the same rule as for a partition table change.
Shrinking releases only the tail, so the streams a partition keeps map to
the same device streams as before.
The feature is opt-in: unless a partition's write_streams is set,
partition I/O behaves exactly as before.

[1] https://lore.kernel.org/all/20241119121632.1225556-16-hch@lst.de/

Keoseong Park (2):
  block: allow write streams on partitions
  block: add a sysfs interface to reserve write streams for a partition

 Documentation/ABI/stable/sysfs-block |  19 ++++
 block/bdev.c                         |   1 +
 block/blk-core.c                     |  10 ++-
 block/partitions/core.c              | 128 +++++++++++++++++++++++++++
 include/linux/blk_types.h            |   3 +
 include/linux/blkdev.h               |   4 +-
 6 files changed, 163 insertions(+), 2 deletions(-)

-- 
2.43.0

