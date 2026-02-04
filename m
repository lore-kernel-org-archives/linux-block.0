Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A940B6DB;
	Wed,  4 Feb 2026 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212939; cv=none; b=IaiORfi5RK62VgfKbYyhIbqgnIKQ/YdkHRj/tfZcCXIN+B5u/FJO6FFH+sgdFZ2iq9fDp3vzp6rIozfNSdlZFy6BX/qCpCnadmDTe0dp9G1dYv91UG90Wv5jLvECJp1WM50aBLzzhec0k3OOSYeEGocEgXGd7xhrtz/TuOyzrUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212939; c=relaxed/simple;
	bh=pc9zD6AGH0779UZk+DuKfn4l01qz37hu1Ou3/rMWP/o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U6PJscERFTmR33/SGe8COZ9p8ZslM0SHC5NHvCP3EVHfL7sVCL+pl/Sameml5tAD+D0xBg3GS6GCO6nB4m1XMcCG9uyDWFs8NNPzzSCR7+LEgm2C0Zfp2y+knvI67HpGezeMC9zFPt9ti0Ptox8+xYzAhcagCuGpkqvMfw31xnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn+7zita; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn+7zita"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3B18C16AAE;
	Wed,  4 Feb 2026 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770212938;
	bh=pc9zD6AGH0779UZk+DuKfn4l01qz37hu1Ou3/rMWP/o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Pn+7zitau8dsBWxCJ/Po0WKOyYvBGRrURL5BuXh/VP36NBXTyCoEJdm3E5Mdrhqfq
	 lL3S8Xm64GgVHK6EQNAMFLxWuwaUNqIGOtaiWIc9szT7gtd16urZmagC9B1+2V+7cP
	 kcTu1e3QTZaom/DIiG7pYFO6J+YoyanShIHk4wObDB6pLnq4slSsi5F2GpbwbEMx1v
	 9U32saX28N8lzHSuH+Z51vE0MsV4npEG7Y8LYPQyw1idsI1BFCWqn5iLTbW2rlZVux
	 tv2RLxe4xvFXxDoKWuD0tsktyLlSumaPj21FlSABGCj3Ak+QCh/4sRuUVRh8kbLMkm
	 f7B6S+XzdXDmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF649E9538B;
	Wed,  4 Feb 2026 13:48:57 +0000 (UTC)
From: Jihan LIN via B4 Relay <devnull+linjh22s.gmail.com@kernel.org>
Subject: [PATCH RFC 0/3] zram: Allow zcomps to manage their own streams
Date: Wed, 04 Feb 2026 13:48:50 +0000
Message-Id: <20260204-b4_zcomp_stream-v1-0-35c06ce1d332@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJOg2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIKGbZBJflZyfWxBfXFKUmpira55qmWZuYWGSamhkoQTUVVCUmpZZATY
 xWinIzVkptrYWAHqm2bFmAAAA
X-Change-ID: 20260202-b4_zcomp_stream-7e9f7884e128
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Jihan LIN <linjh22s@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770212935; l=3744;
 i=linjh22s@gmail.com; s=linjh22s_machine; h=from:subject:message-id;
 bh=pc9zD6AGH0779UZk+DuKfn4l01qz37hu1Ou3/rMWP/o=;
 b=4SsG2RqijlRLSQ8Y2rIR4aTpFpmzdHPT9SqREaJPrkg9S+oH8KLUA3tOjM6z7p08YaCO/0haT
 foiz3YYYU4FAWr7+UkX43u+xl3ZpHSv+FRPi3qG6X+mPwyyqRJMA0xI
X-Developer-Key: i=linjh22s@gmail.com; a=ed25519;
 pk=MnRQAVFy1t4tiGb8ce7ohJwrN2YFXd+dA7XmzR6GmUc=
X-Endpoint-Received: by B4 Relay for linjh22s@gmail.com/linjh22s_machine
 with auth_id=592
X-Original-From: Jihan LIN <linjh22s@gmail.com>
Reply-To: linjh22s@gmail.com

Hi all,

This RFC series introduces a new interface to allow zram compression
backends to manage their own streams, in addition to the existing
per-CPU stream model.

Current zram manages compression contexts via preemptive per-CPU
streams, which strictly limits concurrency to the number of online CPUs. 
In contrast, hardware accelerators specialized for page compression
generally process PAGE_SIZE payloads (e.g. 4K) using standard
algorithms. These devices expose the limitations of this model due to
the following features:
 - These devices utilize a hardware queue to batch requests. A typical
   queue depth (e.g., 256) far exceeds the number of available CPUs.
 - These devices are asymmetric. Submission is generally fast and
   asynchronous, but completion implies latency.
 - Some devices only support compression requests, leaving decompression
   to be handled by software.

This exposes the limitations of the current zcomp architecture, which
assumes a model where streams are inherently tied to CPU execution
contexts. This design is not flexible enough to integrate with such
backends, as it forces a one-size-fits-all model that limits the ability
to offload compression operations from CPU.

This series proposes a hybrid approach. While maintaining full backward
compatibility with existing backends, this series introduces a new set
of operations, op->{get, put}_streams(), for backends that wish to
manage their own streams. This allows the backend to handle contentions
internally and dynamically select an execution path for the acquired
streams. A new flag is also introduced to indicate this capability at
runtime. zram_write_page() now prefers streams managed by the backend if
 a bio is considered asynchronous.

Some design decisions as follows.
1. The proposed get_stream() does not take gfp_t flags to keep the
   interface minimal. By design, backends are fully responsible for
   allocation safety.
2. The default per-cpu streams now also imply synchronous path for the
   backends.
3. The recompression path currently relies on the default per-cpu
   streams. This is a trade-off, since recompression is primarily for
   memory saving, and hardware accelerators typically prioritize
   throughput over compression ratio.
4. zstrm->lock is restricted to the default per-cpu streams. Backends
   must implement internal locking if required. While currently exposed
   in struct zstrm, this mutex is an implementation detail of the
   default path. Future work may involve making the default stream
   locking mechanism opaque to the backends, ensuring they interact only
   with the necessary stream interfaces.

Although I do not have access to an Intel IAA accelerator and other
accelerators may not be generally available, this series seems to give
a good start for supporting batched asynchronous operations in zram.
The next step would be to introduce an interface that allows
non-blocking compression submission and validate its real-world
performance once such hardware accelerators become available.

Signed-off-by: Jihan LIN <linjh22s@gmail.com>
---
Jihan LIN (3):
      zram: Rename zcomp_strm_{init, free}()
      zram: Introduce zcomp-managed streams
      zram: Use zcomp-managed streams for async write requests

 drivers/block/zram/zcomp.c    | 37 ++++++++++++++++++++++++++++++-------
 drivers/block/zram/zcomp.h    | 23 +++++++++++++++++++++--
 drivers/block/zram/zram_drv.c | 28 ++++++++++++++++++++++------
 3 files changed, 73 insertions(+), 15 deletions(-)
---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20260202-b4_zcomp_stream-7e9f7884e128

Best regards,
-- 
Jihan LIN <linjh22s@gmail.com>


