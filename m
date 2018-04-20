Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753770AbeDTG7O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Apr 2018 02:59:14 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH 0/3] scsi: scsi-mq: don't hold host_busy in IO path
Date: Fri, 20 Apr 2018 14:57:39 +0800
Message-Id: <20180420065742.8043-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This patches removes the expensive atomic opeation on host-wide counter
of .host_busy for scsi-mq, and it is observed that IOPS can be increased by
15% with this change in IO test over scsi_debug.


Ming Lei (3):
  scsi: introduce scsi_host_busy()
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

-- 
2.9.5
