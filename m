Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478D1D9663;
	Mon, 18 Aug 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542973; cv=none; b=g2MwHldRjYX4ygFJr0hB6s5BQnRJor5k+G/muet9p2lksRpm7Tnuz1zC0m5S/6znTDmlFrOrcqawESZA+sfLzDuIM39kAPXW6ffwMDpm+/q+sRJJtZcuBPcVRp7hun3CIXSRCKwG3dZrlA/BZjKVHYpy88fwKb9KzDtDaPdEUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542973; c=relaxed/simple;
	bh=umU1Cz5b5VF4Y2yhNDgjD9rjTReMlxo3yHS/O3/h0Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKAyu6k8QNZG1Yy3azojtVC96bxECHfMcVENPPXBPmMq1R//BB7SoMzHwMYuhMO0LFzGt7IWGXPwfSLKTnxY1kXvzgTOxauHwJVudTWWKfIAv97paLzJxV+Om6YGsgLF94af9VVPwe8O5I7VB2LH69NNo0EBatA0BLgmXTczpS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=HUJsvhMY; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="HUJsvhMY"
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IGWu50001189;
	Mon, 18 Aug 2025 18:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=W+KsTlQtUMNegy9RAtelMGZT1gbY74l453ylO
	yTCqew=; b=HUJsvhMYmsxS/Ddcv6LXtT5nGXGnRYwyAgEE1a8RATm294QSpbkzl
	ygiDXwYrqD3tEsR6QoT6nRKVb7zuVJk2vsfBh07yoheYyzYorL1Zt3XRJvtidTFc
	e7FDVrL93SwF0xEExzDHL/C55dz//rjNIJtIthuC0mh/+Thss/GtA5uOohYMhKvo
	eg2mrejfTpEXb6y4ITLDC5N7yn1nUNWCxy75wem5UCYL5cLa7a0VC9rcqFVJYdWF
	BjgveT42xAOmfjYFWDDKZQ/VycnaPPdFXFFRdMlOLYaSdRT0W0U0wNcuUSPbT14E
	DkJkZwj96CUuvHXajmTZMFnfnYGTzpYxQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48m4tw2uf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 18:49:23 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 55A45132D4;
	Mon, 18 Aug 2025 18:48:50 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id EE48A883AC59; Mon, 18 Aug 2025 18:48:23 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: fixed commit message 
Date: Mon, 18 Aug 2025 18:48:19 +0000
Message-ID: <20250818184821.115033-1-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE3NiBTYWx0ZWRfX9Ro5b1XGfSB8
 KyY5zL/UfPTtErpp4XOzspS6BqVMY597S5WQjfEqe3AOBJU6abtIfqekfsX5x/oCRXbh/3Mnhhh
 2hSuuCanr6ebp/yhT2LOhnxHAXxoMuFKJ8G4sxu0Q6wqMOUstKFjqiADDCXZ711185JhmXGo3xQ
 pYNuIf6e0Ataf0n9FuOENHsgZGWG/ZuKBLclldJZ5OLMoCDEf6ipBN+U4CNh6VGML5tSs9J/jFR
 t0MpSc1EMYal945kiGmmDofmFnSvO9/GWXQBbAb5z4FbP1/3QUa1NroNWsP3ApW8MpzxRYNsEAF
 MWbO4w/2yvkLQJI2ZxspTtOCTjuOkggxzwNArDjyoPZ7Q0DjlquK0ERue7jdxEu+Z7rKjLLCml+
 TlMPKvW/UyWIzMp6bYEts9YasnPBhlYcgOfLlOMQv3UVn3SvfYxQPi7cCoMr8PPpVz+cj34V
X-Proofpoint-GUID: miUm8yF8XHJeqAoN3NkmpOesQBHojFzz
X-Authority-Analysis: v=2.4 cv=B8C50PtM c=1 sm=1 tr=0 ts=68a375b3 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=2OwXVqhp2XgA:10 a=30U4ZI-q069OsqsH1RIA:9
X-Proofpoint-ORIG-GUID: miUm8yF8XHJeqAoN3NkmpOesQBHojFzz
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=755 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508180176

fixed the commit message
Rajeev Mishra (2):
  loop: Consolidate size calculation logic into lo_calculate_size()
  loop: use vfs_getattr_nosec for accurate file size

 drivers/block/loop.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

-- 
2.43.7

