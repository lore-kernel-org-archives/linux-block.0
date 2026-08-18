Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2A29E10B
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058719; cv=none; b=d97AL3DUinmjmvdSgCw6uuUQWWuyqNCspHwgIBmHHB9MhAZMqvAbOyTiTBSqcZ4qwwEbpbijeFsbMPn+9HDU0aBf4LiW+cmMY1sRbCkeh2fn5ZsvqYGQRsI75woak0/hB0B9oPEN1Fm3UvnAFuqJrqVkyMLkt9s5MbEgpOEPMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058719; c=relaxed/simple;
	bh=YB3KNd43g/4Pj06HWzLuJT7aO8aYl26boOITBr2vV3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zrb253bGp+l/mAdrS/Vl/MjoDlD2N6bld+3vbZtUJFWGOzYIM5Dv8QcrrhpzkqWRgLKL0E3gLKR6SsQAVQC2hxAOrr+cTAdAWhnuet/jb5XuEDUrnqXJr7ipkeBr8pGlQc8bDp1B9jAtXaNXe6rHgqqNHB3ziuRJYiSzMvEyJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d87a0549b0611f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:1c6d31f0-0d07-4182-8da0-234d88edab82,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:1c6d31f0-0d07-4182-8da0-234d88edab82,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:548b3725e8740d8b535e6e6eaaedaff4,BulkI
	D:2608171610276YUZ4UIQ,BulkQuantity:1,SF:10|66|78|81|82|83|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5d87a0549b0611f19a56ed5b684f684d-20260818
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1345776728; Tue, 18 Aug 2026 21:11:46 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/4] block: factor out path limit stacking
Date: Tue, 18 Aug 2026 21:11:37 +0800
Message-Id: <20260818131137.2426827-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260817081017.GC21461@lst.de>
References: <20260817081017.GC21461@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

Agreed. I'll add helper macros for the min and min_not_zero patterns and
include operation limits such as max_write_zeroes_sectors in the common
path constraint helper in v3.

Thanks,
Yao
