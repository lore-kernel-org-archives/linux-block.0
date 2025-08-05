Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126CB295DBE
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414300; cv=none; b=GEIHqQU8AwcpYDimmT+sbDdBAtAAjrssEaBh6Q8fhhF4XyWztJbSITr+TEm5WwPHd1qtRG4ygbG6vnPfePavKgOazyibkR0HEpUSZ3uud2c94KXBFxVzU0Ps/q5PAOmnXf3wooisi4CnP/mMnpcozJE9nrn5CqZLXrdAv9UQ9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414300; c=relaxed/simple;
	bh=dONyzp7vO9CcsBjoHJ0PYTOUNUYjyjdwUhUPkGq3pbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HP8Rq/K/l3QP2VlqPp8443gknmYNCtPkysApECmILbvt0yGcVSB2HMrNxYEerT59O1MUKHWmR4j32HhResb6CUqo0YXM29C/p2bU6TyAMg2Og6p68CfG+TEaSfrfguYneoh/H8bXyQ/6lngw7UrRrlrtJoyvzqJnA26t7MF+E3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k4Ot37xt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k4Ot37xt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5758gZHM005150;
	Tue, 5 Aug 2025 17:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CF5dkEA420dSjpqtU
	9G7AGtYx8H32GBKnkJDS99Fcx0=; b=k4Ot37xtfJkiS0+QZ05szquvXy4pcChGt
	649vUBW0ufSIpSjDOTAM5XSIlkAzyYFyNkJ4EpJoKW1XaBvJT6gQEw4ImoJxO67z
	TA3bbRf89WvF+1/PGk+WSATVDU6ijhSqaXnAIKslh/T1yfSGE+jicuYKo+Np98K9
	v+cbpA53MiveZCiJ4X8vPwfQ/ltlhaE8gVAOZXYRLAEAzK9IpAUP0lCjs5RQTnLB
	fucpIwyVwjl6RzqZqDBVWnmBbd6PG3CfAPLGD7A8Iwrh05V4FeXnK75LXeD2OV0n
	3kwAERoH2BYPzGnoAe3KIPEChtCL1d5wXROAgqu6a5vHxcjeYAGJw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0yvf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 17:18:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575DnsYs006827;
	Tue, 5 Aug 2025 17:18:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489xgmkbu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 17:18:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575HI0dS57999748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 17:18:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6055E20043;
	Tue,  5 Aug 2025 17:18:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A54B820040;
	Tue,  5 Aug 2025 17:17:57 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.35.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 17:17:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, yukuai1@huaweicloud.com, axboe@kernel.dk, hch@lst.de,
        kch@nvidia.com, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: [PATCHv2 2/2] block: clear QUEUE_FLAG_QOS_ENABLED in rq_qos_del()
Date: Tue,  5 Aug 2025 22:47:41 +0530
Message-ID: <20250805171749.3448694-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250805171749.3448694-1-nilay@linux.ibm.com>
References: <20250805171749.3448694-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JVOzQmfwbb0DIKP3zNnjeashXHH2Cb3i
X-Proofpoint-ORIG-GUID: JVOzQmfwbb0DIKP3zNnjeashXHH2Cb3i
X-Authority-Analysis: v=2.4 cv=GNoIEvNK c=1 sm=1 tr=0 ts=68923ccb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=UJK3Dzy7yT7oL-vBR3kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDExOCBTYWx0ZWRfX5KXhLznwAQ7n
 +ml0m0veKwNnFIf5VEQVO4NNciL/rmB6H8n0mX9BLSvPjZnzn3y6XUT90SwE3NiPsCthhfQAoD3
 /MtgKgad4BsqLWoy89h+gqIo3FI7IH9iDTRaKu8VUrwPBMbXzF3QpO3xF9W6PhP2pqcZ7KVLwzf
 SJQjO5AiBR5V7cTnc0eLG1pgrE22jq5UYCpIaC3RJAjD5UCgTtWlNXgZRYfR/nBAZ/AQlxriNeW
 F5oHPhH3Fteo96mXd03tlsaR6x8YZFDmVYt6V4m9DG6i8VlzeHHwghXIerpSuB0NUzEU1wlOavu
 QrP8PIqcH59LyV/4NTCmkoFQqwUuaMHfPS8hovN9l8fURDdURhT3Eb8JWWff2wyqcpVmU/0xkq0
 h5zfkg7yvXKt8Qf5aiRufJe6FhzMWRQxCWa1ZxXKpRSrYPgYxMnyElkqHlfnIXM2F3Cahl02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=866 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050118

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

