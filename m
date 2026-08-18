Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76141397
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058552; cv=none; b=qwOmIjA9RdlcMz8piPkcKsac+1hd9inTJ+kCs6wF+sEG+mGAHjNy7psUrZV1rd3ioqVzdCv54TTyPfJcNgtJUoTaLb38ScxH0PKqUfxWJrU347YfrPHb3XyNEzC7D2U3wjQV4Brhj2yG7uw3uuAg0if97wF9j3fTtPt7ebYPnhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058552; c=relaxed/simple;
	bh=ACYXKU/Nic1yc8Z4UR9F6KI9s2qOj/VTudiQ5yqRyF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WenhYl0pZoLMknI+q1VV69dE8dsA36ZZtA5XPkcr8L2CRfP1GQyLR9fSCzmpQjQsRViFVTGd9WrZ4kqTQ6llVoS/5kJi94RrjwA/U2obq+NvPFtcHqqh7WRZOG3uQSL6dkTrI9RssomDV05pv6Ngnxp2icgd9pXXauQbCL2wnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fb5d59be9b0511f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d7d061bb-4bb4-447d-8c4f-30e6de1b515a,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:d7d061bb-4bb4-447d-8c4f-30e6de1b515a,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:de5d071f5d1758ad4f4bce3cb37d6f49,BulkI
	D:260817160545Z40WACRV,BulkQuantity:2,SF:10|66|78|81|82|83|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fb5d59be9b0511f19a56ed5b684f684d-20260818
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 851412601; Tue, 18 Aug 2026 21:09:01 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/4] block: factor block size and alignment handling out of blk_stack_limits
Date: Tue, 18 Aug 2026 21:08:48 +0800
Message-Id: <20260818130848.2408718-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <58358ff3-2c59-4ebb-bfa7-3ef22a7fb1a3@oracle.com>
References: <58358ff3-2c59-4ebb-bfa7-3ef22a7fb1a3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

The intended boundary is the mapped-range geometry: block sizes and
alignment for a top-device range starting at @start on the bottom device.
The max sector limits stay with it because they must be rounded after the
resulting logical block size is known. I'll clarify this in v3.

Thanks,
Yao
