Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214633A718
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268174; cv=none; b=RiIFbyq7b6gA3kOs1bpSCFuZEp1W+5EhhWy8uWkT8PdNxnZSA7X3IDdCV7RDPnHEoEOrAvb1pN8891xPq3vtbemoa/c6Pobr63L+GS4NpeSdz+D/mc2DE8I1F0w5EIM227pQqpg6cDqPHIFEM4kQ4PTxPFpIYBwPefB6EZZnBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268174; c=relaxed/simple;
	bh=yRL1J1QpJhkLYIy2lr2EbNTS/wmtg94e30OebBKEFw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCZVtE9PlJOdq1OzUCitOOFPpRVh4ugh5c+GX4243apIg/vom2Bc1BcxZkmD6CEGlXDPhFPUFQV+YFiRGXEP3b7+6Pv7KcZzgZ6oDdRQlY230gyvCM4iC54vkUBsffbC4DgBr9P8XftzXfZjgmpwoZAh+IvlDL2oJRLBB61Id+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I+eXlpNB; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I+eXlpNB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784268169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8IjuMzlv8GEhImlYUewVCFCbHhMBDBXn/IyW5nCXWPM=;
	b=I+eXlpNBW1eidiQqK0QhU5cgPuY73d8j04T7lV0pBB0xZNwXrnEHBgk2aQp80Bjj3PJcww
	Ok50OjvWOxdWuxdY+VZJg/A+PcOWM9a2DLYvrZKtKK6T3BF89W2K6mMNblrtLgAV7gzojT
	XALcK8cW42gEiISiZ57HvLoQp93ZLLI=
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH v2 0/2] blk-iolatency: fix io.latency documentation accuracy
Date: Fri, 17 Jul 2026 14:02:23 +0800
Message-ID: <20260717060225.2019764-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Hi,

This series fixes three inaccuracies in the io.latency documentation
(Documentation/admin-guide/cgroup-v2.rst), all caused by the doc
describing only rotational-device behavior:

  Patch 1 documents the rotational vs non-rotational difference:
  throttling is based on average latency on rotational devices but on the
  fraction of IOs that miss the target on non-rotational devices; the
  tuning guidance and io.stat field list are updated accordingly
  (avg_lat/win are rotational-only; missed/total are documented for
  non-rotational devices).

  Patch 2 corrects the delay unit: io.stat reports delay_nsec in
  nanoseconds, not microseconds as the doc stated.

Both patches are documentation-only and checkpatch-clean.

---

Changes in v2 (address review feedback):
  - The non-rotational tuning guidance no longer implies missed/total is a
    latency baseline: iolatency reports no average latency for
    non-rotational devices, so the target must be chosen from device
    characteristics and missed/total only verifies it is being met.
  - missed/total are now described as live counters for the current window
    (accumulated since the last window boundary), not "the last window":
    iolatency_ssd_stat() sums the per-cpu counters without resetting them,
    while they are reset at window end by iolatency_check_latencies().

Tao Cui (2):
  Docs/admin-guide/cgroup-v2: document io.latency rotational vs
    non-rotational behavior
  Docs/admin-guide/cgroup-v2: fix delay_nsec unit in io.latency doc

 Documentation/admin-guide/cgroup-v2.rst | 55 +++++++++++++++++--------
 1 file changed, 38 insertions(+), 17 deletions(-)

--
2.43.0
