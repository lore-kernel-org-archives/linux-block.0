Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311E2701BC
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441497; cv=none; b=bVtzSaQkmnpnIyY4nAdiq1JALU6fiK8c0bdBes4d0kgKgMqNkwbOlJXgbZo4/rU7MarQdWKWROjMQ2joA7BCLMyX8t1ug9EswP+MLf8mOo/zjKSfKDKJJ7YtTrGZfa4AMk3i8J6SNlju+9cFTHVg47LI762Ue/XRAFTlDZmmfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441497; c=relaxed/simple;
	bh=Hk4CcxicHHVtPH18BOXInku52HV1nXKPB08vqHt5p+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mct3tHc/vju3H+b+8j15wtJTFWCK4oSMidUXff93EJHrS0iaPSJOI4nO72QaghLA4x0Io7sX8XW/Ws5Uy6keHNaHW285CxKJ2uuUClH2QFOq2QKomTE/aOSLhR7Hagz/0NON493qeOQ7X5RY54pE+LuzHiBzvzplapBzK0Y8nsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cTghGSDb; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cTghGSDb"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so34652a91.3
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745441494; x=1746046294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=goNu6vGqXHnJ8RO1fz4V5E7ge6aZfBjCMg2/5j2/saU=;
        b=cTghGSDbEm+c2zlXX2a4rzHKFCXmrry4/ieFC/wkXO3FO1J2X2mv/6WD/QQ5Wotlmz
         Xrknb4ySo4wohzfcyrGfdIv2KiB5wPm7w2kuqeEfxt0Bd3OAyR7b04SRnegHrqCzdPi/
         vV9FkIl0HQCPkjBJpKdNFjFEqRbYaWW1D+GlDP/8n5eipnnRZ9sXH7dAwbAH0XwSGNTb
         V5ooOeYo3DQAwjqiCZa+hYIWXdHZIvfXEGSBJfUSs72uzNYQaKXAv0gMQ1/n9zFHmLuN
         cFEGDSmPtQkGegIaYDOwWR5A5we8swoNejZcRD4Svn2cHs9DUZ1/SwW3Fk3SK+4h7516
         NZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441494; x=1746046294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goNu6vGqXHnJ8RO1fz4V5E7ge6aZfBjCMg2/5j2/saU=;
        b=n+4w5Qa9GhvlJbR6CWwOk5AtG6EmVhz7pOTBXcMEUfjxEefPt5t7V2igQHf2+aqizs
         W/rr4CPKeEEO5NgvEOgWgFjwV2FwNp0loZ4W7vuImxR0h6uV9BDlf3IAuYNHdanCzOcM
         HSxiTwEL4laKf3cMrQDxnKqe7Kjmp6/OtXZVnHmc9n0WpIT7897qIbrI/FsrpX+WNvDr
         EME438dEPSpVZTrsoJuw3ymiW3P1U3Qt0qd+0F9oA1mCdUJdCotDk5YpzwCmcdZWf840
         65EyIf8H5VEErnxu7WMX1lyhfGXhoTFUIML8GvlI8Pc0vUm/WyORMyaTqSb53au6hecm
         nW6g==
X-Gm-Message-State: AOJu0Ywo3+Y/dE5X59g81Coto5CsfHsYsEGmpv/uxVp1XU1KfzoepoH5
	FXmn7QR4c1ojF1hBffNE3QHQPMD/yQZb1ucyUTegCscfgyVtf74jnVXqciOO5uMb2enACfoNSix
	3XAmlBHm3uaMCrljIm5PnFMJ0ec283SjJintOBhuivqe8+Btn
X-Gm-Gg: ASbGncsrirnBmozNIEO3jH97NFvG+Vd3u96J0kOlVUeIt7tIiWmAh1IDUJreUlubk/e
	khARVNI3oE56b1RbCRE/+e2hG6KT+/TZLzqgAGoOShqpB+2gu2hLOd+oX8nddZVIrig7ouiDz67
	+SfP8KKU9qNNqZjFUcNliUNTb+cSh9vmwM6Sf0JaErTuKNa55rcbAZrib1nHQo/bIHby6lQtFt3
	ymtYTHaeKTCPdLJAsFzwsV/FHOXEstMwZFcP94iDqPNQDlHuJGVG9QtpmXEw+U1+0zvkRZj52rZ
	WSQCXPbeb3U3lLtWX1aYYe2iPtteYQ==
X-Google-Smtp-Source: AGHT+IEZRHcMFxF+HVqKALRsVl/gqkKMSWX6d9LvtJXMiaBIYMjl7zUK+xTB64fko8CZygZIAEAvBSRvj0Jx
X-Received: by 2002:a17:90b:33d0:b0:2ee:f59a:94d3 with SMTP id 98e67ed59e1d1-309ed3ce35cmr109800a91.0.1745441493574;
        Wed, 23 Apr 2025 13:51:33 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-309df9daeefsm131362a91.2.2025.04.23.13.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:51:33 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C8319340159;
	Wed, 23 Apr 2025 14:51:32 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B3126E428A5; Wed, 23 Apr 2025 14:51:32 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/3] block: avoid hctx spinlock for plug with multiple queues
Date: Wed, 23 Apr 2025 14:51:24 -0600
Message-ID: <20250423205127.2976981-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mq_flush_plug_list() has a fast path if all requests in the plug
are destined for the same request_queue. It calls ->queue_rqs() with the
whole batch of requests, falling back on ->queue_rq() for any requests
not handled by ->queue_rqs(). However, if the requests are destined for
multiple queues, blk_mq_flush_plug_list() has a slow path that calls
blk_mq_dispatch_list() repeatedly to filter the requests by ctx/hctx.
Each queue's requests are inserted into the hctx's dispatch list under a
spinlock, then __blk_mq_sched_dispatch_requests() takes them out of the
dispatch list (taking the spinlock again), and finally
blk_mq_dispatch_rq_list() calls ->queue_rq() on each request.

Acquiring the hctx spinlock twice and calling ->queue_rq() instead of
->queue_rqs() makes the slow path significantly more expensive. Thus,
batching more requests into a single plug (e.g. io_uring_enter syscall)
can counterintuitively hurt performance by causing the plug to span
multiple queues. We have observed 2-3% of CPU time spent acquiring the
hctx spinlock alone on workloads issuing requests to multiple NVMe
devices in the same io_uring SQE batches.

Add a medium path in blk_mq_flush_plug_list() for plugs that don't have
elevators or come from a schedule, but do span multiple queues. Filter
the requests by queue and call ->queue_rqs()/->queue_rq() on the list of
requests destined to each request_queue.

With this change, we no longer see any CPU time spent in _raw_spin_lock
from blk_mq_flush_plug_list and throughput increases accordingly.

Caleb Sander Mateos (3):
  block: take rq_list instead of plug in dispatch functions
  block: factor out blk_mq_dispatch_queue_requests() helper
  block: avoid hctx spinlock for plug with multiple queues

 block/blk-mq.c      | 106 +++++++++++++++++++++++++++++++-------------
 block/mq-deadline.c |   2 +-
 2 files changed, 75 insertions(+), 33 deletions(-)

-- 
2.45.2

