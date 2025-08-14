Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB024EAA7;
	Thu, 14 Aug 2025 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153448; cv=none; b=WQgfidOZpXBvGxgwY5kZYZPEkkC8jSR4+NCN3OFkMklqxiPp1i3o2FeqPdryDw8TEmoJnB4Ab5ckmWSDjgaDSR70/lIz+C4apvBhFJV/NwpvHzUE/MPsvDs1TM/ZdYAfZMV9ZBNB6qTPy6MO5QBCCrjoRkqxZBxDvO3watx4Hpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153448; c=relaxed/simple;
	bh=EvdQ6Bg8OnlITVamBcloGQkXv3LWJan23b0GY22b9ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nXNCOXjACPjYaCN62jMA7Hg6ms7KqiWfR3tDeDfnKMmxhNwsKScM3sib3gyajzmqtt3iDwf3X3iTMOoz6a74r8Rhcw/SZ0f78DdmJG2UHQ+6+vhZvTqdyoZxuFCh850rM1lp+OqFRdOjb2MCYS6lPVcN50Tmw9EV9fbyUir5xtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=liK/K+Vs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="liK/K+Vs"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DM8Erw011435;
	Thu, 14 Aug 2025 06:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yYUb25VbWnegftuQMWLMgm
	Nh1P2XLmEoohNyE4+Czww=; b=liK/K+VsHR4iAEkXsqzxG2bArLZQn9r8cjWNSg
	6WjsEMU3MqmaMpDGQEEIwjIF4+a+807GdBaLygHEARCQA49u/7psYmIDIMKcaOrL
	ikqVqyyKwkp2fFveysOT3P0UNW9sALgS8s/k5gwNlofO8g2REVt2kYc3xtbx7nHR
	b/gzEGC7NPYp5D3Q+Hj30/Ph8KYKkm8SGooXVNqdECC2mv0L6K16crfgrb/64ThW
	ipKuikfZqRinkbtYo3Siv6o+c5Rk28TMXhFKoysetVXgiuJVnSBfA4Z8/aByY9za
	Tykycol2XzbWfVOc2ZC+bpJK6FVHvvVLsep02F20mzH3ylvg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9wpem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 06:37:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E6bGVO015595;
	Thu, 14 Aug 2025 06:37:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 48dydm4gex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 06:37:16 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57E6bGHT015590;
	Thu, 14 Aug 2025 06:37:16 GMT
Received: from hu-devc-blr-u20-c-new.qualcomm.com (hu-hardshar-blr.qualcomm.com [10.190.104.221])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 57E6bGvd015589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 06:37:16 +0000
Received: by hu-devc-blr-u20-c-new.qualcomm.com (Postfix, from userid 3848816)
	id AAC1420A07; Thu, 14 Aug 2025 12:07:14 +0530 (+0530)
From: Hardeep Sharma <quic_hardshar@quicinc.com>
To: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Hardeep Sharma <quic_hardshar@quicinc.com>
Subject: [PATCH 6.6.y v2 1/1] block: Fix bounce check logic in blk_queue_may_bounce()
Date: Thu, 14 Aug 2025 12:06:55 +0530
Message-Id: <20250814063655.1902688-1-quic_hardshar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689d8420 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=aRHBprkQ1X53iwqQ5hAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -aOy7J7bLtS5wTFA6AJRsMHqcXjgTXKm
X-Proofpoint-ORIG-GUID: -aOy7J7bLtS5wTFA6AJRsMHqcXjgTXKm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfXw/7ZR4OgbAko
 4RzDSzoX+n17nLV7RUakqOfSpcgzdkmCy/v5/0ssEjpZT82aKjMY8ggXB2SpMudFt5TkE2Lt9a9
 chWWGdTeaYilrEkfBYbLIjxmtXnd/S3aAx951QfkwNYCzjKxfV49b2HFmhDG1aH2bG10ys1crs/
 /z6hq3K2jLRquuwVaP66pyH6TR6sZRBHM6d9eXf66uHzYP5yc4kxlGowr9If0OqPyujl/YTslNP
 PMdp7sbud2uG2ABzvIbJ3V9GMArA2/Pgz3FlJODnRcpICqfojfJRWUlQnsZ96UWAYAhC/jeu3uz
 R7EyhJ3w7yr64Wmm9pSLKjnGHjiu6c+wFB5uMnFc+fel7w7P8G4nyF6Hw0FB5pNXBJGKHT4K78c
 UqOgo2S5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

Buffer bouncing is needed only when memory exists above the lowmem region,
i.e., when max_low_pfn < max_pfn. The previous check (max_low_pfn >=
max_pfn) was inverted and prevented bouncing when it could actually be
required.

Note that bouncing depends on CONFIG_HIGHMEM, which is typically enabled
on 32-bit ARM where not all memory is permanently mapped into the kernel’s
lowmem region.

Branch-Specific Note:

This fix is specific to this branch (6.6.y) only.
In the upstream “tip” kernel, bounce buffer support for highmem pages
was completely removed after kernel version 6.12. Therefore, this
modification is not possible or relevant in the tip branch.

Fixes: 9bb33f24abbd0 ("block: refactor the bounce buffering code")
Cc: stable@vger.kernel.org
Signed-off-by: Hardeep Sharma <quic_hardshar@quicinc.com>
---
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

