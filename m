Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071965;
	b=e1t2SWzC1n3niffkItXvJqiYSjL9746gkNJIhgTt9b4FJg+C0YDdVLsiTtW5tZDNGJAz
	 uveNs9jwAnRToeKayUmSuwx4slw36UoN5/GjnB8HkQvrxLblgwVO+cXwFPWusPavpJywZ
	 CvrH9Vb/NIYFR3XBcG/WoWYHcpAIojg7gL30u74fBjtAOq0loymvo7/9St+IXoMuMj7Ds
	 tw3lc2+AKyMVMrF9NQVQJ9wx7NrrTkmFGtJuIvplG7X7W1vxU6JQQEVAQQd8CnTbzYCAs
	 X8R4vM+26s+kkDVNp1OtgAR/R/6e7hrqVNHZkVVL3v7Yv0KpN15MKxB+VQ6PoxYe6Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071965;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LZoD7OlA4lWPmoq26J8osVF320fIPT6gJeeje9bAEdY=;
	b=rDQbCNow3bKzfjPFjk0IcFWGktImpgAGgsPSlaGvFDhKEYAKbk3Z+5U927BIpK4J2HiB
	 WEv2MtsQIddBo114Qyt90UHdGxPpql4zzVWMZVTFQbGB7beGd0qlG/RulCkKK3NZRofHI
	 z+hgbCdaQszaJpLCQIEtZHNXY7ZJHqbDKi7uWyOXtWX3bnLzMHN04xfKyOMa7Q8aI0VZw
	 OSOLU0n5LHAhHy+3a3aY55l5CkZkMBbUlY3JDN2hixNyEN9evTiKANAQpAYAPUaOrgOO4
	 2NKPdLCQoKvTGfk69ppMTg+wrybf/A+JDqGoPRFilsH2fJ9OFoT6UVqysUyyUNfnJCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yiYnT6B7;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F8606A324
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 07:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E79F8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yiYnT6B7
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795071956; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LZoD7OlA4lWPmoq26J8osVF320fIPT6gJeeje9bAEdY=;
	b=yiYnT6B7cJ1kf1/JjiSnQoq1pmQJ0flhRWGIpp2UL2JHZ+g+N28cM2pZSJguDlBh6CtZGaVrLBi9nJH8rCv+IOZzvMebMgKO6hmFl5qtbQxAWhchYCx/wOXELMNNlsf1Bd+e5f6aWLv7vl3EcEIWew5+1/+0Qzbt2l6doPjnYZ8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF2hAVi_1795071955;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF2hAVi_1795071955 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:05:55 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 0/7] block fixes found by code inspection
Date: Thu, 19 Nov 2026 15:05:41 +0800
Message-ID: <20261119070548.3125491-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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

Seven block layer fixes, all found by code inspection of the tags SRCU
lifetime, the hctx reuse path, and the blk-cgroup configuration writers.

Patch 1 and patch 7 close the two halves of the tags_srcu protection for
tag iterators: patch 1 frees the tags->rqs[] and tags->static_rqs[]
arrays in the SRCU callback together with the bitmaps, patch 7 unpublishes
set->tags[] before the grace period starts, so a reader can no longer
load a pointer that the grace period has already released.

Patch 2 clears a stale BLK_MQ_S_STOPPED flag when a parked hctx is
reused, so requests queued on it do not stall until the driver happens
to stop and restart the queue again.

Patch 3 and patch 4 fix the locking order of ioc_cost_model_write():
patch 3 releases rq_qos_mutex before freezing the queue like
ioc_qos_write() does, patch 4 moves the unfreeze in ioc_qos_write()
ahead of the bdev reference drop, closing the same lifetime gap in both
writers.

Patch 5 fixes the mean folding in blk_rq_stat_sum(), which silently
dropped the samples of an already folded source and kept
blk-iolatency's accumulated window mean at zero on rotating disks.

Patch 6 rejects a dead disk in the three lazy policy init helpers, so a
configuration write racing del_gendisk() can no longer attach an orphan
iocost/iolatency/throttle policy that nothing tears down again.

Found by code inspection.

Tested on a KVM q35 guest with a 7.4-rc1 based kernel (PROVE_LOCKING
enabled): hctx state flags after a stop/shrink/start/grow cycle on
nullb0 show no stale flags and IO on the reused hctx completes; iocost
cost.model and cost.qos writes against a live and a removed nullb
device behave as expected, with the removed device rejected with
-ENODEV and the live device accepting all model, qos and coefficient
writes; concurrent nullb submit_queues resizes against continuous
debugfs busy/tags reads under fio ran for six minutes without errors.

Guixin Liu (7):
  blk-mq: free the rqs arrays of tags in the SRCU callback
  blk-mq: clear stale stopped flag on hctx reuse
  blk-iocost: don't take rq_qos_mutex before the queue is frozen in cost
    model write
  blk-iocost: unfreeze the queue before dropping the bdev reference in
    qos write
  blk-stat: account for the mean of the source in blk_rq_stat_sum()
  blk-cgroup: don't attach a qos policy to a dead disk
  blk-mq: unpublish the tags before deferring their free to SRCU

 block/blk-iocost.c    | 19 ++++++++++++++-----
 block/blk-iolatency.c |  3 +++
 block/blk-mq-tag.c    |  2 ++
 block/blk-mq.c        | 24 +++++++-----------------
 block/blk-mq.h        |  1 -
 block/blk-stat.c      |  8 ++++++--
 block/blk-throttle.c  |  3 +++
 7 files changed, 35 insertions(+), 25 deletions(-)

--
2.43.7

