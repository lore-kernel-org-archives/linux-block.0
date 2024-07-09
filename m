Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E93158A36
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530246; cv=none; b=lQBZ9djHKDUGhlt61YYKpWKsDG0hAenaIURB5vti1i2bR4UBi6MBJVGmBP/Xasi5h/X5BrmdHntUW09tathHMKYdFZiZXbTquuN7Yde6CHhY64AEDH8qm03DspoDK61FXEOZRUL9OqwzotzFIKXKwddTAdFxbQ+HUEbyX8xrI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530246; c=relaxed/simple;
	bh=CBJ99x43/70zGwHPjM38CAlxxeD2VQFXSI6RVuuM9wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e07uAIpP+BcE8jytsC3oZ1d1TQ4iIzQrv9LM57kBAVE/ri5DdMBKli+ysX5p4dZRyKXZCMS0ldYT5PndDLTAlAFvnhj7wf85xL5jAyr7/o/8pN4IpnJBfna/r448iA8dXGUwpceptZPrm6btsXuuDoYDn9mlFXwydGAkwO10G2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aJ/spdJw; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aJ/spdJw"
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720530235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ebK7bmN5g56VOCyyzOzUAvkTrnBN4ITiAsuNihnZjQY=;
	b=aJ/spdJwG3nfjXdkjEEn3aT5cHRPpEes6XnS9OT7NaBvO98BgA13moroZlR8IljkjedC92
	ozZ2LKBIx8vOV91iLFgTAv0Y1YRE7ma/ucrdn66Z7S4nUGtVorx1eeYFcZbJKA/Be0B0WM
	aS9pWeEwF6KIG64yGJaakhda5GnJD+s=
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: gregory.price@memverge.com
X-Envelope-To: john@groves.net
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: bbhushan2@marvell.com
X-Envelope-To: chaitanyak@nvidia.com
X-Envelope-To: rdunlap@infradead.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: dongsheng.yang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
To: axboe@kernel.dk,
	dan.j.williams@intel.com,
	gregory.price@memverge.com,
	John@groves.net,
	Jonathan.Cameron@Huawei.com,
	bbhushan2@marvell.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH v1 0/7] Introduce CBD (CXL Block Device)
Date: Tue,  9 Jul 2024 13:03:36 +0000
Message-Id: <20240709130343.858363-1-dongsheng.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,
        This is V1 for CXL Block Device. This patchset is based on v6.9 and
it's available at: https://github.com/DataTravelGuide/linux branch cbd.

changes from RFC: (https://lore.kernel.org/lkml/20240422071606.52637-1-dongsheng.yang@easystack.cn/)
        (1) only support hardware-consistency cxl shared memory.
		As discussed in the RFC, the current cbd only supports
hardware-consistency for CXL shared memory, and some code related to
software-consistency support has been removed from the RFC. In the
current tests, whether using local PMEM or QEMU-simulated shared memory
devices, they all are hardware-consistency.

        (2) add a segment abstraction for transport data space management.
		The layout of the transport remains essentially
unchanged, with the only difference being the addition of a segment
abstraction for scalability purposes. A channel is a type of segment
used for data transfer between the blkdev and the backend. In the
future, there will be more segment types, such as a cache segment for
caching data for the blkdev.

        (3) add CONFIG_CBD_CRC option in Kconfig
		We only support hardware-consistency, so theoretically,
there should be no data consistency issues when transferring data
between blkdev and the backend. However, cbd provides a verification
mechanism, offering CRC checks for both metadata and data to verify
after data reception. This method impacts performance, so it is an
option in Kconfig.

        (4) allow user to clear dead object in transport metadata
		When a host using cbd, whether backend or blkdev, dies
without unregistering, the metadata in the transport will retain some
dead information. In v1, users are allowed to clear this dead metadata
via sysfs. Of course, there is a heartbeat mechanism to ensure users do
not mistakenly delete alive metadata.

        (5) allow user to force stop blkdev and reattach backend
		This also handles scenarios where the host goes offline
unexpectedly. When the backend goes offline unexpectedly, the
corresponding blkdev might have I/O operations that cannot finish. In
such cases, cbd provides two ways to handle this:
		a) If the backend can recover, we can re-add the backend to the
corresponding transport, allowing the blkdev's I/O operations to continue being processed.
		b) If the backend cannot recover, the blkdev can be force-stopped, and
the incomplete I/O operations will return EIO, but they will no longer remain blocked.

        (6) dont allocate new pages in hander for bio data.
		The backend handler does not allocate pages for bio.
Instead, the handler can directly map the data pages from the transport
to the bio, and then send the bio to the backend disk, achieving zero
copy on the backend side.

        (7) new test project cbd-tests:
		cbd-tests (https://github.com/DataTravelGuide/cbd-tests), for testing cbd. It is
an automated testing project based on the Avocado testing framework. Currently,
it includes xfstests on cbd block devices with XFS, V1 Passed all 944 tests in xfstests
(https://datatravelguide.github.io/dtg-blog/cbd/test-results/test_result_v1/test-results/xfstests-1-xfstests.py_Xfstests.test_run-cbdd_timeout-no_timeout-disk_type-fs_type-fs_xfs-f090/debug.log). as well as fio performance testing directly on /dev/cbdX block devices.

The test results can be viewed here in [test results]:
	https://datatravelguide.github.io/dtg-blog/cbd/cbd.html#test-results

Thanx

Dongsheng Yang (7):
  cbd: introduce cbd_transport
  cbd: introduce cbd_host
  cbd: introduce cbd_segment
  cbd: introduce cbd_channel
  cbd: introduce cbd_blkdev
  cbd: introduce cbd_backend
  block: Init for CBD(CXL Block Device) module

 drivers/block/Kconfig             |   2 +
 drivers/block/Makefile            |   2 +
 drivers/block/cbd/Kconfig         |  23 +
 drivers/block/cbd/Makefile        |   3 +
 drivers/block/cbd/cbd_backend.c   | 296 ++++++++++
 drivers/block/cbd/cbd_blkdev.c    | 417 ++++++++++++++
 drivers/block/cbd/cbd_channel.c   | 153 ++++++
 drivers/block/cbd/cbd_handler.c   | 263 +++++++++
 drivers/block/cbd/cbd_host.c      | 128 +++++
 drivers/block/cbd/cbd_internal.h  | 848 ++++++++++++++++++++++++++++
 drivers/block/cbd/cbd_main.c      | 224 ++++++++
 drivers/block/cbd/cbd_queue.c     | 526 ++++++++++++++++++
 drivers/block/cbd/cbd_segment.c   | 108 ++++
 drivers/block/cbd/cbd_transport.c | 883 ++++++++++++++++++++++++++++++
 14 files changed, 3876 insertions(+)
 create mode 100644 drivers/block/cbd/Kconfig
 create mode 100644 drivers/block/cbd/Makefile
 create mode 100644 drivers/block/cbd/cbd_backend.c
 create mode 100644 drivers/block/cbd/cbd_blkdev.c
 create mode 100644 drivers/block/cbd/cbd_channel.c
 create mode 100644 drivers/block/cbd/cbd_handler.c
 create mode 100644 drivers/block/cbd/cbd_host.c
 create mode 100644 drivers/block/cbd/cbd_internal.h
 create mode 100644 drivers/block/cbd/cbd_main.c
 create mode 100644 drivers/block/cbd/cbd_queue.c
 create mode 100644 drivers/block/cbd/cbd_segment.c
 create mode 100644 drivers/block/cbd/cbd_transport.c

-- 
2.34.1

