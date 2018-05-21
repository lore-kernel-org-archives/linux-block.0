Return-Path: <yizhan@redhat.com>
Date: Mon, 21 May 2018 02:37:56 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Message-ID: <1352065975.3088816.1526884676038.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180518174247.31098-1-keith.busch@intel.com>
References: <20180518174247.31098-1-keith.busch@intel.com>
Subject: Re: [PATCH blktests] Fix block/011 to not use sysfs for device
 disabling
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Keith
I tried this patch on my R730 Server, but it lead to system hang after setpci, could you help check it, thanks.

Console log:
storageqe-62 login: 
Kernel 4.17.0-rc5 on an x86_64

storageqe-62 login: [ 1058.118258] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 3
[ 1058.118261] {1}[Hardware Error]: event severity: fatal
[ 1058.118262] {1}[Hardware Error]:  Error 0, type: fatal
[ 1058.118265] {1}[Hardware Error]:   section_type: PCIe error
[ 1058.118266] {1}[Hardware Error]:   port_type: 0, PCIe end point
[ 1058.118267] {1}[Hardware Error]:   version: 1.16
[ 1058.118269] {1}[Hardware Error]:   command: 0x0400, status: 0x0010
[ 1058.118270] {1}[Hardware Error]:   device_id: 0000:85:00.0
[ 1058.118271] {1}[Hardware Error]:   slot: 0
[ 1058.118271] {1}[Hardware Error]:   secondary_bus: 0x00
[ 1058.118273] {1}[Hardware Error]:   vendor_id: 0x144d, device_id: 0xa821
[ 1058.118274] {1}[Hardware Error]:   class_code: 020801
[ 1058.118275] Kernel panic - not syncing: Fatal hardware error!
[ 1058.118301] Kernel Offset: 0x14800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Best Regards,
  Yi Zhang


----- Original Message -----
From: "Keith Busch" <keith.busch@intel.com>
To: "Omar Sandoval" <osandov@osandov.com>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: "Johannes Thumshirn" <jthumshirn@suse.de>, "Christoph Hellwig" <hch@lst.de>, "Jens Axboe" <axboe@kernel.dk>, "Ming Lei" <ming.lei@redhat.com>, "Keith Busch" <keith.busch@intel.com>
Sent: Saturday, May 19, 2018 1:42:47 AM
Subject: [PATCH blktests] Fix block/011 to not use sysfs for device disabling

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
