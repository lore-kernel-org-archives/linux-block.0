Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC12114;
	Fri, 25 Jul 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442846; cv=none; b=qJHjdOh2lxkOuwx6DuEqIDeEHRoEAhmvL+shD/Zc0ccNWWC6k0qIiPn/zPxlprVGllGP8VOHAGS9u3TveBxjDv2N1Y/iKzy6hnWwgvywUpQYnPzN4VEen/+K20fwvXv4V1A6Gc7EHbYoMM7m30u/XYE9PH8MKGKm5YtcjT6Hyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442846; c=relaxed/simple;
	bh=+wEueGMSq/GWSW913wV+r02q1yzQXRc5gpvONjMAkfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hhO8/fwPxId3/CvZLNvuIuo8WNbahHAeDojU1YwMJhtSgNG0fR9PLV9iq0fvzkTRsMYbzjfhDu9EnvnblrNgkee5ukKs+3inuo3leYJLp3FayjRX6MqCB4zequk8SfRCNOQhENCvNTJXGDC8VK/7gXg+vSLmA81CNnseV/6xa0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lmsIkubR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lmsIkubR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8s9IR015762;
	Fri, 25 Jul 2025 11:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dzjU7ttLJ/mNbzQTDtKPdy
	iYr7bxF356Q7uC+lXe6Hw=; b=lmsIkubRD7bgOc7yjPlIKFFu99M+49UecYiu7m
	EzcR5iqvUb4Btnj7RZutcKJ+raeJ8jbqcXEA5buWD8NNiiG3ut6lTL+P3kkd2MiP
	4e0HKPVJH+ParGeW/YX+8RFAOKrv9nSp140W2lXfQiTHGALfGwluYRyLj3A+BqYV
	AR2z5ziuj5YUh9fKmLjbxL83AIe6EZDgc4JVQR68WCxBFFjiIQksZdCAc6OKpXS7
	k7OSO9yLSqjlFD3I7uzNgrh8iupVy1RRKxKBv8pC1Ss+UTqlZiu72/Fr3V5MkqqK
	Vqym/Hm4meWowKD15/Vhtt9BpFNf4B+JjQJMfYtBGVSfDcig==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w501vea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 11:27:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PBRFfN031820;
	Fri, 25 Jul 2025 11:27:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 483ef2s3qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 11:27:15 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56PBREVh031815;
	Fri, 25 Jul 2025 11:27:14 GMT
Received: from hu-devc-blr-u20-c-new.qualcomm.com (hu-hardshar-blr.qualcomm.com [10.190.104.221])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 56PBRELT031814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 11:27:14 +0000
Received: by hu-devc-blr-u20-c-new.qualcomm.com (Postfix, from userid 3848816)
	id E3C8620A5F; Fri, 25 Jul 2025 16:57:13 +0530 (+0530)
From: Hardeep Sharma <quic_hardshar@quicinc.com>
To: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Hardeep Sharma <quic_hardshar@quicinc.com>
Subject: [PATCH 6.6.y v2 1/1] block: Fix bounce check logic in blk_queue_may_bounce()
Date: Fri, 25 Jul 2025 16:57:10 +0530
Message-Id: <20250725112710.219313-1-quic_hardshar@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uDR2AzBEjnWe6eR8y_qZn4lC_Oebq-lx
X-Proofpoint-ORIG-GUID: uDR2AzBEjnWe6eR8y_qZn4lC_Oebq-lx
X-Authority-Analysis: v=2.4 cv=bKAWIO+Z c=1 sm=1 tr=0 ts=68836a17 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=6abORDSa23aJwOuxMHkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA5NyBTYWx0ZWRfX2lxgPXhYh/AK
 oAlndLLqc7CF363FR8zfpgHs9nRYB2iMJHSfnumr/6IVkc6/64dw/LYGxocdhiayIq4NwYsKafA
 3deo0JsP0/iJ8RLT34dLgPEyNIiQBdNIAmmSFft+Hk128UyMG7DDAA5lTT3UiQaFf0l/Kqd5c0e
 ygkxDzxyfqITq1GJz19l9SX2ofG0bjPg4ckeho6y6klbjtHdUDzM9OSf9P29+KDk7ng9BZad+dn
 l1syhrRDT6isvjWpggUgwslFDZ1J25sQzcmch63YxekHYTuX/fM6/F1wZEuCUZFVadbATtcSlWL
 dSFNHkzKl9pU1IpkM3YjBu8rCAtVFp/hzVs2CwfKPjIAqjjQfuHP66g7vauCcDimUkIwIs12ZyC
 ixC44rVjXWbc5JBdeXaUv7ZaWhKgwb/NspVOr1aRaov3BzPS1uqqYuaZvetKugOGeZ75vIBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=739 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250097

Buffer bouncing is needed only when memory exists above the lowmem region,
i.e., when max_low_pfn < max_pfn. The previous check (max_low_pfn >=
max_pfn) was inverted and prevented bouncing when it could actually be
required.

Note that bouncing depends on CONFIG_HIGHMEM, which is typically enabled
on 32-bit ARM where not all memory is permanently mapped into the kernel’s
lowmem region.

Fixes: 9bb33f24abbd0 ("block: refactor the bounce buffering code")
Cc: stable@vger.kernel.org
Signed-off-by: Hardeep Sharma <quic_hardshar@quicinc.com>
---
Changelog v1..v2:

* Updated subject line

 block/blk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 67915b04b3c1..f8a1d64be5a2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -383,7 +383,7 @@ static inline bool blk_queue_may_bounce(struct request_queue *q)
 {
 	return IS_ENABLED(CONFIG_BOUNCE) &&
 		q->limits.bounce == BLK_BOUNCE_HIGH &&
-		max_low_pfn >= max_pfn;
+		max_low_pfn < max_pfn;
 }
 
 static inline struct bio *blk_queue_bounce(struct bio *bio,
-- 
2.25.1

