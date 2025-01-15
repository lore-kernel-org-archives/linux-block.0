Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B898488
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 04:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915354; cv=none; b=QeeHAvv3H/lCnf9GA9mkIzllJTn2odfh7gXkY4Mw/FkOqSMMwUVnF8sYYTUgx/hvfm5osWMMq4NdBfITJLwC8KLMTnz4oDJMVekjefWZJgIsc6VLnQnY7kRVzI+tsMH+fazaCoDKgLS6PiihXgqi9+kZnXcTjG41MXMi1qQbAX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915354; c=relaxed/simple;
	bh=cBU/Tm7/0KWeP8batAQyp3hnUllGkFsq44P4qYQynSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QCpUghR+U6fvspgVyrp7oaemlWZgf34N7qyb8wctWGqyEEgqWa0U8oa87PuEGadH89LHJWTajoSuXTkCJG+fVQnV4D9GYpjiHGMxDaehykoWeDpxxppYtokAI0yrAIefpdvtIOdUEvStu3XsT3/20cdeplcQIZudBj/+RGIkh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EIJob+xs; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EIJob+xs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736915353; x=1768451353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cBU/Tm7/0KWeP8batAQyp3hnUllGkFsq44P4qYQynSQ=;
  b=EIJob+xsDyUqUAnrSUgt2l4/GqSIyJYzjw3rXJPTL6Hxq+TiabNfY6gl
   kFLYrlPxmx+kbksjXejTM/pdmwIUb0rZQY3TYjrqUkJnwzrlvlPQnIf5P
   5g8qI15JnjPC2YeYBc6FfCRzwhbNLIZi0D0egHEb9KgvlPxZuiUKfg0jA
   LHnhXXedG2eofdHUGfPJmDj8bE9nfOrL+8SzooLvjg4Nk9S8hweucyiJh
   4+Ej+STupt2gOtFjgXMXoTvabzIa+6/JH4q1i0dyPdBtDvCFK9V+fMmLj
   JnMWN/L9h5lfL13fqxtNNHv/JqtMGA7Ys43PCL/MgRcZ+vFZaFEkN8zF6
   g==;
X-CSE-ConnectionGUID: 4akqm1vqSceGuoNYQWGtoQ==
X-CSE-MsgGUID: ndrjKRZWTUGvQrt/mQXucw==
X-IronPort-AV: E=Sophos;i="6.12,316,1728921600"; 
   d="scan'208";a="35958002"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2025 12:29:12 +0800
IronPort-SDR: 67872ac0_y7WkJsjwfBHY7fqjvLtGv+s6yeJgRe/TnLcgGjL+hJr2giW
 8W3rPsbG7fvarVbUsHMXx5eQlD4XE3jJOHNeRNw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2025 19:25:52 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jan 2025 20:29:11 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH for-next v3 0/5] null_blk: improve write failure simulation
Date: Wed, 15 Jan 2025 13:29:05 +0900
Message-ID: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, null_blk has 'badblocks' parameter to simulate IO failures
for broken blocks. This helps checking if userland tools can handle IO
failures. However, this badblocks feature has two differences from the
IO failures on real storage devices. Firstly, when write operations fail
for the badblocks, null_blk does not write any data, while real storage
devices sometimes do partial data write. Secondly, null_blk always make
write operations fail for the specified badblocks, while real storage
devices can recover the bad blocks so that next write operations can
succeed after failure. Hence, real storage devices are required to check
if userland tools support such partial writes or bad blocks recovery.

This series improves write failure simulation by null_blk to allow
checking userland tools without real storage devices. The first patch
is a preparation to make new feature addition simpler. The second patch
introduces the 'badblocks_once' parameter to simulate bad blocks
recovery. The third patch fixes a bug, and the fourth patch adds a
function argument to prepare for the fifth patch. The fifth patch adds
the partial IO support and introduces the 'badblocks_partial_io'
parameter.

Changes from v2:
* 1st patch: Reflected comments on the list
* 2nd patch: Moved the 4th patch in v2 series to 2nd
             Reduced if-block nest level
* 3rd patch: Added to fix zone resource management bug
* 4th patch: Added to prepare for the next patch
* 5th patch: Rewritten to care zone resource management
             Introduced badblocks_patial_io parameter

Changes from v1:
* Added the first patch which avoids the long, multi-line features string

Shin'ichiro Kawasaki (5):
  null_blk: generate null_blk configfs features string
  null_blk: introduce badblocks_once parameter
  null_blk: fix zone resource management for badblocks
  null_blk: pass transfer size to null_handle_rq()
  null_blk: do partial IO for bad blocks

 drivers/block/null_blk/main.c     | 162 +++++++++++++++++++-----------
 drivers/block/null_blk/null_blk.h |   6 ++
 drivers/block/null_blk/zoned.c    |  20 +++-
 3 files changed, 127 insertions(+), 61 deletions(-)

-- 
2.47.0

