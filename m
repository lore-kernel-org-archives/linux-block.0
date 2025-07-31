Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB32E406
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944658; cv=none; b=o+oPeGnGHcAHTHDZkGkCJ6IjXxbduLjU23E5kQCaezqJeXIS1RvN5tE8rMCt/cTNKC//av5ZXuH2Q2XLHl6tBiKlPQNkZfDr3bFfyjvhSygqiHbaL2JGfjwAiOkRi/splaihRR/Qg4yrVmn+xmD/khphIkL/0mZtOj5Pbm14/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944658; c=relaxed/simple;
	bh=F1koaQpG5RiYkmXLSaH32gPgQinIXivpSy8xeXHW5uA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b7aWepTecRq4VmDMLz9r5phgLEc2EI8BU0OcMa/GblSJiZpKn/p7H/jmW4hTjSrq6qk+t5sYPjxlZpyEFgdkTja/zeQYvS6ieQqaYXH+IDpmMqiT2lmx17kJdxnuQIRgoZ63mCosmXYmdvXy+GF8gdD/lHsi4W2NEvFE+AIE/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKi5ftRr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKi5ftRr"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313c3915345so1006817a91.3
        for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 23:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753944656; x=1754549456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eDJaxtMqe7fiyPuNTQg1qGmKmUg0reM6fAkK/O+G1w4=;
        b=ZKi5ftRrFSMS0Xq4BzS6G2dirApUJHxzmxihdThRJjXGvxeCuT6vmliC2Qhxjml2Xu
         xW1muFLDXVqOiq9IOpXxcB8v0lirI3IVp1wJj2XgeUs+tjyog6HKqwThbPAcfK7ZdWlV
         e6GN5mlJL6utA9jmvYJ4DsGDJbyia4dp5t3sO/W/G9LsCHJimvYXvFaf1LKx7jtoPOUS
         tPAoStK16paJ1f9n/So7/V8O3b7jjcrCrWCxo4uFLE7VnFMklJm81tkVecxqumA1hQmk
         oNlQEvqDXZv1qqrCrHgaDKXjZZ+4AsEyA5GP9Yd3r0vSIMyQTTjiPoCdOrtyRJ0qykXm
         cBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753944656; x=1754549456;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDJaxtMqe7fiyPuNTQg1qGmKmUg0reM6fAkK/O+G1w4=;
        b=ZJNpSSnGgfKqhkgU+Jja4QnRxIVxeOf13q3JUeev1kWoa5Zj5CDn5tzTT7tewE5EHs
         AQM85FslzBaLrE5mxID01uskVhJ+dLKrxBodYqgU7zIHPFpjIOFnm2o/UYOu78ap/p8i
         2VmKzBghyOU5FMlCVpGLiv2XmxkYCuZYmpcSSedxW5RDzM/XiVpVZQQpC/4jfm5k4UH9
         h+ToGJzpoSiCVczkkSnpwx60WCaADvjUw3ooiWBupunr6FyynOQv82W0O2JVLSngSDkJ
         WQEG6nqdAn+b71g2ZAbyzRBdrUGTZ5EAylC/dIxc+/1hSeJoMIzbDpFfvZXV/+sHIF1W
         QQOg==
X-Forwarded-Encrypted: i=1; AJvYcCV/2RSPJZEoSuIxgc//RoHmbcdyqhoP2FQNfD+gX+riqZ6Sx2jXNnf/0DpuMV40R2daUBvJgKJQbGgDjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKDpCnHT4fx38do95IOIN5Bq5v+q/FUF+dTtb/DYPSTKo+kUdk
	PDEOikScqMAv1EsEF+Sitxv4Pus2mflL5Bs6Qa9RY8CsuJ8/THlLIkc0S/3caH/ku+u3Nh+yV8h
	OYiBsZ26oBUJI6JPYktsD
X-Google-Smtp-Source: AGHT+IFpIPWixJhTbrmE7dv0Cm0HofhpwRmbpRh4awsTGTBSBMeWjmf38aB3IMobKpTlhlDwGPSTmVR7kD9SQmQO
X-Received: from pjbtb15.prod.google.com ([2002:a17:90b:53cf:b0:31f:26b:cc66])
 (user=richardycc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a81:b0:31f:210d:2e56 with SMTP id 98e67ed59e1d1-31f5de557femr8853490a91.28.1753944656412;
 Wed, 30 Jul 2025 23:50:56 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:49:46 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731064949.1690732-1-richardycc@google.com>
Subject: [PATCH v2 0/3] zram: support asynchronous writeback
From: Richard Chang <richardycc@google.com>
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Richard Chang <richardycc@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series introduces asynchronous writeback to the zram module.
By moving to an asynchronous model, we can perform writeback operations
more efficiently.

The series is structured as follows:

The first patch is a preparatory refactoring that moves all
writeback-related code into its own files (zram_wb.[ch]) without any
functional changes.

The second patch introduces the core infrastructure for asynchronicity,
including a dedicated kthread, a request queue, and helper functions to
manage writeback requests.

The final patch enables asynchronous writeback by switching from
submit_bio_wait() to the non-blocking submit_bio(). This patch also
includes performance benchmarks demonstrating a 27% improvement in
idle writeback speed on an Android platform.

Changes in v2:
- Rebase and spilt to a series of patchset
- Add test results
- Link to v1: https://lore.kernel.org/all/20250618132622.3730219-1-richardycc@google.com/

Richard Chang (3):
  zram: refactor writeback helpers
  zram: add async writeback infrastructure
  zram: enable asynchronous writeback

 drivers/block/zram/Makefile   |   1 +
 drivers/block/zram/zram_drv.c | 157 +++++++--------------
 drivers/block/zram/zram_drv.h |  30 ++++
 drivers/block/zram/zram_wb.c  | 248 ++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_wb.h  |  42 ++++++
 5 files changed, 371 insertions(+), 107 deletions(-)
 create mode 100644 drivers/block/zram/zram_wb.c
 create mode 100644 drivers/block/zram/zram_wb.h

-- 
2.50.1.565.gc32cd1483b-goog

