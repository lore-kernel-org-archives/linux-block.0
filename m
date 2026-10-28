Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205884;
	b=oFP6NVN6XqdV0p6Ybiwrw6WLSyjyX/YXzO/IoPU2quy2zzH/1+nXh4P7L5/8JDsrBbKe
	 yA4c3xBgt8SFo6lOuatQ0D+uKQNVmSnUxgF/oGpnXWxNcUJAcvizNMfCLnVIePXkuTxM/
	 9RbCRQe+CThG5cDHWIc2qVjyq/WuJoVv5LzLcbigPWHuWgKx23voyMjHibkwYzfj8+nkU
	 7hnl+jwUHrZkJGeeZkes51uB0YNmUdtVdMyUfFwIqWE1DcnEcRIb8ztW7BmMCtM1MkNuD
	 zdqP2iDf/8YJ/XxbXTP8sK054OJndmIc3POk68m8I5ZLpJZMBdd8jmfuFsNifmSXVbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uCt+bqnV1TErfBOb4wpLK89zEMYn1nEYdeCgPwVJWPw=;
	b=rDYUxBixJwRMEJZS3dhSUn8eLMpc3mikucpaN2/D4PhrSeAYyHbORyJDRpXz8zDSUWxO
	 FKHgBqE+bcABHJvyGsuk5SzXK0XXsfz//vFLvjZW0+3LxOWJngY5IBCDhg0BCX0gjZxMG
	 5KxOO0IS5DqJqxih61rxmYN0spa9XtCqYQ7RX5SHPLTniO676dY6exjelSMdFo9b/tLw+
	 Y1iTt9NMDDT5B8AkuH/NPiF84X+JMqoD2lCu0Zyo9TvNJ39Yl80QjEtKCHM9393DMZe9O
	 okyXxurxIwYY+wDNnuvOFgVpM2vIqGaEZOU5l0P6ZdCgbk0X92pobSIa2KXk4SwAEHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jpMdPlLN;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B4606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC0B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jpMdPlLN
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6dde81a6820so999493eaf.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205883; x=1793810683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uCt+bqnV1TErfBOb4wpLK89zEMYn1nEYdeCgPwVJWPw=;
        b=jpMdPlLNcsGjrkyrjW0t/qKulS9VpL5LW5YTWef2aSropPu9rNxn2KUHljiLnYEpoM
         O6WS52uaVq5Kzrz1D81gAlJHf5aqjAG8gBamujX+Xovjgb4BqlJmOk7P2MJWhlz8uuHk
         pKcWLD0NV6KwWbWaHJGmwU+6Qu3IaTxt9jdnh9xy8FRvtsNzgVOi4MXYRS+UZ7sDvWw7
         nU2SeMfhILG0UdamDg3koG8aDqOO32LaDD5B+opyFjSG27T2sjGt+JUaA+1BHvDWi1g+
         C3BEHrZxcAdNBrNA+UZ6+Ra2Z48JSDAlO7BeW2l/IhYOv1qL4vfzINXSbJJgscmEsDsV
         eszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205883; x=1793810683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uCt+bqnV1TErfBOb4wpLK89zEMYn1nEYdeCgPwVJWPw=;
        b=LCxipu7nY4yWCjythPJ+uOHQ/49x61M/0B7yAGKq9RxagraRjQ3+o/RZzkAX0zuatF
         f86nDCbIwJiuAX/sjX3/4fIORDrWe1lgNgJH0MIlhYC65+tZT/KZ290ptlujfzTbBTJn
         INJtvRCUE8LLhSDeAyuvqi8hdKF3v612V9lIy31Rs9Srw/AKLv+2Eg0w160ocHCHQhnQ
         642QWif/2fCCyNF+XpHws402OYXJPQ9Ef84wmzD1Un0vtXARdpB96d64V/Z/qeHjcCbt
         Mo+HqmjIDdzpyRoX9fyb4S5SJxnxWNQE27+w99TiXtbOvoVg+QUDLaneqiuk4Sz4uw7L
         Pf3Q==
X-Gm-Message-State: AFq9FYJSnIFcUMRN0IWFRqTn3ghGt1cElOU51egLAAMSVxAG/BVVqcyX
	2MLshykoD9dzWBdap8PJaXyPAhT2INZpobP4IwiG6czJllyMbsF9NHObbnDPsIAYbJfXk7iaLRe
	6dvmeOWw=
X-Gm-Gg: AYBFou1+kSsT7ku6P+qtbC8SBslceOgABpxezU47JRlxRQTmr5Ljw/707S+4whooErj
	wLEkxSSv8iWBgyLe0cTGhuRM/RjSupdPqNfAwNpUtuEb1WtCUVyRGIsYP0Jnt7XqL33KwClaOzc
	Eal4RKzfK5MPDeDrHXcrjr5gPMp3eVfZIrIO2/XZQlveBTSP01BBTKXt+M0AWvVEvsuH8Y7wAuA
	ZzJsloUO1b+QQTvzngg6KppZqdnLrfcmcx/pQL1RZOetlti1QBHw+cgtPto2dLhQo0l41bNbeQT
	7pkbVVX1FwhKc2cCTtDT+nlcGwA+8UuQg463DiutN2fz+AbWtqK+HTn/sXnyqGPQdEwCQ//Uq8w
	1sDYBC5nzmhlzc3Lmluz7dJf/Cf0xFyPnh3ITmlUPjFEyxuUgfxTOFjM/3CgVX52mtJhdYa7l0I
	I35yWgMUmgYTqXxWFhKjnfSh9tp1w8kcfSzzV13nd/SAVKB9mZm5V0QQp7yTlu0WJKsW9hOM2sx
	1KTQ+ZCvFPeakPB/w81O5HrQPm/1WB+zhxfHQUdLZNznACftlgxhq/f5Os/L+UXNk8Ze+cr2c3g
	t2zU7XAtKfjRNrirXe6f3WStO/MpYVHLfBU1x/lZbZ9CAvGnL/htm5YCmAYN6yzLIo3YyK7EZg=
	=
X-Received: by 2002:a05:6820:1c9d:b0:702:f7c2:1928 with SMTP id 006d021491bc7-713efffe531mr1734415eaf.74.1793205882768;
        Wed, 28 Oct 2026 09:44:42 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/98] blk-cgroup: don't free a blkg with its punt work queued
Date: Wed, 28 Oct 2026 10:41:22 -0600
Message-ID: <20261028164415.1262013-20-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

blkg_async_bio_workfn() relies on the bios on the list pinning the blkg.
But blkcg_punt_bio_submit() can call queue_work() after a running
instance already took and completed the bio, and queue_work() succeeds
on an empty list for the same reason. Nothing holds the blkg then, and
free_work shares its memory with async_bio_work on top of that.

Hold a reference across blkcg_punt_bio_submit(), give the two works
memory of their own, and cancel async_bio_work in blkg_free_workfn().

Fixes: d3f77dfdc718 ("blkcg: implement REQ_CGROUP_PUNT")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c | 13 ++++++++++++-
 block/blk-cgroup.h |  6 ++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c9187d95a54b..00da55c6ec43 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -121,6 +121,11 @@ static void blkg_free_workfn(struct work_struct *work)
 	struct request_queue *q = blkg->q;
 	int i;
 
+#ifdef CONFIG_BLK_CGROUP_PUNT_BIO
+	/* It may have been queued for bios which an earlier run has taken */
+	cancel_work_sync(&blkg->async_bio_work);
+#endif
+
 	/*
 	 * pd_free_fn() can also be called from blkcg_deactivate_policy(),
 	 * in order to make sure pd_free_fn() is called in order, the deletion
@@ -218,7 +223,7 @@ static void blkg_async_bio_workfn(struct work_struct *work)
 	struct blk_plug plug;
 	bool need_plug = false;
 
-	/* as long as there are pending bios, @blkg can't go away */
+	/* blkg_free_workfn() waits for us */
 	spin_lock(&blkg->async_bio_lock);
 	bio_list_merge_init(&bios, &blkg->async_bios);
 	spin_unlock(&blkg->async_bio_lock);
@@ -245,10 +250,16 @@ void blkcg_punt_bio_submit(struct bio *bio)
 	struct blkcg_gq *blkg = bio->bi_blkg;
 
 	if (blkg->parent) {
+		/*
+		 * Once it is on the list, a run which is under way can submit
+		 * @bio, and its reference goes when it completes.
+		 */
+		blkg_get(blkg);
 		spin_lock(&blkg->async_bio_lock);
 		bio_list_add(&blkg->async_bios, bio);
 		spin_unlock(&blkg->async_bio_lock);
 		queue_work(blkcg_punt_bio_wq, &blkg->async_bio_work);
+		blkg_put(blkg);
 	} else {
 		/* never bounce for the root cgroup */
 		submit_bio(bio);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index e67c69839129..1fd60cb4157c 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -76,11 +76,9 @@ struct blkcg_gq {
 #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
 	spinlock_t			async_bio_lock;
 	struct bio_list			async_bios;
+	struct work_struct		async_bio_work;
 #endif
-	union {
-		struct work_struct	async_bio_work;
-		struct work_struct	free_work;
-	};
+	struct work_struct		free_work;
 
 	atomic_t			use_delay;
 	atomic64_t			delay_nsec;
-- 
2.56.0

