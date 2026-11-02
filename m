Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600089;
	b=tBA9gZ3wCVJeaLZoOGF7D40MGsUdg5cCuDZzaa78cMoDMcFwSSL08b5fp2I4vkDCDBde
	 +HoU/dwPGJtOyrFBBlxBtUbr0tbobDaHgsDSvFOAETen3C+fKCe/HPHVgfJ/wUd7gMGnQ
	 WSgxxvoXh0T0kVA+UhbvGMQ1yASEmkoDS4MsTKTws4ckuYB9+2ZLJ55LVpoC+RmnwLbUx
	 U59DK0pmFVdKmghFGD9GVHkAgTSgdOMl78gm/Cs5nFx2BQFNhC6ZB63ujGrvJRMubs6dR
	 Om+jD1TG1ZxKGBLnR4x69qCCH7Y1R8NR1ywBTvl6EUJ5egBQOlMb02M1cq/AGPGKtvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=UYKyTKANHmNueSZX+Vts+dz5q7U+GTeUPWVYwIUP5po=;
	b=pvPSjBFkEzxvEagCCudlp+00HafnG2QmYjrTmsIYUaoR8Yz2m2Ir4Fb8mbc/6uKUt1r0
	 eUWGYrc0Tbs5DhPlcV2JLKrddB8ZN0anoLAvMWsTwZvg9jEvleKDdWH5KHBp5iSC84mry
	 nNNMstphO6lQG/QQDJhXM/cgY5bLWt2COxZjsjg8DxOb1RJabTpBRdgsFYpz1l0IRQyN5
	 U6vkxfyTA8gMNSXBJLtsnwVTHdJH44DcvFM3SI37JJdw4xAOJTi22Xcev+DP15cPclV3A
	 dozQiY9XMRgjzdMcgYfLPog+cOXZqPSXuSbossSd0Ti1gqL9SJyT4aYR6v+lAoowOMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=juf1jwvj;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3B606A32C
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 06:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE3B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=juf1jwvj
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so3185266c88.1
        for <linux-block@vger.kernel.org>; Sun, 01 Nov 2026 22:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793600088; x=1794204888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYKyTKANHmNueSZX+Vts+dz5q7U+GTeUPWVYwIUP5po=;
        b=juf1jwvjuVQts4E14edw9EOV/a773u93dE6UuWrjI4untug/WsMRXIOyaLsm/mRv8e
         NLomAgwC2EqEhqA+iknJ3B49Gd+ALaVoSTNYIOHEUiHTYQiYcKcONL9EtO7FDsx+2vrz
         uJNjMkJj0fR38sN2imgIcIAimKqQ/lJzBivsq4a950Dq7HiYjGH8/Jvqkt9JKb7RtNNO
         P142w2kGl8eWdSXLTxyASIXfNwquXzcpEr7kgn5x+F9Qg9F9MrQVY+J4l1SJVZRF5KpN
         ONiwdnWHwKEuKm0+CfONacuYqkJhoO/9GFkocmokIaBYrWmUfEU8G3/RH39EfyaqvZSY
         MafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600088; x=1794204888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYKyTKANHmNueSZX+Vts+dz5q7U+GTeUPWVYwIUP5po=;
        b=zfoPzw6WIgrfUWzeVFLp8ZhnDppWilrWJZyc7zj0YVBfgOFclP1R6ongMWcrPJ8P0L
         dvl7k/QNthi+aTB8RZyVZm9c9LmMC6Epr0x+wNjUaldKBXKBFE/kVNmUZXdYjmKucces
         NQJCD2/Kb7LTE+6xUGeXm1r38Xanm19Trz/hFIEaG/OmA3dh2WFUuFXIfyWGbEGT6phl
         qmnlqWcV/BQUtdTao+Kt+Nnle2bz1A3vzCsMYb3qzCilGGCO6fqCQoMkbDuxE7JCzxdl
         GKHnhrjcyHKGJ5+MHjlPncF8634vsk726GVcIp2Zwk0CkhkvIpUCpG6cisKYLzFDYEqz
         pSuw==
X-Forwarded-Encrypted: i=1; AKwUvBzn+G1/I7v6fGgSPz0Zpbbqy+cuFcQ6hyoSxM6PX7jkAD0rmM/uqOBWQcLCvY6BT8QLjiAYuwB9sLTonQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJfw+G6UaHTctmuAiUCrx5WeBue0GPPmiMUGp3AV/WR7r/W5IzM
	oQ3pDo3MKljtU9xzW6iy8cNUJ/xryz8Bbx5KhetExOpIYQZpFSpBAzei
X-Gm-Gg: AYBFou1a8b+ROUy2CdAzO9ISTo1XWVM+AarH4iG2+ORrSA8Bwj2sgkr4jSiAIFGZLKu
	r6NMMUdW2xv5QKt4V7Ob6JMnRYjxbqf583OhPRzYQO7wdx2cohDL8ejBprNo8XilGTsgoc4aYL4
	HrJjYskwr/NJ86MR07QS+P5w2Y2qOXrW+ht61uc4qtPLaHlF6nE9oaZuB3HFRvRL7B+g9WLAcMP
	7DK2RuccoS4tNB27hRsUBFRj9QglHq4HQ76Htxgic4uKoT04gWmeW+tKzd+gQg83mR/jT5WJfrJ
	NAUoI9PmRVInF9FxwA2dHvmX9BK3auNy03JAcw5M38kB/kwyGapsR2ZhpZ6bXQ9Sl21jE8iZ1IX
	87m/qFnBLrASaHuqIjuksqjgsTFAv+ktej+xJ7alVMPWNZ3zrb4UU0IkQ9eigdoDtufpiDxg5oU
	FTrY7Sbl2U80iEePuEuMGzUj36NRocOdfeKpUjyw1KmJUVvymomhnJKJFXJg+AqJdGT6cSdx252
	2HUmEXnAzmPET5qhoA7t6CHCiQhbg1jgAuCsUy7s5TcUeWvGyqz3CvGsz3415BecRsEK/d0A4+v
	0l7MFAurNp1UHBWVe6hRFvP1SIR5Fw1XsFVTzifCQmDriKo=
X-Received: by 2002:a05:7023:d09:b0:1a4:4194:fc04 with SMTP id a92af1059eb24-1ac5e320bd8mr13624659c88.28.1793600088113;
        Sun, 01 Nov 2026 22:14:48 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm30288043c88.14.2026.11.01.22.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:14:47 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 01:14:37 -0500
Subject: [PATCH 2/2] block: set QUEUE_FLAG_NO_ELV_SWITCH under the read
 lock in del_gendisk()
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-bug-nvme-remove-ns-async-v1-2-61780fee111c@gmail.com>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
In-Reply-To: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Stuart Hayes <stuart.w.hayes@gmail.com>, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

del_gendisk() takes the tag set's update_nr_hwq_lock for write to set
QUEUE_FLAG_NO_ELV_SWITCH, then for read around __del_gendisk(). The
write lock was there to wait for elevator switches from sysfs, which
held the lock for read when the flag was added.

When several disks of one tag set are deleted at once, as nvme does for
the namespaces of a controller, each write lock waits for the other
disks to get through __del_gendisk() under the read lock, and the
deletions run one after another.

Elevator switches from sysfs have taken update_nr_hwq_lock for write
since commit 4ff58d6bc9dd4 ("block: serialize elevator changes for the
same queue using a writer lock"), as updates of nr_hw_queues do. Set the
flag under the read lock instead, which still waits for both and keeps
them out.

Disconnect time of an nvme controller that removes its namespaces in
parallel, from a target on the same host, over tcp to 127.0.0.1 and
over nvme-loop, with 4 I/O queues, median of 3 runs on each of two
boots per kernel:

  namespaces  transport  before              after
           8  tcp          85 /   91 ms        51 /   47 ms
          32  tcp         294 /  293 ms        75 /   70 ms
          64  tcp         533 /  550 ms       115 /  124 ms
          64  loop       1283 / 1200 ms       185 /  204 ms

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 block/genhd.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 10ca8b4d6eea7..5afc60bf139e6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -781,16 +781,6 @@ static void __del_gendisk(struct gendisk *disk)
 		blk_unfreeze_release_lock(q);
 }
 
-static void disable_elv_switch(struct request_queue *q)
-{
-	struct blk_mq_tag_set *set = q->tag_set;
-	WARN_ON_ONCE(!queue_is_mq(q));
-
-	down_write(&set->update_nr_hwq_lock);
-	blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, q);
-	up_write(&set->update_nr_hwq_lock);
-}
-
 /**
  * del_gendisk - remove the gendisk
  * @disk: the struct gendisk to remove
@@ -820,10 +810,13 @@ void del_gendisk(struct gendisk *disk)
 	} else {
 		set = disk->queue->tag_set;
 
-		disable_elv_switch(disk->queue);
-
 		memflags = memalloc_noio_save();
 		down_read(&set->update_nr_hwq_lock);
+		/*
+		 * Set the flag under the read lock, as elevator switches take
+		 * update_nr_hwq_lock for write.
+		 */
+		blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, disk->queue);
 		__del_gendisk(disk);
 		up_read(&set->update_nr_hwq_lock);
 		memalloc_noio_restore(memflags);

-- 
2.43.0

