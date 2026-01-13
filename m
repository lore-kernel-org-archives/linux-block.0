Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E926A0A7;
	Tue, 13 Jan 2026 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282171; cv=none; b=kzOYNk/jmaKEFsNK/fS3eBYeZXin2+Ekj1V9QxL7lcxFVUNjm7WA+0QdYGhbyweExGyMnBR7nj5yPePO995jA9iqUn7+j1qgaH7LAm9A/teCYat2B3O5gwGu6eBPaSnXWLmZV1rZE0vcFfHsrO0YFT/SLVVvkLo0DQ2tFQ8WdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282171; c=relaxed/simple;
	bh=7Je1yLFj86PYHzKBY2Ymj5N6IGTMfjt0k6b41JrQAhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mSkI73bf/jZNL2f3KsNkg68a7iInAq1dZaGWxYFpJiN09Rmz6sGneK90kP4WB6T/1wMlNIYX941DKAPf/cOukmzdxs7CaIPr+ao160Ev1gpozInNSfTPmRJc4KBpPdsHaQewUEWR5tswCznTOQz1xqWEH/5w8ArQEOWDqLqC4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Et9og4DQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Et9og4DQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60D14BtB001750;
	Tue, 13 Jan 2026 05:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=l/Gm8XhO0jm50pd8vnU6JnAyR70D3utZ5sVBbnh3z
	JQ=; b=Et9og4DQaBbwZI4GFKDpU0bNO72ywHmx9ftZp9j/Y8iWRYLxjfpfZtI9n
	zhJAvFv2PCiw5r2XZzlFIhq7ioREIzuRXtckaupBkIyck+0jwwzyF7wCkct70yKV
	hBzd2ynlCakAyLhooInKHDiNW7bGFyz3wJWAX5qq31H7R6nVnzOa4N36Hth+NcBK
	Kcg2QtfW8fRkR/z+NXcaGdgV1ysO/KmTqmJmB38CfrlcLpjca/nVIcxjXmJRFVUe
	ASYXbL6T/OcC7lX3ljNh951bgkTdZoqLjkXEzimQTmyE/pUeOaK3+p9CAskmcAEX
	BKx9SVRZnrFGH/ukOqassCC9RFk5g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h2rr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 05:29:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60D1nKZg002505;
	Tue, 13 Jan 2026 05:29:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13sjgtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 05:29:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60D5TQdo51577320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 05:29:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED4A120040;
	Tue, 13 Jan 2026 05:29:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92FE020043;
	Tue, 13 Jan 2026 05:29:24 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.193])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Jan 2026 05:29:24 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, gjoyce@ibm.com, Nilay Shroff <nilay@linux.ibm.com>,
        stable@vger.kernel.org
Subject: [PATCH] null_blk: fix kmemleak by releasing references to fault configfs items
Date: Tue, 13 Jan 2026 10:58:04 +0530
Message-ID: <20260113052901.1741689-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kQUVrZhw2c5FNefoDXKU7aChJ3JL8nkQ
X-Proofpoint-ORIG-GUID: kQUVrZhw2c5FNefoDXKU7aChJ3JL8nkQ
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=6965d838 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=w_JtO988ZX80fDk7qXcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA0MSBTYWx0ZWRfX1yO5nWOxgRLY
 VmnGqnIOBcqm8iLM0MIuivwP1xhGy2itnP8m8yYU29omP8gBOv5Brldesj4c2ZG10Pjqg/46cAY
 GLeFURfpNThy3FDSTG3QL79ci/Li5SsE9D6nT2N9OBTFv/hPmFFmi8mH7m8FtFDYyanmbclAI9d
 sOD2OV/yAye65fq7jjuxlsqqjG9+Uq2EB3du+th8jqPnazLJMEcQ92KKLFZmslcbJWMAX1AkOrW
 wrEgFM6PLh2eIsqMIZ0NNx56efoVLhh6v6NekLnKigeBXsjY0iRYWpWADaPdBiJKs6S3PJzi+wI
 3ZAq5D27nU1/11ZX5TticQ9pwXbek/72cIfgbrCFsSK0UAa9IscxKpjkXnxW6pvnG7DBo7CYIU1
 7usdFEL3PMINPaa4vNAQkvM3iYoyYuS6MU7h2nNeXeBd1NeyUI5jFZH6SxxRKaniSl0G9CrPUIQ
 bmu5IVkuXlsD9Pd8Y4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601130041

When CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled, the null-blk
driver sets up fault injection support by creating the timeout_inject,
requeue_inject, and init_hctx_fault_inject configfs items as children
of the top-level nullbX configfs group.

However, when the nullbX device is removed, the references taken to
these fault-config configfs items are not released. As a result,
kmemleak reports a memory leak, for example:

unreferenced object 0xc00000021ff25c40 (size 32):
  comm "mkdir", pid 10665, jiffies 4322121578
  hex dump (first 32 bytes):
    69 6e 69 74 5f 68 63 74 78 5f 66 61 75 6c 74 5f  init_hctx_fault_
    69 6e 6a 65 63 74 00 88 00 00 00 00 00 00 00 00  inject..........
  backtrace (crc 1a018c86):
    __kmalloc_node_track_caller_noprof+0x494/0xbd8
    kvasprintf+0x74/0xf4
    config_item_set_name+0xf0/0x104
    config_group_init_type_name+0x48/0xfc
    fault_config_init+0x48/0xf0
    0xc0080000180559e4
    configfs_mkdir+0x304/0x814
    vfs_mkdir+0x49c/0x604
    do_mkdirat+0x314/0x3d0
    sys_mkdir+0xa0/0xd8
    system_call_exception+0x1b0/0x4f0
    system_call_vectored_common+0x15c/0x2ec

Fix this by explicitly releasing the references to the fault-config
configfs items when dropping the reference to the top-level nullbX
configfs group.

Cc: stable@vger.kernel.org
Fixes: bb4c19e030f4 ("block: null_blk: make fault-injection dynamically configurable per device")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
v1->v2:
    Added fixes and stable tags
---
 drivers/block/null_blk/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c7c0fb79a6bf..4c0632ab4e1b 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -665,12 +665,22 @@ static void nullb_add_fault_config(struct nullb_device *dev)
 	configfs_add_default_group(&dev->init_hctx_fault_config.group, &dev->group);
 }
 
+static void nullb_del_fault_config(struct nullb_device *dev)
+{
+	config_item_put(&dev->init_hctx_fault_config.group.cg_item);
+	config_item_put(&dev->requeue_config.group.cg_item);
+	config_item_put(&dev->timeout_config.group.cg_item);
+}
+
 #else
 
 static void nullb_add_fault_config(struct nullb_device *dev)
 {
 }
 
+static void nullb_del_fault_config(struct nullb_device *dev)
+{
+}
 #endif
 
 static struct
@@ -702,7 +712,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 		null_del_dev(dev->nullb);
 		mutex_unlock(&lock);
 	}
-
+	nullb_del_fault_config(dev);
 	config_item_put(item);
 }
 
-- 
2.52.0

