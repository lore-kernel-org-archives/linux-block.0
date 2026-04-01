Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C4367F21
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027298; cv=none; b=uu3IJRfoYwPI4VGXwNlv6OwcCu68pb8aFC/j+z4TbarCKEPfJe2ah7TE7ImmsdIgoNDAVvv6Zpwg7eEtyjalvh0GtLGycLC5oK0SbPBSSLJj1gXx4V970vfGpSXfkzVxZUL90YqM3QrALDRjPcXDapwsCIElJe6Wvc1cY1CxuEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027298; c=relaxed/simple;
	bh=8ajz2OSqVUsi9GqzJqnmR9pGr+9quIl362HaDMIGUhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dg3izuMvlwJdtIkkUCzS/MfLWPNBlzw13V2zx+KZ8GKP1nyVEU3QupAkx1RdY8hlKnPdwHW9nnB6X1kr7ewVxitGAU0X9+thz5HBQ2OJbLDcN3qRdNVgNboscVvECl2lhAqkBqCx6PbDANTC+/uP0h0Ro5aO+XIlbtTADZRMoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E0suKZw4; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E0suKZw4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4nVsPPLcw8EgfcoMvqWObtWYn3nnVQQd1qd+kAUO5oo=;
	b=E0suKZw45NjvfaeWDbVBARoUvErxCQE9SR5y28tr8q4LzEiBvyjrryGl3eHx3vPORpscuT
	YY6aYOyo12v9GmzVnZSjsMXQQcKIy7aoZI8hLl15mFMuC3xxXOunpWk/8gHKEHJMgajN7c
	kvGjTUbHSmT4aDIgaZKJvCs7lgp38UU=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 00/10] block: sysfs cleanup for deprecated API usage
Date: Wed,  1 Apr 2026 15:07:06 +0800
Message-ID: <20260401070716.991-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

A set of straightforward cleanups across the block layer sysfs
interfaces:

Patches 1-7 convert remaining sprintf()/snprintf() calls in sysfs
show functions to sysfs_emit()/sysfs_emit_at().

Patches 8-10 replace deprecated sscanf()/simple_strtoul() with
kstrtol()/kstrtoint() in sysfs store functions.

Jackie Liu (10):
  block: convert to sysfs_emit() in blk_ia_range show()
  block: convert blk-mq hw sysfs show to sysfs_emit/sysfs_emit_at
  block: convert disk events sysfs show to sysfs_emit/sysfs_emit_at
  block: convert partition sysfs show to sysfs_emit()
  block: convert part_timeout_show() to sysfs_emit()
  block: convert kyber latency show to sysfs_emit()
  block: convert bfq_var_show() to sysfs_emit()
  block: use kstrtol() instead of sscanf() in
    disk_events_poll_msecs_store()
  block: replace simple_strtoul() with kstrtoint() in
    part_timeout_store()
  block: replace sscanf() with kstrtoint() in part_fail_store()

 block/bfq-iosched.c     |  2 +-
 block/blk-ia-ranges.c   |  4 ++--
 block/blk-mq-sysfs.c    | 19 ++++++++++---------
 block/blk-timeout.c     | 18 ++++++++----------
 block/disk-events.c     | 12 ++++++------
 block/genhd.c           | 16 +++++++++-------
 block/kyber-iosched.c   |  2 +-
 block/partitions/core.c | 10 +++++-----
 8 files changed, 42 insertions(+), 41 deletions(-)

-- 
2.51.1

