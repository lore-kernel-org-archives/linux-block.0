Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29525744D
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310104; cv=none; b=pXIpF8rX3VeEwdDh4xd5DJ8vRaw4vicow2uqn+C8c3ZqEH8N1unQfGn/QCwAw3/J1AEAS09M4nO6OBzZhKOi8Yb2Ig6ey7yq90ODQMD9eKctOiOxzVCxdCYmZjp4fZYFMY53fvTprp9EyvghdvQ6a2s76KqcEnC8HKkTb2nb3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310104; c=relaxed/simple;
	bh=dONyzp7vO9CcsBjoHJ0PYTOUNUYjyjdwUhUPkGq3pbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGj69Eq2pBQtDQjtxrNJ6phrVIQPbcDzCc84Rg0dSifMM/S4OHUr80nFdqSppMTToACuh9zyIi3QwIJGAAbQ7PXgw/5OEO1FifzFA94t65uFH7UlWkXBwmZzfWdBdJo8JsS/OoOnVG9Rgx0qChxNxDZPohL3g91UcsEZexwamlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lOIaGoMy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lOIaGoMy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574AHTG8009281;
	Mon, 4 Aug 2025 12:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CF5dkEA420dSjpqtU
	9G7AGtYx8H32GBKnkJDS99Fcx0=; b=lOIaGoMyM2SdLQgcK8jsum4ITuayd84am
	ZAf1iFNmcfVHtXM8iMfISHb6VoNvY5CljSxwjI/crmt9t92gkyM3grrNYoAJUxvr
	lfsg2JC0AEecwgHHeMn0rPHLmqJVLzdW3Fffbje/wT82r8Kku7rPjic4VW3DHKIH
	rLShwlOkMEq+4cfEMSlXs4rP576itxwb3H7SPSShT2N8+Z1DSt4nm8GpJUymmr2x
	6W7BfMNf3/Vkh4qOMGTfGP1qs4YmVDMKdllmC/WZunIDWhlBfzljq9flZfOAXzqz
	tYb+2LV9pYWsacgUk784OQ054IZR4pwI84+tf+QABAXCEaKL+oUVQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489a6d8vpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 12:21:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 574A3d2w009541;
	Mon, 4 Aug 2025 12:21:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489x0nwscx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 12:21:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 574CLVSo23200230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 12:21:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7757A20043;
	Mon,  4 Aug 2025 12:21:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA24E20040;
	Mon,  4 Aug 2025 12:21:29 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Aug 2025 12:21:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, kch@nvidia.com, shinichiro.kawasaki@wdc.com, hch@lst.de,
        ming.lei@redhat.com, gjoyce@ibm.com
Subject: [PATCH 2/2] block: clear QUEUE_FLAG_QOS_ENABLED in rq_qos_del()
Date: Mon,  4 Aug 2025 17:51:11 +0530
Message-ID: <20250804122125.3271397-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250804122125.3271397-1-nilay@linux.ibm.com>
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OCBTYWx0ZWRfX/UdbL8snyo2D
 4oL4fqgGIBagCwPvJAaiMX9HOtSw3mxzOKd8LDdIm4ieaMUo1APTzBj3qG3XxQA+wbKUP8wmq5w
 CSqu4mONed8GPR1vupaKdgpbLXZ/XtNltswrleK0TTYNepxBW8Qlq6UWO/23DNUG+sM4t4TjgxN
 sPtbzVOsZUFGJ+LVgzXLZAym60F38Xx/BvZEdAC/rmS9I7eRBaXVKDwdSWmuunSjp9XDUa0ikPI
 q6kToeh+vjsG4mm6PbJCzeyNyTRuuFOQS7NZZcAC4iD9iOyozHPB6Y4Zn4ny1F80077RTS71IwS
 ijfnJC3MGJwGxhxCLptQjBwoXsC5PoQaJ7ptn65h3YIqcTJB/EMDc2r1FEPwI8CHE4Ao3bO4Ygr
 9asiXOTXjcQkYb18InMkeFoIpIcoF8ihNZS0A5rs9/T/BKW2NSsqmhNeLSY+zLSbooF0t5iA
X-Authority-Analysis: v=2.4 cv=Qp9e3Uyd c=1 sm=1 tr=0 ts=6890a5ce cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=UJK3Dzy7yT7oL-vBR3kA:9
X-Proofpoint-ORIG-GUID: RSfGRkyKBqlzWGAPv7miOPzH1dqQuKUm
X-Proofpoint-GUID: RSfGRkyKBqlzWGAPv7miOPzH1dqQuKUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=931 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040068

When a QoS function is removed via rq_qos_del(), and it happens to be the
last QoS function on the request queue, q->rq_qos becomes NULL. In this
case, the QUEUE_FLAG_QOS_ENABLED bit should also be cleared to reflect
that no QoS hooks remain active.

This patch ensures that the QUEUE_FLAG_QOS_ENABLED flag is cleared if the
queue no longer has any associated rq_qos policies. Failing to do so
could cause unnecessary dereferences of a now-null q->rq_qos pointer in
the I/O path.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-rq-qos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 460c04715321..654478dfbc20 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -375,6 +375,8 @@ void rq_qos_del(struct rq_qos *rqos)
 			break;
 		}
 	}
+	if (!q->rq_qos)
+		blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
 	blk_mq_unfreeze_queue(q, memflags);
 
 	mutex_lock(&q->debugfs_mutex);
-- 
2.50.1

