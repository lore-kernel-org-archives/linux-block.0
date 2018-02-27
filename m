Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>
Cc: linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Don Brace <don.brace@microsemi.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/8] blk-mq & scsi: fix reply queue selection and improve host wide tagset
Date: Tue, 27 Feb 2018 18:07:42 +0800
Message-Id: <20180227100750.32299-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi All,

The 1st two patches fixes reply queue selection, and this issue has been
reported and can cause IO hang during booting, please consider the two
for V4.16.

The following 6 patches try to improve hostwide tagset on hpsa and
megaraid_sas by making hw queue per NUMA node.

I don't have high-performance hpsa and megaraid_sas device at hand.

Don Brace, could you test this patchset on concurrent IOs over you hpsa
SSD and see if this approach is well?

Kashyap, could you test this patchset on your megaraid_sas SSDs?

	gitweb: https://github.com/ming1/linux/tree/v4.16-rc-host-tags-v3.2

thanks,
Ming

Hannes Reinecke (1):
  scsi: Add template flag 'host_tagset'

Ming Lei (7):
  scsi: hpsa: fix selection of reply queue
  scsi: megaraid_sas: fix selection of reply queue
  blk-mq: introduce 'start_tag' field to 'struct blk_mq_tags'
  blk-mq: introduce BLK_MQ_F_HOST_TAGS
  block: null_blk: introduce module parameter of 'g_host_tags'
  scsi: hpsa: improve scsi_mq performance via .host_tagset
  scsi: megaraid: improve scsi_mq performance via .host_tagset

 block/blk-mq-debugfs.c                      |  2 +
 block/blk-mq-sched.c                        |  2 +-
 block/blk-mq-tag.c                          | 13 +++--
 block/blk-mq-tag.h                          | 11 ++--
 block/blk-mq.c                              | 50 +++++++++++++++---
 block/blk-mq.h                              |  3 +-
 drivers/block/null_blk.c                    |  6 +++
 drivers/scsi/hpsa.c                         | 79 ++++++++++++++++++++++-------
 drivers/scsi/hpsa.h                         |  1 +
 drivers/scsi/megaraid/megaraid_sas.h        |  2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c   | 40 ++++++++++++++-
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 12 ++---
 drivers/scsi/scsi_lib.c                     |  2 +
 include/linux/blk-mq.h                      |  2 +
 include/scsi/scsi_host.h                    |  3 ++
 15 files changed, 182 insertions(+), 46 deletions(-)

-- 
2.9.5
