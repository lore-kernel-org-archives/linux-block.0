Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616E145328
	for <linux-block@vger.kernel.org>; Fri, 16 Feb 2024 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117479; cv=none; b=FAZ121FOcrkRiseg2vudbZTCY2AA4QAQywMThRFLiYk8JpGMNt7HJXS/zGhRZGXT9n5md0UGsVl6fIcPT+M1JdEhYg5Pv8/cGjhmmORMcyCalZ6LvM9+ZbxpHzH/sxHQ6oJz5L0pJGGEAlS64xYBLFGfB5Ri++fg+r9lTZf/7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117479; c=relaxed/simple;
	bh=guIGWwKQy1UvuQYjGnFY/gU61jblFXAtYISCDrB97Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cd+/BUrmMgG8hpT71ZkV0/yWjE8cvTEbX6oZ+gch85gTU059rpJZCm7ZZLj8NRkx2+UtUesa8rHzqZl1+WpIcCcU6wyzODo6KGlpbYJzCRVc9oGqWVHLyp/36GIbKvV+75rY9TcT8k1tn/Y0iXfcyv48ZvdpzTKVqaOCRawNVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dg5Hu4Nt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dg5Hu4Nt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GL1eoD012667;
	Fri, 16 Feb 2024 21:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7Zunqwr6T2l56I2nx1OW+7CDyoD2dmq6P+N+pbr7Ol0=;
 b=dg5Hu4NtXnYeksE9AjwjiYdELo06T+wanol//BZUsF2kwTer/Sp7D/RVoP36SHEVD5v7
 +B7AcOmpZEVYpSG1P9Iirb0+MGQND+QcAitIUAGPkGGSOXMq59Bx+f1lEttAYDk/JZDN
 AgxyWVkUjvDhT3pApl79pin+KNh6aM8NrIBmYjb1vNbyGvNGCIrRpTclJjB7OvR8y229
 +qyinG9W7pYqGfyn0gvGc4lflnGAuGrpWyx2yWEPv+s4qYTB+jB9GK2Hmo+3PY+SlvTN
 fihIq9T/AmPGUuO13BOat8TpIedkmicWZdlciJyVlXffBkqUqKJ+IEDE3w1yayKff68n Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wadh1218q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:04:22 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GL2PkX014690;
	Fri, 16 Feb 2024 21:04:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wadh1218f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:04:22 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GJ0lm3024877;
	Fri, 16 Feb 2024 21:04:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpwrkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:04:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GL4IRE13894352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:04:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F170358064;
	Fri, 16 Feb 2024 21:04:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4CB858061;
	Fri, 16 Feb 2024 21:04:17 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.61.109.190])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 21:04:17 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, brking@linux.ibm.com, msuchanek@suse.de,
        axboe@kernel.dk, akpm@linux-foundation.org, gjoyce@linux.ibm.com,
        okozina@redhat.com, hch@lst.de, dwagner@suse.de
Subject: [PATCH 0/1] add empty atom support to SED Opal parser
Date: Fri, 16 Feb 2024 15:04:16 -0600
Message-Id: <20240216210417.3526064-1-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jaIOe4loHHNfFAGVO1uUtd14LTown0FP
X-Proofpoint-GUID: bxwnSh-ZAtlyBygt9MBtBAMgSn_c1xQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 malwarescore=0 mlxlogscore=773
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160165

From: Greg Joyce <gjoyce@linux.ibm.com>

Some SED Opal compliant NVMe drives generate "empty atoms" that cause
the message response parser to fail. The TCG spec indicates that 
empty atoms are for alignment and should be ignored. This change
adds recognition of empty atoms and ignores them if found. This
allows the parser to corectly process the response message.

Greg Joyce (1):
  block: sed-opal: handle empty atoms when parsing response

 block/opal_proto.h | 1 +
 block/sed-opal.c   | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
gjoyce@linux.ibm.com

