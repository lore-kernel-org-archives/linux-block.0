Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099E182B4
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753011386; cv=none; b=Yxa6bEzQhwQYIdyCxDSL3riBK8z/DHk7xQaAl0Hwo8jH5EddvoFOHI/Yrso29hqorZwe/AyvlzgdLVqtnPLrkcyv1Jqo1/cY7M0ZD/Vp7h7LqqCosKlYg6fddPfLj+cN3wobIWQmJR49AISbRRinCM9AXNFOKusUfVjyV71+0Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753011386; c=relaxed/simple;
	bh=G1I/ZOolutOuWXzb0q1ckCryhfqfpvy552VcFDMk+Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9njG9YfdVYO3TSB6QmlB3K2a+5AS6LrL2vp4YXxHsJEV8REiwu4h+IAVGFz2QNqa2vZCC8Iez+QKvI2RO7r6ZFp/8lywH67WhgbUoqFXV1k+fGGQ5m8WWp85gkWpTNgDo8hmYunozowETiT+A11QeI6ukxSRGKcbwWw9+I9GZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SKOYiEQo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SKOYiEQo"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K5I93Q022110;
	Sun, 20 Jul 2025 11:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JBUUkQ
	b+hU28bKGfHAOEFn8QXzzZ+gOERzhL4Rozexc=; b=SKOYiEQoVCdIc2QO7pddNm
	qSX8A5SgLTQgAXzoJHCK1757I4dNyNnihr+nppujKkqbhW8VshcECHFwyfIkvJoI
	BiyKbMMcdd2ChIwjWB4F5JUgQYwXPMMcuhE80S8kIHjVq+7j3LGZxZ2PIaHOEZsM
	MoykcQWKH+vScrdIDGQ/a4+XqXkSkTYkzsQyFGCFtusWpA3uSXAp81Gr9e4rQSX3
	AXQqvBRQYGhb/IHJgwlKhWShrwsA/PmLymTKltY6OAe7Ntqx+/B4k9wNqQmWl6f/
	WoFaN3eYJl+gncgdBFsquPoReAPMQHbE3hpqV6lVR023p0MuNaQ3chLAl2rvEWtA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805usv5xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 11:36:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56K6VIhx004735;
	Sun, 20 Jul 2025 11:36:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8fgtad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 11:36:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KBa5GF50332004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 11:36:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A1D12004B;
	Sun, 20 Jul 2025 11:36:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FCBE20040;
	Sun, 20 Jul 2025 11:36:02 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.22.10])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 11:36:02 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
        dlemoal@kernel.org, johannes.thumshirn@wdc.com, gjoyce@ibm.com
Subject: [PATCH 2/2] null_blk: fix set->driver_data while setting up tagset
Date: Sun, 20 Jul 2025 17:05:42 +0530
Message-ID: <20250720113553.913034-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720113553.913034-1-nilay@linux.ibm.com>
References: <20250720113553.913034-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEwNyBTYWx0ZWRfXzALvs636oQUc
 5Guk5pLkHnQQ8a/BIL00mkKfKfRq5h8Kc+1tXhd46aRfxwwcF2fMy5OY//w33RrmC8pRcfOP9ss
 uikKyBSm0rAtrW74dfWGKPrNsadSBac2lyL9A+6qZfl4bQgGL69Lwg2g3AXX2MdioTtzZLl4ma3
 i39/J8zCrT0G2I6EnHixa5IpRojcxHTmGGnV1GR1GxJKuOcLDNnx5UMYoLAh/muKmNlXhtSqE3S
 ZSIrDz47BtPqSNbgdnQzHPah/Y90zMYmOyYF8dJPbxFaK+h+Sti1Qo2ZvwWEHcGdNyvnfkvmrla
 jwyIUIX9cgL781coJ5U1Ju885wyauVDrS2fxoHWEBssDZSnzZdNH2nt9gvgMhdq4e9D40eMhHDb
 yvNlAVRa5cuNZAdllxUL0Nx4k5dqo6ILifHFP/TxBDaL5Yelb6Q4MMqPUSad2fZX8YuLSmTL
X-Proofpoint-ORIG-GUID: HE5zWZOGRpq-pVUIGa9a4sCjBnIxlMRe
X-Authority-Analysis: v=2.4 cv=cIDgskeN c=1 sm=1 tr=0 ts=687cd4a8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=49Q1tluVDS-zqvZwqn8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HE5zWZOGRpq-pVUIGa9a4sCjBnIxlMRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200107

When setting up a null block device, we initialize a tagset that
includes a driver_data field—typically used by block drivers to
store a pointer to driver-specific data. In the case of null_blk,
this should point to the struct nullb instance.

However, due to recent tagset refactoring in the null_blk driver, we
missed initializing driver_data when creating a shared tagset. As a
result, software queues (ctx) fail to map correctly to new hardware
queues (hctx). For example, increasing the number of submit queues
triggers an nr_hw_queues update, which invokes null_map_queues() to
remap queues. Since set->driver_data is unset, null_map_queues()
fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
effectively making the hardware queues unusable for I/O.

This patch fixes the issue by ensuring that set->driver_data is properly
initialized to point to the struct nullb during tagset setup.

Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/block/null_blk/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index aa163ae9b2aa..9e1c4ce6fc42 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1854,13 +1854,14 @@ static int null_init_global_tag_set(void)
 
 static int null_setup_tagset(struct nullb *nullb)
 {
+	nullb->tag_set->driver_data = nullb;
+
 	if (nullb->dev->shared_tags) {
 		nullb->tag_set = &tag_set;
 		return null_init_global_tag_set();
 	}
 
 	nullb->tag_set = &nullb->__tag_set;
-	nullb->tag_set->driver_data = nullb;
 	nullb->tag_set->nr_hw_queues = nullb->dev->submit_queues;
 	nullb->tag_set->queue_depth = nullb->dev->hw_queue_depth;
 	nullb->tag_set->numa_node = nullb->dev->home_node;
-- 
2.50.1

