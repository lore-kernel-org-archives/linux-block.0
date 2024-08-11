Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52102E646
	for <linux-block@vger.kernel.org>; Sun, 11 Aug 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371576; cv=none; b=SKVRZRjnNxLw0u2nOcERu55dzJl8Y2PyZZGvJ4wnRFnSowoOJNyz6Q7Upmq6hx2rg+dLY94ltqh32IWNUV5Qcu9vjgtG8XJ9E7CRl2wuvN1Y4etjTEMheQyIWmFsQBFz1Sgb/6Vfrpa8Y+8f6rRwcv7l1E0VrOwclIEN2jhVKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371576; c=relaxed/simple;
	bh=v5jSDFfK2NHEbMWosQWn6G/sglvlKQQhmlLCRg1Qa+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ly2IFDnYPtsNOSH/WKswM4GdFnUDqgmfgXW5BSDYYG9rfJfRKOxUwXJYIlW24coLEkYG9+l48na7Cztp78bMdj9SpculdJSWf6X8XZ3YwJGeqGdohZ00BFhbYQloOiUar/r/nd9UWqNqqbfEx1gIkYq9Oa5mcQFh59PCj9Xl8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e8XkSEQ0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e8XkSEQ0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd9e70b592so26308525ad.3
        for <linux-block@vger.kernel.org>; Sun, 11 Aug 2024 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723371574; x=1723976374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHD6u79EjEv29RNRwjvBd/7eFbzoXwrn3wscnjegDn4=;
        b=e8XkSEQ0qgJnnMxMR9IClm61xMA/aEiPiVpy0ZUrPkbKY55R+rzH7dJ1GFdTuWNY+S
         91HF8kZaGDLEHs9dwEybieO0maTIv1mYbBI2gc/M5XCXZmpIMUaygux1WJmxFBAk0ym6
         yMmeO8UPBhr+9GgQ5K+eXxAl/aobI4fD17bW62RgoOX/BJ1KqcuxxV5VHhn5lR2TMPWc
         sQ2P16F5u8W7djiFDng1m4pE6bCFz2FHe2MkPIfDCcZwaAyD4xl9vuSrd7aHmpFUhTZe
         fcVCx25xSNjLcBNV42wA2ibVteZq/PBlL/xL6fHVd8pEc4y4mP3vwHPRHiL5gfU2M/i3
         tYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723371574; x=1723976374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHD6u79EjEv29RNRwjvBd/7eFbzoXwrn3wscnjegDn4=;
        b=LMQ5ViQ73l7V7GnGy3fDt/lr7zbbFBruGmKRdKhEWTZlyobUEfNySiK97qvedYwfFL
         +HaR0ZVm/QXsN0KnaUoidbxno/nMydWre8WFCDgqt+HE8PWP3m9G2jKjm/UVB4Y+c5Lw
         N6Hwxk5IWKqDnl930oxw6Zln6l80stT3SuTBEP3BMtqJo1D0ux9UtfzPgVQ6St3ph3hd
         l554o6IYlZ1z3wEc9x4H/wli+fJe+ePnM3rVhw3ak5jn3DigXopN0JEXAXkgtB8VbLLM
         1+1IEo6afcaxlTiKtIvKCnHcJjEsRYwJz+dcFOBA9NTM1MjaQ+tLHAZpLL0cus5nYngy
         +mhA==
X-Gm-Message-State: AOJu0YzSO7U/bhoctdNH/RIgKaniXzIVWJQA+bp1NI4uxLBJqOBfrTRz
	XasqAzEVabxfAolLAkchM789HfyREEk2+SNIbGNLjl5Pz9fXu+QVSEUz6Pu3U5c=
X-Google-Smtp-Source: AGHT+IGnfFBgy7ehBxC2BcVfMoI1OSpkPsLoKJsbaGtA2u9Fcei/Z4OQpt6ly4oSLVcYPET3eEeJKw==
X-Received: by 2002:a17:902:e747:b0:1f8:44f8:a364 with SMTP id d9443c01a7336-200ae5abed8mr79055675ad.48.1723371573903;
        Sun, 11 Aug 2024 03:19:33 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb48b81sm20992155ad.297.2024.08.11.03.19.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Aug 2024 03:19:33 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/4] Fix some starvation problems
Date: Sun, 11 Aug 2024 18:19:17 +0800
Message-Id: <20240811101921.4031-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We encounter a problem on our servers where there are hundreds of
UNINTERRUPTED processes which are all waiting in the WBT wait queue.
And the IO hung detector logged so many messages about "blocked for
more than 122 seconds". The call trace is as follows:

    Call Trace:
        __schedule+0x959/0xee0
        schedule+0x40/0xb0
        io_schedule+0x12/0x40
        rq_qos_wait+0xaf/0x140
        wbt_wait+0x92/0xc0
        __rq_qos_throttle+0x20/0x30
        blk_mq_make_request+0x12a/0x5c0
        generic_make_request_nocheck+0x172/0x3f0
        submit_bio+0x42/0x1c0
        ...

The WBT module is used to throttle buffered writeback, which will
block any buffered writeback IO request until the previous inflight
IOs have been completed. So I checked the inflight IO counter. That
was one meaning one IO request was submitted to the downstream
interface like block core layer or device driver (virtio_blk driver
in our case). We need to figure out why the inflight IO is not
completed in time. I confirmed that all the virtio ring buffers of
virtio_blk are empty, so the root cause is not related to the block
device or the virtio_blk driver since the driver has never received
that IO request.

We know that block core layer could submit IO requests to the driver
through kworker (the callback function is blk_mq_run_work_fn). I
thought maybe the kworker was blocked by some other resources causing
the callback to not be evoked in time. So I checked all the kworkers
and workqueues and confirmed there was no pending work on any kworker
or workqueue.

Integrate all the investigation information, I guess the problem should
be in block core layer missing a chance to submit an IO request. After
some investigation of code, I found some following scenarios which could
cause similar symptoms. I am not sure whether this is the root cause or
not, but maybe it is a reasonable suspect.

Muchun Song (4):
  block: fix request starvation when queue is stopped or quiesced
  block: fix ordering between checking BLK_MQ_S_STOPPED and adding
    requests to hctx->dispatch
  block: fix missing smp_mb in blk_mq_{delay_}run_hw_queues
  block: fix fix ordering between checking QUEUE_FLAG_QUIESCED and
    adding requests to hctx->dispatch

 block/blk-mq.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

-- 
2.20.1

