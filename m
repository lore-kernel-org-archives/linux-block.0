Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13A219E0;
	Thu, 29 Aug 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918077; cv=none; b=cNDWhSLyRenjgw9Pl6gwcLm4Dq269Ei6LbCF8uk5G/OY8nHDAF5LrWAPL0cMnp+d/6Jp4RJ2vytZQgRqNnzIw28UqLdA0q/58bQmKQUC0X1KQJlBL1fDf2JEsbwtSXF5kYPbkHjSOi2w4OqDmqPAthz/dlqp34Z+qImQXyOJhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918077; c=relaxed/simple;
	bh=qQ1QhRJfWXzL+NFAlYH6609UIlwBlD1gCnMQ/XLB7aY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ml0Gk14IEE4mYg2KJy1lHrP+nNvjoyK13e8rZS/JUyGWxAnGNo1v/YD+UfUoF3m6ZuozxJYYwU2taTAXZFzRnO4KyNV5oLHztGymN5wdQf0hIjuyIk5doTFwq0oWWslt+i97h0//6RcYz7aHjAtrtN/Z2rA7HG8fSPh4mB7ICYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGHkQzUb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGHkQzUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724918076; x=1756454076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qQ1QhRJfWXzL+NFAlYH6609UIlwBlD1gCnMQ/XLB7aY=;
  b=DGHkQzUbFWp2cHxYzamrRjp0YUWqjlOQ7iS75P61aPa3KNRoHGuMlktk
   JnsVYPgbM1Ka9s6ApbpCNGYEzNGzuE22goOzdz3EMzYGTncveQs5jegRz
   PJEKoB2IGTrYoOjgv2cSLL2HTbPOHqic7FV17Ce/FDlNGEH9pau0XIstB
   2PSWioJ2ZlgXJeFLmYOPdHOhmgL+0H062cWUdSPj1uU26jsbchyk2/X13
   Ly9mJlck6Xose1RZPZWCu2rbSTSlRCQlPx1LJ1MPz5KBdhlJHhqMHYbnJ
   d4OfgWRiGDl9EjyqpW3L1p5nf0iuKYiVzuDG/0SVlKfrDpSW3hgF2cXg3
   Q==;
X-CSE-ConnectionGUID: ydMiGA1HRrqtqrDWV9I3SQ==
X-CSE-MsgGUID: 5Gk1Ruq5S3KmBG+3wqv/aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="13275401"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="13275401"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 00:54:36 -0700
X-CSE-ConnectionGUID: ObprGb/SRvSk1N7jDMiaoQ==
X-CSE-MsgGUID: t6bymFt5T9mhYaOvh6nhUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68161189"
Received: from carterle-desk.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.205])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 00:54:35 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] block: CPU latency PM QoS tuning
Date: Thu, 29 Aug 2024 10:18:18 +0300
Message-ID: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

These patches introduce a mechanism for limiting deep CPU idle states
during block IO. With certain workloads, it is possible for CPU to
enter deep idle while waiting for the IO completion, causing a large
latency to the completion interrupt. See example below, where I used
an Intel Icelake Xeon system to run a simple 'fio' test with random
reads, and with CPU C6 state disabled / enabled (results from 2 * 2min
runs):

C6 enabled:
    slat (nsec): min=1769, max=73247, avg=6960.96, stdev=2115.90
    clat (nsec): min=442, max=242706, avg=23767.06, stdev=13348.74
     lat (usec): min=12, max=250, avg=30.73, stdev=13.96

    slat (nsec): min=1849, max=58824, avg=6970.61, stdev=2134.38
    clat (nsec): min=1684, max=241880, avg=23545.68, stdev=13448.87
     lat (usec): min=12, max=249, avg=30.52, stdev=14.03

C6 disabled:
    slat (nsec): min=2110, max=57871, avg=6867.86, stdev=1711.55
    clat (nsec): min=486, max=98292, avg=22185.50, stdev=10473.34
     lat (usec): min=13, max=105, avg=29.05, stdev=10.99

    slat (nsec): min=2128, max=67730, avg=6913.52, stdev=1714.89
    clat (nsec): min=552, max=93409, avg=22582.50, stdev=10407.53
     lat (usec): min=13, max=108, avg=29.50, stdev=10.93

The maximum latency with C6 enabled is about 2.5x seen with C6
disabled.

Now, the patches provided here introduce a mechanism for the block
layer to limit the maximum CPU latencies, with user configurable
sysfs knobs per block device. Doing following config in my test
system:

  /sys/block/nvme0n1/cpu_lat_limit_us = 10
  /sys/block/nvme0n1/cpu_lat_timeout_ms = 3

This limits the maximum CPU latency for the active CPUs doing block IO
to 10us, and the limit is removed if there is no block IO for 3ms.

Running the same fio test used above with C6 enabled, I get:

    slat (nsec): min=1887, max=71037, avg=7239.68, stdev=1850.67
    clat (nsec): min=438, max=103628, avg=22488.75, stdev=10457.86
     lat (usec): min=12, max=133, avg=29.73, stdev=11.04

    slat (nsec): min=1942, max=69159, avg=7194.01, stdev=1788.63
    clat (nsec): min=418, max=115739, avg=22239.51, stdev=10448.37
     lat (usec): min=12, max=123, avg=29.43, stdev=10.96

... so the maximum latencies are cut by approx 100us and are quite close
to the levels seen with C6 disabled completely system wide.

Any thoughts about the patches and the approach taken?

-Tero

