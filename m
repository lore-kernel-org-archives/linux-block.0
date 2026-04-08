Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB938551B
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689751; cv=none; b=ibx9BZsGD/UEnPMQLdZNhor1q4uketZ5oHdkNbCYZ28MBMUxRbS8KdUL8gbPfpLw3p/WrSg0JQS2BJ0zaRR5nyUiKtUyn+pAa5DlvUHoW7F1h0rmCviVu52idI5eWzomQ03aPJPNzgdQAGVmck23osshId20YtZa3aFsKI12i8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689751; c=relaxed/simple;
	bh=NLsrsfzymzUrMVWpo0v5CWjs+5vL2gt0uuiGjvhOdbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PvdBHzS3k/s1GW/CJhIcrINGqEuwiP7K0tnx/3Fmcmtii5cRpHzVZXXXQWDgouI5/sAayNQ/h0sm6Jeoz8udOdS+R5VeoNwfRi6H3GgBCZMbGr1FIuS/rq8zUKYroQbzwe38o+Yn7AA3HtLbxiIL7NWlOUCQJaFrNRbReUruufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HzKTHYw5; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HzKTHYw5"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638Mu8F33332687
	for <linux-block@vger.kernel.org>; Wed, 8 Apr 2026 19:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=oqJ0
	a3t8jS6c/vIHutzSVyyVpnCMDCW4Tg6feS4OXSE=; b=HzKTHYw5S6TceESdnFDi
	2PNZkSYBxbwNoM6vCZD02Bn52JxAF3fmiLb5Zl0DXAZ027SkvzDtmLqsSh0agOZ2
	FMQHkv37L2/YC6T0QQZhV32Hyng6vCTFHZtnQ/qFXH+1N6AqwlmlDpk0rs1t+HS1
	y/u4YeZFNMsff/0FZv2/u9Elb9b6m4+NJg/ZuHU1Fu2C85UakQ/0j2hh8ZzKxko6
	86QeTWgfNfGnr6RScYrZDvHWFk2B77v1WjT6IELF6h/oVvFbLOxxceGdmgCkZohz
	4Kfajmxx6+h0eire1jm052vY07QegjnGepZ4S2NQ8O3Q5A/He8G7moK9ISs5vDn6
	nw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3mrtcx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 19:09:08 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8d3bb62cd2bso22617685a.1
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 16:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689748; x=1776294548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oqJ0a3t8jS6c/vIHutzSVyyVpnCMDCW4Tg6feS4OXSE=;
        b=nGGu31Yy3BTzuQXCRoUS36P5j0jaQjSmahQAtM1tctjnTxzh5ZAcIZrwU1aDBZKfl0
         3Co8kK29Eq8rGKgCU5v6/DD4iavgke70BUGjKwtDot4nLBbK+9qy/BPCwQz1J1qJp9TI
         guAjeXOm5CRwHRN4FgWPMjD6wm+EXT6FaonV9VWQvFyAp0+dHlgvpsgIYiDEzVUIcaq2
         cmqzmltRPdS3A1vgOTxzDHanFagvstm2i7SvYNZQtv5gnVpWQH5k99vj4ekDwmJsSWWQ
         ClKERDOA4tGWFP6iAlgZmdkYOZonpKn0GeaHVQcmrxIFMzfpZWnq70kVm5SmxWuipVgJ
         zMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKvgsT8pthyo8YZtGeyQiMtMnJy4hhu3d6Uk+CrpDhFX7YaGbS9rGtAheAQTnVsbttP58SMprK4e6IfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOfkKHFPCcIdT8FDm6NF9HrmImctpYBfagtCSVp5PK1auDRIt
	DnICyeFV0+st+DTpxQdctkVyS2C9zeakv9PZ9UxyZHW6rl0LyhW63lzoScsL+1a8fy3SpO3j5LO
	Z+Yj/NDiF2wUiR1IhnKdMWrurUuUynLvgpKJSUtTG2D+zFpJMJKfydFaGzWN/
X-Gm-Gg: AeBDieuozvgpCQQglSN4iU/MoU0ozh86fAi5mpXywkXCg5zvWKgS8AaOc8bmOUu5bJL
	NWSzMKvbCPsBukpP/fGVZRr5enRNkN4khcJnZxVvahb2ceBPy6aHM+Ll37ghhcf+Jujm56TA3pd
	YoSZ/Upup+mrGsTtCCw4DqsjsDfpDHRlXjrj4aiIPKxBWaMp0U8KMqqTTS+JDL31Ip3f0nK6KUE
	sHwAzLxUwxFxI2GMjtxqKpbnWbUjO8Zl6D4z86tjzywFOQKbmz6PS/n63/NjknCDqKbhqdFH7vq
	cBbvF5f3xisnMnXRJWeb44xBxNUEuqdpx4c7JvhBeAUs2fo0EgIDwW32fH+yx14zFw/YyVa7TIe
	gZXFaUuJ/Wmgcd543O7hcl/0L8WQstVmE
X-Received: by 2002:a05:620a:288c:b0:8cf:e015:afee with SMTP id af79cd13be357-8dc3d5637abmr251838385a.41.1775689747778;
        Wed, 08 Apr 2026 16:09:07 -0700 (PDT)
X-Received: by 2002:a05:620a:288c:b0:8cf:e015:afee with SMTP id af79cd13be357-8dc3d5637abmr251831985a.41.1775689747307;
        Wed, 08 Apr 2026 16:09:07 -0700 (PDT)
Received: from [127.0.1.1] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8dc1514d382sm125665485a.4.2026.04.08.16.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:09:06 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 08 Apr 2026 19:08:49 -0400
Subject: [PATCH RFC v5 1/3] block: add BIO_COMPLETE_IN_TASK for
 task-context completion
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-blk-dontcache-v5-1-0f080c20a96f@columbia.edu>
References: <20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu>
In-Reply-To: <20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775689745; l=5340;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=NLsrsfzymzUrMVWpo0v5CWjs+5vL2gt0uuiGjvhOdbM=;
 b=u66r3JWWGQoqmnanaB2/ADYIPFPR9XzOSNkajI3Qmqzv2OFXZ3a1f4nowuwzVHTLchKqwLvP3
 C8IK+oGI7fzBnCtSgWvUg1tgEQWCLKJKma5i/Qp7RNIk3ZGfLD8QeKY
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 2dsPxyofl_AWjvHx1aCaxLm09PRJPEYS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDIxNCBTYWx0ZWRfX6k+QSo0HzbvL
 Nk6kb0L+BsAkTcG2+hMEUP3l7uWwpQW/thbqZN6XbCdIOYJlT9WO+CLiYPoxLoT0wexp3ifKA19
 Ltck7uqBM5ckfe5keIjaKki0dTj3Ou5lCnKajqC2+5T6RkHvjfap9seT4MQrZqRy3efvTMosYnd
 TWGPtLxiwMs+8eh8kFidd1pfUR1fEsA/8bmPE7LKvWq3txaUpdsVx/DnUx7kOEtYm1v0X7uNSAv
 pbFzjG5Mha2EYi1tIGoGmWF5Pu0YrTJcwQYGVSYMZ+qYjsfzSrZ698Fz7go2JY3nB2qITV1hDGB
 tA2FwfCPft18LOdsdQXwLy3BAOEttI2quov/QH5BDoPQieZDwh1gs599Z/GSa0HgwwJgtB+EsI4
 Z6yRKEylzvsgdOxf+kzOf0BlQ/VvHhpvfe/KyxUovGRBZ3fx++Qx23v5Xuzh8/VBBrDktpaNVY/
 VZPGorXGPjq20eqQYAg==
X-Proofpoint-GUID: 2dsPxyofl_AWjvHx1aCaxLm09PRJPEYS
X-Authority-Analysis: v=2.4 cv=eOcjSnp1 c=1 sm=1 tr=0 ts=69d6e014 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=JfrnYn6hAAAA:8 a=ignxIbPQDb6uhq8P750A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=10 adultscore=0
 impostorscore=10 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080214

Some bio completion handlers need to run in task context but bio_endio()
can be called from IRQ context (e.g. buffer_head writeback). Add a
BIO_COMPLETE_IN_TASK flag that bio submitters can set to request
task-context completion of their bi_end_io callback.

When bio_endio() sees this flag and is running in non-task context, it
queues the bio to a per-cpu lockless list and schedules a delayed work
item to call bi_end_io() from task context.  The delayed work uses a
1-jiffie delay to allow batches of completions to accumulate before
processing. A CPU hotplug dead callback drains any remaining bios from
the departing CPU's batch.

This will be used to enable RWF_DONTCACHE for block devices, and could
be used for other subsystems like fscrypt that need task-context bio
completion.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c               | 83 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/blk_types.h |  7 +++-
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8203bb7455a9..21b403eb1c04 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/blk-crypto.h>
 #include <linux/xarray.h>
+#include <linux/llist.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1714,6 +1715,51 @@ void bio_check_pages_dirty(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
+struct bio_complete_batch {
+	struct llist_head list;
+	struct delayed_work work;
+	int cpu;
+};
+
+static DEFINE_PER_CPU(struct bio_complete_batch, bio_complete_batch);
+static struct workqueue_struct *bio_complete_wq;
+
+static void bio_complete_work_fn(struct work_struct *w)
+{
+	struct delayed_work *dw = to_delayed_work(w);
+	struct bio_complete_batch *batch =
+		container_of(dw, struct bio_complete_batch, work);
+	struct llist_node *node;
+	struct bio *bio, *next;
+
+	do {
+		node = llist_del_all(&batch->list);
+		if (!node)
+			break;
+
+		node = llist_reverse_order(node);
+		llist_for_each_entry_safe(bio, next, node, bi_llist)
+			bio->bi_end_io(bio);
+
+		if (need_resched()) {
+			if (!llist_empty(&batch->list))
+				mod_delayed_work_on(batch->cpu,
+						    bio_complete_wq,
+						    &batch->work, 0);
+			break;
+		}
+	} while (1);
+}
+
+static void bio_queue_completion(struct bio *bio)
+{
+	struct bio_complete_batch *batch = this_cpu_ptr(&bio_complete_batch);
+
+	if (llist_add(&bio->bi_llist, &batch->list))
+		mod_delayed_work_on(batch->cpu, bio_complete_wq,
+				    &batch->work, 1);
+}
+
 static inline bool bio_remaining_done(struct bio *bio)
 {
 	/*
@@ -1788,7 +1834,9 @@ void bio_endio(struct bio *bio)
 	}
 #endif
 
-	if (bio->bi_end_io)
+	if (!in_task() && bio_flagged(bio, BIO_COMPLETE_IN_TASK))
+		bio_queue_completion(bio);
+	else if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
 EXPORT_SYMBOL(bio_endio);
@@ -1974,6 +2022,24 @@ int bioset_init(struct bio_set *bs,
 }
 EXPORT_SYMBOL(bioset_init);
 
+/*
+ * Drain a dead CPU's deferred bio completions.
+ */
+static int bio_complete_batch_cpu_dead(unsigned int cpu)
+{
+	struct bio_complete_batch *batch =
+		per_cpu_ptr(&bio_complete_batch, cpu);
+	struct llist_node *node;
+	struct bio *bio, *next;
+
+	node = llist_del_all(&batch->list);
+	node = llist_reverse_order(node);
+	llist_for_each_entry_safe(bio, next, node, bi_llist)
+		bio->bi_end_io(bio);
+
+	return 0;
+}
+
 static int __init init_bio(void)
 {
 	int i;
@@ -1988,6 +2054,21 @@ static int __init init_bio(void)
 				SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
 	}
 
+	for_each_possible_cpu(i) {
+		struct bio_complete_batch *batch =
+			per_cpu_ptr(&bio_complete_batch, i);
+
+		init_llist_head(&batch->list);
+		INIT_DELAYED_WORK(&batch->work, bio_complete_work_fn);
+		batch->cpu = i;
+	}
+
+	bio_complete_wq = alloc_workqueue("bio_complete", WQ_MEM_RECLAIM, 0);
+	if (!bio_complete_wq)
+		panic("bio: can't allocate bio_complete workqueue\n");
+
+	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "block/bio:complete:dead",
+				NULL, bio_complete_batch_cpu_dead);
 	cpuhp_setup_state_multi(CPUHP_BIO_DEAD, "block/bio:dead", NULL,
 					bio_cpu_dead);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..0b55159d110d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/ktime.h>
 #include <linux/rw_hint.h>
+#include <linux/llist.h>
 
 struct bio_set;
 struct bio;
@@ -208,7 +209,10 @@ typedef unsigned int blk_qc_t;
  * stacking drivers)
  */
 struct bio {
-	struct bio		*bi_next;	/* request queue link */
+	union {
+		struct bio	*bi_next;	/* request queue link */
+		struct llist_node bi_llist;	/* deferred completion */
+	};
 	struct block_device	*bi_bdev;
 	blk_opf_t		bi_opf;		/* bottom bits REQ_OP, top bits
 						 * req_flags.
@@ -322,6 +326,7 @@ enum {
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
+	BIO_COMPLETE_IN_TASK, /* complete bi_end_io() in task context */
 	BIO_FLAG_LAST
 };
 

-- 
2.39.5

