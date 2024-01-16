Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB11CF98
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424307; cv=none; b=FLYoYISgRZ6ilWwhUQX/u9KOz4TVgUmhvp7YESntAUWNXuPwfwoLHBfpupVlLdpTjng863j0OQJe2/dkw3UgyTbX3FhzddPmDQ47kXPGwvWkxd1otxTyfKMU6r8aQ/MrafQFai4/2S43Gv43Hl3YhigvjTMDVgW5G7kXPf4G3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424307; c=relaxed/simple;
	bh=f0+WWJ5qeBZXZdXMfPSvE2O2XsNxVggq+PxMwxK+/Ww=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=FwkWWCAmJTtmGACvoO5qnPm6TBZFYCBboJUSnmH8D7kj4WkoM6KE+HgwfLDWn845EqIb0SpW929DzPlbC7f9mizgnGTaCNzfrzEaToFcfN1ZXu+hqUfsY3Q3ANFTNe4g15SIhDa7uN5uEOkbGw6a5JbIwjJkQP7W8aej+z+rEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CyUYxiar
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CyUYxiar"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-360630beb7bso7915405ab.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 08:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705424305; x=1706029105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OQsqWA3wgPKqR98FS44Fcrdj5xBVdgVFItDpaqFekA=;
        b=CyUYxiarWmOBRSkRNdlvgttbrJ2gVeascE+3w9F5M4VF2botqASlWtCPhkV+NPyzR/
         QxBVcg/DvBMzcwTRqRulqCivyVyb9MDciHRusTwEdkWsh8A3qFADZTuZCTmzXlKVoQb6
         DHfPgnR7hvyb5800ODnPoHaXjMWhKgO5sVbOMKcYyE3f6qeMMDg9ONXyuPGZb9uU96v+
         RoQoa70xQnbi1WaFcMgEwiw7sylcu/TH3yjapdSlQ32BIvC88GuVOqO0ZWk9kF0BhwSs
         feyb7h6b0xkws20QdQo4UX2KLDp9crIWMj3tYVyl0Yjwdglk0A3iii1+hbdz+UyY3RMB
         kx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424305; x=1706029105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OQsqWA3wgPKqR98FS44Fcrdj5xBVdgVFItDpaqFekA=;
        b=fotmneO3SyWxWQoBEcVMdcO/JYwfkKBSZqWWC6G3H/M2dYsJMRq5AW2WsDGu/tlZv5
         Vp7/PQoryoquHGGexrlsJRB3SKhSHImIlLSCmYEe0ea3LG7jC5Mex7i3Hs/uyO2gOXph
         o7BC6bynroJQjAl6F0c4mSHFK3RprxvQuqI7vkLG9PZ/mcDGSwtSh9mvO3LfHoMvnktN
         oHOkOoQLl7UsmnRDSmIkvn2JCusoFo1rJzXeFgKUN6mBzKMayiNC0QCUGHUMk0RGvjof
         p5YURho8i9uAoQ8ns6FtIPn5eXGMoKtRUQKkKSTgLeVbjkTP4zPovCdRw/+hh2VTwABJ
         Pdbw==
X-Gm-Message-State: AOJu0YxzGmKD8surV2Pno2bOStFLE9Oa+eq0IPbFh4gDPb0WIppfVFLo
	iE4DexM6EuTlwfg1YNlkk0Xw2ek0OBY1l3hAYUkuTsb0hUWjGA==
X-Google-Smtp-Source: AGHT+IEuWWsXm4QCBpM5jiQ+ALyDDo22ll6ytkkOLnvZ48HkyzlB8sdlQW/Mia7gbQxotZLyX3VyPw==
X-Received: by 2002:a6b:680a:0:b0:7bf:60bc:7f1e with SMTP id d10-20020a6b680a000000b007bf60bc7f1emr952247ioc.1.1705424305037;
        Tue, 16 Jan 2024 08:58:25 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c14-20020a02a60e000000b0046ea43e4d0csm71744jam.168.2024.01.16.08.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:58:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: kbusch@kernel.org,
	joshi.k@samsung.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] block: shrink plug->{nr_ios, rq_count} to unsigned char
Date: Tue, 16 Jan 2024 09:54:25 -0700
Message-ID: <20240116165814.236767-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116165814.236767-1-axboe@kernel.dk>
References: <20240116165814.236767-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We never use more than 64 max in here, we can change them from unsigned
short to just a byte. Add a BUILD_BUG_ON() check, in case the max plug
count changes in the future.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 4 ++--
 block/blk-mq.c         | 2 ++
 include/linux/blkdev.h | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cc4db4d92c75..902799f71a59 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1063,7 +1063,7 @@ int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
 
-void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
+void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned char nr_ios)
 {
 	struct task_struct *tsk = current;
 
@@ -1076,7 +1076,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	plug->cur_ktime = 0;
 	plug->mq_list = NULL;
 	plug->cached_rq = NULL;
-	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
+	plug->nr_ios = min_t(unsigned char, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
 	plug->has_elevator = false;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aff9e9492f59..a9b4a66e1e13 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1283,6 +1283,8 @@ EXPORT_SYMBOL(blk_mq_start_request);
  */
 static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 {
+	BUILD_BUG_ON(2 * BLK_MAX_REQUEST_COUNT > U8_MAX);
+
 	if (plug->multiple_queues)
 		return BLK_MAX_REQUEST_COUNT * 2;
 	return BLK_MAX_REQUEST_COUNT;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 81a7fca1b4f7..5b17d0e460e4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -943,9 +943,9 @@ struct blk_plug {
 	/* if ios_left is > 1, we can batch tag/rq allocations */
 	struct request *cached_rq;
 	u64 cur_ktime;
-	unsigned short nr_ios;
+	unsigned char nr_ios;
 
-	unsigned short rq_count;
+	unsigned char rq_count;
 
 	bool multiple_queues;
 	bool has_elevator;
@@ -963,7 +963,7 @@ struct blk_plug_cb {
 extern struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug,
 					     void *data, int size);
 extern void blk_start_plug(struct blk_plug *);
-extern void blk_start_plug_nr_ios(struct blk_plug *, unsigned short);
+extern void blk_start_plug_nr_ios(struct blk_plug *, unsigned char);
 extern void blk_finish_plug(struct blk_plug *);
 
 void __blk_flush_plug(struct blk_plug *plug, bool from_schedule);
@@ -1010,7 +1010,7 @@ struct blk_plug {
 };
 
 static inline void blk_start_plug_nr_ios(struct blk_plug *plug,
-					 unsigned short nr_ios)
+					 unsigned char nr_ios)
 {
 }
 
-- 
2.43.0

