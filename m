Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463221D7984
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099137; cv=none; b=gR7LuIyrrmFl9woZC0MCei0tPtbXSoDSJLDS/ddwrjnDPdcHfIYplSy59Sx/JPbKZAwfi3OOEju/sya8eYUpfN16GHbz0wwgHNB/itz3qeWRq0zcIWnEGcK7t8E54CIyM41ADY8U/rBrWO9fQYCZD4VBekOfRG2xAqghhCxSBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099137; c=relaxed/simple;
	bh=/eduy8G868qMOAcMHCox+t7fwURHyAMkacgGLKyuUTU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J/UTD8t5ilaJ9/Hm+AuxI4kgYClISE8jqarJFCZ23pmZ1r8zqpa/RCoCRkUev3ocDYX9N/25Wq4r3rTFIvtiJutIQ5VXsy+uowlgHg1ctGLAd588LRvurGfc/Ve5gIOxY4JY/Diysdfei/DDzfjUvxlgXIf6E3DSpGicDQCcIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Wb1YNZwj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Wb1YNZwj"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 57DF1ZMW032629
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:32:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=/M1d/NZN2jGF4JwLAM
	4nQoOj13sBQ+gz8kyS9mWZedY=; b=Wb1YNZwjbGmnIPHu6XXo8YbK6CPmKxEGQM
	Ube4SEWqqyT3qnji8CBuAwQiAn419oU2PyinuZV7wgH8bYvw5KuTzEr369844Rqx
	SxO7yjnHZEemjBlHgLxbBzGXGYg7n6D5zBa/oo7Wgh3IlwTgH1Fi9J+14idpwfkU
	mxfdGhVzG/0tYF0tKAGFq51itzkF/TsYqiVpAiMpUejsscooLkwCyQbOh1uM18bQ
	K8dtlhRIDZ/C6LEEocCt7moPhmI+qvP9uoexfzUuDfXRVXVlzWOEdpu+X2k4/aKK
	BsLtzQAE88NFtC6NT4YQ0bVJUoeA1o95b0i7R+aIcEpd82uu3EDw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 48gqmwte1f-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:32:12 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 3C27D97CD7C; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 0/9] blk dma iter for integrity metadata
Date: Wed, 13 Aug 2025 08:31:44 -0700
Message-ID: <20250813153153.3260897-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=BaTY0qt2 c=1 sm=1 tr=0 ts=689caffc cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=zCnT93EQd0_OxjDQTxwA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: -nCKD_qBbLEoRbWuhU84-t1f2v49znd7
X-Proofpoint-ORIG-GUID: -nCKD_qBbLEoRbWuhU84-t1f2v49znd7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX3aXjJ/HeBJ1d ElhQMXhuF3eNEihX+2p9ilrehZvQzuUvg0uuapfHfIQBZJVjrdZO5g6ssWd4lESrOVXZa32OdAj coEKFmY17AHm9wckLW6MYoNlVLODvqv+H6P4B9a+leZ6M9wxQUMl6MMLng4Q2rf3sAsZIqmAoM6
 Jjbze7ryE+URMZLosc/WeXJnxuM4iL516RMEGTZ7nSM3BshvTvXLB9zZq0/uvxnbXGxVF4iIfAM O4+2SY7WzGouG3XxiFWA3mfp+a8pceIfL5InYM7kgT5kNgXQUSH6K14ieqrNVZWm2LCRw3xdbVM 0NklyTFZsxLRryuGy3xbwT8UTKSKaASR7FalFW+naHvw7TDjra9XwsVARSSAL2XM358Y7CoBybT
 AYS2ZMLL1IvX1X41NkBM7At/FdkNxoICHL8aU74DnRNJSiNH00mIlLuijJD0o+PZvygXws3+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version:

  https://lore.kernel.org/linux-block/20250812135210.4172178-1-kbusch@met=
a.com/

Changes since v6 addressing review feeback from Christoph:

  - Moved the integrity sg conversion to its own patch

  - implemented it in blk-mq-dma.c instead of blk-integrity.c to avoid
    having to shuffling functions and common types around

  - fixed a mistake in v6 that missed using the iter_next helper
    function

  - improved changelog for the patch introducing the scatterless
    integrity mapping

  - nvme cleanups

Keith Busch (9):
  blk-mq-dma: create blk_map_iter type
  blk-mq-dma: provide the bio_vec array being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add scatter-less integrity data DMA mapping
  blk-integrity: use iterator for mapping sg
  nvme-pci: create common sgl unmapping helper
  nvme-pci: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-integrity.c         |  58 -------
 block/blk-mq-dma.c            | 278 ++++++++++++++++++++++++++--------
 drivers/nvme/host/pci.c       | 197 +++++++++++++-----------
 include/linux/blk-integrity.h |  17 +++
 include/linux/blk-mq-dma.h    |  14 +-
 include/linux/blk_types.h     |   2 -
 7 files changed, 350 insertions(+), 218 deletions(-)

--=20
2.47.3

