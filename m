Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Omar Sandoval <osandov@osandov.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH blktests] Fix block/011 to not use sysfs for device disabling
Date: Fri, 18 May 2018 11:42:47 -0600
Message-Id: <20180518174247.31098-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The PCI sysfs interface may not be a dependable method for toggling the
PCI device state to trigger the timeouts. This patch goes directly to
the config space to make device failure occur.

The success of this test is still senstive to timing, as it may disable
IO memory when a driver is trying to bring it online. This can look like
a permanent device failure from the driver's perspective.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 tests/block/011 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/block/011 b/tests/block/011
index 62e89f7..2fc0ffb 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -21,7 +21,7 @@ DESCRIPTION="disable PCI device while doing I/O"
 TIMED=1
 
 requires() {
-	_have_fio
+	_have_fio && _have_program setpci
 }
 
 device_requires() {
@@ -43,10 +43,11 @@ test_device() {
 	_run_fio_rand_io --filename="$TEST_DEV" --size="$size" \
 			--ignore_error=EIO,ENXIO,ENODEV &
 
+	# toggle PCI Command Register's Memory and Bus Master enabling
 	while kill -0 $! 2>/dev/null; do
-		echo 0 > "/sys/bus/pci/devices/${pdev}/enable"
+		setpci -s "${pdev}" 4.w=0:6
 		sleep .2
-		echo 1 > "/sys/bus/pci/devices/${pdev}/enable"
+		setpci -s "${pdev}" 4.w=6:6
 		sleep .2
 	done
 
-- 
2.14.3
