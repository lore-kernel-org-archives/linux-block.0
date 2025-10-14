Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EA3019D0
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454315; cv=none; b=sI4qNc2HlKNXROEptbaQ/1Py0c7KYrd6/76OVMw7juCdVdrGjNwkgfBRfdh6Aw2GFABU4WxlWo7dY561veTmp4I5PApaI+RktDBqP87UmFf0Czjovl37Kxz8CaXshb7qhIR5lugxW5nEnWAclOHTcxnVI2dlBKkGAVK6dxA7yVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454315; c=relaxed/simple;
	bh=UpYas62rPORtfEY+YrvuB+eCVAONAIMVPz6Kz3WI910=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s0+deNWm/rK0maF1WlZjwXaZXg7CAV3yzOxrlHge2Y9N8e442N/zk3tkudopXsdcCUtfx5EHEUpO09x96vER6q4N6v7agMX6buoEYvbCQ+z2rWHBr+ixsWV1a0+lBIAFSdpqNrdno8gSZ6XsS1r27rUbXRY3qb3UDhu4qqIHdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gwgfMs1/; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gwgfMs1/"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59E9movL2010951
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 08:05:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=wJt9aA7Z2dipsC5sJf
	brKnoSz9SDb71SUd6mhYZTWdA=; b=gwgfMs1/uCImlrog1yCeRcx4aHJlxkAfoQ
	3IaJ8WemXj+cW+pl/DnISmc1zWGW2DMGyM/FyveZ/2s8wg/8hYfhpW1eidbh7Tie
	evcfWeXUzqwLenRk37BKtBflfYJ9w0Dy8wwt5Wio/Lm17QoKXATMOTYPe5J9tQzV
	4UZ0KE0BIhgEDhmyDl67eZzOBskP/7drO+LhmZ/Qk/8qbnjgY1nosBhrfvaWGQKU
	oEjI7fyevxDxbov53LE80LvfQ0QeTzrjdlbf31j/xDq6JkFR/KDr2AjOye+VsMvx
	l3ZWP7mOF7W7qGz9KHZrtZRIYU7iaA2gDYg5WupQ7b0uhqBwfmgQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49sm7f2032-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 08:05:12 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 14 Oct 2025 15:05:11 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4E7932B305DB; Tue, 14 Oct 2025 08:05:08 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 0/2] block, nvme: removing virtual boundary mask reliance
Date: Tue, 14 Oct 2025 08:04:54 -0700
Message-ID: <20251014150456.2219261-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDExNCBTYWx0ZWRfX8nZ18eKoZ15+
 Uvjr2IdkDb6Eko++e8bvDOMAjGRH9+ZsT5xJO56VjBIhFVduOfCZvb+qdD5FNvb9nxP7om4SzNS
 pngc4MGX+hU62hw3trfv/V+29LTJ+vo7//X4F/2EwzEhT/Ret0HyHi5mfiA22eLh8l2Kf8u2HWE
 XjuBgSxWgIiLZ1v25XA7nD3bCVLMCi3DNy9ymMhd0espIrU1Ljg/at077VWe/BIfbREX20skLXy
 ivaVnGKbGyrj5yMA+wAFnk8dNiXQOUyfJCZiiKm7lHSZG9XfRrgDj3k8/tLcFYMz7WSw/hLLShS
 WxVFzMZ1VDEi79lWAkMeX8wzEoMsvTcF+5dzW9l1kziKFxTyrT4ehvliNhZm4fEZQB+UPrQrQ5A
 S1jwkssY+Vb+ivlOcjE72E6Zfrm97Q==
X-Proofpoint-ORIG-GUID: bRnWC4Twx_3m8_eLGfQ3bk0vbN0X5qhD
X-Proofpoint-GUID: bRnWC4Twx_3m8_eLGfQ3bk0vbN0X5qhD
X-Authority-Analysis: v=2.4 cv=MMJtWcZl c=1 sm=1 tr=0 ts=68ee66a8 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=D3lQaUfW4OkPWDUkTUkA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version here:

  https://lore.kernel.org/linux-block/20251007175245.3898972-1-kbusch@met=
a.com/

The purpose is to allow optimization decisions to happen per IO, and
flexibility to utilize unaligned buffers for hardware that supports it.

The virtual boundary that NVMe uses provides specific guarantees about
the data alignment, but that might not be large enough for some CPU
architectures to take advantage of even if an applications uses aligned
data buffers that could use it.

At the same time, the virtual boundary prevents the driver from directly
using memory in ways the hardware may be capable of accessing. This
creates unnecessary needs on applications to double buffer their data
into a more restrictive virtually contiguous format.

This patch series provides an efficient way to track segment boundary
gaps per-IO so that the optimizations can be decided per-IO. This
provides flexibility to use all hardware to their abilities beyond what
the virtual boundary mask can provide.

Note, abuse of this capability may result in worse performance compared
to the bounce buffer solutions. Sending a bunch of tiny vectors for one
IO incurs significant protocol overhead, so while this patch set allows
you to do that, I recommend that you don't. We can't enforce a minimum
size though because vectors may straddle pages with only a few words in
the first and/or last pages, which we do need to support.

Changes from v4:

 * Keep the same lowest-set-bit representation in the request as the
   bio; provide a helper to turn it into a mask

 * Open-code the bvec gaps calculation since the helper is being removed

 * Additional code comments

 * Keeping the virt boundary unchanged for the loop target for now. Only
   pci, tcp, and fc are not reporting such a boundary.

Keith Busch (2):
  block: accumulate memory segment gaps per bio
  nvme: remove virtual boundary for sgl capable devices

 block/bio.c                 |  1 +
 block/blk-map.c             |  3 +++
 block/blk-merge.c           | 39 ++++++++++++++++++++++++++++++++++---
 block/blk-mq-dma.c          |  3 +--
 block/blk-mq.c              |  6 ++++++
 drivers/nvme/host/apple.c   |  1 +
 drivers/nvme/host/core.c    | 10 +++++-----
 drivers/nvme/host/fabrics.h |  6 ++++++
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/nvme.h    |  7 +++++++
 drivers/nvme/host/pci.c     | 28 +++++++++++++++++++++++---
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 drivers/nvme/target/loop.c  |  1 +
 include/linux/bio.h         |  2 ++
 include/linux/blk-mq.h      | 16 +++++++++++++++
 include/linux/blk_types.h   | 12 ++++++++++++
 17 files changed, 125 insertions(+), 13 deletions(-)

--=20
2.47.3

