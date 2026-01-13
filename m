Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C43491C7;
	Tue, 13 Jan 2026 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287466; cv=none; b=nvV5tZElnah+t7iTuj50IF+vCmvQXGUKrkCL6eUngZVZNRPqdAOzLezFzDYsTtp0s/WGgmMmN1yR8N1TyjCPNZ0ntUeo25MtJE/3EGMrlQB54kBW2H4S0hoQGP1VOU8CR4EYvh4fhCEjsIeBRXtM2gTBa7/WsJZsm5AedQOKvS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287466; c=relaxed/simple;
	bh=BWfscaNYPwnW7IjZIi/MyG5lEbBm/1oE2cO2BGYbPtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtD+L8zJB8hYY9EczMf6F1u6zhcf5NznTkA1pXsUhze5PbX3ZxA7YsAR6qMi9rOEJzyO3kMPvYbRQIRl3bstGd/X8oEA/XvLyJp/b02RGXX4iCGdlnoq2iJ7Qeie1I/+sCkgAEr4jKpoGk1CYFyseaSshOnAWpSklMM0fuyv4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FRLQU1Nv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FRLQU1Nv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60D3Lnvr032261;
	Tue, 13 Jan 2026 06:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BUZxUqZZ1GUQn1N6fTFnOeUubYElWI/wI75Wmh8aM
	Qw=; b=FRLQU1Nvu6JAwN+eBx0tes0fttvIalh+Xxs/yOnGDLd9tlKaEFt+nIsn8
	707tKAX6kiEg6olrIikHXB+Mlf5Vkrw9ITVrYGRVuwwuS7i3dhb0fL+r01dwtB5e
	WFKJXASVsCb3EtimAlhC6eY3K5H1SC/GAVk158O8VpOl59FgD90KGs3VZkXLYdUz
	ZbH3xYfalTEm9h1g6/HrtwuIMldwXBctCu3xyesg4nR7TU05Fl9wwrFbq1D/N9ie
	TBagu+Nv3uUM4Jzmk8iBgdHhZFJDPcz1Tt56XoyHVvCxJiV/t9Wu+rOcwGWRJc6n
	OEskQBlMRIw5NLLA7rw64RFbri3Fg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedstr9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 06:57:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60D5YMNW014278;
	Tue, 13 Jan 2026 06:57:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fy2rqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 06:57:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60D6veph51577128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:57:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2356D20043;
	Tue, 13 Jan 2026 06:57:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADA4F20040;
	Tue, 13 Jan 2026 06:57:38 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.193])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Jan 2026 06:57:38 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, gjoyce@ibm.com, Nilay Shroff <nilay@linux.ibm.com>,
        stable@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCHv2] null_blk: fix kmemleak by releasing references to fault configfs items
Date: Tue, 13 Jan 2026 12:27:22 +0530
Message-ID: <20260113065729.1764122-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1NCBTYWx0ZWRfX2uzhD8WkxaJA
 j1FhD+UvsrGICIMToLNQHlj2jPvu0ez2rymzWtQVI9CqjVgc5PYbXthoGAsw20WtSJm+FSAR/u6
 vX8XSxxukWa8My5n3gZE2D5BUrF9NYRd7cv5t7xN22GbF0352BkwBWQflndVGZXOYcUUWsIPfSc
 f2b93CtNBzsnNL/hMbL1dzBdZSpGwpuCSPzunKvnvrmuBmUL70Fz3G2yjGxAPxEwplCGfp7D8J6
 3dVARoLfOyQEAxuz/JMJoLYpdxG6WDn3eNy3YC/053o3LHm4fS+Q4VYhJfYe846lyWOXOoRaa5D
 vXhAqrjc8c8gK48ywBdODTRW1niiTGOqg+GLuCRkrpHVer85OkuFsVVDCx06JwxIJ2WCkZkD9wD
 8TWozsWXLFJBRfz+Cy1i3ZnSKFJJ0cVwZLSvVHoa1+X3FDf+GyoM6zDzEzfQAK8uuM7y3DXx5iP
 Cm9ZWS5DRn4n0y1h5uQ==
X-Proofpoint-GUID: HhylLc8gok_Rxcl78v6mTGVH404T4haF
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6965ece6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=w_JtO988ZX80fDk7qXcA:9
X-Proofpoint-ORIG-GUID: HhylLc8gok_Rxcl78v6mTGVH404T4haF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601130054

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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Fixes: bb4c19e030f4 ("block: null_blk: make fault-injection dynamically configurable per device")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
v1->v2:
    - Added fixes, stable abd reviewed-by tags
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

