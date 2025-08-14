Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252552E765D
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160004; cv=none; b=UNWghnPqkTgNp9KLNr0v7vNjKs+hEY4yDhItnZ4g9/n8MwyHQfMg6TNp0eVsBQ8IlbMH1wU7P4v2OTkwmgqimkJpnyA9Jj+qkEgHO+sp0N3G74jSiwvEyNKWwdc/KX1GnAyKhMibLxB4N6asVWMifkv6F++WNgKa54yDWuqawQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160004; c=relaxed/simple;
	bh=v0xA2sz1ktDmZGmQ0w/CH3OqTXvCYsqh3+oTcUWEtFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqUs781DHMlQx4X4xAcipRNV0SGXzjVFXss7UngjUoWsYZKOf+DVD8Lk1MAmoy6TXphJwpPAeBUQfAN+k6n0VZcPhv8VwUqqOcM1PTXwFNul8bCpZo2h4QuVxMdGOXo6ACPkB3m+w29iync7WmJDhRDYc1IoiHg5JOnCoyUmCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ux6cA2hL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ux6cA2hL"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DM7Dsh026626;
	Thu, 14 Aug 2025 08:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1GgtySJaTUVduGkkH
	bbdDXac8GLA3X/yTN6CVwqn/ZI=; b=Ux6cA2hLIo9Ph1caoRWtuOxcaauDxYh3v
	e3fXzWuT5uojSXceK2tni4Z7enbpHY70JQjzeoe7vWiimWk+Nj/ZaNVWEMow3KYv
	yXg4K01xUMW4N2Jdypd9TKUvccxzQH2TIVWPFb2Si1Yu/bDY+OB0OxIVEZBpmX7c
	mVJNENyKMse83o4rk9e+IEikLFrBypdjki1Xk9TF1Sz45v1hi9BAiCm/LXNGHRxu
	pabpeI8M+5lTRWV7B/GGjHt4nTeGydUXkBsD/TnYxiaH3+5+ORqlWbMIqlTBSxJX
	SNY0m/+oVJC/6Znb6GY+1dYFvFILMApzl1ejQ3GQzhW9IQJPzE9Kw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaad8ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:26:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8KAXL026279;
	Thu, 14 Aug 2025 08:26:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21bgba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:26:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57E8QKOq49414642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 08:26:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3981020040;
	Thu, 14 Aug 2025 08:26:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4925E2004B;
	Thu, 14 Aug 2025 08:26:18 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.214])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 08:26:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, ming.lei@redhat.com, yukuai1@huaweicloud.com, hch@lst.de,
        shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com
Subject: [PATCHv3 2/3] block: decrement block_rq_qos static key in rq_qos_del()
Date: Thu, 14 Aug 2025 13:54:58 +0530
Message-ID: <20250814082612.500845-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814082612.500845-1-nilay@linux.ibm.com>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689d9daf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=SYFAYIXRm5ESkqApvb4A:9
X-Proofpoint-ORIG-GUID: EwCDCbU5Xzid4rL0FKr10s6ENUPLBsp1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX2f+Ceo4yA4qD
 +FDqUorqwpax7Pejz9dtcUHqAV9ZPxbXjYvFtoh4jS5oO0rji+e0fZYrbBWbMSLGzL7dfwUx7KM
 C8aFbJ9gWoQsp/KKrswnr0wp+Jwj0zj2qitR8+EiOGx4X8SQXpdr98x4lILHPynCjS9waPh6xTe
 tSG2nxm3JZjrurvj8jEsDIUYnGOp4AO48dJ565+6pvYHq/N1OJlbJ9pl1y//p3k9OBbN1mHKtTt
 H05piUBE+1Xo5MEvE4z8J/QugjuWIeLU6cuaW2okae6R2+VNw72q9ZHitjMPu46T4bg/lpQB608
 w6s4/U+757SRFmH9VImls9eCRka8se/j15ZQDjcW8uJb4CiGO4/1IE64KkZIgCAmvU7CVlwc6Px
 SU1ovMB/
X-Proofpoint-GUID: EwCDCbU5Xzid4rL0FKr10s6ENUPLBsp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224

rq_qos_add() increments the block_rq_qos static key when a QoS
policy is attached. When a QoS policy is removed via rq_qos_del(),
we must symmetrically decrement the static key. If this removal drops
the last QoS policy from the queue (q->rq_qos becomes NULL), the
static branch can be disabled and the jump label patched to a NOP,
avoiding overhead on the hot path.

This change ensures rq_qos_add()/rq_qos_del() keep the
block_rq_qos static key balanced and prevents leaving the branch
permanently enabled after the last policy is removed.

Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-rq-qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 848591fb3c57..b1e24bb85ad2 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -374,6 +374,7 @@ void rq_qos_del(struct rq_qos *rqos)
 	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
 		if (*cur == rqos) {
 			*cur = rqos->next;
+			static_branch_dec(&block_rq_qos);
 			break;
 		}
 	}
-- 
2.50.1

