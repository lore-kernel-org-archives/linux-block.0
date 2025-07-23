Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6B2E7F1F
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278323; cv=none; b=Ju9Sg7z68QbBL6rWerU7jb77iy5xT0chVAPBi/WtPqWlobk5WZHz2kaYrOd3n+4kFjI5h2N7RRZnMiIvVWVqmrtDFyJL1YZBBu6ZCZ9ejmMVVE/x/XPfg2rQbWTOl0igddGedb5J0rwxsm3+65UzMVYYGdyrdgTR2Znpbt7xH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278323; c=relaxed/simple;
	bh=cIdFuBn2qXNafq3iQFinlHaROviwHUZu51bXkrQ5E7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEKEyQq/hEKBnUDuC1G5PJqk7T6ip6c4AYHG2wlHx/Mm97YN0WoypTxNXBUo+Wb55YxkxBQmRQLf8qfykNTicjL/nwYWn8dH383VIjfXNGY75B9tiG/a46JCX73Vy69y/ruJcZg2Q93+dbNvqiJHyVlm8c1nPNNHNBzmYgYDQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fkDk5r0s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fkDk5r0s"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9EXpS028810;
	Wed, 23 Jul 2025 13:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RkkVl0Xe7hFUpHB02
	YyvakwjQx3PpP2UOr/tWECmHAE=; b=fkDk5r0sA7qzRUj3DsSORPnM+5BSA4Xvt
	PcbZQ/3Q6vPbE1YIE+9v9VL7LOTibvs+6bAd9L+WtBngQ9dWaM66kS8WjDpgWKA0
	zbCkClZVPcUQKPjQWvWXoxZqcaD0JHW79sUuavr5q28hshWd9ofNXMXpYdKkHDYM
	MJyaaUlWCPxYSNjaoKn7wofaLlZnWT96NVlPS8AWUSjOdAjdf0UsgVMWXDG1nu/i
	sL9P4wg+4+lNN3o4XmxvYw4L3S8h0q6t0hf7QAsQrwy/U/Cn0raTqTF5jN77r/LY
	vDkchO1p9AFjwhLMobzaiaZgunD4O/qycjF5AN3uhdbZzQNVGNevQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyktsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:44:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCcT38004735;
	Wed, 23 Jul 2025 13:44:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8fy6we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:44:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56NDis8G27918758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 13:44:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F7D720040;
	Wed, 23 Jul 2025 13:44:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACD762004B;
	Wed, 23 Jul 2025 13:44:50 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.41.196])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Jul 2025 13:44:50 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, dlemoal@kernel.org, yukuai1@huaweicloud.com, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, johannes.thumshirn@wdc.com,
        gjoyce@ibm.com
Subject: [PATCHv3 2/2] null_blk: prevent submit and poll queues update for shared tagset
Date: Wed, 23 Jul 2025 19:13:55 +0530
Message-ID: <20250723134442.1283664-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723134442.1283664-1-nilay@linux.ibm.com>
References: <20250723134442.1283664-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OPc8qNm_iu51YbVApzunDMRLsl3gO_iY
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=6880e75a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=HfARY0vCpeR-NTxWe5oA:9
X-Proofpoint-GUID: OPc8qNm_iu51YbVApzunDMRLsl3gO_iY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfX9vJ1gCSOnLiK
 PYqmxp7yv6poR2QI2OkTdhx397GxvWILN7niPW6ynHiJdrjPKF5RQqIJv4k9dCHKzbxm0IA1mMv
 Zj9iaXqGehiVok7Z45DXZ3RHb77ywSCc49o1DaQGGkmC4DNJs7Ga1R175N0h7loqK1d0ATrj/Pt
 vO93qePAWElwxXc9TpI0n/44IPvq/FlkEvLE/UCci5rZYkL+vRW8EcSL426IZ/uy9IpuA89AODK
 w42HVYmV5+fPFMWHyXcmg76Nkhfw7iUxNPYkQcXwNDmSpBi3HnrJMAN8HjUoxylTz35zhx7up/r
 4+o0Wpm1e+R4yBQWmq3bIXjTrj08GbTDT/4Enfxm18K16XbPzMCE1JzUBiqLAYkYg50U0bu/Q6o
 MRZaooHhneJvVno04inj2mtPixDMRM3ifGkemcrhNhmKsCW/ZJBs19Wxhn+braMWES26hIFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=840 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230117

When a user updates the number of submit or poll queues on a null_blk
device, the block layer creates new hardware queues (hctxs). However, if
the device is using a shared tagset, null_blk does not map any software
queues (ctx) to the newly created hctx (via null_map_queues()), resulting
in those hardware queues being left unused for I/O. This behavior is
misleading, as the user may expect the new queues to be functional, even
though they are effectively ignored. To avoid this confusion and potential
misconfiguration:
- Reject runtime updates to submit_queues or poll_queues via sysfs when
  the device uses a shared tagset by returning -EINVAL.
- During configuration validation (prior to powering on the device), reset
  submit_queues and poll_queues to the module parameters (g_submit_queues
  and g_poll_queues) if the shared tagset is enabled.

This ensures consistent behavior and avoids creating unused hardware queues
(hctxs) due to ineffective runtime queue updates.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/block/null_blk/main.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index aa163ae9b2aa..57bd9aeb9aaf 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -388,6 +388,12 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 	if (!submit_queues)
 		return -EINVAL;
 
+	/*
+	 * Cannot update queues with shared tagset.
+	 */
+	if (dev->shared_tags)
+		return -EINVAL;
+
 	/*
 	 * Make sure that null_init_hctx() does not access nullb->queues[] past
 	 * the end of that array.
@@ -1884,18 +1890,24 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->queue_mode = NULL_Q_MQ;
 	}
 
-	if (dev->use_per_node_hctx) {
-		if (dev->submit_queues != nr_online_nodes)
-			dev->submit_queues = nr_online_nodes;
-	} else if (dev->submit_queues > nr_cpu_ids)
-		dev->submit_queues = nr_cpu_ids;
-	else if (dev->submit_queues == 0)
-		dev->submit_queues = 1;
-	dev->prev_submit_queues = dev->submit_queues;
-
-	if (dev->poll_queues > g_poll_queues)
+	if (dev->shared_tags) {
+		dev->submit_queues = g_submit_queues;
 		dev->poll_queues = g_poll_queues;
+	} else {
+		if (dev->use_per_node_hctx) {
+			if (dev->submit_queues != nr_online_nodes)
+				dev->submit_queues = nr_online_nodes;
+		} else if (dev->submit_queues > nr_cpu_ids)
+			dev->submit_queues = nr_cpu_ids;
+		else if (dev->submit_queues == 0)
+			dev->submit_queues = 1;
+
+		if (dev->poll_queues > g_poll_queues)
+			dev->poll_queues = g_poll_queues;
+	}
+	dev->prev_submit_queues = dev->submit_queues;
 	dev->prev_poll_queues = dev->poll_queues;
+
 	dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER);
 
 	/* Do memory allocation, so set blocking */
-- 
2.50.1

