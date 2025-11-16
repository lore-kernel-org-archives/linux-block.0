Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218601946DF
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763263265; cv=none; b=F6mNXmYDhIV1X9L1E7v041OQaAC1uYSlqXz+UUytw84RRvOx03d6kSPAm80GU7fZ2omZFttf0/40JI4SMhcGLJKNRNqYfHDVptaREtZ+BccBG8R/nA3xxAff4pU7/J98GAxxYwsCNE4yG6HWuso5MNf5g9j09BjcItv0CmMMWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763263265; c=relaxed/simple;
	bh=VjgK2syfSljhRiCLQFmGeAGsZnX5ka0nw8dhvP7kb1k=;
	h=Subject:Message-Id:From:Content-Type:Mime-Version:Date:To:Cc; b=TMk54FZGlf544GYwZC661CICP+0EX8eaH5/7IafPKuW9U3E9B/3bnVLJIiqNKKeh0QWY/xyyB+z4GAtZuxpAhLQIeqkMUeOR5XusjUdIyxKAqbCvzvx23kJeYFNUNkoEZrnSNT0PN9LMjVc9IlvA8gwCA8sEfCq6szZABVGyUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=c+LWoZVR; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="c+LWoZVR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763263256;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=HQz1co1h88XBt3KnhahzJhjr5KXwtbkfJe0/LJVmJW8=;
 b=c+LWoZVRVCvxEXVfeRM4U2ZkFSpNvoPjXbHtbxeaycYX2sN6ns8o6mnQGEk3OIjVYxiuwD
 deCSfEsTILHabYXND4p4atff/ZVJFUre2btTAVt/qXop+oRGp/17vAONG4R7oPEmB1/NPZ
 Ma4gZps8wZZ4Kf8dFvZiUeLLPxERGzc04gkCMBg/GGUDy/+3O5NpauhQ4icvZeNlpAzi7k
 zMbBF6DuF2/9yF8wRsPHyAexcbtIywBdk0D8LIf53iXxa+3CwEzQGZoQqft2WamS1+sRWY
 2Z9Hk93ujo3YUxxjvw2SiCZ/JNNllIx7jzURQME9pN/d/Q5O84zQhKZBA32lmw==
Subject: [PATCH RESEND v4 0/7] blk-mq: introduce new queue attribute async_depth
Message-Id: <20251116032044.118664-1-yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 11:20:53 +0800
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269194316+05f0c0+vger.kernel.org+yukuai@fnnas.com>
Date: Sun, 16 Nov 2025 11:20:34 +0800
Content-Transfer-Encoding: 7bit
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Cc: <yukuai@fnnas.com>, <nilay@linux.ibm.com>, <bvanassche@acm.org>

Changes in v4:
 - add review tag for the last patch 3;
 - rebase with my new email address, patches are not changed;
Changes in v3:
 - use guard()/scope_guard() in patch 3;
 - add review tag other than patch 3;
Changes in v2:
 - keep limit_depth() method for kyber and mq-deadline in patch 3;
 - add description about sysfs api change for kyber and mq-deadline;
 - improve documentation in patch 7;
 - add review tag for patch 1;

Background and motivation:

At first, we test a performance regression from 5.10 to 6.6 in
downstream kernel(described in patch 5), the regression is related to
async_depth in mq-dealine.

While trying to fix this regression, Bart suggests add a new attribute
to request_queue, and I think this is a good idea because all elevators
have similar logical, however only mq-deadline allow user to configure
async_depth.

patch 1-3 add new queue attribute async_depth;
patch 4 convert kyber to use request_queue->async_depth;
patch 5 covnert mq-dedaline to use request_queue->async_depth, also the
performance regression will be fixed;
patch 6 convert bfq to use request_queue->async_depth;

Yu Kuai (7):
  block: convert nr_requests to unsigned int
  blk-mq-sched: unify elevators checking for async requests
  blk-mq: add a new queue sysfs attribute async_depth
  kyber: covert to use request_queue->async_depth
  mq-deadline: covert to use request_queue->async_depth
  block, bfq: convert to use request_queue->async_depth
  blk-mq: add documentation for new queue attribute async_dpeth

 Documentation/ABI/stable/sysfs-block | 34 +++++++++++++++
 block/bfq-iosched.c                  | 45 ++++++++-----------
 block/blk-core.c                     |  1 +
 block/blk-mq-sched.h                 |  5 +++
 block/blk-mq.c                       | 64 +++++++++++++++++-----------
 block/blk-sysfs.c                    | 42 ++++++++++++++++++
 block/elevator.c                     |  1 +
 block/kyber-iosched.c                | 33 +++-----------
 block/mq-deadline.c                  | 39 +++--------------
 include/linux/blkdev.h               |  3 +-
 10 files changed, 152 insertions(+), 115 deletions(-)

-- 
2.51.0
