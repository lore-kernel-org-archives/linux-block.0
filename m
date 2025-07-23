Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066362E8DEE
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278313; cv=none; b=NF1OIMmEqXCLMHygip302Dnd+Uq4YtpPel8ZZBOoAIyptdrq/qPG5ldf/WVyEHSPsE2ANTRtX//XRI/YOeGOl48lVa57FsjorT0aJ1szSqOYblJZcGou8X3ukz3iptzQhMdiWe6F4K07bH4vRK7Zm8TeOWEbm4q8wqV7XLohMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278313; c=relaxed/simple;
	bh=qC/9AjnZP8KQEcZGGqcduig/m57sgItKvtJxXbCbJT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJhylkxaPMR24fi+RKYjImxPvnuv9JcBylTLLqNYZj6kVUe9E24udsE+VYGbL8afIQAL235BUYqYgD+8UWaO770Hkede4xNuZ8IO9WS+S3zFuBXqJy86hsXp7PwEHF7WCRmCzOeyPIfcP7x8FxxwGlXvxSW0VPTGzvlGUQC/uiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jX310A3D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jX310A3D"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N4qrMv015911;
	Wed, 23 Jul 2025 13:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Kpwt1GMrEkbfJ65jtJtdzsz6dnI6
	Ij6clusxzB0I6mc=; b=jX310A3DniS05KoU/2s9hXeoznTiq5sBXp7BbED3qNP/
	V75CPtsv/L6xf6JB+Ejm8Vx0Z/LiY2AFsE8w6o4sD8Mqzf6GKIeBbQD1kNqcWE+1
	sre2pX596qF35mY2nPHsXEIIF1s7UcH6WNXHG2TA0uZjz2eAubh8VKgdyHnm7h3U
	gQB0jB6W7l2Om2LOeAlfOjUtQfVj6w7GdLQtZ3fOMxoH4DY/YAjJO9fv2ts4BOCZ
	zSMxzOol+S4mxdNQjAGueYjVt5Jrez0QXF//3HultTJG/LLbez8lbQE3XNV/bZDj
	ALoLQz79MpoUutwtiaRE3pGACYuNvc6FnTqH30kvgg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff651uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:44:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56NBNfJ0012867;
	Wed, 23 Jul 2025 13:44:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p30862r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:44:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56NDikFt43319620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 13:44:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD28F2004F;
	Wed, 23 Jul 2025 13:44:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0A6820040;
	Wed, 23 Jul 2025 13:44:43 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.41.196])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Jul 2025 13:44:43 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, dlemoal@kernel.org, yukuai1@huaweicloud.com, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, johannes.thumshirn@wdc.com,
        gjoyce@ibm.com
Subject: [PATCHv3 0/2] fix sbitmap initialization and null_blk shared tagset behavior
Date: Wed, 23 Jul 2025 19:13:53 +0530
Message-ID: <20250723134442.1283664-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfX7nef9EkqqEhn
 Nr7ZhSjAbEGOVQPHzkpJKeyFQQ/Oe2wt1+F24qArN1rYu6PfNe7z+hSQ7akrolhILZBuz1vrFOr
 AZm5DZsVXBFW25SICjJkUllJZgqpfHSoT6ZDNqRM1InIwAWvkdFHOgyhOdAsN+/Lq51roZcL0BG
 hcp9vpcE13jB1MkJgZ29oU85KEmdg8kJKjD1ENj2HspPMqmH3jMtWJRUeBxafOgLDDouQoXWMNc
 Zmrey5rdJxXkOxUMl1VgOdLapbwpA7oQIivRDFynj+WCRgvWKoWNN6lK4tyk9ma080joZTVs7RQ
 5BRjEHinMGQane+jaOvhigRK2CqY1GCK9GuRwboBifOcN02dlEGocOUaz/IgjTCEnYzYb0Z26cD
 3PRqVlmfwRRt6KGWn/p/3mdrasKnbj58S79AgUNZbbsDsKV5rBAK1R3OGOcuLRS9MeUZLleh
X-Proofpoint-ORIG-GUID: 5T0kPg7P65DBXCCBaNaul7RnzDl47vM-
X-Proofpoint-GUID: 5T0kPg7P65DBXCCBaNaul7RnzDl47vM-
X-Authority-Analysis: v=2.4 cv=TtbmhCXh c=1 sm=1 tr=0 ts=6880e751 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=MMnfdg8G3pu6OI0W2nEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=858 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=90 spamscore=0
 adultscore=0 phishscore=0 bulkscore=90 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230117

Hi,

This patchset fixes two subtle issues discovered while unit testing
nr_hw_queue update code using null_blk driver.

The first patch in the series, fixes an issue in the sbitmap initialization
code, where sb->alloc_hint is not explicitly set to NULL when the sbitmap
depth is zero. This can lead to a kernel crash in sbitmap_free(), which
unconditionally calls free_percpu() on sb->alloc_hint — even if it was
never allocated. The crash is caused by dereferencing an invalid pointer
or stale garbage value.

The second patch in the series, prevents runtime updates to submit_queues
or poll_queues when using a shared tagset. Currently, such updates lead 
to the allocation of new hardware queues (hctx) that are never mapped to
any software queues (ctx), rendering them unusable for I/O. This patch
rejects these changes and ensures more consistent behavior. Interestingly,
this unnecessary queue update path helped uncover the issue fixed in first
patch.

As usual, review and feedback are most welcome!

Changes from v2:
    - Updated the second patch to prevent the user from modifying submit
      or poll queues when tagset is shared (Damien Le Moal, Yu Kuai)
Changes from v1:
    - The set->driver_data field should be initialized separately for the
      shared tagset to ensure it is correctly set for both shared and
      non-shared tagset cases. (Damien Le Moal)

Nilay Shroff (2):
  lib/sbitmap: fix kernel crash observed when sbitmap depth is zero
  null_blk: prevent submit and poll queues update for shared tagset

 drivers/block/null_blk/main.c | 32 ++++++++++++++++++++++----------
 lib/sbitmap.c                 |  1 +
 2 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.50.1

