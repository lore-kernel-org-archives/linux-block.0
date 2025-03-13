Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD9266F19
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866774; cv=none; b=NKOhApf20Wx1MUEfskRbkxSSDggSkEReT5IPj7p2XEHZ9DdLrORJoUcuw4PZrSn8KrXNdAm17HeI4W7muw4fuD+HpwGjhK5xX49ZV7CmImC3umElzjmco09h+jZr4XwY7nGgV0ZjDHamKSnEGB/YNutCGD3cLKb55mFmm5OwXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866774; c=relaxed/simple;
	bh=AH0N7huOtbiYtpdBanUUEbizv+L3/VEIFvQCk63C9ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4UMxkRS4iSIETzj3agTw+7JIH+gy1uxy93EypFuIO2cYLENRRCekiEG7aPzWtKpD6vpYkKQZhUbSP9LDJjTUgEIGc8+BdSOCIro3XeCwkNpTudT2MIE58DvlDNEc+WEmM+FaTC7xg6ZwIGLRjBXUPM9degk/y8v4ALTIbldsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OTaGWKnO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OTaGWKnO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D9xZOI010699;
	Thu, 13 Mar 2025 11:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cN4sGfPdtpY5GHBj8
	S011dBBB9n9eUKwf/HLU5JZjJA=; b=OTaGWKnOjJ2m6LS03H2KjOnJUnfx05EX6
	lej46jl6j4AykznO7cU9jzQAxTq95cQznRCjEesRENPTQK+JmFqskeURS/PK07Xw
	vxnV0eLCP8M3F8lji0UgLwc+YJIliofvhfWkSuSskbgGTC/GP72g+vm8E/IZmV6b
	l0x4qxAvQmCJfg9m7zmi+ypAR8uCm4BgV5pa1bOWCAr5KDD1XPDPr+a1+rC/+svl
	Vei0vSe/qum5j0Tz+4/YYq29lnBWQ9Kd2euTDvPwLeRg3LoZ7gO3lc+kUH6nimjx
	Iuwr47qHZi/uBd2SYkIFvD8wrom+zE/MfbG+a7wbPN9OdFeHa++vg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhg0bew5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:52:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D8rPUQ027040;
	Thu, 13 Mar 2025 11:52:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsr1hjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:52:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52DBqgGh56885578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 11:52:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 363FA2005A;
	Thu, 13 Mar 2025 11:52:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D309720040;
	Thu, 13 Mar 2025 11:52:40 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 11:52:40 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv2 3/3] block: protect debugfs attribute method hctx_busy_show
Date: Thu, 13 Mar 2025 17:21:52 +0530
Message-ID: <20250313115235.3707600-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313115235.3707600-1-nilay@linux.ibm.com>
References: <20250313115235.3707600-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y7FcOBJOJO8Dr7Nrp71Bz1e6jg8u8wlm
X-Proofpoint-ORIG-GUID: Y7FcOBJOJO8Dr7Nrp71Bz1e6jg8u8wlm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=883 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130090

The hctx_busy_show method in debugfs is currently unprotected.
This method iterates over all started requests in a tagset and
prints them. However, the tags can be updated concurrently via
the sysfs attributes 'nr_requests' or 'scheduler' (elevator
switch), leading to potential race conditions.

Since sysfs attributes 'nr_requests' and 'scheduler' are already
protected using q->elevator_lock, extend this protection to the
debugfs 'busy' attribute as well to ensure consistency.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-debugfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 1c958bbaddce..3421b5521fe2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -347,9 +347,14 @@ static int hctx_busy_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 	struct show_busy_params params = { .m = m, .hctx = hctx };
+	int res;
 
+	res = mutex_lock_interruptible(&hctx->queue->elevator_lock);
+	if (res)
+		return res;
 	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
 				&params);
+	mutex_unlock(&hctx->queue->elevator_lock);
 
 	return 0;
 }
-- 
2.47.1

