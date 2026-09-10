Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996243EEAE7
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034970; cv=none; b=n9kI8p551E1sCQUroNnXN7T1pInQbUmr+bbkYEahwoBX4Jld+BSuTty3CyTk4iO3wX8gU/WYzvhZo5JMdftCujqUDQr37PadVXXkq/4CZG+YDeEjreZWeN10yOMkq7o8rhOZVF7n1tOVbxdhjoGRWfwFhXAKw9lSTBQaRJmtgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034970; c=relaxed/simple;
	bh=FDh0DW4FreAXgSlDFmbyju9lTtz4hVwzfOzm+e6qy+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VycnDduDxocPr0/Rs9K+anfkCp3A/tTWGkUDkbth2i7m/KPrrQ9gmWZUjAA0cMD8YX4LOS4LRRQXtVNvDwxVXLZYclm0WJzSJS3osg+9lh6Z2rddCxT2rI8cvlN7CmYePeKotxPO9zhrrLMeRrENFrZXOWuEHRDB9t5e7gMugAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aafcedfcacff11f19a56ed5b684f684d-20260910
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a6cd0f10-e723-4c87-8165-18430586c298,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:a6cd0f10-e723-4c87-8165-18430586c298,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:6a195ccaa05e1996a283e674f5ff424d,BulkI
	D:26083116041099FKK443,BulkQuantity:2,SF:10|66|78|81|82|83|102|127|136|850
	|865|898,TC:nil,Content:0|15|50|99,EDM:5|-100,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aafcedfcacff11f19a56ed5b684f684d-20260910
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1445208291; Thu, 10 Sep 2026 18:09:11 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: john.g.garry@oracle.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	john.garry@linux.dev,
	kbusch@kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	sangyao@kylinos.cn
Subject: Re: [PATCH v3 0/5] block, nvme: support same-LBA multipath limit stacking
Date: Thu, 10 Sep 2026 18:08:48 +0800
Message-Id: <20260910100848.1248846-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b6372900-7be4-4e6e-94ae-f816341e4c07@oracle.com>
References: <b6372900-7be4-4e6e-94ae-f816341e4c07@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi John,

Sorry for the late reply, and thanks for the review.

Initializing the head limits only once needs some care, as we still
need to refresh them after Format NVM and namespace changes.
I'm working on this and will send v4 once it's ready.

Thanks,
Yao
