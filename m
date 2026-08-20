Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9AE23815B
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187372; cv=none; b=csekoBh1QmRE+qIJkjFXzYHt/byglYzwungByYPLzvyvcGpRkXoImflGPl/+4a0HQ5ivx+Js9yGuyA53LUItk40tnE2DrIdIGMqMU5Y1Z1GxY9bpjdm5/cMPmjSrZymNKV0sxkVUcK9rOxke3Lv4QPmPJvLt62RW0w2Lh/O/UBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187372; c=relaxed/simple;
	bh=1nMSuv1BdRBJ6ggoL8KNoTEoEsA8LvL0J7ybengfuTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKYidOCiLDJiURCGWYe/qepEd/Qa59JICHxnLAVb0r9kiAqeegicVQGdcyZFFf/o6IJOBMPhwMZl9MH1KlaVonvyP0PouDN1EyZ9wCzRhlPuAvX3hDuc/O4JoefJ6UXuFHhZ72IupYwKLcjT6zLre5hbkD4gMGfrGVs0jdjYZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e8626e769c3111f19a56ed5b684f684d-20260820
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_QP, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:066b6852-abf6-4c80-8ddb-455eba091a83,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:066b6852-abf6-4c80-8ddb-455eba091a83,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:55e9f2d24782c58d6ca998e0b11ac445,BulkI
	D:260819162138MN74OV5N,BulkQuantity:1,SF:10|66|78|81|82|83|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e8626e769c3111f19a56ed5b684f684d-20260820
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 538528718; Thu, 20 Aug 2026 08:55:59 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: shinichiro.kawasaki@wdc.com
Cc: dwagner@suse.de,
	linux-block@vger.kernel.org,
	sangyao@kylinos.cn
Subject: Re: [PATCH blktests] nvme/070: add multipath command effects log lifetime test
Date: Thu, 20 Aug 2026 08:55:32 +0800
Message-Id: <20260820005532.1564542-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aoVkX-G5f4WNiU8e@shinhome>
References: <aoVkX-G5f4WNiU8e@shinhome>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Shin'ichiro,=0D
=0D
Thanks for the review. I agree with the other suggestions, but I have one=0D
concern about dropping the KASAN requirement.=0D
=0D
The issue is reliably reproducible with KASAN enabled. Without KASAN,=0D
however, the test may pass even on an affected kernel and fail to catch=0D
the bug. Given this limitation, do you think it is still appropriate to=0D
remove the _have_kernel_options KASAN check?=0D
=0D
I will also update the commit message and test comments with the actual=0D
kernel fix commit once it is merged.=0D
=0D
Thanks,=0D
Yao=0D
