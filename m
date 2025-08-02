Received: from smtp.smtpout.orange.fr (smtp-69.smtpout.orange.fr [80.12.242.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA566ADD;
	Sat,  2 Aug 2025 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754119585; cv=none; b=L6TMY3trkxSSLbyd8ev8SNUONZSBcCb/rpxfWebqnwvFR4iN5D9jK+womyLtOGYzYZu2EAHZHERMCOIIB60qyZ9bm3Bs6hg0FkdIyg0NcM+9+oogigpOA2bwPtp8UuBW3S3d3dJJDTcbesfOEKyAUotDpcA6sczqeQtCer3y7y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754119585; c=relaxed/simple;
	bh=NSREs7H+Yc0DM8zD9xre6BL+mYsrEFoz38UY/+fIWW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oG1taXwPeT5FR936jN0bROpU5yTtRdcUm+kVJJA5alNvR8whRc7JVtA5nT7F/SZu7HcQgB4VWEvJPp2pR96zuKt0kORgomCfhsd9SKd/vPwhepN97aHpH8XPslCnRlGMQPyOn1V21/DcFJDdTKK+HxX2jmjxSVeIA31M3b/G+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=C2qrsfiX; arc=none smtp.client-ip=80.12.242.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="C2qrsfiX"
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id i6d9unmhFKxUMi6d9ue2xP; Sat, 02 Aug 2025 09:26:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1754119573;
	bh=A6EO1oc43a46dugxnP2nqOm0PNJLUSOuHaQkhzSg+Ms=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=C2qrsfiXYEcVQDvyPH+qazkmDr3HariQnxrj0MmCVkSAj+Fpo6TMdLi7T8k6eBRD+
	 W5JYTp8jDO4qK87ABKzVFHO7IjEB7sCBA2qxNgRntW86BwyJ7hwgjLih0gKTBN0b7X
	 yWslMRjyTsg2lQfogFRuz5GPrHSCMmynM5n1E0fIgGF5E8jQCAlHXDzV60Jvj4PRyf
	 OLnRu9jdoQNj8bSkNpKqPy+xrvIUKzbEHusHQzvN2bRyCpRDga3EHIwzeerR1UyfQ0
	 D8YxQf6xdjwkwgvfFyt86oY+IX0JU6IMwFn5/tJ2vdsbIDYrUSE0qErhb7ooVjjIT+
	 7lHwbT5SOmvrw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Aug 2025 09:26:13 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-block@vger.kernel.org
Subject: [PATCH] block, bfq: Reorder struct bfq_iocq_bfqq_data
Date: Sat,  2 Aug 2025 09:25:59 +0200
Message-ID: <79394db1befaa658e8066b8e3348073ce27d9d26.1754119538.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of struct bfq_iocq_bfqq_data can be reduced by moving a few fields
around.

On a x86_64, with allmodconfig, this shrinks the size from 144 to 128
bytes.
The main benefit is to reduce the size of struct bfq_io_cq from 1360 to
1232.

This structure is stored in a dedicated slab cache. So reducing its size
improves cache usage.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

On my system, struct bfq_io_cq are stored in 8 pages slab. Each of these
slabs hold 24 entries.

$ sudo cat /proc/slabinfo | grep bfq_io
bfq_io_cq            378    384   1360   24    8 : tunables    0    0    0 : slabdata     16     16      0

With the new layout, we should store 26 entries.
(8 * 4096 / 1232 = 26.60)
---
 block/bfq-iosched.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 687a3a7ba784..0b4704932d72 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -427,9 +427,6 @@ struct bfq_iocq_bfqq_data {
 	 */
 	bool saved_IO_bound;
 
-	u64 saved_io_start_time;
-	u64 saved_tot_idle_time;
-
 	/*
 	 * Same purpose as the previous fields for the values of the
 	 * field keeping the queue's belonging to a large burst
@@ -450,6 +447,9 @@ struct bfq_iocq_bfqq_data {
 	 */
 	unsigned int saved_weight;
 
+	u64 saved_io_start_time;
+	u64 saved_tot_idle_time;
+
 	/*
 	 * Similar to previous fields: save wr information.
 	 */
@@ -457,13 +457,13 @@ struct bfq_iocq_bfqq_data {
 	unsigned long saved_last_wr_start_finish;
 	unsigned long saved_service_from_wr;
 	unsigned long saved_wr_start_at_switch_to_srt;
-	unsigned int saved_wr_cur_max_time;
 	struct bfq_ttime saved_ttime;
+	unsigned int saved_wr_cur_max_time;
 
 	/* Save also injection state */
-	u64 saved_last_serv_time_ns;
 	unsigned int saved_inject_limit;
 	unsigned long saved_decrease_time_jif;
+	u64 saved_last_serv_time_ns;
 
 	/* candidate queue for a stable merge (due to close creation time) */
 	struct bfq_queue *stable_merge_bfqq;
-- 
2.50.1

