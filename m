Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B5280328
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062335; cv=none; b=AL+g763DlB6dFpZbQe1ry8QHvqDHulUtPW4pzK60OqLVhwxhf0JMRTnOT84oJrT7m9vdytJp0CUQLvvklvrq/kXmOtCC6iBnH1kS+9EnCGqApNxtBL2VILuVxHJGHWjO/yWHJxwtsLhKfkpaLLph6THr4yuYxd3uijJZHB7RSIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062335; c=relaxed/simple;
	bh=++ys8qf1mVFh7eaJ0LPRH0noW+e/5qWo081uJ6QywX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyIGCw4QxGMfEU6ewIV70BK5OThiELPt294WfZfnE4IJCJr7fdHl+gUjja9u3UU71PnO7DFPj2vKwETgR8uqoRY3U7tBZijwo8Pi/HN4AtSg+JkI6vv9MpDhSs75bYfC2wBRiU5endntbmEnSLkrSzY0h+Ls5a+DfdJOXz0r8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J/1X21Hv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J/1X21Hv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so9865865e9.1
        for <linux-block@vger.kernel.org>; Fri, 05 Sep 2025 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062331; x=1757667131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o4r2c6Wzzp+J29SS3YZXj6FxIBq7GTFCT9Pn6IdrUA=;
        b=J/1X21Hv9aeS3pK1XqRWVYzLZUylMw79x3kM7hwjj4PKyLuexMappeM6E6+biSXjoP
         sd6c3rfJZnLntDYkXdCxUskuyPCTD+25RNzIK7VNCtKEzXehW9wnE506YLyhj49CT2Oa
         OK73kobcTr32n3pe3Uaeew6C8hnEHqc/cZZX1bkCkl3q0VATh4QHbnuAYmnr+t+OZAyI
         xv98opbmchHpz+KDBgQWL3Yml3saNw9a+rhkkTcaMqN8n/+RqSX0ka1jKv/i7K+0SQ0I
         QGPzW3xhhVks2OnSnSfG38Y2bMGy9ajRa8+CIQLkjSask0aAHxbcdk+FH9R4CDajwgKb
         WIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062331; x=1757667131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o4r2c6Wzzp+J29SS3YZXj6FxIBq7GTFCT9Pn6IdrUA=;
        b=Pc1n6NXln9X2geOSVBjM1tsyEUGt2QMRDKGjkiIOlVXPsdZJ1a3QStlQ6Taj4ozv3M
         6xBo/FZVkPkNAJAt7mhChaR9mt/fZBREptuMERgZWQZ7mpXsboU6slNKP3qU2Jwy570f
         QG4EsKOu7fRVVuMTBKhqc2DENNKXNPdxaVbmXvzKD5Df/I3oScaLD9/67spe2YM0Vr68
         MstIXmmqv1aY2Qwo4eluJWpgP5DFHxvcp6qXMPxmyNv7nK+TfX8sXzU3BXBQ4MpqPAhO
         +HfBa+h7lSeov2AWW3frH94Xo5eFSXR42qWJGDXB7LblogbbHWx94k+2UcDqXeNjE2Cl
         P1nA==
X-Forwarded-Encrypted: i=1; AJvYcCUnoQ3XXzyeIROLe5zkHHNWPDGf4p5a/8LiwKxzKj/lMg65pfmGMQoT3QLBdqGGRO79R9Fda0Qrh1xkgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRW9JOgtivrfDhux8fgse2MZRpTfXWo6MMAhzzdYWM8C7/WWa7
	/V/7MP9tG5Ag+Fi6LC93OZ8m6AJ1+32QF4eRTMjV5YGQeGBv9tPhmpozmekJZmgjZr0=
X-Gm-Gg: ASbGnctpd0X4yVksKvdUeotToBYlnL6vjLd5vEkaoqQ0E+9FXdTSwnTn+utdksm/Sj6
	H5020f5x6yGuVcbtEVIc/WojjdhOG2t/hgvGuPrAeEsL2wmUfRi/j39UzYW/TYua3YD+6T6lff0
	C+sN3VZXfqUakR/S4Efhp+JwkxXHigLmpo35fgCF4bhiSWYqvmne/35hLVrsaTYWDKonrGNz78I
	+24wru8dxg0JADLs/8jX/CCM+FOtQwPkOQ0t8jLgICW6CRYhA76wGScREOytv8MirtYesQKFdTC
	IfpwT+RaCIxioODF0PgYQIDYp7lCzwQurldtPANt65hWWW+nsX2LHEe6Dh2nQqBP5ngCkQC1Ctz
	C3zo2k1WYQRTno0sBuYgnxUWjTTCixLt2g6lGvmPRU6F+RqtoVkp/CxGnCQ==
X-Google-Smtp-Source: AGHT+IGzUSTZ0dDnwg+i9qkis6hQBvZ5e7JyYMSkRPsAT6NSK9nycRZK+BwlgAZJyKeWJKn15q8TDw==
X-Received: by 2002:a05:600c:3b01:b0:45d:d202:77f0 with SMTP id 5b1f17b1804b1-45dd5b3c05fmr20914855e9.5.1757062331095;
        Fri, 05 Sep 2025 01:52:11 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm166359115e9.2.2025.09.05.01.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:52:10 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] drivers/block: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 10:51:40 +0200
Message-ID: <20250905085141.93357-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085141.93357-1-marco.crivellari@suse.com>
References: <20250905085141.93357-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fda7d8624889..c7e0fa29a572 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -975,7 +975,7 @@ static int read_from_bdev_sync(struct zram *zram, struct page *page,
 	work.entry = entry;
 
 	INIT_WORK_ONSTACK(&work.work, zram_sync_read);
-	queue_work(system_unbound_wq, &work.work);
+	queue_work(system_dfl_wq, &work.work);
 	flush_work(&work.work);
 	destroy_work_on_stack(&work.work);
 
-- 
2.51.0

