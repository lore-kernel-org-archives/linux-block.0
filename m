Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F8209673
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832782; cv=none; b=brVSo0PMLaGfS7SHZGZk6VUCIIQWIPiu5KV6PpNiqHSUXe0a/NoModX8cDbK2KCT6DRcHUOgt9m6KfZMXyGH4dl1tg9oUQVcPAWq7UNZ+VzVdK/v5zgSs/Y2SvUk6OEkSXEyOSMXSFI6RDEmF/d8eIvPLtsjFDFgqpqxuawFQzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832782; c=relaxed/simple;
	bh=gga0MbQ1Hl4K6CTAjakegceyy0H6RjvB7HaC+uLoafM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=djUD6dS2KsWPAMkDRnbnU9VS4WbFN1Y/fKH6S/rPu7Bd09rHqT2lTQt3F+9k3MpIQNsOmqkhesDDEYPPRjK4f/DOnONNNrIg5Lz8Da9o/oL9EZlGm/aNfoJv1Y1omQqX1kUc1NM7+HGbgmVyA+AzzTsE7vOmhELXLvnSOYHLCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bEqmu1wc; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bEqmu1wc"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-85da5a3667bso146639f.1
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744832778; x=1745437578; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=53p1BwOELVOFcxvuRiM3Mb9M9qJv+fUwivLfHTNYqH0=;
        b=bEqmu1wcO8z4LVGzWcFYPjBsr0QrtwQ1N87MqpLtmDcRGZvytw63REVf1DiHAWh57Y
         K/VyDVZEqd3NCK2umwQsbGSWMMIrT5Suuwb8sg6eOfy3BFjtTR92R+YCAHO35DZdJ+PA
         D6W4VvrXg69p6fnYzawdOIOAg4K7Lln5KfxFp0VcEnVRuUcT5JzcmfYc6wVy5ZOKgB7R
         nr7DK8Dm8Q68T8XdZrtTNWNb7788FeeWi+YulZYXVJwEPQxAilwlCawm05Fxh3Gjzxyf
         3OmU3vfPV78xILa06O62e1vmN4bvKCTkZvQdt7ZDRuM2FdyJ1olA9Yzw3VuB82X6R5r0
         +A7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744832778; x=1745437578;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53p1BwOELVOFcxvuRiM3Mb9M9qJv+fUwivLfHTNYqH0=;
        b=SEsSO7ojhe1sfaMYcZvbmiqlo10mewNspb4KtQSWnesr48sFo+kKq5Njctf5jldCQ9
         1magut+NkrL24fktyM/GHUJ0/NOjnnvyo769k1Uc92lmVU4ZVXXvIB5gMop/HEk4zkT2
         HAoGxDJY86Zt7LizGMVE/PODeVPMRhZOfNgTujNJ5WDn9kWqgTJRnKyM9OzZLn2r54+8
         Yggg3W1y5nD19/MmeoomcVWm0tohaKDiQuEF/Z+RAu8uWmO3OTpplunSs+LmWWL1dafz
         HS4ZaBz3Te/U7NLFYKsxAEVcOxiV1lC7rvKDCsoBLf3642ieVIxyrPwFOp5LEJOgsYdH
         2Vhg==
X-Gm-Message-State: AOJu0Yxh1S/CZWd0/hip3E47OEycXNLik7S+5tfJcOgi+sVY91MgdCKQ
	Hqn9SC72I+cafLQJBaZ4lyPj6N1iK21AFiXphEM61OAoO5eQXllHgSi4LoQXRu5Cs5M6Wvh0JXq
	o/14fIGXRsNV9SfZPGpacUtnIN168IPC4W9KnU2KBsb9z2jtt
X-Gm-Gg: ASbGnct4AmfzFeA0IAg3sqxNBPOBumsBn4eyx6lRU1xJ2aAgbHp6ADIa7Q3N0irASTJ
	FHmQx0tFiO5TLk9CPtV7Ju1NsnH6vRPk2uOoxIN4gKSjOW7ESewlZ996hYvMJwtG0vowqx/eRap
	RXeDNeEiTDb7JTZXpDo5k5kb994PJEkSJ8ypVJ+kBkturajBc629BLMrRWvOfc6YHnQLsOuPIj6
	9XPc2BSPckOaY3NK8DNWuYgDbXssf8IxEkRF8YZ3KA4EhvpozDtBLvvkyq0Un7e0w0Iry58LKhR
	7D68ehDc0KvtcaHusRjRAQV2IaCGWAY=
X-Google-Smtp-Source: AGHT+IFRK+SWNGDbSYaodhLievdDAeUAC28Cwhp2NaeiPcDnju3mmg8V9zOSHK/TTBEojw4gVHAQVKPP+NGm
X-Received: by 2002:a05:6602:4017:b0:85b:4afc:11d1 with SMTP id ca18e2360f4ac-861c50948fbmr388496939f.5.1744832778346;
        Wed, 16 Apr 2025 12:46:18 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-86165428d68sm57998839f.11.2025.04.16.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:46:18 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 86D9934035E;
	Wed, 16 Apr 2025 13:46:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 7D201E407EC; Wed, 16 Apr 2025 13:46:16 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v5 0/4] ublk: decouple server threads from hctxs
Date: Wed, 16 Apr 2025 13:46:04 -0600
Message-Id: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPwIAGgC/3XO0YrDIBAF0F8pPq9l1DGaPvU/liWYZGwl2yZoE
 3Yp+fdqoVDY7OMduOfOnSWKgRI77O4s0hJSGK856I8d687ueiIe+pyZBKkBwfK5/R6am0tDM1F
 swsi7qladr8D2xrFcmyL58PMkP79yPod0G+Pvc2ER5VowFABSSkRl9gqsra3ggs8pbw4uHqc5U
 qm5E+278cIKtMhX+Z9PFsmBt7WxxlDlew3bjHpjBGwwqjBWCLIetUa3zeA7ozcYzIxGKaCthcP
 K/2XWdX0Aj2fQNoEBAAA=
X-Change-ID: 20250408-ublk_task_per_io-c693cf608d7a
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This patch set aims to allow ublk server threads to better balance load
amongst themselves by decoupling server threads from ublk queues/hctxs,
so that multiple threads can service I/Os from a single hctx.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v5:
- Set io->task before ublk_mark_io_ready (Caleb Sander Mateos)
- Set io->task atomically, read it atomically when needed
- Return 0 on success from command-specific helpers in
  __ublk_ch_uring_cmd (Caleb Sander Mateos)
- Rename ublk_handle_need_get_data to ublk_get_data (Caleb Sander
  Mateos)
- Link to v4: https://lore.kernel.org/r/20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com

Changes in v4:
- Drop "ublk: properly serialize all FETCH_REQs" since Ming is taking it
  in another set
- Prevent data races by marking data structures which should be
  read-only in the I/O path as const (Ming Lei)
- Link to v3: https://lore.kernel.org/r/20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com

Changes in v3:
- Check for UBLK_IO_FLAG_ACTIVE on I/O again after taking lock to ensure
  that two concurrent FETCH_REQs on the same I/O can't succeed (Caleb
  Sander Mateos)
- Link to v2: https://lore.kernel.org/r/20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com

Changes in v2:
- Remove changes split into other patches
- To ease error handling/synchronization, associate each I/O (instead of
  each queue) to the last task that issues a FETCH_REQ against it. Only
  that task is allowed to operate on the I/O.
- Link to v1: https://lore.kernel.org/r/20241002224437.3088981-1-ushankar@purestorage.com

---
Uday Shankar (4):
      ublk: require unique task per io instead of unique task per hctx
      ublk: mark ublk_queue as const for ublk_commit_and_fetch
      ublk: mark ublk_queue as const for ublk_register_io_buf
      ublk: mark ublk_queue as const for ublk_handle_need_get_data

 drivers/block/ublk_drv.c | 205 +++++++++++++++++++++++------------------------
 1 file changed, 100 insertions(+), 105 deletions(-)
---
base-commit: d3b4b25e363e4ce193e6103e64f7de12b96668b9
change-id: 20250408-ublk_task_per_io-c693cf608d7a

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

