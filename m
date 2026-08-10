Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0726537DAAD
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351852; cv=none; b=KB4UdcCKU24Bw8/tmKlqe0Kr58d5KlTn9K7CCaLP3kXBwMC0ui2gg0+S9KpXIGJeqB73U2N9dqBqWg+dIGaiSHLctyDS9qijDTzKbXk3boB8VwFVSw+ftiyCHb48vt60JvwTvUkGRm4JYwREVzYNFW/dOF5ZhBa1aVKt/BgHmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351852; c=relaxed/simple;
	bh=2zz/YDBfBE60MeZURe4eH+xwS1quBTlzpy3Mkms+m2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZARbznk0Wc4SK8T5KZqINugD1rRbqLJPnnkwAODxhI8sFUH6IFHnlwuQmCzNJ8DafUypq9co6E2qdpAMROXWxgujWptc1JqipqOm6MFKxwZHwhlWqLM7HuUhsnOs8T7jxkBDAt1YIyt68iPyJxygI2oL9IZDsTl0WDe3iOcKl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 90983856949811f1aa26b74ffac11d73-20260810
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_QP, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_AS_FROM, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0cec714a-a86c-4433-b80e-104d1a6400b3,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:0cec714a-a86c-4433-b80e-104d1a6400b3,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:47048db6355b9a3cdbee5087e94c61eb,BulkI
	D:260810164140PAAK7HM7,BulkQuantity:1,Recheck:0,SF:10|66|78|81|82|83|101|1
	02|127|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 90983856949811f1aa26b74ffac11d73-20260810
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 34844069; Mon, 10 Aug 2026 16:50:40 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: sangyao@kylinos.cn
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH v2 0/4] block/nvme: split path limits for namespace heads
Date: Mon, 10 Aug 2026 16:50:05 +0800
Message-Id: <20260810085005.2275640-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806024658.4193386-1-sangyao@kylinos.cn>
References: <20260806024658.4193386-1-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just to clarify the base for this series: it is based on the public=0D
nvme/nvme-7.3 branch at bf881dd20062 ("nvmet: reject out-of-range mdts=0D
values in configfs store").=0D
=0D
It depends on 224041412693 ("nvme-multipath: revalidate zones for=0D
namespace heads"). Sashiko appears to have failed to fetch nvme/HEAD and=0D
then tried axboe/HEAD, which does not contain that dependency, so the=0D
reported apply failure looks like a baseline selection issue rather than a=
=0D
conflict on the intended nvme tree.=0D
=0D
Thanks,=0D
Yao=0D
