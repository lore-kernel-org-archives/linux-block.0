Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFAB286D64
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106729; cv=none; b=SnrwlssrR2Rd/p8XqdPZohToruKsVga00itKobd1aDGb8o/7iJIO3iDhG29iWRv9EKzmunjTz8HlasldONkRtmkPN106k8/4dKfSX/Fb0xvYAdGjltn6hLciChBRwcHpFuw9W3xYphxa/O63qfl/Xu/MXVnON/6cPixsYfl9aVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106729; c=relaxed/simple;
	bh=AGyML8H1RYVQWR2LC7akvP0TFtI2A02+W91KFgoLn04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJAQJFBp+KokVOcWjthYyDPqFBZaMXoDRytnJx5SMYVPnXKjieztHWgLjLaHWQAsYKpPPBjaJJbnfnrjZzkkOi4bJrYc4k2wO6V7+2clLSZySMYurP6/bjMgMbeTsun9opj2VQSal/LtBJ0qRLhwCiLzjZDTcHASt0d7JTi/bTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rSfdJBQJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rSfdJBQJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBuatN011408;
	Mon, 21 Jul 2025 14:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IEoqa6
	SjyaxAXhcguRxIW1nPrzfx2zSy95UjL6VGqyg=; b=rSfdJBQJ1rcTrpvP3ZXApn
	mDdHBY2yFuBFxkxyBYPFe2hBWJUYZiVLrIivvbYSgNzkD7rjcelm07u7pnCitQTW
	BQgM4XcYTfu2r8p6noqX0a3slwyCMtbqfuE3vLaSy2QU2byXJudrihgV8jz1Wdcb
	Lo9Hn3eOojA2oD+Jr/rhHhubS1q1FMnBClvvrNgwLImDLZ+wwp/ictmScvACzSiJ
	CUqbzcOZkeRw37xvH21YHSL2raIbJ5MHIP+12ogQXl7456JBBTJg2jXCwShm5Nsm
	0KIlVXIFlT1ZYl1JVu172oakyaZw8KEcvsfyJCF2OLVwyscC6YeT+va3GaDcZHRQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v93yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:05:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LC3Ov9012823;
	Mon, 21 Jul 2025 14:05:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p2yxkqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:05:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56LE5BiQ59441410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 14:05:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A92102004B;
	Mon, 21 Jul 2025 14:05:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E640020040;
	Mon, 21 Jul 2025 14:05:08 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.127.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Jul 2025 14:05:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, dlemoal@kernel.org, hare@suse.de, ming.lei@redhat.com,
        axboe@kernel.dk, johannes.thumshirn@wdc.com, gjoyce@ibm.com
Subject: [PATCHv2 2/2] null_blk: fix set->driver_data while setting up tagset
Date: Mon, 21 Jul 2025 19:34:42 +0530
Message-ID: <20250721140450.1030511-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721140450.1030511-1-nilay@linux.ibm.com>
References: <20250721140450.1030511-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ozR9nVF9jNMPtFl8HGL3RT1SvUTOJ13w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEyMSBTYWx0ZWRfXxUoVPITnl0Wj
 W8WXWCYrpnRMObscl23hLTKmnqe1UBu3q+sH4ImStaRcAk7bNkj8RMKBiQGWipKZYqvTevxFDiM
 O4ECXAC2Y7Bl+nakHOeE+0AvDWjXXKifeM60m6kd6ST1Q/qk9D2Mnu+xSrcE1IPM5Dyiz/NDkiE
 wQivoEFLWHnt0OE1bRvJeLWw4Dd5Hvy+Mu7elnb7AlAaStqIomiyODbVGxMxXXlcH1hU7ZLDAPx
 2Zdmltr95WDTdqdWwmXPlhxWroqkneJiauEg+Ed+ertj9oVPSKwqooEksa13pRpEDoA4naBfmPl
 7xRPU9vPad+m6Q5BiSH6Lcrl1G/uK362pH2YmWTf8CL7M7B2xeSPit+mv/5rjBSoNtzJsq7AQgi
 sEnlz4dEfzLGBiStw6diOnKXcSGbd6zOzq21gDb2rCtaPfe6xbLQS2wRxFbpPxmx55CxxOhw
X-Proofpoint-ORIG-GUID: ozR9nVF9jNMPtFl8HGL3RT1SvUTOJ13w
X-Authority-Analysis: v=2.4 cv=JJQ7s9Kb c=1 sm=1 tr=0 ts=687e491b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=49Q1tluVDS-zqvZwqn8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=977 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210121

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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index aa163ae9b2aa..fbae0427263d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1856,6 +1856,7 @@ static int null_setup_tagset(struct nullb *nullb)
 {
 	if (nullb->dev->shared_tags) {
 		nullb->tag_set = &tag_set;
+		nullb->tag_set->driver_data = nullb;
 		return null_init_global_tag_set();
 	}
 
-- 
2.50.1

