Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8489331ECF
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105268; cv=none; b=olZxun0yPP+O6Jluq0zxaWgPEMWfv+wmxQ4EqVNtcjdrjC2eyejlOxC8tDzHipoubyqdW0SomyVhRt8USCXazHwCYJsW5TAgpNUQr7oclCLfFGep3i1HaAN9a54e07W1M6PpsLDuto5p6FWE/1EHxtJAqpeHVmuItDUC3CxwWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105268; c=relaxed/simple;
	bh=NMuBllCuAlqdMOMV6EFUWHe57zX3Lqw91yMl1pa/vmk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VBU9nVJq7upbeTFDVpjCJCAYjsAU2RGFBN6Qm2hxSXbN+Sl2zrma+VqNALuaokNiahokK4hGnp7D1MqHF1rpwDM7tWG5QCRqQIbs898vOlOcD6VwHwL/MGhfpdRJDzf2F44yFyanw7r5ndKgC2rJ0jB91nv5USft2XiexDRipZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz8zhXAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz8zhXAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4251F00893;
	Wed, 10 Jun 2026 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105266;
	bh=Kf1Md4tIVYsRG2xAOI87q3wWQnNIX7a/zTfDmD7RcIE=;
	h=Date:From:To:Subject;
	b=Yz8zhXAzj+f9NGDopIqBJKhx6YPWaNG4k3VE9A0Pegay0lVkOrswC3JsWNPZ0oAu2
	 N18OcTyYLpE9rH2k9j5ZJaaXFbRDeo8NIRuRNDAHnMk8ao5QR8Jb/QyH0Ep3VcQpxh
	 WLeCWtJXNu4y4YLofdEDLIOATCcoUjW8OYUKShFQwh8VNrSGS9WvUigwhK27HLYig9
	 M/iw2BA3AxXrVn1F5SHAmYaTYJ2tJN40Q4zwGFQcRbmB4oSA/54D82r7zF6dp23sEX
	 tNBxPRFnar9UifSXgpbD2K3ByrczUByNveT3Lub9S2jab6s3di+PK/MgpgHZeWThoC
	 aNEG3fmRsuG2w==
Date: Wed, 10 Jun 2026 17:27:42 +0200
From: Carlos Maiolino <cem@kernel.org>
To: brauner@kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] iomap: enforce DIO alignment check in iomap]
Message-ID: <aimCIEpCwUUyoORf@nidhogg.toxiclabs.cc>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry, I screwed up two addresses, bouncing them to the right addresses
to avoid spamming the lists again.

----- Forwarded message from cem@kernel.org -----

Date: Wed, 10 Jun 2026 16:52:11 +0200
From: cem@kernel.org
To: brauner@vger.kernel.org
Cc: linux-block@vger.kernel.devel, linux-fsdevel@vger.kernel.org,
  linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, Carlos Maiolino
 <cem@kernel.org>,  Keith Busch <kbusch@kernel.org>, Hannes Reinecke
 <hare@suse.de>,  "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] iomap: enforce DIO alignment check in iomap
Message-ID: <20260610145218.141369-1-cem@kernel.org>
X-Mailer: git-send-email 2.54.0
Tags: sent

From: Carlos Maiolino <cem@kernel.org>

The DIO alignment check has been lifted from iomap layer to rely on the
block layer to enforce proper alignment when issuing direct IO
operations. This though, depending on the IO size and buffer address
passed to the IO operation may lead to user-visible behavior change.

This has been caught initially by LTP test diotest4 running on
PPC architecture, where the test fails because a read() operation
with a supposedly misaligned buffer succeeds instead of an expected
-EINVAL.
This has no direct relationship with PPC, but seems to do with the
IO size crossing page borders or not.

The test allocates a 4k buffer, and then increments the buffer pointer
by a single byte to enforce a misaligned address. It then issues a 4k
read() using such buffer. The read is supposed to return an -EINVAL but
it ends up succeeding.

The allocated buffer is at least a single page, so the read() size being
smaller will end up most of the time within the very same page initially
allocated which seems to suffice the block layer to accept the IO.

On x86 though, the same 4k read will end up crossing page boundaries
causing a bio_split which ends up properly checking the address and
rejecting it due to misalignment.
The test itself is buggy (which seems by design) because it ends up
attempting to read 4096 bytes into a 4095, but I believe the test
expected the address to be rejected prior to any write attempt.

The problematic behavior is reproducible on x86 by reducing the IO size
to something < PAGE_SIZE, so the misaligned read()s will also be accepted
by the block layer.

Fixing this is just a matter of enforcing daddr and memory
alignment back into iomap.

This behavior is reproducible in ext4 and xfs due to both relying on
iomap layer, btrfs does not present this behavior change as it does its
own DIO alignment checking.

Fixes: 7eac33186957 ("iomap: simplify direct io validity check")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---

While I didn't spot any memory/disk corruption looking into this, it
changes the user behavior that dictates buffer addresses must be
properly aligned when issuing direct IO operations so I thought making
iomap check again for the buffer address alignment is reasonable.

 fs/iomap/direct-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 95254aa1b654..0064984e64e5 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -400,6 +400,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	if ((pos | length) & (alignment - 1))
 		return -EINVAL;
 
+	if (iov_iter_alignment(dio->submit.iter) & (alignment - 1))
+		return -EINVAL;
+
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		bool need_completion_work = true;
 
-- 
2.54.0



----- End forwarded message -----
