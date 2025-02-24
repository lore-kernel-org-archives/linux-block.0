Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432062571B8
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404012; cv=none; b=L6/vmEui/k7bKrcJywFbxLA60GFyrOpaMoJUAFA5UnGT7HaiY7mHG0Qt6on7oUF425O7E0JMGsUpV1xJ8XrPVT8oUQ6zZNOeqiVcg5E9MfmveXmpF9L4e2NKNRe5f6PI/wKvCOLWcXxNLcUlmKmcK1diGkSExrHrpD3E+hPXnHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404012; c=relaxed/simple;
	bh=Gz14a2w/A+uf5d0bCRqHPBlf3lncJGEq68KV2zam8b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z97skwzbwgrhEtBghdFG35bPMW2dtqbwnuHeBSiWvI0aFfeqIMWYNYVVseDIHKwn7PSk1Lfi/6FIJUcCoX+beRLjRUWHq2vJiIzSH6rDaLyC7dDHyuJ6UseDPnbvWMxOPpECoVddBTYRbX6+J1LxUHEKyWGC4zEJxVT55l0LyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pcIoikHl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pcIoikHl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O2DA7q013077;
	Mon, 24 Feb 2025 13:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Dfa9LDVZHB/laKYUu
	1LFzALo8Ytmi0xJ66uJ+vWc838=; b=pcIoikHlswQQLb6Pm5yHZBgF7O2PRd6yT
	Ln8wg92tsmlooWGan0EI1mIclg4n0lECkqE+VirKHaOBb7D94E66Msz8d+Wl5giq
	ltDG+MGjFRHrt+h2lRnCzPBCQtKHZ9jUvsfNKw6wlPNmI5/Uvovu6PkjrbauI8uF
	6PTltOSwygOsWoDDkNA1EzHj/KAogNho7PXHEEuTSKlVdzq7ojjpYDi9mxNExZen
	hplWp9gsFVlEfxeSjZB7zwMN7EVI0gy4pH8n0cFzWBYr/c3SeUi/MT6Vjh6t+LEw
	3D6ybP1bYh8oBVDVZssC8nxCnUxVzq24STewvEJCK7Dz+HrBPJCZQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450fm02jtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:31:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9qIlk027337;
	Mon, 24 Feb 2025 13:31:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum1pw6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:31:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ODVJkA42992034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 13:31:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4653420043;
	Mon, 24 Feb 2025 13:31:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B23F820040;
	Mon, 24 Feb 2025 13:31:17 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 13:31:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv3 7/7] block: protect read_ahead_kb using q->limits_lock
Date: Mon, 24 Feb 2025 19:00:58 +0530
Message-ID: <20250224133102.1240146-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250224133102.1240146-1-nilay@linux.ibm.com>
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cYtmqDAn5aIZ4xRavq3CORA_ZCqShV2S
X-Proofpoint-GUID: cYtmqDAn5aIZ4xRavq3CORA_ZCqShV2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240098

The bdi->ra_pages could be updated under q->limits_lock because it's
usually calculated from the queue limits by queue_limits_commit_update.
So protect reading/writing the sysfs attribute read_ahead_kb using
q->limits_lock instead of q->sysfs_lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8f47d9f30fbf..228f81a9060f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -93,9 +93,9 @@ static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
 	ssize_t ret;
 
-	mutex_lock(&disk->queue->sysfs_lock);
+	mutex_lock(&disk->queue->limits_lock);
 	ret = queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
-	mutex_unlock(&disk->queue->sysfs_lock);
+	mutex_unlock(&disk->queue->limits_lock);
 
 	return ret;
 }
@@ -111,12 +111,15 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
 	ret = queue_var_store(&ra_kb, page, count);
 	if (ret < 0)
 		return ret;
-
-	mutex_lock(&q->sysfs_lock);
+	/*
+	 * ->ra_pages is protected by ->limits_lock because it is usually
+	 * calculated from the queue limits by queue_limits_commit_update.
+	 */
+	mutex_lock(&q->limits_lock);
 	memflags = blk_mq_freeze_queue(q);
 	disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
+	mutex_unlock(&q->limits_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
 
 	return ret;
 }
@@ -670,7 +673,8 @@ static struct attribute *queue_attrs[] = {
 	&queue_dma_alignment_entry.attr,
 
 	/*
-	 * attributes protected with q->sysfs_lock
+	 * attributes which require some form of locking
+	 * other than q->sysfs_lock
 	 */
 	&queue_ra_entry.attr,
 
-- 
2.47.1

