Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58743C07C
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588365; cv=none; b=qKGIDka44MhAPtazWaRT4B8IoLwv99FotRysspie7HGFvAawbcMDSAJjbpUefj0pW5/Lq5H7nwo/h3kF51BA/LkASUblFWCJ+qxIRPjIKdBr5I2BWOSSSJI3YyywDCnSiHAlwlEUDzbXazSjmL+YYUIMniaMvtjmNQSaNOn4408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588365; c=relaxed/simple;
	bh=AMG+S9uIkOnlXsM7yeloALb+/ZqAC7mh39Erqs8h6qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+Fx+7KJUBnEskV327IOylm7WCdhmKyzaQ+xeXPatmufJMN7OCr5HD3BMLIgZHQutnn9j0D9x9leSRdBCJ938M8EfYLH36NzWgCQONYJVbUG9vw+p+w8YvA2YLhjffEqjB/scqNR5pAUlm2WyGz4FMgHINuEpn+zAYl2Vpm1ICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=maRmMF/6; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="maRmMF/6"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hlV0G6lTRzlfvpW;
	Wed, 16 Sep 2026 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1789588331; x=1792180332; bh=x/ARTKrqImNouHLf/Twf2iHrLS3ttsB8vIO
	QyKgYoYE=; b=maRmMF/6ywB8Vdsg3+9UKayDdSZr+6o7xrekWlIbNL+174GXTyA
	7EhYKdkksVsjI4oBmoIe0KUn1KieZSAygAEXKmklVMVm3Vs72Z+wYnYGSzguCqVd
	/JAqsZ9/vsqZiQqrS9g+RqkpZV9Wxuf26o3D1y1E7lSFp+a5hKaRxJBMeIO20ehi
	0Z2+e4HDZ34M+PBAA/A0sl4u8/vc0vAyWiy0fTCcITE1AGXH0kEkNAvhpR8OVjA7
	cQACpDCJiVL7vv8KoTVjT2KFqfLOd5tdXIc+tt0Bhb4REAJEC4Mu5W10MKASEosE
	hiKhiuSdWp3bysEHaX2RAbBD9JrNSjXU0LA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TfmhfaH6zizd; Wed, 16 Sep 2026 19:52:11 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hlV092kDbzlfvpG;
	Wed, 16 Sep 2026 19:52:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] loop: Fix teardown
Date: Wed, 16 Sep 2026 12:51:51 -0700
Message-ID: <cover.1789587960.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

My attempts to help Tetsuo with fixing the issues in his loop driver patc=
h
series have not been successful so far. Hence this patch series. (See als=
o
https://lore.kernel.org/linux-block/60bf7af2-b84e-4056-9195-a26ad51ada46@=
I-love.SAKURA.ne.jp/).

When tearing down an autoclear loop device upon release, the loop driver
must drain in-flight I/O and flush workqueues to prevent NULL pointer
dereferences in lo_rw_aio() and related I/O paths.

However, the .release() block device callback is invoked while holding
disk->open_mutex. Freezing the request queue or draining workqueues under
disk->open_mutex causes lock inversion and circular locking dependencies
(e.g., when worker threads or I/O completion paths also acquire open_mute=
x
or interact with request queue synchronization).

This patch series resolves the lock inversion by:
1. Adding a .post_release() block device operation that is called
   synchronously from bdev_release() immediately after disk->open_mutex
   is released.
2. Migrating __loop_clr_fd() to .post_release(), allowing loop device
   teardown and queue freezing to happen outside of disk->open_mutex.

Please consider applying this patch series.

Thanks,

Bart.

Bart Van Assche (2):
  block: Add post_release() operation
  loop: Perform __loop_clr_fd() after disk->open_mutex is dropped

 block/bdev.c                     |  3 ++
 drivers/block/loop.c             | 51 +++++++++++++++++++++++---------
 include/linux/blkdev.h           |  5 ++++
 rust/kernel/block/mq/gen_disk.rs |  1 +
 4 files changed, 46 insertions(+), 14 deletions(-)

