Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 0/5] SCSI: fix selection of reply(hw) queue
Date: Tue, 13 Mar 2018 17:42:38 +0800
Message-Id: <20180313094243.8710-1-ming.lei@redhat.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hi All,

The patches fixes reply queue(virt-queue on virtio-scsi) selection on hpsa,
megaraid_sa and virtio-scsi, and IO hang can be caused easily by this issue.

This issue is triggered by 84676c1f21e8 ("genirq/affinity: assign vectors
to all possible CPUs"). After 84676c1f21e8, it is easy to see one msix
vector mapped to all offline CPUs. If the reply queue is seleteced from
all allocated msix vectors(reply queues) in round-roin way, the selected
replay queue may not have any online CPU mapped, IO hang is caused.

Both hpsa and megaraid_sas uses host-wide tagset, we can't convert the
reply queue to blk_mq hw queue directly, otherwise IO performance is degraded
much, according to Kashyap's test, so this patchset sets up one mapping talbe
for selecting reply queue, and this approach has been used by mpt3sas already.

For virtio-scsi, the virt-queue is really hw queue wrt. blk-mq view, so
we introduce 'force_blk_mq' for fix this issue because: 1) virtio-blk
has been used for years in blk-mq mode; 2) we have discussed recently
that scsi_mq will be enabled at default soon.


gitweb:
	https://github.com/ming1/linux/tree/v4.16-rc-select-reply-queue-fix-V5

V5:
	- cover legacy vector for megaraid_sas(2/5)
	- patch style change (4/5)
	- add one virtio-scsi cleanup patch(5/5)

V4:
	- splitted from previous patchset
	- handle virtio-scsi by force_blk_mq

Ming Lei (5):
  scsi: hpsa: fix selection of reply queue
  scsi: megaraid_sas: fix selection of reply queue
  scsi: introduce force_blk_mq
  scsi: virtio_scsi: fix IO hang caused by irq vector automatic affinity
  scsi: virtio_scsi: unify scsi_host_template

 drivers/scsi/hosts.c                        |   1 +
 drivers/scsi/hpsa.c                         |  73 ++++++++++++----
 drivers/scsi/hpsa.h                         |   1 +
 drivers/scsi/megaraid/megaraid_sas.h        |   1 +
 drivers/scsi/megaraid/megaraid_sas_base.c   |  39 ++++++++-
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  12 +--
 drivers/scsi/virtio_scsi.c                  | 129 ++++------------------------
 include/scsi/scsi_host.h                    |   3 +
 8 files changed, 116 insertions(+), 143 deletions(-)

-- 
2.9.5
