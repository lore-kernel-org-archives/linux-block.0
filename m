Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6492571D7
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797250; cv=none; b=nGkqZMdZPB+AEZFMoo2T8XNlFb350LXjdntMThBrHUiOqSMjSvNmD00V9bKk7gKzwRFXQlH/Yss/wDL4S4pTE6F5imwZXnwowhpoH4iNzQS5vaJIUkwLszVefbjrCTPDgEw4CsPQWYVtbaultT4K462MpUE9DM9GjGztiVvXVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797250; c=relaxed/simple;
	bh=MXQclzfsRmqFswYWLmxXm6CNdk2N0S+337Wlz6FtvKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdNQ+gecHVgJLIifiMyKy7JyEyheaZfWKVr9IiBquAwEdl4fbGMj5IyQNDD1mFxOZSAfULy70haCNDKylhaErozaQQt0jMfTPnc+QF66jVMFRxbYjFpsYKT+s3bXy4/YmGyH2eXkb/mfZmPA7jAXqyajVbq65gd1+SsYfBRIVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LebsB9qN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LebsB9qN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2958db8ae4fso27463485ad.2
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 23:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763797248; x=1764402048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlvl/ghygj0NmIQRAayRRMGj5XV6lcmj5TBV8+HeVEc=;
        b=LebsB9qNjiZTyJ4bg8albzgubvPz+zXHJQoVzHNYA0/nQzNYFkPdERLPic4phUrf1m
         FFLH2io/H2vm5Nb77HjJaErNhXMLfhOO5nHdmxs71+8DBA2KSSTscFH0QQpKGPplBcaO
         QHjfotGvUPNt7Z34pmMv4MUe0qwyxO+hXcyGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763797248; x=1764402048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlvl/ghygj0NmIQRAayRRMGj5XV6lcmj5TBV8+HeVEc=;
        b=jX9FLcFqhGLBFZ5RntAXgONBQWx57kwVytC3+77rnF38tFwM9U13bjb0FCahFy7nRJ
         FFMQJNSNmsEp8Vyf7pmKr9wE5YamnvucegXifjzfbxaDlFgKg+vaFujhZMFWT5VEArID
         xk6jnO8qYjNicCuy4zorcP7vjT+PCExYu1YdetE2+IEPlrjdsLJE1hhYjRe1E+kaTrMg
         G8NdrxWgS8nT/xdWhf+ow/UX9phKa/DAxbv9Z1pmLVJ8XYqSK73T384XA1eAchD04NAT
         piEcgupXng1isZx5aGAe8h8uebxfVx12IqnirKjVptXQOkTxHqxQ5tE3YWyx73j/xLlZ
         mrHg==
X-Forwarded-Encrypted: i=1; AJvYcCWxDU/OgIgaSgNsM+ZlltKUnwjRxVqke/HbM+Eri62VD+CkOZLK7WwmLmEoamysoTibzY7wP7EsCJafTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7dUyqBzdFMTapZlU706oBzJpoSmgur025XpZbPJ9zbHh4RDvj
	VZWE5qWoXZG7ojE/OQx6lV4TGKFTx1wuDHrIPsKrHeElyCsejnwegvJckSt5VBa7Sg==
X-Gm-Gg: ASbGnctI+dDpZmpOortXvfeGfNW+AKPXiQD9lnqDy9U/onJnRiqWhiltGcCgDkfZd36
	Mt1bL8CXLnJ9PK1Px+wgBsNC7yVUM1KvDo8GhhjV5ZnCUgrTFYUiM3CgJN76wyP1a0HNof+a2q2
	VIhDz/8+0XtS0yUeBDA2wI2swDFn983d8UPAbN1xs114HDwA0g68L9ZyZeo4zXWYuGNuwcq3ZQr
	O/Q/kUdgK5zFd0Mci3Y0dCiAEYf3HpTMOS2119mmurOUK0xOVn0T5qI/BYYXXTvXH1CTBCWMJ5Y
	Ydp5j9QGlnttOwzg8ZsPPtQsNKWLAv88xVkDxFR3tmrB/NDEqTN52baFsuVVfqZ2HHgBXOSX2+n
	XsUQC6nd3YEPH/VVakEzatigbC8SdkpcrXQPv0ipcR6VvbLqco5hpVx0VG5ce67ue8NEzAcPugp
	ZuqrR2qrs3Dceg+/yGBHAZb3F/ns5/BAhwSaejA3mua32gcLUqDdUXDtwcSzTcjC8jUBwc014mD
	w==
X-Google-Smtp-Source: AGHT+IHJ5OoQEmf8k8l+f+f0vaIbSHKi6dQio3TsdtNL2AazXMLkkUb2ETu1nh4IGFMM7AfN6JKoQg==
X-Received: by 2002:a17:903:19e5:b0:290:c0d7:237e with SMTP id d9443c01a7336-29b6c68be27mr64410735ad.39.1763797247998;
        Fri, 21 Nov 2025 23:40:47 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:948e:149d:963b:f660])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138628sm77771555ad.31.2025.11.21.23.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:40:47 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv6 0/6] zram: introduce writeback bio batching
Date: Sat, 22 Nov 2025 16:40:23 +0900
Message-ID: <20251122074029.3948921-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As writeback is becoming more and more common the longstanding
limitations of zram writeback throughput are becoming more
visible.  Introduce writeback bio batching so that multiple
writeback bio-s can be processed simultaneously.

v5 -> v6:
- added some comments to make code clearer
- use write lock for batch size limit store (Andrew)
- err on 0 batch size (Brian)
- pickup reviewed-by tags (Brian)

Sergey Senozhatsky (6):
  zram: introduce writeback bio batching
  zram: add writeback batch size device attr
  zram: take write lock in wb limit store handlers
  zram: drop wb_limit_lock
  zram: rework bdev block allocation
  zram: read slot block idx under slot lock

 drivers/block/zram/zram_drv.c | 471 ++++++++++++++++++++++++++--------
 drivers/block/zram/zram_drv.h |   2 +-
 2 files changed, 365 insertions(+), 108 deletions(-)

-- 
2.52.0.460.gd25c4c69ec-goog

