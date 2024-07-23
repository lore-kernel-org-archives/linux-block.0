Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ADB14A4FF;
	Tue, 23 Jul 2024 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727721; cv=none; b=ALKtX0aoyTscwQqhpqKfYFtgEGSORGjyD627ELLbyERilCbzMiaEDQ3GvmO3oPX0K2nIlNAeh9J/oN1fpf382Spip5JaffOGdOdhTC1NcswkRwG6baIO9+ADnczZdubrLp3fT+oYx2luADuMcN59vKrzN0gr+G3w23weFZpadgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727721; c=relaxed/simple;
	bh=NcDpupcZcDk6/0XTYK18tiU/nA/nZnaPVgRpLi4PPa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IXUpI7yJZ/RQ1jpCFfk8x7LqI8N4e0Ri+Mlf/yXH0ogwqUUxUYWbg84zae9XAyaJz3DPI3WM3FgvMoI0hyXMmycciMCj/bWI/4O6Sv9yUpaC3Lb0UTGnrNtFawXD5haj+sXJPUWsAUeP3WEEFTj0DYv0sI4h1UQVuHUyGCcKDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdOWFQpc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdOWFQpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91B9C4AF0B;
	Tue, 23 Jul 2024 09:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721727721;
	bh=NcDpupcZcDk6/0XTYK18tiU/nA/nZnaPVgRpLi4PPa4=;
	h=From:Date:Subject:To:Cc:From;
	b=cdOWFQpcyfVoOMiGT+7ICwbw37JeS6fhY39vVyEai+n5SO3p/C8c2lgLLxFv2jaU0
	 /tSm54hT+dNiijQG/Yfv/BqOk+T3VBiEmV+13U8cmwwGbS2eLNSQLHQRfU+iWnoAge
	 YpaTZAymS8hYm59WWxYDHWz+MHlAMFnkjaVNdm493z/lWNTi3VlugcDMgom4S9RQgq
	 UqWYo7CH/agVpGPATqJIAFAQok9NftgLB7IM0ZJodIsizQCvWfjqfjIjT4jZxOkFFR
	 10+hmj/V/sI/X6PgnjxUr3OE7ypiF/xNgpDgJQ2WSE9nuBHTN4w9263dTHxCTMmUcJ
	 G+YBF7J5l9DcA==
From: Simon Horman <horms@kernel.org>
Date: Tue, 23 Jul 2024 10:41:52 +0100
Subject: [PATCH] drbd: Add peer_device to Kernel doc
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-drbd-doc-v1-1-a04d9b7a9688@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN96n2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNj3ZSipBTdlPxk3WRDAwMjA3MDg8SUVCWg8oKi1LTMCrBR0bG1tQD
 oFOZDWgAAAA==
To: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc: Andreas Gruenbacher <agruen@kernel.org>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

Add missing documentation of peer_device parameter to Kernel doc.

These parameters were added in commit 8164dd6c8ae1 ("drbd: Add peer
device parameter to whole-bitmap I/O handlers")

Flagged by W=1 builds.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/block/drbd/drbd_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f92673f05c7a..a9e49b212341 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3422,6 +3422,7 @@ void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(local)
 /**
  * drbd_bmio_set_n_write() - io_fn for drbd_queue_bitmap_io() or drbd_bitmap_io()
  * @device:	DRBD device.
+ * @peer_device: Peer DRBD device.
  *
  * Sets all bits in the bitmap and writes the whole bitmap to stable storage.
  */
@@ -3448,6 +3449,7 @@ int drbd_bmio_set_n_write(struct drbd_device *device,
 /**
  * drbd_bmio_clear_n_write() - io_fn for drbd_queue_bitmap_io() or drbd_bitmap_io()
  * @device:	DRBD device.
+ * @peer_device: Peer DRBD device.
  *
  * Clears all bits in the bitmap and writes the whole bitmap to stable storage.
  */
@@ -3501,6 +3503,7 @@ static int w_bitmap_io(struct drbd_work *w, int unused)
  * @done:	callback to be called after the bitmap IO was performed
  * @why:	Descriptive text of the reason for doing the IO
  * @flags:	Bitmap flags
+ * @peer_device: Peer DRBD device.
  *
  * While IO on the bitmap happens we freeze application IO thus we ensure
  * that drbd_set_out_of_sync() can not be called. This function MAY ONLY be
@@ -3549,6 +3552,7 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
  * @io_fn:	IO callback to be called when bitmap IO is possible
  * @why:	Descriptive text of the reason for doing the IO
  * @flags:	Bitmap flags
+ * @peer_device: Peer DRBD device.
  *
  * freezes application IO while that the actual IO operations runs. This
  * functions MAY NOT be called from worker context.

