Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852D469835
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058628; cv=none; b=lCR6xmltlswnE+dXOJ+cVARsXujft++7G9zLLoH96eOFNCuU28DZ/PnY/roS3YxcEP9uQA3wLUsLje367d0nQ+vyAytbSG/cZzlh32RldF+UMmENRC7WJ5BwKgkzSshk2z39LoP4LvbdJ6onTGD8BXXFUHCAW47HqUXgvdymiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058628; c=relaxed/simple;
	bh=B8i6gdvQFIsgD5R1vtQ0UILZD/gaGnCLPh1fxGVhOjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHUtNEJJ4/Y3Cx/8RQma9zbRoNyniM9m0j9WNT++sYuPMYpdcVGDRnxdNv3yP+JfuhfF45/hCXBUsck9cqUzTSGkp+uqqhs+GqGucr4vF/kRAG9iVsRp8T+cRADaY9Ysg2P/E99EOdvc09E6GSLxiXcrcJkHAHZItT/SPR7BgPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 26f5c1109b0611f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ccb0cb3f-fb8d-49b7-b1c6-6ee489ad2ca7,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:ccb0cb3f-fb8d-49b7-b1c6-6ee489ad2ca7,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:0298928303da9aff86039721ca64e8ef,BulkI
	D:2608171614060D7QSHQU,BulkQuantity:2,SF:10|66|78|81|82|83|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 26f5c1109b0611f19a56ed5b684f684d-20260818
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 786968726; Tue, 18 Aug 2026 21:10:15 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 4/4] block, nvme: use lower-level limit helpers for namespace heads
Date: Tue, 18 Aug 2026 21:09:44 +0800
Message-Id: <20260818130944.2414676-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4d8f9b7d-339a-49c5-9670-0ddd36d7d203@oracle.com>
References: <4d8f9b7d-339a-49c5-9670-0ddd36d7d203@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

Yes, agreed. Fixed namespace properties such as logical block size should
not be updated during per-path limit reduction.

I'll fix this and send v3 shortly.

Thanks,
Yao
