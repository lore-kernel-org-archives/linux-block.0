Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3D54F89
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680231; cv=none; b=faQCcHW3vYmf9oFo3m+ONfztI6vLCVDfCc6KlQWtOhRnGKmvXXLTZ+8BOT3vH0X7kvM0uctcW/x9Gcbym2K4j3PCkKBkQR5ZqCqPes+rCD5hfThQ5B1XYVKYWkDQVrqFCIpu9TbU7Yb5Ai52f4xt2jX+bW58PoS/7K2wr+du/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680231; c=relaxed/simple;
	bh=WK/x5/gu4d0+kAD7L+3T6eBJOVM5ZL1vRZbxjlPc3xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAj+swnWq06TxdDP8yRYAbsWk97g3f6QsBw88PKKC0aWgVlRWODd84CXfuS37IkFR6jBohHZPnlUoPrQb11OOhgTUBw23GHN4O29Lg1o+N3DuYkguu3qbOb65oUvttNs4bBkKTCMahSpROIcaJQ/3xSAMm/vESvUZEYIn3FAWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nckPgWPJ; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nckPgWPJ"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bee9f626caso13152239f.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 08:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705680228; x=1706285028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efGH3Ww5OFomzaU1SXx6b7i3xuNfb5LRmOmTQkRzSEM=;
        b=nckPgWPJBEeHh0LVK1l9JDYKoO5PHgtKaIN1kgVbl692r6GiBj/B3KjNebMQT/yaU6
         pGbMQT4WQyY2FZmFk2e4tQMMPAeFw0q+hrku59+JEewvKZOvIsuHH27WHEGNrY9uuaPm
         vQEsa+2jVYx7JJu9mlIhkPPO+NTTOr44NcAQ9gT9ul8w087jpdRZeo8bCOuP8XO+wveq
         k3uUHh/N5zeasw7tZU9SARIa3pvsvk2qhlqw6fpHgOUrDGMUNRfIXnCBo2kUKDdJtfOB
         6v51eb22trdH/+NqS8wCwhHEAZqN1QgsrLowBIvHH6u7DJdduo6ysfMyhxjNuAMW4VYw
         LSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680228; x=1706285028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efGH3Ww5OFomzaU1SXx6b7i3xuNfb5LRmOmTQkRzSEM=;
        b=cDFpRiI5PoMmDDFaXDvCwjOVRmK7CCoR/oABGV9vmHIvO+Fc2RwxFdGWxn3PIDoZhd
         d2ky8ZeVW5LxJnUPZw4z1FQpQvctfTtaUD76SDgfDdH+j6ip99tGsDsxMZ6bpdf4NVNi
         RqUP/AqHkZMmAH674xxvC3R8FQLtLK6szIqDaoTQaZgAGtJ40MQXSd5SEkeF+6f6vbTN
         W4qcORTKni9MYMFBskpM8SrADWitZNi2Stc/eijdRZSDFhtSuW9JZYh89Jki7o3/k2PJ
         J6jw4kQaLxrVUKdxi/PdoGO/ZkJ6aBn7T1hlrtsw4ZhSDGLp1Yoa4kQlcThFxb2sJ+wR
         q/oA==
X-Gm-Message-State: AOJu0YwNO6c2wmXwdVZJUG5ZV4FAmLZi97hVk1YNk1fCb9jqy4ELaXYX
	6KlTLjlRn5ureN07199qA3u5o4SLRP9KPHK55SQBqSH6JXSJjVg2goarAeJSXMeIpddJEdbwN+Z
	WP+I=
X-Google-Smtp-Source: AGHT+IHG5VJIqG9vKDidy9uJpU2u7GLeyFWKkPchlZQb4v/Y+W7XsDpqdS6ZMw0THmxCgv79X/n1cg==
X-Received: by 2002:a05:6e02:144d:b0:360:64ad:cf39 with SMTP id p13-20020a056e02144d00b0036064adcf39mr60459ilo.2.1705680228355;
        Fri, 19 Jan 2024 08:03:48 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bc8-20020a056e02008800b0035fe37a9c09sm5645163ilb.20.2024.01.19.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 08:03:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: bvanassche@acm.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] block/mq-deadline: skip expensive merge lookups if contended
Date: Fri, 19 Jan 2024 09:02:09 -0700
Message-ID: <20240119160338.1191281-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119160338.1191281-1-axboe@kernel.dk>
References: <20240119160338.1191281-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do several stages of merging in the block layer - the most likely one
to work is also the cheap one, merging direct in the per-task plug when
IO is submitted. Getting merges outside of that is a lot less likely,
but IO schedulers may still maintain internal data structures to
facilitate merge lookups outside of the plug.

Make mq-deadline skip expensive merge lookups if the queue lock is
already contended. The likelihood of getting a merge here is not very
likely, hence it should not be a problem skipping the attempt in the
also unlikely event that the queue is already contended.

Perf diff shows the difference between a random read/write workload
with 4 threads doing IO, with expensive merges turned on and off:

    25.00%    +61.94%  [kernel.kallsyms]  [k] queued_spin_lock_slowpath

where we almost quadruple the lock contention by attempting these
expensive merges.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index cc3155d50e0d..2de0832b1e5d 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -817,7 +817,19 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 	struct request *free = NULL;
 	bool ret;
 
-	spin_lock(&dd->lock);
+	/*
+	 * bio merging is called for every bio queued, and it's very easy
+	 * to run into contention because of that. If we fail getting
+	 * the dd lock, just skip this merge attempt. For related IO, the
+	 * plug will be the successful merging point. If we get here, we
+	 * already failed doing the obvious merge. Chances of actually
+	 * getting a merge off this path is a lot slimmer, so skipping an
+	 * occassional lookup that will most likely not succeed anyway should
+	 * not be a problem.
+	 */
+	if (!spin_trylock(&dd->lock))
+		return false;
+
 	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
 	spin_unlock(&dd->lock);
 
-- 
2.43.0

