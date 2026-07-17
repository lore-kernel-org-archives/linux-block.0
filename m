Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6BE418A58
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298409; cv=none; b=Y2SLHekmG3eYNrCCdEzrFuGaadVPHfgD8zM7WwCN8NsTiM52STNQm4VKVO7ZlnyvlLERvuN9k+GzAYoHTHta1fvNBEuKjiR2PZtfsWMtNgQ1sViKVo1mnTG8bCKowRevo0LinDpI1Gkp6XkLo5H7xF1fyVFdBQJk884UMNxhrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298409; c=relaxed/simple;
	bh=oohGbbAaLkslWdgC4Krwn0hyoZWvS3LxdokSu2BvOOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l/o3bjT7gly+ghzywJaowhmUIj9cInUFihfZG4XtGyjGmPwUES/3IKO0QyFIF8tv+5DpHm0Y81lTIjRGAHKhyOtdMp8YEgVpdMIv/zNigAbknvL/BDyYcJRYd+gL9CuQo9P+yGd9EwG4DuZuzBCmnLjOF8X/vZasWL8O2tXEu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lbrK+kmf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZUBT7E/U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lbrK+kmf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZUBT7E/U"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE87bb2123056
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 14:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DnJzG8liwW0p9lFDlKh2ng
	X3HM625dVQVl02XQ3FxcY=; b=lbrK+kmfH333XrFlpHdgqI/hR6KKFJt/oLualr
	FbUYywgIGmTrz1J2sHOBQMBxbunU1V0o0zDJAu82XNalwGAeOkQOUAyKmSKAwNTT
	aBU+uxPQfk3vR21OFvlpVkKzVexXGlwinzzl+5gBw6P9F2R/qKNz20CF06j+NNLp
	RldRXvyhUV7rLqnDs019caFkBkuZL8nf17/ffVqcKXey7oz96OgZH9Sf6LebAcmu
	FkaODQ73Tif0DibIW+xudW2DCdHkBxSvJqVPeE8NJv2eeMLW2x9a6TK/rO4WwllB
	b/Q8CD/WbRgqbvpgh46jfDUbDeT0FTiORi1ARYxS+5O1ZiTQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffe0ut3f2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 14:26:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c19493ac2so149677941cf.1
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784298405; x=1784903205; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DnJzG8liwW0p9lFDlKh2ngX3HM625dVQVl02XQ3FxcY=;
        b=ZUBT7E/UlA0sdOs2wcGsi/gY8FK0CoQpROBkdGMaC6X13cIbZQqTc1l54RZwdRoP6q
         FTwAbTaJTmqJP8YEebKBXtMFEVLM5OeUjcH7v9GWlEmDTuLTldJP3mqXBSRFLQ+XGysC
         4iDvLAWOZLns9uvcM2HNVFmG5pLiQ7t+kz/5uDnr+h8WXx4cbAPHNxmmVvs/4flWEFQe
         qGUm2Q6pRifL2c/+UJXKZZaIE4EJvhyEoL4IyUEEmZwdzVjaSGsV5q5f7Qqf0Li0jtir
         W+bCRkDrvOR/xmt3o9K7KKSgNs4EaAgGo11aSk1tKORS1hlJ+AqhyQaPHr83xmc367nU
         l6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784298405; x=1784903205;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DnJzG8liwW0p9lFDlKh2ngX3HM625dVQVl02XQ3FxcY=;
        b=MIpx4KQs11qnDOLH3fj7lT7rgqK/GutMx5nRr2n3e72ScubCcpvcBfpEzC9Jsj2bqb
         Nqsqk73p/ZgYksjbp4UvMGfyV5mMsxFxMDCVAJzdS9cW7nfQf203wmItCoZ0pF4ogqND
         2Zf5s+xMw+6DTcfn81JiVPEzDEXTnKSFaPUCMm2EqNWQIr80TiZ1dSTHji10fN8Dnwv2
         gROAwhaf74oocOyumAKN70NhQwpnM71dU5bRCF3O2P5/Ea+vsZVE0Gm8RQiXM+I93pYZ
         t6qJVur+fvXDYUdBeQIrwwAJRjxFupfiVNBeW7BzecAs/k7InLrc9LDJa9/Ccca/3aNb
         STLA==
X-Gm-Message-State: AOJu0YwZwQMCz3c4uUhCYSDFK56PsGbFAIvDcit+LDbjV8L14qeqpoNC
	BaKvhgPa2xXk/Nxd8TbYXkFXsOinzTH43NxoWSlrnAadI3BnYSPl7OsojspVMMLwoCWy7boSfGl
	TRtlCCG+tat0VHTgI76u/g0LfDtvuOlVz2bXJpQdAYZqZWy43Qjfq4dAltDPRqr103vvyxmkMtE
	CT
X-Gm-Gg: AfdE7ckPHmktVM/UPsieT6lqHYaRv0xm/lCoWuO1LfpBbE2hECW5xmYKNqdvBXTXdOv
	60XG/+jwWN+6RQ97laibGXZzroOjWK5gdl3Edq8tMmm3+oeS/Fp1cKPKjEy61sgBorKerO4xAD7
	Qoj161d40WhBcN5Ouf00KJW6SFVOEIwFIwD1E93HPBwuL1I9ej7+dFH6tbcSdkAXZoE7UNxvzR7
	d8xFyh7QIq0lyRl9G6M4yMIJMgQpgD++3tP8qP6JhOEgsJN49y1SmEyPm0R6ASqX2GSwpuAruGO
	S5FiRZKfCrrkmMA/60nMfY43POQh0VD1+ePwrdqDpFE5RT5br8J1isn8Ao6dvINTBdnsPCKjDq4
	D/p6UYK85iWoMxIi0UYQ4b8GJomVe8uvaL53/qOgAHJcSMCwnj91YOQ3ON0YSG2hn81cZYUZDQj
	TZBpSKcHOAu70ctkC4b2ub/t36sOaxkBjIl2TWP4vXBEriIoWMmto=
X-Received: by 2002:a05:622a:22a2:b0:517:9407:5c36 with SMTP id d75a77b69052e-5213e28dc47mr24764191cf.53.1784298405275;
        Fri, 17 Jul 2026 07:26:45 -0700 (PDT)
X-Received: by 2002:a05:622a:22a2:b0:517:9407:5c36 with SMTP id d75a77b69052e-5213e28dc47mr24763851cf.53.1784298404832;
        Fri, 17 Jul 2026 07:26:44 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000688dsm824789a12.29.2026.07.17.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:26:43 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 16:26:33 +0200
Subject: [PATCH] block: partitions: of: Fix NULL dereference on partition
 without reg
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-partition-null-v1-1-47984cff2d7e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJg7WmoC/x2MQQqAIBAAvyJ7bkEFk/pKdCjbakFMtCKQ/p50H
 JiZApkSU4ZeFEh0c+YjVFCNALdPYSPkpTJoqVtplcU4pZPPamG4vMdZGtKuMy2RhRrFRCs//3A
 Y3/cDHm7ZcWAAAAA=
X-Change-ID: 20260717-partition-null-b05e2c956ee7
To: Jens Axboe <axboe@kernel.dk>, Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=deWwG3Xe c=1 sm=1 tr=0 ts=6a5a3ba5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=e4y8cmn4OwqddjlM7QMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE0NiBTYWx0ZWRfXxGdJ9amNj134
 ug3SuBpeXWgw1dbdngtTqU4NBVB1Ep5/b9ihMFIZbtXx8JbHyifOzknAiLbpovwf7gFr/QATtcF
 lWSEylUD+IWQTEOh3uuvh8B3A22NHFjc/O9F4Oh7UcouOO3fwn7MytYCME7c4/hB18U9PS07I5+
 A45l5jYUR8Qx5y8nsXeaPmszqHdQunBFui9kawiX0k6NtH/1BbQfAHRvd6Yc7Q2QZltVk9ZGGMV
 IE1Tc1smRv8NJjfgvPmrbrvgR66ZpUOxnWBF5kP/9LJudx/4P5DlRbRGeHXzGNTklsUZF5M2Une
 qu8jMjcgjCXQVWQXCiJBYMltUxcfmqdXXe3t3hZLTFocETaYlL7nxoNElRdiTP/AnqkdKkWWwnR
 5gOrblGMcuHXVnLIldgEFHG7hG8tGan4SZdUaxUnpwKY0oSWd3Eo0nZV6VypSAWEMuGylQjdM/C
 eo+Erhb5vmXQ9fGgIug==
X-Proofpoint-ORIG-GUID: 3wWbftmP2QrxDvdZVfunNHxxM_GahmRQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE0NiBTYWx0ZWRfXyBKhSPnDmocA
 ruqzD29/eycfpArCHREzfvnCEjaxN7ENJm0EHVJtPiwez9sTTB9xGeCo5X2OzZzksUNWu0iGmG/
 Sj2QewchvOpNeqsoqZc1pVu8Xiq48sE=
X-Proofpoint-GUID: 3wWbftmP2QrxDvdZVfunNHxxM_GahmRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170146

A child node of a fixed-partitions node may lack a reg property, either
because it is malformed or because it is not a partition entry at all.
In that case of_get_property() returns NULL to reg, which is then
dereferenced without proper checking.

Fixes: 2e3a191e89f9 ("block: add support for partition table defined in OF")
Cc: stable@vger.kernel.org
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index 53664ea06b6540e3d1155141adaafac7286f2d21..dab36513eba336344c9558d486a8915624b0fca8 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -15,6 +15,9 @@ static int validate_of_partition(struct device_node *np, int slot)
 	int a_cells = of_n_addr_cells(np);
 	int s_cells = of_n_size_cells(np);
 
+	if (!reg)
+		return -EINVAL;
+
 	/* Make sure reg len match the expected addr and size cells */
 	if (len / sizeof(*reg) != a_cells + s_cells)
 		return -EINVAL;

---
base-commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a
change-id: 20260717-partition-null-b05e2c956ee7

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

