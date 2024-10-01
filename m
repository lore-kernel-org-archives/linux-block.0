Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED828F4
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791425; cv=none; b=cjcCV0pOxPRT9smX/Po+eW9vkh8N9+a/pWPfouJ0TYjIP6R7QQDTawnAxWXBeRQ9JYdWtbiGJfA6l9rCUdEVaREgezxveeVFjXtkrwrgTKIXP0Gl5Yq7hCxDs3qsiNqi3prErbzg89qb7geD5Z0K1OwZ47uo+NhqRFhs1RNr2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791425; c=relaxed/simple;
	bh=7lt8i0f0NGfwpGpBcZC32B05olT28jpzbeQgtjTnyd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMzq6XCmur0GhHgnJ+r/aZkgfHEGeIfz4t3KAQ2zS3m/YpDONtqcFpSMNuSG/uYQSiEkPkCAhtlzUSKzYW4nCGUwKcw7PpSgMCaF1IMvVA0AkVnSk4kCHpBhsdg2Pkc+ddIo/K6ji+whCILTBi+7ezhxuGhIiqhO9xxqjuUPDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UIZnfv0Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UIZnfv0Y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491AqUn4000759;
	Tue, 1 Oct 2024 14:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=BnmecZ0iqTgZULodIzqRc9lkfTQb08vAy8iJId1
	48mM=; b=UIZnfv0YD62X/iXf1XMWiU7GiEMpUJcb/3Cxw91mRBzNyKwhVD4mybx
	ia5HJb37RsM/Z6b8lb936l8m4lhZj7BG05RGtHgyf4fLHIWMXD4Ji/po1YNGqRbl
	wqj+x58Ons3+hjkHckLJnqe2Dq6YjlHckgaJD+i4yjKTgorioZ7FSNwgjDKwjuUe
	ZRIufA5Pi4zkf9n5PAcKXiJz8T0bnRl5fc8BY3M3pUJW3W/uXT9I0LvyWcNX/yL4
	yDvcmwlkXpLqjaC/mXeVwDReZ+njp1vj6ydzfIR9fBewo2CBbTf0ILMB/42/b+8Z
	Q0ga1LXly/AAshwBv4Omn6ylh++l+jQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420fq4s0w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 14:02:55 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491DwjbB014448;
	Tue, 1 Oct 2024 14:02:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420fq4s0w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 14:02:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491CgmYp017836;
	Tue, 1 Oct 2024 14:02:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mvs15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 14:02:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491E2omo42598856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 14:02:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EB242004D;
	Tue,  1 Oct 2024 14:02:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9990420040;
	Tue,  1 Oct 2024 14:02:46 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.143])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 14:02:46 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-mm@kvack.org, linux-block@vger.kernel.org
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, yi.zhang@redhat.com,
        shinichiro.kawasaki@wdc.com, axboe@kernel.dk, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] mm, slab: fix use of SLAB_SUPPORTS_SYSFS in kmem_cache_release()
Date: Tue,  1 Oct 2024 19:32:35 +0530
Message-ID: <20241001140245.306087-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3VwRkQjG5-kubepOQFdAhebx0butX-gr
X-Proofpoint-GUID: Hg5ddDC25tYzFi1maFfjT6DHJXN_XNtl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=960 clxscore=1011 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010089

The fix implemented in commit 4ec10268ed98 ("mm, slab: unlink slabinfo,
sysfs and debugfs immediately") caused a subtle side effect due to which
while destroying the kmem cache, the code path would never get into
sysfs_slab_release() function even though SLAB_SUPPORTS_SYSFS is defined
and slab state is FULL. Due to this side effect, we would never release
kobject defined for kmem cache and leak the associated memory.

The issue here's with the use of __is_defined() macro in kmem_cache_
release(). The __is_defined() macro expands to __take_second_arg(
arg1_or_junk 1, 0). If "arg1_or_junk" is defined to 1 then it expands to
__take_second_arg(0, 1, 0) and returns 1. If "arg1_or_junk" is NOT defined
to any value then it expands to __take_second_arg(... 1, 0) and returns 0.

In this particular issue, SLAB_SUPPORTS_SYSFS is defined without any
associated value and that causes __is_defined(SLAB_SUPPORTS_SYSFS) to
always evaluate to 0 and hence it would never invoke sysfs_slab_release().

This patch helps fix this issue by defining SLAB_SUPPORTS_SYSFS to 1.

Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs9YCCcfmdxN43-9H3HnTYQsRtTYw1Kzq-L468GfLKAENA@mail.gmail.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 mm/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index f22fb760b286..3e0a08ea4c42 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -310,7 +310,7 @@ struct kmem_cache {
 };
 
 #if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
-#define SLAB_SUPPORTS_SYSFS
+#define SLAB_SUPPORTS_SYSFS 1
 void sysfs_slab_unlink(struct kmem_cache *s);
 void sysfs_slab_release(struct kmem_cache *s);
 #else
-- 
2.45.2

