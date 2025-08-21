Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD32350847
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809082; cv=none; b=byx7FYg5CRKz/Zg9YsU+A2v7mEiEJGE56XY7JB0p+OAjcBOwqQJx/15w2iY9GU1MCEfOhWaHmt+rWpLDpZRMYrXKcw7Ip0+22VsZMT5q+8rE7jWlcVVK9CxMy5k2KO0bD+pdJ4LDcWL5z92Dlji09euIIdY1gHranWjni6DpIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809082; c=relaxed/simple;
	bh=QvHlQxJLoa3RiauM1XlYnSSKSxoDs4yZyOcjXPlH6rY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=prO1HY0CkstHgTL0qRndSdUa8d1e5QOVVn5uhZx4luA/ETZ4eZV9FN+ion1Pxk/pJ5D0K5QhOvTPq6/SmsocHQZpZ4enrCTTWdmhFXoEfGriKU6QP7DqBtwVx+w95TTH8b9kHThHlheR+h4vcg1iS9eT5ae7WO/ei12FrQl6yOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=q7oVnO/F; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="q7oVnO/F"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57LKUQ7e1193217
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 13:44:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=hm2agGAshuZsugLZ0p
	QzuhSejxyf1vg4VI5sjJjTHIk=; b=q7oVnO/F+6tqg0FT3m84IAsCH/DCGKGjWL
	4IKjGbhd/+gemk/3P5LALqwkF+nAmCacz2Qyo1ecWyQI5UkYHvDy/TXj7aXMUU07
	SxeNI9kNkIIgjoIclwcBzm311NuZbNV6C0jHyX293tL2Xo3BDP1Lz4usqh+9PHTF
	yMq8KZSiqWFpdb2e1cRJiqU79ng1XGx1tZSxhp85BdT1/NXO8XDvV4giYrjgfCdl
	VHYQ0tBC9ntwotXVibCy5/1DwIQH3x91Zu5LckqDdbdSIAH5EcKA/wpylspCSq1d
	/nournMjajjRzXOGWimsyNXyMpINe9TodFsN2wstGWjzJqOMKKjQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48pa5a09gv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 13:44:39 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 21 Aug 2025 20:44:36 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 99F5ADAAF46; Thu, 21 Aug 2025 13:44:21 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/2] block+nvme: reducing virtual boundary mask reliance
Date: Thu, 21 Aug 2025 13:44:18 -0700
Message-ID: <20250821204420.2267923-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: r9n3gUtPn42i2v_MJ4VAgWY2MXCP4uBt
X-Authority-Analysis: v=2.4 cv=F9UOtqhN c=1 sm=1 tr=0 ts=68a78537 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=t7V0oaV8DjCZFRwKODIA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE3NyBTYWx0ZWRfXzPC2lsphDPvB
 uTl2VVLRabgRlHU7mKHgcTV3HZK2PaeT62s3hDs4YhEMYHgvJ4eCxRNeJoncZok1LslwUArSBEH
 1y7AV/9Gqpv0Qlxs6Ab1JDQOcQtC/JzgVOPwG02sVvmVcvj7FoQ//8dSLAE5VOX2vhrb9SbQ8KC
 ccluCXJvMMGEbBquXISj3ALfOQERiEmScOK7Fl4rTAWLH+MrY2GGVLzihzk6CG3C8zI5U2wUkcI
 Wi9deUVnKaPwBmv5FbBUNFVjJJ2h5rTVZqJcY7lKx3Ahdwv1q+V9cQ/QLgLCqalx8o6CqjqKITE
 cRLrfVNmySRzLqwINhZqdJpPRnTuzpGUACZeSYbQQk5SF7vhNOFemJjxRMBGmTB1dL0XcRqfils
 57tBG7li4gUvKtwY5nY4C8S8gaNCF8sMqTvPV5rHCqlTZZPAr6ecvLuunKQ5S349D/HA+pNw
X-Proofpoint-ORIG-GUID: r9n3gUtPn42i2v_MJ4VAgWY2MXCP4uBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version is here:

  https://lore.kernel.org/linux-nvme/20250805195608.2379107-1-kbusch@meta=
.com/

This patch set depends on this unmerged series for flexible direct-io
here:

  https://lore.kernel.org/linux-block/20250819164922.640964-1-kbusch@meta=
.com/

The purpose of this is to allow optimization decisions to happen per IO.
The virtual boundary that NVMe reports provides specific guarantees
about the data alignment, but that might not be large enough for some
CPU architectures to take advantage of even iif an applications uses
aligned data buffers that could use it.

At the same time, the virtual boundary prevents the driver from directly
using memory in ways the hardware may be capable of accessing. This
creates unnecessary needs on applications to double buffer their data
into the more restrictive virtually contiguous format.

This patch series provides an efficient way to track page boundary gaps
per-IO so that the optimizations can be decided per-IO. This provides
flexibility to use all hardware to their abilities beyond what the
virtual boundary mask can provide.

Note, abuse of this capability may result in worse performance compared
to the bounce buffer solutions. Sending a bunch of tiny vectors for one
IO incurs significant protocol overhead, so while this patch set allows
you to do that, I recommend that you don't. We can't enforce a minimum
size though because vectors may straddle pages with only a few words in
the first and/or last pages, which we do need to support.

Changes from v2:

  - We only need to know about the lowest set bit in any bio vector page
    gap. Use that to avoid increasing the bio size

  - Fixed back merges; the previous was potentially missing one of the
    bio's gaps

  - Use pointers instead of relying on the inline to generate good code.

  - Trivial name changes

  - Comments explaing the new bio field, and the nvme usage for deciding
    on SGL vs PRP DMA.

Keith Busch (2):
  block: accumulate segment page gaps per bio
  nvme: remove virtual boundary for sgl capable devices

 block/bio.c               |  1 +
 block/blk-merge.c         | 39 ++++++++++++++++++++++++++++++++++++---
 block/blk-mq-dma.c        |  3 +--
 block/blk-mq.c            | 10 ++++++++++
 drivers/nvme/host/core.c  | 21 ++++++++++++++++-----
 drivers/nvme/host/pci.c   | 16 +++++++++++++---
 include/linux/blk-mq.h    |  2 ++
 include/linux/blk_types.h |  8 ++++++++
 8 files changed, 87 insertions(+), 13 deletions(-)

--=20
2.47.3

