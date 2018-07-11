Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH RFC 0/4] blk-mq: support runtime PM
Date: Thu, 12 Jul 2018 00:29:02 +0800
Message-Id: <20180711162906.14271-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi Guys,

Runtime PM is usually enabled for SCSI devices, and we are switching to
SCSI_MQ recently, but runtime PM isn't supported yet by blk-mq, and
people may complain that.

This patch tries to support runtime PM for blk-mq. And one chanllenge is
that it can be quite expensive to account the active in-flight IOs for
figuring out when to mark the last busy. This patch simply marks busy
after each non-PM IO is done, and this way is workable because:

1) pm_runtime_mark_last_busy() is very cheap

2) in-flight non-PM IO is checked in blk_pre_runtime_suspend(), so
if there is any IO queued, the device will be prevented from being
suspened.

3) Generally speaking, autosuspend_delay_ms is often big, and should
be in unit of second, so it shouldn't be a big deal to check if queue
is idle in blk_pre_runtime_suspend().

Ming Lei (4):
  blk-mq: introduce blk_mq_support_runtime_pm()
  blk-mq: introduce blk_mq_pm_queue_idle()
  blk-mq: prepare for supporting runtime PM
  scsi_mq: enable runtime PM

 block/blk-core.c        | 14 +++++++++++---
 block/blk-mq.c          | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq.h          |  3 +++
 drivers/scsi/scsi_lib.c |  3 ++-
 include/linux/blk-mq.h  | 10 ++++++++++
 5 files changed, 72 insertions(+), 4 deletions(-)

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org


-- 
2.9.5
