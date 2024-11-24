Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077E1B4F0F
	for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453024; cv=none; b=Npc11FY5BOAXQWHMPtxYvJhs5DZZu+xGmAD6XqsQFcWCYayWOkyjDug3Ok1fbiRuNP4qKncVZMfynK6CDVPYbMDD3U1swSmmNbE5f31OQQzsr61Tyfep9Z2kT0TxbJTZvFd+O7FJ7QihdImoWqZ3oYDlMv1YczCFvSBPtcESNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453024; c=relaxed/simple;
	bh=ahVCmtt3bfePZIIVrlj+yR5s34VlsZBHeUfsezoLr34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLwAl71iEgLDtbHp+2wdDWPiCjZgTsCsJWTiH/I5kPht0QUjgAhQBJrmprqiBPqjftDcQANEM/9BLvFDqhM8kfYI1whoqtPbba32LZnYq/kYurbCNYp/DtErDcpyZtj8PxKsscxV4t+f1Wq445A6TcchBlZayRFoqN+dHZJ3cmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hUWlpiP8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hUWlpiP8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AO6hSKY026890;
	Sun, 24 Nov 2024 12:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ib+A9tEwr4Cf/PkY0y7ZpBD0wncIrsDb5788WCUTy
	p8=; b=hUWlpiP8NsGPHv3xYgRkHH5zcUur6CId9Hho1YkIeE0m7CUWdsLZpLQld
	ka71CKHTVFcV/oNjlkDMBsDgPrvGWVwkKElUhgq9tsfjDn12BM6NmmmATeXNJj2i
	ZFmec9nINHTw3dwYit3SALzG2eKqKUCCq6+JNXeFoDcgMW6vhnN+Y0Vt69Z361hu
	RA1/0I6/wGi2qjvSna84E6H0v8K/XtumzPcLjYN2GfUIalCGLafe2Gf6xKt7zOR+
	v+9PKJLN8lhtDKir6CeXmODatSL8VA5I86dRzLmNe5BshL+wnKOm07O/6sy5eTWd
	sRUlV6WZWO7hlLPifKrrCmlyOLl8w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jm1eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 12:56:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AO2gcTc027494;
	Sun, 24 Nov 2024 12:56:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 433ukj0mqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 12:56:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AOCuWWP48955650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Nov 2024 12:56:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90ED220043;
	Sun, 24 Nov 2024 12:56:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2CFE20040;
	Sun, 24 Nov 2024 12:56:29 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.4.180])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 24 Nov 2024 12:56:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, yi.zhang@redhat.com,
        shinichiro.kawasaki@wdc.com, mlombard@redhat.com, gjoyce@linux.ibm.com
Subject: [PATCHv2] nvmet: use kzalloc instead of ZERO_PAGE in nvme_execute_identify_ns_nvm()
Date: Sun, 24 Nov 2024 18:25:53 +0530
Message-ID: <20241124125628.2532658-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yg3Lm6ZW3isdKx0V2hMI4aWlpsnWrVVJ
X-Proofpoint-GUID: Yg3Lm6ZW3isdKx0V2hMI4aWlpsnWrVVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=998 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411240105

The nvme_execute_identify_ns_nvm function uses ZERO_PAGE for copying
SG list with all zeros. As ZERO_PAGE would not necessarily return the
virtual-address of the zero page, we need to first convert the page
address to kernel virtual-address and then use it as source address
for copying the data to SG list with all zeros. Using return address
of ZERO_PAGE(0) as source address for copying data to SG list would
fill the target buffer with random/garbage value and causes the
undesired side effect.

As other identify implemenations uses kzalloc for allocating a zero
filled buffer, we decided use kzalloc for allocating a zero filled
buffer in nvme_execute_identify_ns_nvm function and then use this
buffer for copying all zeros to SG list buffers. So esentially, we
now avoid using ZERO_PAGE.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: 64a51080eaba ("nvmet: implement id ns for nvm command set")
Link: https://lore.kernel.org/all/CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v1:
    - Use kzalloc instead of ZERO_PAGE() for allocating zero filled
	  buffer (Christoph Hellwing, Keith Busch)

 drivers/nvme/target/admin-cmd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 934b401fbc2f..f92c5cb1a25b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -901,13 +901,18 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
 static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
 {
 	u16 status;
+	struct nvme_id_ns_nvm *id;
 
 	status = nvmet_req_find_ns(req);
 	if (status)
 		goto out;
 
-	status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
-				   NVME_IDENTIFY_DATA_SIZE);
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.45.2

