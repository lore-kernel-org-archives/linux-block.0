Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5D345752
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239614; cv=none; b=MNQo09kobi1U/kGw841oX3duzfFGfHrd08yy7ldRI8gyL9pzOb+Nn+EEz3615zhxt//ymGEo4xOdk4QoyWMlvbQo7v6CB3OSnHQ04xYHmc19w0QGNBWBfpLopx/r8WTXNOzGQqxDhOq3qOtTjnudtTywfN6lPcLwuWeZoWJgcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239614; c=relaxed/simple;
	bh=rgLdTPq1BrgfJDP1xqQlvUY2nWT0/dySwn5gWmxRvF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpjnremdQieYTwyF1vuqMTj6I6oTabOE5UlUi0qO76YKtGFixED2xJ8FrjXDWJuSwB5UYj5WJqkPKwx9zCUdTAvGmnOqVn+wPBQWJKIBZ8dLgkBPJ5jsav5N8xskT2J28dPYOLOcrRjEHg+bCHQRnAGSuChIE7jy+Hf9V30dURg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eFFFLcB1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eFFFLcB1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60CEY8LD006734;
	Mon, 12 Jan 2026 17:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WnWqkMKth3Nx/JU5VBEMRw9PaQRNEwtMPBWTEXCQV
	JU=; b=eFFFLcB1rysEJYR3yQNOfcdYWDQsnGYPh0h9xMIDsuaHMv2l19fUbdyyt
	QqVocLNCqn+FrzWWR4q4BkqMkMXd6xRl/yO9cNmGcAmIRE4HalHRGEAxl+KallsS
	pOcpJ6Nf5RZi0+ckRrASl3jxKHnCegFtFX2e4LIybvAwoqoSI68UaeUdwJLjdhi3
	Xc77mBmLe+kHDgpOra83eTykN7MNqD/h6uJHgD7lshxG/RsWZ5fTL1TYBRzQt8w2
	ZzEWlHVJEgwqm/RQJoOyymcY08LwCxsH10Oyj2uHPWp8NpFgWArvqZiDtdYgUvcX
	Ft5kpEaickARgkSdVx/trn9miUcow==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6e06an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 17:40:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CGSMxP025566;
	Mon, 12 Jan 2026 17:40:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23myb47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 17:40:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CHe7T252298172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 17:40:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E9D320043;
	Mon, 12 Jan 2026 17:40:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2A592004E;
	Mon, 12 Jan 2026 17:40:05 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.142.186])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Jan 2026 17:40:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCH] null_blk: fix kmemleak by releasing references to fault configfs items
Date: Mon, 12 Jan 2026 23:09:55 +0530
Message-ID: <20260112174003.1724320-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3m22ch9fjFoA6cK30SqpBFt8fnfL6WeB
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=696531f9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=w_JtO988ZX80fDk7qXcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE0MyBTYWx0ZWRfX80GlZWowyaEt
 a7pa/yqkPLgSimXh8LS687hiiJU3OeVjCU+aihrF1p9odpGgh63Qt+IpVBq7FkfvuVUICB9Tw2p
 l1fwoNY4G8xMuR0Hq2QpPyntlcvSfqWFbxuxIMNGmoypUEb0fWZoSKOjsRDRvQAogrIz4QpzVeF
 Y1/ghgHQFuRWCHishxstq1NFMd9KP4czydZJ5dl40poZ457HJ46c7eqoXMKlt/o0WV81Nh+xIVR
 rpzd5yfdJRBQpHhak0HPF4tTTJqs1Rd1xcqT3WhDR2OKccNfru3n/P8clG8pnsFD+hKyargulf1
 5W7SefClqmZWDlh45/7v9xgiB+2h5iGZtKOqgBxgu/UjwzQN9AGa65fwzia2QjxfsI4jPENOsXz
 e/21qFU6Hlukg5yJUMcSlYRGljKUpKBeZe6UbrkkBS34Zh45QdvLRSrdXkT+fsgWAqxgu9W2bto
 qxi5I/VH7OO4LrepDEw==
X-Proofpoint-ORIG-GUID: 3m22ch9fjFoA6cK30SqpBFt8fnfL6WeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120143

When CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled, the null-blk
driver sets up fault injection support by creating the timeout_inject,
requeue_inject, and init_hctx_fault_inject configfs items as children
of the top-level nullb configfs group.

However, when the nullb device is removed, the references taken to
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
configfs items when dropping the reference to the top-level nullb
configfs group.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
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

