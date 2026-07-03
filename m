Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BC346E60;
	Fri,  3 Jul 2026 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061767; cv=none; b=jRATN25ikkuF7wQlBJSxpPr/muAvBegudaqP0C7Dnfw5tfNqky7SIamRiJbh5L0TvZnzlnmE621k4eN/23yi/tGW0VXZVOVe5CZrhUgZjnwRN7QIC2PD2mT8z5TTf0vU9j0/6llFnSIOlUPyj0YGYnWTKZk4tiGt1S2K/67QKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061767; c=relaxed/simple;
	bh=s2VKc/HzDR6VOFLOuGLN65AXOrIGehsGR/A56Y18d4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MiUGqdtV4ORFE+OjUYVC8lAFebE63vbrKVttFZ2vdnvlrJOLPCLemzpQ3L7WswpNzG+SolDKFl4WQTuQjAQeitl2n5jyiukPewDzymz0ett48neglCqyS5PmSsaDvA8a+ugCS4yXqN4PRsp8RFp2HU28znbO3kbQ6OZeAl3bJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Pv0vzNlB; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Pv0vzNlB"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635tm343634610;
	Fri, 3 Jul 2026 06:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Katjj/cuk
	Rgdm/iNJiHF4WzT64MfVpuABmmk7thjFmc=; b=Pv0vzNlBidOV1rj6J0KnHHG7t
	lOFlHo5W7sR4i/40ETKYuBnUx7TKymTScmWTgaXXksRfFPwotVkxclmDKo3cfjvZ
	aMTrRfVzlD8NdCoUuyYYFaHBrOXgYGHzBpbY/a3NUPHndrauibi1qJ0nxHo7dsvT
	UZzR3gcH+CXxmlcoPIfQ113QoY3SxE4IsJxAFohKsiEENm87shzldM2IjFcVo/9z
	R1X08imuJxvPxgTdLiNsloN/HXXSsObPm0zC8/veBDAJrIGUyONo9FwPYG/RCsA0
	kWrB4pzySDwNYHJeyo76LBuCMc7BQmpql37oYXw934jUSyoo4ZhY787t8bPMg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f23r0h6jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 03 Jul 2026 06:55:54 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 2 Jul 2026 23:55:51 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 2 Jul 2026 23:55:49 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <axboe@kernel.dk>, <brauner@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH] block: reject block device inodes with i_rdev == 0 in lookup_bdev()
Date: Fri, 3 Jul 2026 14:55:48 +0800
Message-ID: <20260703065548.1135125-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DNC/JSNb c=1 sm=1 tr=0 ts=6a475cfa cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=sDr0Vi_8eM124Q3J9N0A:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: SyaiLJQogmZUyd1CPa6rwZ3loDidgE4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2NCBTYWx0ZWRfXxgdYRcoUHxZB
 vYydIph0WORBoQ9S1O/Wusd8YniyUpvTqnjN18RjQx/rzrvhzXlSeBdujCcEFJQkfaNXROfshFj
 u5GFDrijb6xE+1/K5lCUEBdGqdKU1l0tm6kIIgcK7hO4mgPfE9HmyuFbm3BDsyNaWqM/iwzX84b
 1nFVP2c8Ptb5SXzLxOb2/F4K3H3k3XrZ4l/qJEjHsuXkPH/jZkmJpI6HcftefxC1Q+/1Lhg9xAb
 XRYGtYfMdCxj5U9O0elKHg47Gt/zQPPcO7xoavU7bSfdlckIW+yRlmI5qZlUO/ht6ne+U0PSyyk
 eGRyqNNRUu+GnJimrEygxOo20mQ89tv+b4XEvR/Os5i/ilNWLVc7MzMOE1pqWQELki3Ti0AcQ41
 mrgtN4kgoaxNS5YXNGC1i2BpWkafl26DgfBbWyXsTCeojmUTdOSsLl/ChzIuxr/PdCyjthFmQEl
 fqeUHbcLRVgLjDGn6CA==
X-Proofpoint-GUID: SyaiLJQogmZUyd1CPa6rwZ3loDidgE4v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2NCBTYWx0ZWRfX5gCdSzw8aubz
 ElkUo4MZptPQivcMg6TZuanmYVHobpNQ/lTEfjnNh5cbcxQjyQ337uzP73DKpITfsl7MqdmNusT
 JVrhC1Cnh87dwaP2wFBa49mDNpvmJnPWcNrKaf3Gj1ALl6avr23R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030064

lookup_bdev() blindly returns inode->i_rdev without validating it.
When a FUSE filesystem exposes a root inode with S_IFBLK mode but
i_rdev == 0 (via rootmode=060000), any subsequent mount attempt using
that path as a block device source propagates dev_t 0 into the
superblock machinery.  After commit 9ee5f161a4db ("fs: maintain a
global device-to-superblock table") this triggers a WARNING in
super_dev_register().

Reject i_rdev == 0 early with -ENODEV since no real block device
driver registers major 0.

Reported-by: syzbot+72fe3ea5814121fbc76e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72fe3ea5814121fbc76e
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 block/bdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 28b0d40c362f..797d7f0ef609 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1278,6 +1278,18 @@ int lookup_bdev(const char *pathname, dev_t *dev)
 	if (!may_open_dev(&path))
 		goto out_path_put;
 
+	/*
+	 * Reject a block device inode with i_rdev == 0.  A dev_t of 0 is
+	 * never valid for a block device: no real block device driver
+	 * registers major 0.  Fake block device inodes (e.g. fuse with
+	 * rootmode=S_IFBLK) can expose i_rdev == 0, and letting that
+	 * propagate would confuse superblock lookup and trigger warnings
+	 * in the device-to-superblock table (super_dev_register).
+	 */
+	error = -ENODEV;
+	if (!inode->i_rdev)
+		goto out_path_put;
+
 	*dev = inode->i_rdev;
 	error = 0;
 out_path_put:
-- 
2.43.0

