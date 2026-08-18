Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5423803E1
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058937; cv=none; b=LxI6P82R2eDFWc0l/dvfPa4J8OBLrwIDequ05qsOc8l0Jlb2VBU6CXqw8dIViKg9TWFGq7g+2dkOlpsrVq5FWYsaZaRpvmxyZq86gL3oL6cgTEEjjWba/Ptt1XGSTIHkDYNl1tgtH0eDcAJpNUYanyyO0QaCxzsLb5P0D5D4eZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058937; c=relaxed/simple;
	bh=iEp19t/EtrTz951yyUHrxVufHwZDyFdlnh694G64KBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uo5UMf3zFrHaH5ZvLkREucKpJwIdjSTYUyzHuSqOQOjQikgQK4dPl1AmkmMrOYrY09vlGpFWSVXRG4o6otVv1wG91bjjXsY+ziqLrAIAblS88jvDireozr+K+7DxCAFrtnqh1JhfQMkr+v4OJEz07bkfx20pK1TSmBO/25GXVdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e0a454329b0611f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f21e0a2f-297d-450d-9afe-4a3cf08adcef,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:f21e0a2f-297d-450d-9afe-4a3cf08adcef,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:0f5adf245986fb97d2b323c6bccaaeac,BulkI
	D:2608171614060D7QSHQU,BulkQuantity:3,SF:10|66|78|81|82|83|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e0a454329b0611f19a56ed5b684f684d-20260818
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 920006891; Tue, 18 Aug 2026 21:15:26 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 4/4] block, nvme: use lower-level limit helpers for namespace heads
Date: Tue, 18 Aug 2026 21:14:59 +0800
Message-Id: <20260818131459.2448720-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260817081355.GD21461@lst.de>
References: <20260817081355.GD21461@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

Agreed. I'll factor this into a block-layer helper in v3 so it can be
reused by NVMe and SCSI multipath.

Thanks,
Yao
