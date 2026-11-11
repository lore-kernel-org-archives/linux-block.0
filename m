Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408652;
	b=smKXjQFSq6uhf5F4it6943h5A27b2Kfd1AQAPOTYwWVE2+1p/yp9MIBQgT8qrg1RBMuW
	 4dagvz7BiXQtPGRbsewkm5cZQs3cw2j4B3x26HjxDez8Lfc94ZKCmKYfbhsg9fDu7650Y
	 zNcTM6z8kE6F/L07xmPalZzJDwamXpFAT7WWtMye3Hv76Ui4jziVql8Wclo+VxNQnOh3L
	 PLV96hE6tbgQxVglouh2gYpmRyJYaGpMhz8dE1ySdEgF6PkO370kqR7TXvmxMJEOnDUmB
	 eeK+bGsxwloiDfLqyf2Ez2DgJpMjbTB4sabMYITpADC/dOyfvDHHChBGg9IN/puAzcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408652;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=in9PLro9lMFGv0mYwnCPKthhm5ByPZ39fDEfz6yqKgw=;
	b=itw1BfIK8woRWZ3MthlkfdM0WEAmyw4o8jghUCOOtEevJdOeGQdsFqlZ4YzwjySnevfI
	 Gcs/J2sZa0/iy++NN/PWLcIAyakKSHCGkXkq5yg2Fw9GfKZFE+2nWB+qSSIKvbmC74oSN
	 FePi008FJIO3f8uSSobO33gOp2jcLpWpNXPZv4zpNlFNe5LE3MH7Xj5XvTmjOsv0Sk3zH
	 ruoQ8ngK5iRgEqvjkQSOuX+q+ivuxXh52F0dp1wkFSLTZxFTBtyIUhXUg5QUHo+yxwYc0
	 OPwFEKylFpASpUQxpTr62zDsKidmEeeHOQgUP3oJNVECk+2FA1HvMvgAJoZ51c07ZOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EnhWMxWB;
	arc=none smtp.remote-ip=95.215.58.103
Received: from mta1.migadu.com (out-103.mta1.migadu.com [95.215.58.103])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A850606A335
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 14:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A850606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EnhWMxWB
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7QlHaYu+LBh346BG07UqQIEHqd8tmQtc/kJLw6MKCas=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794408649; v=1; x=1795013449;
 b=EnhWMxWBnU720igFzLMyg8a1Aidzw9CtrNWxuRMeRaVrpF+XGvKmWrv5RHoq6reeXaehY0i1
 59qRI3VVC49Q8aWlJpMjBcoBg0YdyNJHZp6yQcnCgXJPldHuJy3Hdc/fICZc2fVelCn5T1DVsAd
 d9cya+1BaK+W2Tox76KNE+mU=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8bbdbe130a30bd31;
	Wed, 11 Nov 2026 14:50:49 +0000
X-Mizu-Trace-ID: 8bbdbe130a30bd31
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	dgilbert@interlog.com,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 0/2] blktrace: gate the blktrace interface behind CAP_SYS_ADMIN
Date: Wed, 11 Nov 2026 22:50:32 +0800
Message-ID: <20261111145034.248717-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

hello,

This series gates the blktrace interface behind CAP_SYS_ADMIN.
BLKTRACESETUP allocates user-sized relay buffers and sets up traces
that outlive the creating fd, but holding the block device node, an
sg node, or write access to the sysfs trace attributes is the only
requirement to drive that state today.  Split by tree so each patch
stays in one subsystem: patch 1 gates the block side (the ioctl
dispatch and the sysfs store) and documents the sysfs attributes,
patch 2 gates the sg passthrough.  The two are independent and can
be applied in any order; patch 1 should go through the block tree,
patch 2 needs a SCSI Ack (taking both through block with the Ack
works too).

Unprivileged callers get a single answer (-EPERM for the ioctls,
-EACCES for the sysfs store) instead of values that revealed whether
a trace existed and was running.  With CONFIG_BLK_DEV_IO_TRACE=n the
sg passthrough still returns -ENOTTY, as before.  Privileged callers
behave identically with and without the series.

Verified on next-20261104 under qemu: with the series applied,
BLKTRACESETUP with all capabilities dropped is rejected with -EPERM
through both /dev/sda and /dev/sg0, and a dropped-privilege write to
the sysfs enable attribute is rejected with -EACCES; without the
series the unprivileged ioctl and the sysfs write both succeed.

Base: next-20261104.

Changes since v1:
 - also gate the sysfs trace attribute group, which reached the same
   tracing state without any check (found in follow-up review)
 - document the sysfs trace group in Documentation/ABI, where it has
   been missing since 2009
 - gate the sg passthrough commands in a new patch; the v1 commit
   message mentioned the sg path but gated only blk_trace_ioctl()
   (flagged by sashiko's review of the first posting)
 - commit messages now claim only what each patch covers

Link: https://lore.kernel.org/all/20261106142852.3233950-1-cui.tao@linux.dev/

Tao Cui (2):
  blktrace: require CAP_SYS_ADMIN for the blktrace interface
  scsi: sg: Require CAP_SYS_ADMIN for BLKTRACE passthrough ioctls

 Documentation/ABI/stable/sysfs-block | 18 ++++++++++++++++++
 drivers/scsi/sg.c                    | 10 ++++++++++
 kernel/trace/blktrace.c              |  6 ++++++
 3 files changed, 34 insertions(+)

-- 
2.53.0

