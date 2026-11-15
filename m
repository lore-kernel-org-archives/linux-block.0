Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707924;
	b=miPf7jRR1WernAefKQNVs6KQbDSDu2DA7ypEeHQ02T9SXUuWXBGD6Kb90KCsP5jkIRZS
	 zeleY3W9d6C/ouFyOQenehzFPMojSdnGKySllK/ONNWmzQlpsTibok4zA5VkawXVnXFwW
	 5QAGxmeEO8TEfjskpktZLrWHcD9HpTMjia27CROKN/N32ZX0naUGtLQ/fkFN/x3/sxKlG
	 kmYbNrhmwxEGGT/1u3XU/jIctiZUau13llIXGInMSHDfoGoDS+qrR1y+1Tr+9QoO1eK6/
	 vtdj0NTXPpW+eGOX5Y+l44M8XruydkQVdEazAjExDx2u4Tv2R/fzjVZ7FtixRL532nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707924;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer;
	bh=n8WR2+gLK7JLEeMAEzuJE6kWMT5254NmCSuEzUzFNxI=;
	b=sAaSbC3OrLNVdMHl+mluRBNkgbsdm9EjzUX0mI8QcICofrfkzfkaz5Y46oEvhxezID5i
	 J+a2IeFMCBaEbqyIM8CXu09N+5KRFS1ZllijAvZjx2Ml8ueiFej1cH0WE1S/RxzYtGtYe
	 t3/yUtlZ4mHjUznYuB1dwem2PmAoNMfRbPYJAiuKAAGxUgZzZ1mXL0t5giXmRdwnRLjDZ
	 +zY0OOvqrrThO8mAyWnYB7zdWocAC8PI6Mtz8D4M7ByIkJxVW63COkTVLOSaLaPQCiBM2
	 AiaUuUdGdynhtMnQbXck1b97OywW+XONeaUMBMRCsC9DGNHAlsXXzIqSmzfJHyd9wPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PtDCB3px;
	arc=none smtp.remote-ip=91.218.175.81
Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14272606A327
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 01:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14272606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PtDCB3px
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7jVJGhO9Uh8NdPb2kl5Av9OZJWTpkZHIJH3s4lFAiUI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794707920; v=1; x=1795312720;
 b=PtDCB3pxqAnvDEesjuzsANdaiW6tC6la4UuUdd1S6vZmGyZQLJIPGJb/jKLxHKfcQJIbJPA1
 FLwWqbpVelAEnW5viAtYYS76xp0qvR3vszYIvkYqJD+YH2ViLFBQ/yXPpB0q87z4hJRwIRvixOt
 QyhUd62cT1BClMaji+tVuqE4=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7bd97eff6b03b387;
	Sun, 15 Nov 2026 01:58:40 +0000
X-Mizu-Trace-ID: 7bd97eff6b03b387
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v2 0/2] block: make changing to the current I/O scheduler
 cheap again
Date: Sat, 14 Nov 2026 20:58:31 -0500
Message-Id: <20261114-bug-block-elevator-unchanged-v2-0-5a1fe7d72fa0@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMcR+WoC/42NQQ6CMBBFr0Jm7RhaFNGV9zAsWmaEiaSYVhoM6
 d2teAFn937+f7NCYC8c4FKs4DlKkMll0LsCusG4nlEoM+hS1yof2rlHO07dA3nkaF6Tx9n9qoS
 m7kjTqVZUNZAVT893WTb9rc08SMiD9/Ytqm/6pzgqLPHYVOrcWDqwVtdR3LzsiSO0KaUPPqZ4P
 cgAAAA=
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.13.0

Writing the scheduler a queue already uses to queue/scheduler takes
about 10 ms and freezes the queue, which stalls I/O on live disks every
time a udev rule or tuning tool sets the scheduler unconditionally.

Patch 1 stops requesting a "none-iosched" module on every write of
"none". Patch 2 returns before freezing the queue when the elevator
wouldn't change.

On a null_blk disk (median of 20 writes, all kernels measured in the
same run):

  operation                   base (ms)  patch 1 (ms)  patch 1+2 (ms)
  none -> none                    13.10          9.11            0.08
  mq-deadline -> mq-deadline      10.95          9.05            0.08
  mq-deadline -> none             13.00          7.97            6.03

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V1 -> V2:
- Keep the elevator check under the freeze and note the race in the
  comment, as Christoph suggested
- Say "change" instead of "rewrite" in the cover letter subject
- Rebase onto v7.4-rc2-470-g7e1392a42ea2 and update the numbers from a
  new run

v1: https://lore.kernel.org/r/20261111-bug-block-elevator-unchanged-v1-0-583198bd4e21@linux.dev

---
Qiliang Yuan (2):
      block: don't request a module for the none elevator
      block: return early when the elevator doesn't change

 block/elevator.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
---
base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
change-id: 20261111-bug-block-elevator-unchanged-a6cd2d761d38

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

