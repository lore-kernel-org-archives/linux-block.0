Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63C1304BA
	for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265502; cv=none; b=oWU7zVjgT/isLV0hk8QNoNVY2faI6G7iw45TIxnhlTGVZcnScO2uIUWdg5bPFJOYWH013qhakZHz3s0hDkGeaHFviTeYPLEDc+aN5UoJ5E4yn1gJDKrXGSmcWsj4+y/tyRFAUdajQT6w3YXSRWXKrnrvo2yMvz5ad/wbfQ4y4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265502; c=relaxed/simple;
	bh=H0iELvJGxES3mwtUW6HmNU+CRIRPXQKM2j+fo+X+ZN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxPjapmQnVdgplsH4ibYARzPkcUGEtXHt1cXQ/yD2MhxYS0Krgmz5uGUk9akFM7U/bjJ2GAFMoRRTjHyyt7VneyqNjPYP/Hd5rmO/nPBMDzWE2kg9XHX1Wbvx1wyeKJ+nKF5XBWwkNLjY7K/Wx1vsx+7XDAuJ6UH0SRXv3Y5Nxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NTKVGVUC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NTKVGVUC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1qWHk016849;
	Fri, 22 Nov 2024 08:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3WuS8K3W/HLOwRILSZs8BVVrEenqJoia5gwFjWbnA
	6I=; b=NTKVGVUC0vCix+WfX6UjLfCSkocW4rEYDF9ov1XFYdzEwLABHYWcD3zH+
	6FVxHS6w2mGrI2OHb3EdOxIIttG21tY+XeDRtniK4OCPXzbu7Upns+fm/Xa8zF1m
	9ar2iPEaQSuQqjHBpRAUTGBIhvAEyZ6bMC+FHK9ff/QOsrB6JOiNTIyLY1/stPxC
	C/1/S+TM4Xd7F47EuMBOaPThUxJe+HeocJkKjUs4qenBsFXZO90yc/Mm6+F2iAsj
	A9Hq4o6VjoOMLo4DqrTP2QFoq2qkCvbsQz/i0SZhwtPf2U+Fb5QsGNUZduoHVZsH
	b/LlNmXp5SpquNfJln7JuC/A103uw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xgttqyn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:51:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM278cE012123;
	Fri, 22 Nov 2024 08:51:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y7xjthcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:51:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AM8pHaj17433064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 08:51:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0852620040;
	Fri, 22 Nov 2024 08:51:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 730C32006A;
	Fri, 22 Nov 2024 08:51:14 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 08:51:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, yi.zhang@redhat.com,
        shinichiro.kawasaki@wdc.com, mlombard@redhat.com, gjoyce@linux.ibm.com
Subject: [PATCH] nvmet: fix the use of ZERO_PAGE in nvme_execute_identify_ns_nvm()
Date: Fri, 22 Nov 2024 14:20:36 +0530
Message-ID: <20241122085113.2487839-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WGRYmL0WfAqHFqOj4cZiSfBgRFD0fTNi
X-Proofpoint-ORIG-GUID: WGRYmL0WfAqHFqOj4cZiSfBgRFD0fTNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=944 adultscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411220070

The nvme_execute_identify_ns_nvm function uses ZERO_PAGE
for copying SG list with all zeros. As ZERO_PAGE would not
necessarily return the virtual-address of the zero page, we
need to first convert the page address to kernel virtual-
address and then use it as source address for copying the
data to SG list with all zeros.

Using return address of ZERO_PAGE(0) as source address for
copying data to SG list would fill the target buffer with
random value and causes the undesired side effect. This patch
implements the fix ensuring that we use virtual-address of the
zero page for copying all zeros to the SG list buffers.

Link: https://lore.kernel.org/all/CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com/
Fixes: 64a51080eaba ("nvmet: implement id ns for nvm command set")
[nilay: Use page_to_virt() for converting ZERO_PAGE address to
        virtual-address as suggested by Maurizio Lombardi]
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 934b401fbc2f..a2b0444f28ab 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -901,12 +901,14 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
 static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
 {
 	u16 status;
+	void *zero_buf;
 
 	status = nvmet_req_find_ns(req);
 	if (status)
 		goto out;
 
-	status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
+	zero_buf = page_to_virt(ZERO_PAGE(0));
+	status = nvmet_copy_to_sgl(req, 0, zero_buf,
 				   NVME_IDENTIFY_DATA_SIZE);
 out:
 	nvmet_req_complete(req, status);
-- 
2.45.2

