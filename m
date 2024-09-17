Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63E4C9F
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532537; cv=none; b=akR/T5UimiVgzW8XTVfgv/DwflM1vZbayKs0CMJQMVbrIcRWWziUWnu3bOdl5bzUmTMQ26VgxwZq67/KPqQ2WQBe0IUbE/Wzii8zMwp72nWlTQjnud8Fc/b+E8xZBTVv88xT5l7+cb0Yzo/JvmfSwZF9JfmbciRqOyKTG7z9YSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532537; c=relaxed/simple;
	bh=roRuIR4u+3fcvmM/dnfH+sTOfZq3hGazG7x4w/90Lqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pwl+5P7It3Cn976JtLPeHsj8GrCdBF714SBjO7wzqaZ4VkOVyt4wWeYJzz52zMZbKlJ/FH369ZATRxKJqHPPg3mMcvqfoNB4biPds8vrnGgLipB30ziDXKrD/MIPf6s3FNruZz9hMmCxtaWWz0TrAqkeGZiGv2WYUE1POl2579c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YnqYrlsz; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YnqYrlsz"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-6db9f7969fdso39912097b3.0
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 17:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726532534; x=1727137334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oe2vw+WjcTu4x45b1CL2os/WPzFTgSOaNlI8K+iYMaU=;
        b=YnqYrlszd5odYLXpmaHazbitzeuLSajZa/PN95hMPCgcKnwHjovgmiDtN9ZB7Xk7yX
         lfTMUPP4WM/flbXaCOXcg81Gf2C1QfcyzuwR6BuQpeE9zV+MbTDOOWbbUUIAs71diMt2
         Ajc+Ea7f1tx7u5SasVhR8irqLFpmV3Yl9iSH7AKDIpvwvzXpaDBDFQ4Hj10q3ZNLcvzv
         cq6vTIQi7Ci/iYTYTgsqOOZrPW31emw9Qc+Ip+kUnjOc6E6M+sBmOalcANdJqVMP1EvR
         NcPZeZKnUqeLzivopYM3co5IvW7Lv47lyEeY8Eh841vAAF/KZH6kzYKEFMv7OzQvaPDS
         IGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726532534; x=1727137334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe2vw+WjcTu4x45b1CL2os/WPzFTgSOaNlI8K+iYMaU=;
        b=oNMpgwoD58RDyxbQhI8krTjH1PMeFRD/ourQEBxzvok1Hpnla7t+JvM38bRYk6cY6e
         y1ZWNmkJKLliaYJuedwRxRBJFQ7ruKUDGiIy5KNb4IRS5NY0Jmw2AEvXwlEpp+SJH08k
         gW/00cL7ajn0zmUwcn5AzQJiEH8YBNSG6gI8y2+59Zda0Kq/v+FynNFcktTrLBvGkpAk
         phfWYafs27kevXURPSyWVtjVXOpAN4wNGKcJHFqVLxruI6si//RSDSS4k50SPDzjWnFL
         HWl0XdMkFfc6aKX4FbfFsv6BOXXM7dRgqvg1QHa2qzKBx+ltg2jqoWRJ/dSlXRvrBnMY
         s8fg==
X-Forwarded-Encrypted: i=1; AJvYcCV3EtKVBUgwUZvdE7Fo592Mi1dfXMgbYonO5G76yDeW6OIw7udoBVENeYSotUEE5MUu2z29rfz6IJJVbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYNX1nx+/sOiNSqHH5wm3i3Nfrsd3VqQ8+XoSF66fZu6tPMYO
	YVksEMtxOoHbp6aHEJafnPiJTCnHLJA/iTyzINbYb7P+BFpig2shwW4mCFkvLOAgtZOPln56qBR
	j8AmdG/SUL6vLEwG/frb1s6ZCFMOEiNsKsRDf01dKfb0xi8LC
X-Google-Smtp-Source: AGHT+IHDRb4FR+lryRibAM96iZClMEhBFy9l9UyeRt0bvNkpC7r1+uz0kfJIcAniveR1Thjp823VGJIOTAx6
X-Received: by 2002:a05:690c:4a12:b0:6d6:c5cd:bde0 with SMTP id 00721157ae682-6db9541615cmr185535017b3.15.1726532534119;
        Mon, 16 Sep 2024 17:22:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-6dbe2deefadsm2814507b3.14.2024.09.16.17.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:22:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6203334028F;
	Mon, 16 Sep 2024 18:22:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 527CEE40F10; Mon, 16 Sep 2024 18:22:12 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 0/4] ublk: support device recovery without I/O queueing
Date: Mon, 16 Sep 2024 18:21:51 -0600
Message-Id: <20240917002155.2044225-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk currently supports the following behaviors on ublk server exit:

A: outstanding I/Os get errors, subsequently issued I/Os get errors
B: outstanding I/Os get errors, subsequently issued I/Os queue
C: outstanding I/Os get reissued, subsequently issued I/Os queue

and the following behaviors for recovery of preexisting block devices by
a future incarnation of the ublk server:

1: ublk devices stopped on ublk server exit (no recovery possible)
2: ublk devices are recoverable using start/end_recovery commands

The userspace interface allows selection of combinations of these
behaviors using flags specified at device creation time, namely:

default behavior: A + 1
UBLK_F_USER_RECOVERY: B + 2
UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2

A + 2 is a currently unsupported behavior. This patch series aims to add
support for it.

Uday Shankar (4):
  ublk: check recovery flags for validity
  ublk: refactor recovery configuration flag helpers
  ublk: merge stop_work and quiesce_work
  ublk: support device recovery without I/O queueing

 drivers/block/ublk_drv.c      | 187 +++++++++++++++++++++++-----------
 include/uapi/linux/ublk_cmd.h |  18 ++++
 2 files changed, 145 insertions(+), 60 deletions(-)


base-commit: a46c4336b17af3badf37b3002c8421a21f8db6c7
-- 
2.34.1

