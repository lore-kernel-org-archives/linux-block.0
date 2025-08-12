Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441D288C1A
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006863; cv=none; b=hK4dO1eybBhxJuHrUX+RGWXh+qUGZbFmVysduOneafu7EHc9FZb1oeX+CJzgiBbCZjqgEdgd8blcCppKWsZwRBFD8DMTVrNeD84Mmr9hGkRHd59AfptCV2FE29MpgbuOZuoHqbebI9JVJsi+TiPhAxSJ8948d63Kb+bSyG2b3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006863; c=relaxed/simple;
	bh=nPOO+sbd3PKv13vw4Ovol71QrBSNdGnxsJEX/eL6WeU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cj9Fpx8MY28cS1+cinphoGNxSlSwctVWq32VS2pv9HpYMVc8OvwNA86fjfd4gubGep0JvZVlDnMckleQqBmCOFjf2hfMkceQyhZkZuaCwVNf5pROyUB6f5sS/NIqEHW3FPCXXDjWRWLxjnEg6Oi+4r1ua8BvnKieT3pUJQ47XqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tgOKfAz1; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tgOKfAz1"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDno4F028298
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:54:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=xpOIwliMbime1ppBRv
	QMOHqbeP8PzhQ+O2/c/TiQxeI=; b=tgOKfAz1MkWBzaZMwhTvYbs2fDqRhvjpMR
	8yaa9zbWlpetAJ++rqasjCh4J8ds6mtJNgyJykXU/3FtvbEcnkPiNfmrjUzIAK7R
	MQnEmQvbIMuMTmKnoIhtJXBn0EIZon700eRusP65cwkOB907sSGuSaMXxHpBc+Iv
	ygWJLZK95VfalkcrJ4GgXDGRC3+q3boNvfCtQ/qOfNe0lPNVQYmOiP8RBtArta2J
	c6WOIS4ARI/RDjMyg/9RhPX2H3sG4lwYKHFL6aDc2M3TBgJhFjPlGDKZ0MQGHSpD
	0OJ2MIvLDOhPN2MtCnSm5p7eE5TO/Xc60O6RAoaoY1vS6TfV5Q+Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g0jbufud-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:54:20 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 807268D4075; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 0/8] blk dma iter for integrity metadata
Date: Tue, 12 Aug 2025 06:52:02 -0700
Message-ID: <20250812135210.4172178-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=O+w5vA9W c=1 sm=1 tr=0 ts=689b478c cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=WobvK_TCKI2ct00U_TsA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfXzIASqvYyoZUf N/m3X2Sb+g1mvuXNMYxDqCrUBujHOJM3BeHaAWvM0WKcCXGem5PpAHl3N8Ew1eIDIZj7dFHaXoF pnjY/N427DfN4F2kUxPC0PPlmRwm0RUn7FxKYM3iOj9aRfU/3gdSf5KGmp07IE1H0G10lCx79Sj
 SxTJ9FOWXH+hMTVRIdr84A0UNoOQkTKIlJpbw9yKWEwosW0SefplsuRVPSoXTh4O+zki87OxHQH lUgmEurS6ptgdSATSBUgWxHgsMEozLC7PCEHeVa7znzM+Arr6lzk+TEDkUGinr2abdCbclhxE8W NANBOFbdV/zgojYrX3C4zn1NZttyIR2cex7SUhVkKKEHGWmlkpuzYQFA3Oz62lTvDOTDMtREOeM
 opqnVYs2EvF2DFr7SS48q/S1JHfVsbtx3hXe6MVibGbXGNArKpUZsvp6PumPXV8Y74yp/eCy
X-Proofpoint-ORIG-GUID: wy4NPDyBwIlaP_jm_ADLshv72H46C4Q4
X-Proofpoint-GUID: wy4NPDyBwIlaP_jm_ADLshv72H46C4Q4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version:

  https://lore.kernel.org/linux-block/20250808155826.1864803-1-kbusch@met=
a.com/

Changes since v5, addressing review feedback from Christoph:

  - Keep the phys_vec, create a different iterator for the lower layer
    separated from the phys_vec

  - Commit log changes describing the bvec array being iterated.

  - Rename the blk_map_iter initialiation function; take a pointer
    instead of returning a copy; make it inline

  - Rename the bvec pointer being iterated to "bvecs"

  - Have bio-integrity legacy scatter-gather iteration subscribe to the
    new dma api. This required relocating some inline functions to
    header files.

  - Using 'bio_integrity()' to avoid needing "#ifdef CONFIG_" usage

  - Kernel doc for integrity dma mapping APIs

  - nvme comment explaining when we do or don't use MPTR format

  - Various nvme code cleanups

Keith Busch (8):
  blk-mq-dma: create blk_map_iter type
  blk-mq-dma: provide the bio_vec array being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add support for mapping integrity metadata
  nvme-pci: create common sgl unmapping helper
  nvme-pci: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-integrity.c         |  43 +++---
 block/blk-mq-dma.c            | 251 +++++++++++++++++++++++-----------
 block/blk-mq.h                |  26 ++++
 drivers/nvme/host/pci.c       | 213 +++++++++++++++++------------
 include/linux/blk-integrity.h |  17 +++
 include/linux/blk-mq-dma.h    |  14 +-
 include/linux/blk_types.h     |   2 -
 8 files changed, 364 insertions(+), 204 deletions(-)

--=20
2.47.3

