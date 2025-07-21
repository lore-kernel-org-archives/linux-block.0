Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46777286D64
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106726; cv=none; b=pYsd/8Cr0OMysH9neLY/s88RbAI7K9ildqZijNeJyG0GqUzplZZ70AqI/6un+NuNgbhmAijyFJL6IAUH9Wsa0uusg0NXGhaD2C7ezCOrhuVCD3Qy+jPNjJC9+EpKPJndSTT6iEV3CQqt96kM4/IZFGzVHDtncS0hWfhWxHLZXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106726; c=relaxed/simple;
	bh=IxjE5ckZRtljtpjrDWCoDn4urUGhBRQrg0gTd4zL9ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ir8T+rIqKGc1elHmmZ+4CVc4CilJzRVOZiGl9sJ2ekdK97s4C1z+B1ACD08tg6eDchtU0Eqsw6SuXaF2GWipFS57zk/+gfiSn7+XL/katqVrb9o4AORuDSC7/NQLsSAM6YpPVvQrtSOnJBJB+S2tKrXMjc0lCP0128AD682CEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FmEcRe3n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FmEcRe3n"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LD0IoA031219;
	Mon, 21 Jul 2025 14:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=+uCcFhe7e4ItSL08OnZOrJ3xKy6v
	PrTSpVzP/uSl/L4=; b=FmEcRe3n3X8vVYoz8ohJwMD7pJyRkBY6x2mRpuJjZwpR
	XXlkoV6p0DmlaN08tgV21WDDHIFITNoVlXxb8gsdIPN0HpJraQlsaIbPP3/7Jvi5
	o3j0GvusTUHKBwDwjTnnYviOwpcTXS7SEjZeZCzrSwRMSVbBq7z3M467Q+hwv/TV
	zHqenSQ6BL2PtLGwhyieQvduvCkLXpN/NeGYNesobzPuch7Uipax6WNjTNwWHAOH
	tSNsK9wzBWIJqLlS5uJttWcmW4HSSKVgH/3kpQ24mI9TZlFX2F5xYAQIlTZdT1ns
	AwkF922TPJ2GWjxLC/lwibJOQIXXXrX/TIZS5rVFCQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqryr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:05:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LCL3j1005478;
	Mon, 21 Jul 2025 14:05:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvqnp57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:05:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56LE541359441660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 14:05:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D44F02004F;
	Mon, 21 Jul 2025 14:05:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AD0C20040;
	Mon, 21 Jul 2025 14:04:51 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.127.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Jul 2025 14:04:51 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, dlemoal@kernel.org, hare@suse.de, ming.lei@redhat.com,
        axboe@kernel.dk, johannes.thumshirn@wdc.com, gjoyce@ibm.com
Subject: [PATCHv2 0/2] fix sbitmap initialization and null_blk tagset setup 
Date: Mon, 21 Jul 2025 19:34:40 +0530
Message-ID: <20250721140450.1030511-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zLqtPxAuUJ2UFgk_SlNd1cD5FRhyJec8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEyMSBTYWx0ZWRfX0qTJ+F6EXfq4
 kr7F2o63hJQvsCfWAQiQdQrK8pq5DJCQadhg6YbBXH9pLlXhcpPbjqXX8u9BqROexWjlGGOM5mH
 HD7QoFAAWXeiTpuXOXB7ZXI+/JqJ3GmhlCz2W9X19H496K+ATtz0p0GwH7DXTpXuDskBkX3GPpE
 3vUu31/btbbLu2SLAdROOQ76O16kYQKbH1FEMZBgXenlRKUm41vZkFN6tqfBJ7QFp4vYF1S4x1l
 J+9K25w3hP3L9GyjAGS+KV/DmTSMsXZ+Bv5ndFwhFtgceohKkhNNQ7hxstyoJXCObI/j/amJE3W
 GsDtYtKI0hAJb5sAORFCtYYwktwEOWAs2hFLv0IhDZW6MjlvwOnUFjd8V6P/edOektf+clqy9oh
 fhvALFjpyohtLPngUG2b+Bfqeh4VpmnQPiC++SBMycMU4oxgbCZAub6RpRgAFs7i4KtOXoDf
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687e4913 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=MMnfdg8G3pu6OI0W2nEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zLqtPxAuUJ2UFgk_SlNd1cD5FRhyJec8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=93 priorityscore=1501 bulkscore=93 mlxscore=0 malwarescore=0
 mlxlogscore=486 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210121

Hi,

This patchset fixes two subtle issues discovered while unit testing
nr_hw_queue update code using null_blk driver.

The first patch in the series, fixes an issue in the sbitmap initialization
code, where sb->alloc_hint is not explicitly set to NULL when the sbitmap
depth is zero. This can lead to a kernel crash in sbitmap_free(), which
unconditionally calls free_percpu() on sb->alloc_hint — even if it was
never allocated. The crash is caused by dereferencing an invalid pointer
or stale garbage value.

The second patch in the series fixes a bug in the null_blk driver where
the driver_data field of the tagset is not properly initialized when
setting up shared tagsets. This omission causes null_map_queues() to fail
during nr_hw_queues update, leading to no software queues (ctx) being
mapped to new hardware queues (hctx). As a result, the affected hctx
remains unused for any IO. Interestingly, this bug exposed the first
issue with sbitmap freeing.

As usual, review and feedback are most welcome!

Changes from v1:
    - The set->driver_data field should be initialized separately for the
      shared tagset to ensure it is correctly set for both shared and
      non-shared tagset cases. (Damien Le Moal)

Nilay Shroff (2):
  lib/sbitmap: fix kernel crash observed when sbitmap depth is zero
  null_blk: fix set->driver_data while setting up tagset

 drivers/block/null_blk/main.c | 1 +
 lib/sbitmap.c                 | 1 +
 2 files changed, 2 insertions(+)

-- 
2.50.1

