Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD33A5E7D
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674803; cv=none; b=O8hFK912Dc89HXq73lgACvuLr9mgVQi9kpoWjfJp8KPSqmA7bpRzm4aV2iVbfrPThS4INcD8JE6uB2bF6bmQGyn3aUd70uFARio+NNupk3fwvwZWro7nCMDyjAv9wrU2TAUC7wB2+FGz35f4R67bk3ROYtKwpIod6BUbIEKJz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674803; c=relaxed/simple;
	bh=nxi2S6aKVU6kNdvUnoS4MlXi+1OnhgfsTfAb7JBtZf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QHq2wBg4HHmq2oisVhqBO4Nz4cVyoNJc33v0VVd9CVycdC+X+2DeRnBfAcBZUkPhCzTrbpzfm60AfYJLQm1A2xojKv4K/Rh6nt/jZa/sRUw2mI3YArw2hOSDR80Ehu70OzF/YZf105kOPsIGdBqBJ81Ni+1/AkoqVAaAUjnl2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7b32e2e8978811f1aa26b74ffac11d73-20260814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c589d7bd-9832-4a10-85a2-bb8f1a8d7603,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:c589d7bd-9832-4a10-85a2-bb8f1a8d7603,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:339ba5a94c188856476800f5a4a80f8f,BulkI
	D:2608141033103C9LPL2S,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|850|86
	5|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7b32e2e8978811f1aa26b74ffac11d73-20260814
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1985040081; Fri, 14 Aug 2026 10:33:06 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH 0/3] ublk: validate zoned SET_PARAMS earlier
Date: Fri, 14 Aug 2026 10:32:23 +0800
Message-Id: <20260814023226.354288-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

UBLK_F_ZONED uses params.basic.chunk_sectors as zone size. ublk also
uses it to calculate number of zones with ilog2().

Before this series, SET_PARAMS can accept non-power-of-2 zone size.
Then the device fails later when it is started. Reject it in SET_PARAMS
and add one selftest for this kind of parameter checks.

Patch 1 adds the missing check.

Patch 2 adds a kublk helper which sends SET_PARAMS without START_DEV.

Patch 3 adds test_params_01.sh. It covers basic parameter checks and
zoned parameter checks, including the non-power-of-2 zone size case.

Without patch 1, the non-power-of-2 zoned case is accepted by
SET_PARAMS. With patch 1, it fails in SET_PARAMS.

Yao Sang (3):
  ublk: reject non-power-of-2 zone sizes in SET_PARAMS
  selftests: ublk: add helper for SET_PARAMS
  selftests: ublk: add SET_PARAMS validation test

 drivers/block/ublk_drv.c                      |   2 +-
 tools/testing/selftests/ublk/Makefile         |   2 +
 tools/testing/selftests/ublk/kublk.c          | 161 +++++++++++++++++-
 tools/testing/selftests/ublk/kublk.h          |  18 ++
 .../testing/selftests/ublk/test_params_01.sh  | 114 +++++++++++++
 5 files changed, 295 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_params_01.sh

-- 
2.25.1
