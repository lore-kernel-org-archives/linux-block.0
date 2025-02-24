Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF372192EB
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404006; cv=none; b=jC9zmYl9VsowHgEzYQu2Z7hXrNCJ6JG5REe0rprFNsCpSibKIq50nOZ3nNWJD/Utm/tk5Ef3BctHWSvS/NsQagU+oQ/Cnx/UUH5Q7+zJwsr6cWLVlUuU2HTqNCa6xC3LWlZH0MmAC844DJFt9201ITvc6jQFBVW41Kqwi6adddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404006; c=relaxed/simple;
	bh=ARXandonf5l+BjQooLeb6bhrGSs9F6uYwRQ0ABtFuXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c504P3aCjON18VOQrOqKnqFp77J0obvXHpr0Wnjp3iFhXqVIDsetX/qVaXbVFbZkaAw2Tmoa8e11rIPG7EI6TR2FRFjwhVClpBOVfTSsxGfePoDHOjy6jVsZ+SYF6Dn4H/WvhO27o5lZTmRAhvxsiej0s8uxpKOJEJfznduHU34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l7FaixXs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l7FaixXs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCuTom013307;
	Mon, 24 Feb 2025 13:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=K7vg1TlFAmRMnhvTO
	hISRxadrtFWqHsJsXkC5gj1h4w=; b=l7FaixXsl1VyoLJ3oADEgEjdKQ1M39ER9
	eytia0d28/Rinq3StgZ2jfEqtaF7XkBCD5CSfC226zPYQBEN7koc+vFeYc0oC+em
	2OAI/osk2ncfMfI9PSR6YJorjoFTzJ6HgmcffygV+Hn2SGRlBaiZZeSjgOTIJ/w9
	8rJs93l9gePdNRON05w1oCyve1JvpM2J/Dj4tDbX+699T/CIvOeHFpC6fCAv5PCZ
	Ld2Avcg73pfaJ4+SIEbdQNjvxvUUFey9JgNR12IZbS5ZuNZLOQLl2fMOrpn9OMNa
	PJY0+RkeYlzk4HrO5PrrHNwNfursDJ8yXZUJr5bL2iUc96UJjnQXQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450fm02jt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:31:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBHd1o012499;
	Mon, 24 Feb 2025 13:31:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9y7gem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:31:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ODVBEb52494832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 13:31:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1299420043;
	Mon, 24 Feb 2025 13:31:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8043520040;
	Mon, 24 Feb 2025 13:31:09 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 13:31:09 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv3 3/7] block: remove q->sysfs_lock for attributes which don't need it
Date: Mon, 24 Feb 2025 19:00:54 +0530
Message-ID: <20250224133102.1240146-4-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: kW371-rAADWr2z-v8KJxlCwQstrM_0hJ
X-Proofpoint-GUID: kW371-rAADWr2z-v8KJxlCwQstrM_0hJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240098

There're few sysfs attributes in block layer which don't really need
acquiring q->sysfs_lock while accessing it. The reason being, reading/
writing a value from/to such attributes are either atomic or could be
easily protected using READ_ONCE()/WRITE_ONCE(). Moreover, sysfs
attributes are inherently protected with sysfs/kernfs internal locking.

So this change help segregate all existing sysfs attributes for which
we could avoid acquiring q->sysfs_lock. For all read-only attributes
we removed the q->sysfs_lock from show method of such attributes. In
case attribute is read/write then we removed the q->sysfs_lock from
both show and store methods of these attributes.

We audited all block sysfs attributes and found following list of
attributes which shouldn't require q->sysfs_lock protection:

1. io_poll:
   Write to this attribute is ignored. So, we don't need q->sysfs_lock.

2. io_poll_delay:
   Write to this attribute is NOP, so we don't need q->sysfs_lock.

3. io_timeout:
   Write to this attribute updates q->rq_timeout and read of this
   attribute returns the value stored in q->rq_timeout Moreover, the
   q->rq_timeout is set only once when we init the queue (under blk_mq_
   init_allocated_queue()) even before disk is added. So that means
   that we don't need to protect it with q->sysfs_lock. As this
   attribute is not directly correlated with anything else simply using
   READ_ONCE/WRITE_ONCE should be enough.

4. nomerges:
   Write to this attribute file updates two q->flags : QUEUE_FLAG_
   NOMERGES and QUEUE_FLAG_NOXMERGES. These flags are accessed during
   bio-merge which anyways doesn't run with q->sysfs_lock held.
   Moreover, the q->flags are updated/accessed with bitops which are
   atomic. So, protecting it with q->sysfs_lock is not necessary.

5. rq_affinity:
   Write to this attribute file makes atomic updates to q->flags:
   QUEUE_FLAG_SAME_COMP and QUEUE_FLAG_SAME_FORCE. These flags are
   also accessed from blk_mq_complete_need_ipi() using test_bit macro.
   As read/write to q->flags uses bitops which are atomic, protecting
   it with q->stsys_lock is not necessary.

6. nr_zones:
   Write to this attribute happens in the driver probe method (except
   nvme) before disk is added and outside of q->sysfs_lock or any other
   lock. Moreover nr_zones is defined as "unsigned int" and so reading
   this attribute, even when it's simultaneously being updated on other
   cpu, should not return torn value on any architecture supported by
   linux. So we can avoid using q->sysfs_lock or any other lock/
   protection while reading this attribute.

7. discard_zeroes_data:
   Reading of this attribute always returns 0, so we don't require
   holding q->sysfs_lock.

8. write_same_max_bytes
   Reading of this attribute always returns 0, so we don't require
   holding q->sysfs_lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-settings.c |  2 +-
 block/blk-sysfs.c    | 81 +++++++++++++++-----------------------------
 2 files changed, 29 insertions(+), 54 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c44dadc35e1e..c541bf22f543 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -21,7 +21,7 @@
 
 void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 {
-	q->rq_timeout = timeout;
+	WRITE_ONCE(q->rq_timeout, timeout);
 }
 EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fcfbe59f3a56..83f78d2e1cd3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -172,12 +172,7 @@ QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(max_hw_sectors)
 #define QUEUE_SYSFS_SHOW_CONST(_name, _val)				\
 static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 {									\
-	ssize_t ret;							\
-									\
-	mutex_lock(&disk->queue->sysfs_lock);				\
-	ret = sysfs_emit(page, "%d\n", _val);				\
-	mutex_unlock(&disk->queue->sysfs_lock);				\
-	return ret;							\
+	return sysfs_emit(page, "%d\n", _val);				\
 }
 
 /* deprecated fields */
@@ -266,17 +261,11 @@ QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
 
 static ssize_t queue_poll_show(struct gendisk *disk, char *page)
 {
-	ssize_t ret;
+	if (queue_is_mq(disk->queue))
+		return sysfs_emit(page, "%u\n", blk_mq_can_poll(disk->queue));
 
-	mutex_lock(&disk->queue->sysfs_lock);
-	if (queue_is_mq(disk->queue)) {
-		ret = sysfs_emit(page, "%u\n", blk_mq_can_poll(disk->queue));
-	} else {
-		ret = sysfs_emit(page, "%u\n",
+	return sysfs_emit(page, "%u\n",
 			!!(disk->queue->limits.features & BLK_FEAT_POLL));
-	}
-	mutex_unlock(&disk->queue->sysfs_lock);
-	return ret;
 }
 
 static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
@@ -288,12 +277,7 @@ static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
 
 static ssize_t queue_nr_zones_show(struct gendisk *disk, char *page)
 {
-	ssize_t ret;
-
-	mutex_lock(&disk->queue->sysfs_lock);
-	ret = queue_var_show(disk_nr_zones(disk), page);
-	mutex_unlock(&disk->queue->sysfs_lock);
-	return ret;
+	return queue_var_show(disk_nr_zones(disk), page);
 }
 
 static ssize_t queue_iostats_passthrough_show(struct gendisk *disk, char *page)
@@ -320,13 +304,8 @@ static int queue_iostats_passthrough_store(struct gendisk *disk,
 
 static ssize_t queue_nomerges_show(struct gendisk *disk, char *page)
 {
-	ssize_t ret;
-
-	mutex_lock(&disk->queue->sysfs_lock);
-	ret = queue_var_show((blk_queue_nomerges(disk->queue) << 1) |
+	return queue_var_show((blk_queue_nomerges(disk->queue) << 1) |
 			       blk_queue_noxmerges(disk->queue), page);
-	mutex_unlock(&disk->queue->sysfs_lock);
-	return ret;
 }
 
 static ssize_t queue_nomerges_store(struct gendisk *disk, const char *page,
@@ -340,7 +319,6 @@ static ssize_t queue_nomerges_store(struct gendisk *disk, const char *page,
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&q->sysfs_lock);
 	memflags = blk_mq_freeze_queue(q);
 	blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, q);
 	blk_queue_flag_clear(QUEUE_FLAG_NOXMERGES, q);
@@ -349,22 +327,16 @@ static ssize_t queue_nomerges_store(struct gendisk *disk, const char *page,
 	else if (nm)
 		blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
 
 	return ret;
 }
 
 static ssize_t queue_rq_affinity_show(struct gendisk *disk, char *page)
 {
-	ssize_t ret;
-	bool set, force;
+	bool set = test_bit(QUEUE_FLAG_SAME_COMP, &disk->queue->queue_flags);
+	bool force = test_bit(QUEUE_FLAG_SAME_FORCE, &disk->queue->queue_flags);
 
-	mutex_lock(&disk->queue->sysfs_lock);
-	set = test_bit(QUEUE_FLAG_SAME_COMP, &disk->queue->queue_flags);
-	force = test_bit(QUEUE_FLAG_SAME_FORCE, &disk->queue->queue_flags);
-	ret = queue_var_show(set << force, page);
-	mutex_unlock(&disk->queue->sysfs_lock);
-	return ret;
+	return queue_var_show(set << force, page);
 }
 
 static ssize_t
@@ -380,7 +352,12 @@ queue_rq_affinity_store(struct gendisk *disk, const char *page, size_t count)
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&q->sysfs_lock);
+	/*
+	 * Here we update two queue flags each using atomic bitops, although
+	 * updating two flags isn't atomic it should be harmless as those flags
+	 * are accessed individually using atomic test_bit operation. So we
+	 * don't grab any lock while updating these flags.
+	 */
 	memflags = blk_mq_freeze_queue(q);
 	if (val == 2) {
 		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
@@ -393,7 +370,6 @@ queue_rq_affinity_store(struct gendisk *disk, const char *page, size_t count)
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
 	}
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
 #endif
 	return ret;
 }
@@ -411,30 +387,23 @@ static ssize_t queue_poll_store(struct gendisk *disk, const char *page,
 	ssize_t ret = count;
 	struct request_queue *q = disk->queue;
 
-	mutex_lock(&q->sysfs_lock);
 	memflags = blk_mq_freeze_queue(q);
 	if (!(q->limits.features & BLK_FEAT_POLL)) {
 		ret = -EINVAL;
 		goto out;
 	}
+
 	pr_info_ratelimited("writes to the poll attribute are ignored.\n");
 	pr_info_ratelimited("please use driver specific parameters instead.\n");
 out:
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
-
 	return ret;
 }
 
 static ssize_t queue_io_timeout_show(struct gendisk *disk, char *page)
 {
-	ssize_t ret;
-
-	mutex_lock(&disk->queue->sysfs_lock);
-	ret = sysfs_emit(page, "%u\n",
-			jiffies_to_msecs(disk->queue->rq_timeout));
-	mutex_unlock(&disk->queue->sysfs_lock);
-	return ret;
+	return sysfs_emit(page, "%u\n",
+			jiffies_to_msecs(READ_ONCE(disk->queue->rq_timeout)));
 }
 
 static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
@@ -448,11 +417,9 @@ static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
 	if (err || val == 0)
 		return -EINVAL;
 
-	mutex_lock(&q->sysfs_lock);
 	memflags = blk_mq_freeze_queue(q);
 	blk_queue_rq_timeout(q, msecs_to_jiffies(val));
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
 
 	return count;
 }
@@ -706,6 +673,10 @@ static struct attribute *queue_attrs[] = {
 	 * attributes protected with q->sysfs_lock
 	 */
 	&queue_ra_entry.attr,
+
+	/*
+	 * attributes which don't require locking
+	 */
 	&queue_discard_zeroes_data_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_nr_zones_entry.attr,
@@ -723,11 +694,15 @@ static struct attribute *blk_mq_queue_attrs[] = {
 	 */
 	&queue_requests_entry.attr,
 	&elv_iosched_entry.attr,
-	&queue_rq_affinity_entry.attr,
-	&queue_io_timeout_entry.attr,
 #ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
 #endif
+	/*
+	 * attributes which don't require locking
+	 */
+	&queue_rq_affinity_entry.attr,
+	&queue_io_timeout_entry.attr,
+
 	NULL,
 };
 
-- 
2.47.1

