Return-Path: <Adam.Manzanares@wdc.com>
From: Adam Manzanares <adam.manzanares@hgst.com>
To: <axboe@kernel.dk>, <hare@suse.de>, <mchristi@redhat.com>,
	<dan.j.williams@intel.com>, <martin.petersen@oracle.com>,
	<toshi.kani@hpe.com>, <damien.lemoal@hgst.com>, <ming.lei@canonical.com>,
	<tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v7 0/4] Enabling ATA Command Priorities
Date: Tue, 6 Dec 2016 09:18:01 -0800
Message-ID: <1481044685-2803-1-git-send-email-adam.manzanares@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Adam.Manzanares@wdc.com
List-ID: <linux-block@vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

This patch builds ATA commands with high priority if the iocontext of a process
is set to real time. The goal of the patch is to improve tail latencies of 
workloads that use higher queue depths. This requires setting the iocontext 
ioprio on the request when it is initialized

This patch has been tested with an Ultrastar HE8 HDD and cuts the 
the p99.99 tail latency of foreground IO from 2s down to 72ms when
using the deadline scheduler. This patch works independently of the
scheduler so it can be used with all of the currently available 
request based schedulers. 

Foreground IO, for the previously described results, is an async fio job 
submitting 4K read requests at a QD of 1 to the HDD. The foreground IO is set 
with the iopriority class of real time. The background workload is another fio
job submitting read requests at a QD of 32 to the same HDD with default 
iopriority.

This feature is enabled for ATA devices by setting the ata ncq_prio_enable 
device attribute to 1. An ATA device is also checked to see if the device 
supports per command priority.

v7:
 - Run ncq prio support check when sysfs variable set (zero day bug fix)
 - Fixes from TJ merged in
 - Merge fix for linux-next incorporated

v6:
 - Removed fusion mpt sas prio related code deletion
 - Renamed ata device attribute that enables priority cmds to the device

v5:
 - Updated block patch commit message to indicate the why and not the how
v4:
 - Added blk_rq_set_prio function to associate request prio with ioc prio
 - In init_request_from_bio use bio_prio if it is valid
 - Added ata enable_prio dev attribute to sysfs to enable prioritized commands

v3:
 - Removed null dereference issue in blk-core
 - Renamed queue sysfs entries for clarity
 - Added documentation for sysfs queue entry

v2:
 - Add queue flag to set iopriority going to the request
 - If queue flag set, send iopriority class to ata_build_rw_tf
 - Remove redundant code in ata_ncq_prio_enabled function.


Adam Manzanares (4):
  block: Add iocontext priority to request
  ata: Enabling ATA Command Priorities
  ata: ATA Command Priority Disabled By Default
  ata: set ncq_prio_enabled iff device has support

 block/blk-core.c          |  4 ++-
 drivers/ata/libahci.c     |  1 +
 drivers/ata/libata-core.c | 33 ++++++++++++++++++-
 drivers/ata/libata-scsi.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |  3 +-
 include/linux/ata.h       |  6 ++++
 include/linux/blkdev.h    | 14 ++++++++
 include/linux/libata.h    |  5 +++
 8 files changed, 146 insertions(+), 4 deletions(-)

-- 
2.7.4
