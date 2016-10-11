Return-Path: <Adam.Manzanares@hgst.com>
From: Adam Manzanares <adam.manzanares@hgst.com>
To: <axboe@kernel.dk>, <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>, Adam
 Manzanares <adam.manzanares@hgst.com>
Subject: [PATCH v3 0/2] Enabling ATA Command Priorities
Date: Tue, 11 Oct 2016 13:40:25 -0700
Message-ID: <1476218427-4021-1-git-send-email-adam.manzanares@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: adam.manzanares@hgst.com
List-ID: <linux-block@vger.kernel.org>

This patch builds ATA commands with high priority if the iocontext
of a process is set to real time. The goal of the patch is to
improve tail latencies of workloads that use higher queue depths.

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

This feature is enabled by setting a queue flag that is exposed as a sysfs
entry named rq_ioc_prio. If this feature is enabled, and the submission 
iocontext exists, and the bio_prio is not valid then the request ioprio is
set to the iocontext prio.

v3:
 - Removed null dereference issue in blk-core
 - Renamed queue sysfs entries for clarity
 - Added documentation for sysfs queue entry

v2:
 - Add queue flag to set iopriority going to the request
 - If queue flag set, send iopriority class to ata_build_rw_tf
 - Remove redundant code in ata_ncq_prio_enabled function.


Adam Manzanares (2):
  block: Add iocontext priority to request
  ata: Enabling ATA Command Priorities

 Documentation/block/queue-sysfs.txt | 12 ++++++++++++
 block/blk-core.c                    |  5 +++++
 block/blk-sysfs.c                   | 32 ++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c           | 35 ++++++++++++++++++++++++++++++++++-
 drivers/ata/libata-scsi.c           | 10 +++++++++-
 drivers/ata/libata.h                |  2 +-
 include/linux/ata.h                 |  6 ++++++
 include/linux/blkdev.h              |  3 +++
 include/linux/libata.h              | 18 ++++++++++++++++++
 9 files changed, 120 insertions(+), 3 deletions(-)

-- 
2.1.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
