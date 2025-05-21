Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2222FF2B
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866690; cv=none; b=D497hNH+/nBsPiPgx1ZyUSu5iIIVcvsqU4J1/J18mslzE4yrvfNLcRDoBmnA095w2NDuZOPoTybdCdjQOUT/uZzGhEMmP33G1ns4utQ9hAjXmrQ9wZegTbhTnRT02KP/WpcE0A5/IT4/O1oAgEV0J/PDIH1dRiaWvBwsbuED820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866690; c=relaxed/simple;
	bh=ub1iJxeNkjG467Cy/pX8dQOdB+J40jnCGg6iQIBhsqk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V3mPdDsitLfvQwwfYIYTQ3WVVtxx2efKRhrOWsX3f/sruuBuPXGh058rVUvktOfW+FZaLwMW7tBwd2Fv8Yzitk0uyMgzGL4tSL37EZI5EIUeIBmFuCCd7x2KVZFYOEOAN6Rp+fjY6FM4PGeGoBEmzFhMFto2Cn0f/lGgbe5MZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NcfymIOD; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NcfymIOD"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LMQWgI029158
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=4OMSpxN4Zzouf3D4Ww
	vIxwz73dA7VLEPMQUs1MZ4RTA=; b=NcfymIODh7DioT1YpX5sdW/6k+uobh3YbD
	gMdgeTma9KuzLogbGEId+VnaJASttDmzDxI0YDNkznWotjNiZBOw/jLDxXt8UN+k
	K4F3dh7+C91i8+fwxbmYC5sWbZ+QNa+gESIoeqvphqgsADLseMDQw4Atm/rikn6M
	PEBaGjVn79gRl6iPmmCTRmQHIUoi/FvVWte5yfb3EqcJclS0wmH1EBc/Z6QYzZjm
	7x1RjwyYv960FCFCqhzcbr4G7CASueP3nd0mefz4+CIRS/VIl2N5aV4pHhbTAVfo
	H6pxrtHM6J+WaJmV514l7JEgE4r98ZbSI3ap6xuZQSpGqFVEl7qg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46sd06wf38-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:27 -0700 (PDT)
Received: from twshared37834.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 21 May 2025 22:31:25 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 9D2C11BE54AC2; Wed, 21 May 2025 15:31:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/5] block: another block copy offload
Date: Wed, 21 May 2025 15:31:02 -0700
Message-ID: <20250521223107.709131-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MaBsu4/f c=1 sm=1 tr=0 ts=682e543f cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=GS0gexFe5ZxbJc13yJoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNCBTYWx0ZWRfX4KE/tb0CoFOP VgkkWlQc1IYw7w7kYziBN5kfaiLhNu04R/q4SuEBWPwD5ZG+U4QHDrpfQIRwgzxwdqf1phxK97N gNfoJ/LE9gHgUmq+DDPt1YDnfS+IYTU6SGfqyl9q74InDoW3O1iY5ChQ6YD2bF6YKighwW/NFke
 1+629lfynoQL3iGAN4m1sflTE4AqvphFmHUj61P7UINNZ2b7QoNkzG+BjxMqyK+uYmkcjeFuU5W vrh326PZ8dnKPUCvSCrxhfTclGDoEllN6a/XzStA6fFSGcJiHP7DGmkD+dChV5jU+4NVENWoGmc l1gRbTJd6MOdyvYRCmN8048UrDuIUA3Y2oaw1qM0ONQrXyUxILcFIduZMQOmA6Qnq1PFqGnHG0+
 pYt03DqWoltWQX7BouwqRZjbZ91QK17Hw89SVH2WtODGno8CiDRpofm+XW0xdC9ZlZohd3MV
X-Proofpoint-ORIG-GUID: TOzL0YvsQqd15GOn0djVfXImX9qS2--6
X-Proofpoint-GUID: TOzL0YvsQqd15GOn0djVfXImX9qS2--6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

I was never happy with previous block copy offload attempts, so I had to
take a stab at it. And I was recently asked to take a look at this, so
here goes.

Some key implementation differences from previous approaches:

  1. Only one bio is needed to describe a copy request, so no plugging
     or dispatch tricks required. Like read and write requests, these
     can be artbitrarily large and will be split as needed based on the
     request_queue's limits. The bio's are mergeable with other copy
     commands on adjacent destination sectors.

  2. You can describe as many source sectors as you want in a vector in
     a single bio. This aligns with the nvme protocol's Copy implementati=
on,
     which can be used to efficiently defragment scattered blocks into a
     contiguous destination with a single command.

Oh, and the nvme-target support was included with this patchset too, so
there's a purely in-kernel way to test out the code paths if you don't
have otherwise capable hardware. I also used qemu since that nvme device
supports copy offload too.

Keith Busch (5):
  block: new sector copy api
  block: add support for copy offload
  nvme: add support for copy offload
  block: add support for vectored copies
  nvmet: implement copy support for bdev backed target

 block/bio.c                       |  25 +++++++
 block/blk-core.c                  |   4 ++
 block/blk-lib.c                   | 115 ++++++++++++++++++++++++++++++
 block/blk-merge.c                 |  28 +++++++-
 block/blk-sysfs.c                 |   9 +++
 block/blk.h                       |  17 ++++-
 block/ioctl.c                     |  89 +++++++++++++++++++++++
 drivers/nvme/host/core.c          |  61 ++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c |  52 ++++++++++++++
 include/linux/bio.h               |  20 ++++++
 include/linux/blk-mq.h            |   5 ++
 include/linux/blk_types.h         |   2 +
 include/linux/blkdev.h            |  18 +++++
 include/linux/bvec.h              |  68 +++++++++++++++++-
 include/linux/nvme.h              |  42 ++++++++++-
 include/uapi/linux/fs.h           |  17 +++++
 16 files changed, 566 insertions(+), 6 deletions(-)

--=20
2.47.1

