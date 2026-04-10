Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406183C3C07
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828440; cv=none; b=Fcw3Z7MJIeJRrAezgabO1soH8afgZAfP6Y+6B7Jjem6GB06ka4zK7rL2rat0Th6m+tl90NGiISVRfPQr4GMyxMeiHVuusMKmJR9u5W9tc3z9p0I1v0uSxb45UmFsE/VEpWn7OVIlHWcwqhrA5rDWpWEwOatliAK3atpH8nYW6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828440; c=relaxed/simple;
	bh=ygr8IdCVYJdg1rFWduE3xozN3cdoki6W2GZtEW+3QJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cFVH47BdTEhNjHSa7DDoqYOaTUrLmEbkwW7tcQha8TsUOmTomJrctFdNdcC/rkNzZSl6QfiXQ8M+mkhO5ESdimkuarjUsYzqgOeTUdtgPVhJweD14/Kx9a6sVbeh+Viv1+Ka2lSMz54fNwtSNG5xFGx9PHZ0pLVozCd1vwN28JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EV2FNKFs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TdI8WjpZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EV2FNKFs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TdI8WjpZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AAaYY74148785
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 13:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m16vhmgnCSFatiAvDtIxey
	tz/B5QbIP/Rrl5WhPxvz4=; b=EV2FNKFs4kuXtZPb3Mi59rmsWSH3OQB6gmtEmX
	7Wc/E908AQipsAwSwdwpamibO6LsQJKHwtqYwo68jC0+V2YPPaVvpdnh2xvY1R6T
	tUdUvwX/EDBiV8gaNFALq+VRX74DV0Lm3+2P9qPvVGLGmPc4aHTN4nRWY9ifwM61
	I/oMWjgZW6i43vUUSTQ63fUgWrSW6KK8c/OMg1Cpgay3pdIKMu9OjdeFnzat9uee
	TPhcXyI7ZQEpiTSq/jklk9hsMLdFBxq2MZgikD1z2xGWSWdnTFr/pl3/VDgv5x7W
	wc/Mu1LAp90zW2EZy84TeOl//1eX2GR3e9ZykzjluzhK/L1Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudghhhs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 13:40:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so2816859eec.1
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775828438; x=1776433238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m16vhmgnCSFatiAvDtIxeytz/B5QbIP/Rrl5WhPxvz4=;
        b=TdI8WjpZLcfRw3oue+3XduNGtFEbCc/cgu8DIkRRwpC5bu8TciHGQrSfsJosUiIqR4
         ZEi6N2ICEkpL9GVakMDDfhnYQFYLimd8RAOCAoEbxGR46GYUi8v/p/RfZkPeHbjtCIpk
         dYgbCDWgBNKxEKW/0+F+0eNY4aoygHA+3EgOZ9NR4fEQLjblJ5LJYK41KBaTjbM7vYBd
         I9mY1lRMGipv8jEMaB5Q3cgpAMhhvDtv5Nlb6de9PE6M866qAhcmmrmE/TR3H/s7gTSp
         7pV5quiik6ADBpGjY7xXG6w3luFUxn8vnvqhHsKXiI9/9MSgX2yRPo+rhYRpGHxV5Q4d
         h5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775828438; x=1776433238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m16vhmgnCSFatiAvDtIxeytz/B5QbIP/Rrl5WhPxvz4=;
        b=MBkXxBDqID+vV7QFOgy49+FOMxvnxT/POrye1Wg6YSBg7yrELtWf2ncvlvA5ua4GpF
         z3wrifWVhoO1F7AS/iE34NaeadKtA7tTCJhfAxfS5sua5bIyypZZ5/B9mA8ggNiiOPuO
         R8YApfuSrap/8Kl4z4wn/9TNbBlYAulzj/qndzQUbWya8/pEDetJ8bCx1CbsZxz2wnkH
         z1Ridd7hC5HHMdxlfhL32+4iiRfnzBKvBuTVk0VgkbtyP48Xpr5A+pDyZwt74T+f4yfW
         dLOKhdRKWOBWWnb/5i7BR78x/7IEYkpbxIMUhBGX4ZW5a9ilQ5wqZvlxpYxubUie4vRY
         X2xQ==
X-Gm-Message-State: AOJu0YwFfzRePLauZe33ldF9S4yRq2KjXEvx24qvgbQUvodgQ7MHUiNl
	fCASvwXN8eD4oQWGavVMtRH2PZpKP0fLSFKwCL6AXy/mFP9fV7JoT2B8FVjBGtr8ujn7wHOjG4F
	64rgjjEGyYHZxCAHTgy2qd1ztlzplcOuvzNnDZk32RilbckSlr67nEXu+10bkcw9tNEoRlcb41B
	+Y
X-Gm-Gg: AeBDiesshUepBFupkPFpNsg1tamc9SgBVYDmjrmuM+A6nLM4RFXPuYu/Uv/005pJ6Pk
	gtROdk7GImaw5quzZeyQP7ABCOFtt0Zoo1nOnP2l5FBASvwX2qyjtTHCEXtg2e7g17r4mGHBfGb
	xLawCUySn88VHtd4koX5cEYhl6xqcLJnBWsqnN29+VzHt33vR2lTr9vO436+EPrIr0reu87k8qS
	DsDqGJ+OenSZB49SbdpmjW7tKNrU1b1J3jpVBnCEEilMqDGG6wXf3z5M3dUFsAEZ68dMP8IKzYA
	lizyG/v5LNk9wOaPkkgHSaxTgGi7RCiAK56yZcFytOZeKaG+b3GO1XXj3WNWZzBEoo3AEYDKzfu
	eY0Zn01n8OspOJLISvUI7ZnC7344wK3+sVqNKpv0NGl61hoeZa+HrvzynCyxpKVusy4l9qeiwAf
	rD4O1s
X-Received: by 2002:a05:7300:80c2:b0:2d4:7656:4ec1 with SMTP id 5a478bee46e88-2d588e84919mr1688998eec.17.1775828437743;
        Fri, 10 Apr 2026 06:40:37 -0700 (PDT)
X-Received: by 2002:a05:7300:80c2:b0:2d4:7656:4ec1 with SMTP id 5a478bee46e88-2d588e84919mr1688976eec.17.1775828437148;
        Fri, 10 Apr 2026 06:40:37 -0700 (PDT)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561bde70csm5172631eec.15.2026.04.10.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:40:36 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, israelr@nvidia.com,
        hch@infradead.org, axboe@kernel.dk
Subject: [PATCH v2 0/3] dm-inlinecrypt: add target for inline block device encryption
Date: Fri, 10 Apr 2026 06:40:28 -0700
Message-Id: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0_Sbg_T1Qfg8rFry-WDpueyfj0q9bpMI
X-Proofpoint-GUID: 0_Sbg_T1Qfg8rFry-WDpueyfj0q9bpMI
X-Authority-Analysis: v=2.4 cv=H/brBeYi c=1 sm=1 tr=0 ts=69d8fdd6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=smb5OZ6KEkrD95H7haoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEyOCBTYWx0ZWRfXwjE0SwUFALkl
 kpEXp62VXNPLAC7EU4Eq1rE1Mw3wHig7R7B9lxyONc/xcNfCEkIzkHLZudBIvO3jm7wjw3DHSvu
 V3YpmZNPKmWJtmWmD0BmgVptj7tgi9tXcnNmPAsPFGgf95T1mUU1e2a2nWUiOrjcxlFsDfEBcQs
 gG4/AAPst8ROJm/SOxokTS49DKUxeghSa2gZaXrwosUJ3T3h3xYd3rgYudGFzz2iUG+W1uomrIc
 SqVDdrTbKN4L8znB31WejIoXsNxEfHa41xHuRErhS7Ymye3baEwqAqDC4Jp+hvmfC0EHX3OKU8q
 WUiUDb50T3xgwY+BMl9IFI4IG5VEs5uWBIEHn0kTm8sabgkukeGpnBi4Bf+Ix+5sy2xRp8HPfI6
 z2mPpdyBk8eDgAepfvI/iNmCGLV6vzNEMqjv2qd0hhNN+E4SiMQBEpf6wHNPuhm0/XhTVfFEZ+z
 uqjj0/A2Kb6lVtItr0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100128

This patch series is based on Eric’s work posted at:
https://lore.kernel.org/all/ecbb7ea8-11f6-30c1-ad77-bd984c52ca33@quicinc.com/

Eric’s patches introduce a new dm target, dm-inlinecrypt, to support inline
block-device encryption. The implementation builds on the work previously done
in Android’s dm-default-key, but intentionally drops passthrough support,
as that functionality does not appear likely to be accepted upstream in the
near future. With this limitation, dm-inlinecrypt is positioned as a
practical replacement for dm-crypt, rather than a general passthrough
mechanism.

On top of Eric’s series, keyring key support is added in dm-inlinecrypt. Thus,
both keyring key and hex key are feasible for dm-inlinecrypt. In addition,
dm-inlinecrypt.rst is added as the user-guide of dm-inlinecrypt.

V1:
https://lore.kernel.org/all/20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com/

Eric Biggers (2):
  block: export blk-crypto symbols required by dm-inlinecrypt
  dm-inlinecrypt: add target for inline block device encryption

Linlin Zhang (1):
  dm: add documentation for dm-inlinecrypt target

 .../device-mapper/dm-inlinecrypt.rst          | 122 ++++
 block/blk-crypto.c                            |   3 +
 drivers/md/Kconfig                            |  10 +
 drivers/md/Makefile                           |   1 +
 drivers/md/dm-inlinecrypt.c                   | 559 ++++++++++++++++++
 5 files changed, 695 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-inlinecrypt.rst
 create mode 100644 drivers/md/dm-inlinecrypt.c

-- 
2.34.1

