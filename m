Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA10200129
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351432; cv=none; b=r+rAQM3Ep+w+c57mu0WjUIbUK7OVAklH5G3wmd7OToWqm5DwD90aYIHp+8YIQ0O49AnkG8UvjVpodBS1iQsKt0TGPXcEl1/7sgM23UTiQbBzwopG3xdIoU9RGmQkIW9LrhyXr6rFvw0tpV5DFCK1lqFISDxHKD+2TnqYjx00Edc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351432; c=relaxed/simple;
	bh=1phKNvdQFWi5veFaj6T20D2FijHKyXfTpzoT9znFaWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NvtT81IprNn7duYAHz++64lDgMws95XkCSCZv3Sj0r4x5boIZGGD08OT52HZ+KqCv82nUVkGha1DdK/S3c5wjWeEwPcJX86uYu7IfbY+O4WWeA4zIUiUxtWqonUMMmxSbey6cx3nLwfVqH0qExeVNMTQRQmmDzniYFYYVxVPGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aedhdRfh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aedhdRfh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2057917c493so12912015ad.0
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725351428; x=1725956228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf5lseQP99I3aAxP+7mSuKtoJS4ssIm9vqxlP7ZiAFc=;
        b=aedhdRfhAHVMmBKhe9vH5/SrL305nIMG7np69LCkvLU9umj2o3mEKOMvIQdChEUXom
         WCv4wqqiLUmyyxqpRL7bpycLX7PRWhJ5NC/731GEs5n0zjINmBNNK5HROG3wOMX+Z6e2
         aVxDF3utNOaUCnadFMZpPUf8L1ACuOKLIN/OYO2TczGgESC12NNAs1sKhQJ8ZWnF8M6X
         1b53ojDKfu4J1YLug3Ff8w47+vATuLT6j2jqkv6GZ3LIvwRPLbNH41VSCZ8jtrxL9IHg
         KMIxBQ69hlqxcK7xsw3ElFD9mZiCYCVOeI/4EeznhzEI0YW2oKyUL8uiUCcinUjf+tpp
         pCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351428; x=1725956228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bf5lseQP99I3aAxP+7mSuKtoJS4ssIm9vqxlP7ZiAFc=;
        b=AwdWsFbPToef5K2LWq3K1Mvkg6jsoa19g6LMbVj7WFXvS18My1UcB94OV/hWC4N5aX
         R9U88gTAQqy1rudC0+r5f6YDE6rff50aNtPWkwfgM9uSkFf/KH64P9GTw4fZSffTcO0U
         QG4VvVgmsMKF2uBUCTA84IkmsrpkkkHqD9DwN0bqfK+nvCeusg15hVV3YIISB2gN/Whj
         RScOGHVOJram3GbClxz/AjO9vq664mrfHd5B6U2Xqbv2CswJ1Zc+p42pDLgow6tDQvLJ
         jioTIG970BcBi7XZNaxN7oLS7lIIWt1+gZryU517aHhApcYChG3XbkUChwlvgAAJENpz
         0LKA==
X-Gm-Message-State: AOJu0Yyg6B5tIDo4u1YJomX0/cvLUq6KnK7P1AyT1YbIoidRCqx2mtTb
	4/78KJLZ3IIh2scha1Kqx0PVRxuqaXqzaRQuIZvOh+JGcjsvz/8DDH4tb4SOR9A=
X-Google-Smtp-Source: AGHT+IH/aPR/dUu25AxTch4hquD7Kb58mlC0r6W3pDXCoXR5udOrF35sNMweYbK4IPRV38At8AzNYA==
X-Received: by 2002:a17:902:e551:b0:205:753e:e2e6 with SMTP id d9443c01a7336-205753ee47emr106754135ad.16.1725351428060;
        Tue, 03 Sep 2024 01:17:08 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559cae667sm38155435ad.95.2024.09.03.01.17.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 01:17:07 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/3] Fix some starvation problems in block layer
Date: Tue,  3 Sep 2024 16:16:50 +0800
Message-Id: <20240903081653.65613-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We encounter a problem on our servers where hundreds of UNINTERRUPTED
processes are all waiting in the WBT wait queue. And the IO hung detector
logged so many messages about "blocked for more than 122 seconds". The
call trace is as follows:

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

The WBT module is used to throttle buffered writeback, which will block
any buffered writeback IO request until the previous inflight IOs have
been completed. So I checked the inflight IO counter. That was one meaning
one IO request was submitted to the downstream interface like block core
layer or device driver (virtio_blk driver in our case). We need to figure
out why the inflight IO is not completed in time. I confirmed that all
the virtio ring buffers of virtio_blk are empty and the hardware dispatch
list had one IO request, so the root cause is not related to the block
device or the virtio_blk driver since the driver has never received that
IO request.

We know that block core layer could submit IO requests to the driver through
kworker (the callback function is blk_mq_run_work_fn). I thought maybe the
kworker was blocked by some other resources causing the callback to not be
evoked in time. So I checked all the kworkers and workqueues and confirmed
there was no pending work on any kworker or workqueue.

Integrate all the investigation information, the problem should be in the
block core layer missing a chance to submit that IO request. After
some investigation of code, I found some scenarios which could cause the
problem.

Changes in v2:
  - Collect RB tag from Ming Lei.
  - Use barrier-less approach to fix QUEUE_FLAG_QUIESCED ordering problem
    suggested by Ming Lei.
  - Apply new approach to fix BLK_MQ_S_STOPPED ordering for easier maintenance.
  - Add Fixes tag to each patch.

Muchun Song (3):
  block: fix missing dispatching request when queue is started or
    unquiesced
  block: fix ordering between checking QUEUE_FLAG_QUIESCED and adding
    requests
  block: fix ordering between checking BLK_MQ_S_STOPPED and adding
    requests

 block/blk-mq.c | 55 ++++++++++++++++++++++++++++++++++++++------------
 block/blk-mq.h | 13 ++++++++++++
 2 files changed, 55 insertions(+), 13 deletions(-)

-- 
2.20.1

