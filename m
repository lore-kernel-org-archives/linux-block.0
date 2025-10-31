Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7713126D7
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942880; cv=none; b=XUljIxpJVOxW6125+t620ZjeHUcFtcXKNtRbPF9v3gX1Bh7F2tpQ9xy5hA8+N8f2R6/mm3JQQFkoSJp4OdAxVQZwHDZqr7BimOiP1/f7PWJmtFHPU22ycZp5GZN1gTdAvwhhMagA3KUr4XED1CdhOAAaIwm167znULvoUoBTyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942880; c=relaxed/simple;
	bh=jvDE7lWJxH3JAXZ63PoEX/oK9PZRTBG5vt6245JF66Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSJsjAlrCoF9e7WCGJYJI8IPet0PkAMNRnf0OQ9UEV58EUlUnqbhPDavLE+mozj8Yg3zE4aet0+jAHSOujg0mY+1asZYphm0RDt6pILRCYFGejEubTMv7zvtivUDoknHv/P0yU+U2PPRswh0aFIw/EqelTNzdaYLN2BHjuNTsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dvQYnWoz; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dvQYnWoz"
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-592fac6c37fso325799e87.2
        for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761942877; x=1762547677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=;
        b=dvQYnWozKugEUNvqdhCr6mOWn03B72UNbtIqWXxtzXbQZh2FwocLAAA2fo4AQBP8nD
         gjuJ7hbba2arrHmEhlTtgj3pQKsPpu3BSnPyWnsK/iJ120VJETkxreb4co7cGyDFjZ1Q
         Romr/u0AGF19Syc7K43JIlSdWKtdIt1Ct4P5iyInbmy9uAp6cN0Z1/cei717ORVB3nVw
         DDaUMhf0SYo8HVPxmDmJPPtLOHXG4V63nGyRAWOsWj3w42NKDkkdBx63fvfLk7zXY9gU
         qtPQJcYjFgzu17DHVa4v45yxtBaGrPHVrXeKNpXiD88/aZ8e+7f8iLJHjYqmKVvQCbdk
         8keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942877; x=1762547677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=;
        b=AHsyQ5BhF1X1tTHxTQ/Qlmto/1Jk3Wk0JgFoHuWMlQfvWot1lYy8hbrG7FZfJhp6hp
         3EIgSD8K3p9fy3CMlSmG9lPeJMOh9lkhc385hLiE9TwY7bvIuovUQZmKR8kKYReuzHcx
         R7Tycd6V/g4w62U7La7X82W7VpB+XtMfaWz9/+AUSLwmNa7CrQcCf+tbNJyr346sG6Q+
         e+71DUjQ89Y5jNMrPZUlVY4OkS77FEn/nhGMcZmhiuBiFhD2Zs7RsGB5gBwV3JI3zbz2
         z08riQSI4SR5evk0OrTT71oFDEe50rTuuIZmT8GEbbDNAqSqzfSidPCwthkbYb7YAJYN
         u32Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6xJ/3bIQIvXpRlCG0zz3qtRMPrKQntiRh3CWwy3RT0j8wgnSF3gtK35CmjOnfAjmfJH1FD2LhZvPNjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaosJBVsSLafiI47O0dSR59oeGHiXCd0RnSUzzdQVJ5gbWU1mO
	GMQ7kFVEb6cSwn4fDi51AJctIM6siWDU4vh2RGKD+ZiLoW1liCRcUlibWPQ9F8GsUFqRNZXxQRy
	YZve/m/3Sigh8OAHxdiXUQs0z6DsS6QqmN4N8
X-Gm-Gg: ASbGnct8WHmaLB5otC2YTj8jbS61Vv3BnnNUJhA1QQe0M5gs4Wgb6RLruMDcD9/rk/W
	3Rve30TMAPJYjLFZcVxLmi31RPpvcTNzqIFnajEn+fIPfBXi+HAgbxFVoyc48ip9/DrXWeKJyo7
	UPAuIqCiL6KzEavWoXxHCA0nW6wVSv6CWYHrnEOnYZBYlTUknz0vvHI4TZoHAuJWUtRfQdnRp/7
	sbwpzNSMcFaQRXIqGgglz0DHtfTWMaFNxkvqcRVdXomN18Xhyfl2/fPkb9cRaZaMmNCh46v3nsF
	NvxDXTswNzL1EPL7QNIF7/UtzhRhd8QUlkaJvNxKWlH9pqX8S12RyQZSYs/j4SCr752Z+XVkgAi
	ZhEHAGdYYFpJ4Z9pxbyUaGovmQpVye1Q=
X-Google-Smtp-Source: AGHT+IHYGUnO7bV47O6a0JaarTqAfmI/2Y9l++bnlFY3ld+pOZSgy8vCnY+sYVKLt/9KYUiwgYpMC6aTC4ND
X-Received: by 2002:ac2:4c4f:0:b0:592:f7b4:e5fb with SMTP id 2adb3069b0e04-5941d4ff894mr969734e87.3.1761942876878;
        Fri, 31 Oct 2025 13:34:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5941f3a30cbsm287556e87.27.2025.10.31.13.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:34:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4EBCF3400FE;
	Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 465FEE41255; Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Fri, 31 Oct 2025 14:34:27 -0600
Message-ID: <20251031203430.3886957-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define uring_cmd implementation callback functions to have the
io_req_tw_func_t signature to avoid the additional indirect call and
save 8 bytes in struct io_uring_cmd.

v4:
- Rebase on "io_uring: unify task_work cancelation checks"
- Small cleanup in io_fallback_req_func()
- Avoid intermediate variables where IO_URING_CMD_TASK_WORK_ISSUE_FLAG
  is only used once (Christoph)

v3:
- Hide io_kiocb from uring_cmd implementations
- Label the 8 reserved bytes in struct io_uring_cmd (Ming)

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (3):
  io_uring: only call io_should_terminate_tw() once for ctx
  io_uring: add wrapper type for io_req_tw_func_t arg
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  6 ++++--
 drivers/block/ublk_drv.c       | 18 ++++++++++--------
 drivers/nvme/host/ioctl.c      |  7 ++++---
 fs/btrfs/ioctl.c               |  5 +++--
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring/cmd.h   | 22 +++++++++++++---------
 include/linux/io_uring_types.h |  7 +++++--
 io_uring/futex.c               | 16 +++++++++-------
 io_uring/io_uring.c            | 26 ++++++++++++++------------
 io_uring/io_uring.h            |  4 ++--
 io_uring/msg_ring.c            |  3 ++-
 io_uring/notif.c               |  5 +++--
 io_uring/poll.c                | 11 ++++++-----
 io_uring/poll.h                |  2 +-
 io_uring/rw.c                  |  5 +++--
 io_uring/rw.h                  |  2 +-
 io_uring/timeout.c             | 18 +++++++++++-------
 io_uring/uring_cmd.c           | 17 ++---------------
 io_uring/waitid.c              |  7 ++++---
 19 files changed, 101 insertions(+), 87 deletions(-)

-- 
2.45.2

