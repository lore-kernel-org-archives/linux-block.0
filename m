Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B23EE1D5
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155210; cv=none; b=MBgoXCxcJrUkAgD49ZT40/ObV+P3JQ15SgusHoAI9d4kz4Vai7mueDnHza4jjLZxp4C/GEaKqw/IbgLcV/mYxcBWc2Tubh5GMvn7Vruii8ykfTol8Wp33dD65pEnl8rdFNP1bLYsMJy4ZH14edSHzqPgZQnzeo3mKKYaJ2J3awc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155210; c=relaxed/simple;
	bh=xAW6MqMKsL+3SMPbbAXDSHRYMZdQFnkIVMpW9uCI5Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orFaXwoY98q16RN8YE6nCWprHEeoUu03cDSZxgpGUTAwO0pn30zShFy443qi91OcwWnRgF+g/LithqBa99mHX2fe1RpG55zGytdAW5r/U6GLJ/hvyoe5MikzbWoyPxzLk766oUaIaL1vZG+X4rHadS1Lgku1ZSyPUW3o7fGYOl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=muUlIljR; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="muUlIljR"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fmrJ66y27zlfwJB;
	Thu,  2 Apr 2026 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1775155202; x=1777747203; bh=oF/QAgU5uKZyKo+nERUz58pY18k75G+p3cu
	E1cmO4D0=; b=muUlIljRmdtaWj4mL2EVMoT6vc0AX4OcM1MdFNY5gUqKNbIZpoy
	OBJQmv+3gMmWmz+OWYxATgu0QgNs/7bne0Xk72IuWtbRBuH3cvJpNGtaBxdNG7fh
	Qwi3ACTqFkmJS/uEshB4s8PrZLAL3ynO3HEek/p3D7Tt82yzpxzaWe1QYzO5skaR
	bDDg3NEkU4oqV8pwGg8Ec4vGuxP/v9kjGuyapREHU8QPXP7FcUt5WDNGRoS5n0Vl
	CRTvsMQ1IyY6WRdYYAb3lfDrzdYLPVGih0dHi0Ocje9rlGHalnXVsLyLLijYIKoz
	r7Dvq28dy0rS7LCmxbc1wtMRWgrahw6mL2A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 43BzVidAiNrN; Thu,  2 Apr 2026 18:40:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fmrJ05y2kzlfvqC;
	Thu,  2 Apr 2026 18:40:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 00/12] Enable lock context analysis
Date: Thu,  2 Apr 2026 11:39:32 -0700
Message-ID: <20260402183950.3626956-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

During the most recent merge window the following patch series has been m=
erged:
[PATCH v5 00/36] Compiler-Based Context- and Locking-Analysis
(https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/)=
. That
patch series drops support for verifying lock context annotations with sp=
arse
and introduces support for verifying lock context annotations with Clang.=
 The
support in Clang for lock context annotation and verification is better t=
han
that in sparse. As an example, __cond_acquires() and __guarded_by() are
supported by Clang but not by sparse. Hence this patch series that enable=
s lock
context analysis for the block layer core and all block drivers.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v2:
 - Retained the block layer core patches and left out the block driver pa=
tches.
 - Inlined blkg_conf_open_bdev_frozen() and blkg_conf_close_bdev_frozen()=
.
 - In blkg_conf_open_bdev(), added a return statement if the
   WARN_ON_ONCE() statement triggers.
 - Replaced the "block/ioctl: Add lock context annotations" patch with a
   __release() annotation.
 - Replaced the blk-zoned patch with a patch from Christoph.

Changes compared to v1:
 - Rebased this patch series on top of Jens' for-next branch.
 - Included two patches that split blkg_conf_prep() and blkg_conf_exit().
 - Modified how patches are split. Split the block layer core patch into
   multiple patches and moved the CONTEXT_ANALYSIS :=3D y assignments int=
o the
   block driver patches.
 - Made the new source code comments easier to comprehend.
 - Introduced macros in the mq-deadline and Kyber I/O schedulers to make =
the
   __acquires() expressions easier to read.
 - Removed the changes from this series that are not block layer changes.

Bart Van Assche (11):
  block: Annotate the queue limits functions
  block/bdev: Annotate the blk_holder_ops callback invocations
  block/cgroup: Split blkg_conf_prep()
  block/cgroup: Split blkg_conf_exit()
  block/cgroup: Inline blkg_conf_{open,close}_bdev_frozen()
  block/crypto: Annotate the crypto functions
  block/blk-iocost: Add lock context annotations
  block/blk-mq-debugfs: Improve lock context annotations
  block/kyber: Make the lock context annotations compatible with Clang
  block/mq-deadline: Make the lock context annotations compatible with
    Clang
  block: Enable lock context analysis

Christoph Hellwig (1):
  block/blk-zoned: Refactor blkdev_zone_mgmt_ioctl()

 block/Makefile             |  2 +
 block/bdev.c               | 10 +++-
 block/bfq-cgroup.c         | 11 ++++-
 block/blk-cgroup.c         | 98 ++++++++++----------------------------
 block/blk-cgroup.h         | 13 +++--
 block/blk-crypto-profile.c |  2 +
 block/blk-iocost.c         | 96 +++++++++++++++++++++++--------------
 block/blk-iolatency.c      | 19 ++++----
 block/blk-mq-debugfs.c     | 12 ++---
 block/blk-throttle.c       | 34 +++++++------
 block/blk-zoned.c          | 41 +++++++---------
 block/blk.h                |  4 ++
 block/ioctl.c              |  6 ++-
 block/kyber-iosched.c      |  7 ++-
 block/mq-deadline.c        | 12 +++--
 include/linux/blkdev.h     |  9 ++--
 16 files changed, 195 insertions(+), 181 deletions(-)

