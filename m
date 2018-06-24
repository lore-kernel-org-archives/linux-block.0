Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751876AbeFXOEC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jun 2018 10:04:02 -0400
From: Ming Lei <ming.lei@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH V2 0/2] scsi: scsi-mq: don't hold host_busy in IO path
Date: Sun, 24 Jun 2018 22:03:25 +0800
Message-Id: <20180624140327.28146-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This patches removes the expensive atomic opeation on host-wide counter
of .host_busy for scsi-mq, and it is observed that IOPS can be increased by
15% with this change in IO test over scsi_debug.


V2:
	- merge patch 1&2 into one patch
	- run more tests(blktests, xfstests, ...), and not see regression

Ming Lei (2):
  scsi: read host_busy via scsi_host_busy()
  scsi: avoid to hold host-wide counter of host_busy for scsi_mq

 drivers/scsi/advansys.c                   |  8 ++++----
 drivers/scsi/hosts.c                      | 32 +++++++++++++++++++++++++++++++
 drivers/scsi/libsas/sas_scsi_host.c       |  4 ++--
 drivers/scsi/megaraid/megaraid_sas_base.c |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c       |  4 ++--
 drivers/scsi/qlogicpti.c                  |  2 +-
 drivers/scsi/scsi.c                       |  2 +-
 drivers/scsi/scsi_error.c                 |  6 +++---
 drivers/scsi/scsi_lib.c                   | 23 ++++++++++++++++------
 drivers/scsi/scsi_sysfs.c                 |  2 +-
 include/scsi/scsi_host.h                  |  1 +
 11 files changed, 65 insertions(+), 21 deletions(-)

Cc: Omar Sandoval <osandov@fb.com>,
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: Don Brace <don.brace@microsemi.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>

-- 
2.9.5
