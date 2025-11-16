Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906821A453
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763260911; cv=none; b=MgldG/JjFIaBTPPYw8FaQFZmCKXvn9VRW0Y+3bu9UZ5eourYQF3hjRt2IscZGZ425kMiBOUlUXpH3nYLh8hU9IaikJvuma0lf37r3t36IgzZJ7OmobwjIoMggYHHk4TeKBn1lAvtgRGwu+2UdJBa6ngumuJIxkiGQaPgWP7W1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763260911; c=relaxed/simple;
	bh=t6HAZ/l2XenTfrA5mt/z8jOYLjPugblqhlmEK1Ug+YE=;
	h=Message-Id:Content-Type:Subject:Date:To:Cc:From:Mime-Version; b=qFkD4GF4Nxfu173Yi6itTrNTTUw7mbkYdQLhWvvsFp78ax3MYBQF/mTTs4/CFdeCPuLr5FCvHKMgRU1BCaxEY4yC0VgukLuy0c+kGH7NwDyVv/lKOYSLL6OPAXyL/T/aLRv6BmCMpcssYZpAHLoYR5AXOFoPQep9Q+45Htjnfj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=utk2iMRq; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="utk2iMRq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763260903;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Rn2bulmuLcZ9IJvJDHOF9r6dUsbVVQ9CPeZIoJW/F+8=;
 b=utk2iMRqJpgxR4v2dZh0vE0l5hKjgJ+DY8RbiGd4Xq4Xv2FBdJFucTOH6e5ZA47imYUoZs
 mTyTZ9RXCzdvsgv1/zeE8eYRjtY2tATkbeGklshHfURTt5g/2PaMCP9I480RAwE5oS0ujo
 eqOLaEFDKrpSzmgnbQuvO/Goa1p5miec3+VER+IJrYwpbBFLEzPXLulS43UEIjHbROy7+z
 UN1Mk5NI0vF+BBAMgRVEoN/kXbsW2hgu2ikzVQZWxUfpPH1QePvXySoeYVzHT4WzKD4vdp
 9lX+DyOpYDcSGRfAFdDVLYv6//dvSWhdyKkdayHTOJQ5P6vLvk8Irm8loRhH6A==
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 10:41:40 +0800
Message-Id: <20251116024134.115685-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 0/5] block/blk-rq-qos: fix incorrect lock order for rq_qos_mutex and freeze queue
Date: Sun, 16 Nov 2025 10:41:29 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
X-Lms-Return-Path: <lba+2691939e5+4c99dc+vger.kernel.org+yukuai@fnnas.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>
Cc: <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Currently rq_qos_add() will be called with rq_qos_mutex held, and freeze
queue, this is not expected. This set make sure queu is always freezed
before holding rq_qos_mutex.

Yu Kuai (5):
  block/blk-rq-qos: add a new helper rq_qos_add_freezed()
  blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iocost: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iolatency: fix incorrect lock order for rq_qos_mutex and freeze
    queue
  block/blk-rq-qos: cleanup rq_qos_add()

 block/blk-iocost.c    | 15 +++++++--------
 block/blk-iolatency.c | 11 +++++++----
 block/blk-rq-qos.c    | 23 ++++++-----------------
 block/blk-rq-qos.h    |  4 ++--
 block/blk-wbt.c       |  6 +++++-
 5 files changed, 27 insertions(+), 32 deletions(-)

-- 
2.51.0
