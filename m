Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722943A4F36;
	Mon,  9 Mar 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058987; cv=none; b=Jf3i8qrVOqfVqZuuEsZl3+S75vjkVrOaVkYuMR7lH4gBxMwbR9sFpzwrdd/gAdeOgEwvHmLN8RJ2RhM9a39D3HDboH7Sqk7QS5H8pk4vVxWQpWxlJ7FibDYaVvyhV81EWZvMeBeUBjk1zVEMMq8QotTHSOQ4gkxcgNGESFoFEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058987; c=relaxed/simple;
	bh=LKnZfOM/Cwn+vL43qm0h8f/cfu1cc6MvbJveFJQGlZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PDIVFraUncX8l5FEeU0gJUneoXALDn2prH+MQN/G1FD8lfjGvU75ILYgrecXX3FYlJJuQUfn7yKukPZyxGjxsu+7rP2BpGcGnrr6OXGTESLgxk98VaVSZYc99si6EmevKPZc8nYI+pcdocrsq0rGTz9lzUpO01cWnSVT/CFOHCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGtVqG88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGtVqG88"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48AEAC4CEF7;
	Mon,  9 Mar 2026 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773058987;
	bh=LKnZfOM/Cwn+vL43qm0h8f/cfu1cc6MvbJveFJQGlZI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iGtVqG88/Q+wH/LkV8vt4S69eq3SfB/3sNGBsVAP8mcm5n0DjJMKQ1pGyg4QFSCxi
	 ZLSg8qsNiIklFrLUuMLXz3l5YE9WqRDfLTcdA6EZ/co/Z68/nndAh/IaAw6+XQNxYq
	 XmODSZA3M7WSSNW8Y70YYNV5SL97rUp22SWeScUqBYQbsm441w5x8uWDXzfpgtmvLY
	 eKOC7uhI0OFZpAn41fzvw9z2KjcCVRr0dfmtmwdvq5r4k0LaBJgFG3h96w0LJfSrnA
	 tb7EM8LkEClCehnNE/hb0cJCmvxHJLRdQ4gLotQcWqtDPTIUKJUaH20xImlQ3Kwnwf
	 ohouTGxbQ73lw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39430F3C246;
	Mon,  9 Mar 2026 12:23:07 +0000 (UTC)
From: Jihan LIN via B4 Relay <devnull+linjh22s.gmail.com@kernel.org>
Subject: [PATCH RFC v2 0/5] zram: Allow zcomps to manage their own streams
Date: Mon, 09 Mar 2026 12:23:03 +0000
Message-Id: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKe7rmkC/2WNywrCMBBFf6XM2kiS1ja6EgQ/wK2UUtNpO2Cbk
 pSglvy7Ibhzc+HM49wNHFpCB6dsA4ueHJk5gtxloMd2HpBRFxkklyWPwR5F89FmWhq3WmwnVuG
 xr5QqUEgF8Wux2NMrGe9wu16gjsOR3GrsO7V4kVY/YfEn9IJxlh80LzWKLs/leZhaeu7jDdQhh
 C/w0jXsswAAAA==
X-Change-ID: 20260202-b4_zcomp_stream-7e9f7884e128
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Jihan LIN <linjh22s@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773058983; l=3907;
 i=linjh22s@gmail.com; s=linjh22s_machine; h=from:subject:message-id;
 bh=LKnZfOM/Cwn+vL43qm0h8f/cfu1cc6MvbJveFJQGlZI=;
 b=fiUOv5NcKwfeNr2yKcdNu3XUx8YchsAE4VCCw/XTSSE8szkvGWAe3wf/+rfslvd8BWcG5EI3R
 1btxriNmYuSA+z3fLXPP9/+5B9r47B63PzIswx9mMbjBOsFdApOGri3
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

Currently, zram manages compression contexts via preemptive per-CPU
streams, which strictly limits concurrency to the number of online CPUs.
In contrast, hardware accelerators specialized for page compression
generally process PAGE_SIZE payloads (e.g. 4K) using standard
algorithms. These devices expose the limitations of the current model
due to the following features:
 - These devices utilize a hardware queue to batch requests. A typical
   queue depth (e.g., 256) far exceeds the number of available CPUs.
 - These devices are asymmetric. Submission is generally fast and
   asynchronous, but completion implies latency.
 - Some devices only support compression requests, leaving decompression
   to be handled by software.

The current "one-size-fits-all" design lacks the flexibility to support
these devices, preventing effective offloading of compression work.

This series proposes a hybrid approach. While maintaining full backward
compatibility with existing backends, this series introduces a new set
of operations, op->{get, put}_stream(), for backends that wish to manage
their own streams. This allows the backend to handle contention
internally and dynamically select an execution path for the acquired
streams. A new flag is also introduced to indicate this capability at
runtime. zram_write_page() now prefers streams managed by the backend if
a bio is considered asynchronous.

Some design decisions are as follows.
1. The proposed get_stream() does not take gfp_t flags to keep the
   interface minimal. By design, backends are fully responsible for
   allocation safety.
2. The default per-cpu streams now also imply a synchronous path for the
   backends.
3. The recompression path currently relies on the default per-cpu
   streams. This is a trade-off, since recompression is primarily for
   memory saving, and hardware accelerators typically prioritize
   throughput over compression ratio.
4. Backends must implement internal locking if required. 

This RFC series focuses on the stream management interface required for
accelerator backends, laying the groundwork for batched asynchronous
operations in zram. Since I cannot verify this on specific accelerators
at this moment, a PoC patch that simulates this behavior in software is
included to verify new stream operations without requiring specific
accelerators. The next step would be to add a non-blocking interface to
fully utilize their concurrency, and allow backends to be built as
separate modules. Any feedback would be greatly appreciated.

Signed-off-by: Jihan LIN <linjh22s@gmail.com>
---
Changes in v2:
- Decouple locking from per-CPU streams by introducing struct
  percpu_zstrm (PATCH 2/5)   
- Refactor zcomp-managed streams to use struct managed_zstrm (PATCH 3/5)
- Add PoC zcomp-managed streams for lz4 backend (PATCH 5/5, only for
  demonstration)
- Rebase to v7.0-rc2
- Link to v1: https://lore.kernel.org/r/20260204-b4_zcomp_stream-v1-0-35c06ce1d332@gmail.com

---
Jihan LIN (5):
      zram: Rename zcomp_strm_{init, free}()
      zram: Separate the lock from zcomp_strm
      zram: Introduce zcomp-managed streams
      zram: Use zcomp-managed streams for async write requests
      zram: Add lz4 PoC for zcomp-managed streams

 drivers/block/zram/backend_lz4.c | 464 +++++++++++++++++++++++++++++++++++++--
 drivers/block/zram/zcomp.c       |  85 +++++--
 drivers/block/zram/zcomp.h       |  35 ++-
 drivers/block/zram/zram_drv.c    |  29 ++-
 4 files changed, 562 insertions(+), 51 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260202-b4_zcomp_stream-7e9f7884e128

Best regards,
-- 
Jihan LIN <linjh22s@gmail.com>


