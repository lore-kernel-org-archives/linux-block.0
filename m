Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] post-merge pull for 4.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <0557bc2d-df76-e8ef-8983-14b03f45f689@kernel.dk>
Date: Sun, 30 Apr 2017 20:50:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

After the main block pull request, please pull the below changes. This
pull request contains:

- Further fixups to the NVMe APST code, from Andy.

- Various fixes for (mostly) nvme-fc, from Christoph and James.

- NVMe scsi fixes from Jon and Christoph.

Please pull!


  git://git.kernel.dk/linux-block.git for-4.12/post-merge


----------------------------------------------------------------
Andy Lutomirski (3):
      nvme: Fix APST comment
      nvme: Display raw APST configuration via DYNAMIC_DEBUG
      nvme: Add nvme_core.force_apst to ignore the NO_APST quirk

Christoph Hellwig (8):
      nvme-fc: mark two symbols static
      nvmet-fc: mark nvmet_fc_handle_fcp_rqst static
      nvmet-fc: fix endianess annoations for nvmet_fc_format_rsp_hdr
      nvmet-fc: mark the sqhd field as __le16
      nvmet-fc: properly endian swap sq_head
      nvmet-fcloop: mark two symbols static
      nvme-lightnvm: add missing endianess conversion in nvme_nvm_end_io
      nvme-scsi: remove nvme_trans_security_protocol

Ewan D. Milne (1):
      nvme-fc: avoid memory corruption caused by calling nvmf_free_options() twice

James Smart (26):
      nvme_fc: fix command id check
      nvme_fc: add aen abort to teardown
      nvme_fc: add controller reset support
      Standardize nvme SGL segment count
      Fix nvme unregister port timeout.
      Fix rejected nvme LS Req.
      Fix log message in completion path.
      Add debug messages for nvme/fcp resource allocation.
      Fix spelling in comments.
      Remove unused defines for NVME PostBuf.
      Remove NULL ptr check before kfree.
      Fix extra line print in rqpair debug print.
      Fix PRLI ACC rsp for NVME
      Fix driver unload/reload operation.
      Fix driver usage of 128B WQEs when WQ_CREATE is V1.
      Fix nvme initiator handling when not enabled.
      Remove hba lock from NVMET issue WQE.
      Fix driver load issues when MRQ=8
      Fix crash after issuing lip reset
      Fix max_sgl_segments settings for NVME / NVMET
      Add Fabric assigned WWN support.
      Fix implicit logo and RSCN handling for NVMET
      Update ABORT processing for NVMET.
      Fix Express lane queue creation.
      lpfc revison 11.2.0.12
      lpfc: Fix memory corruption of the lpfc_ncmd->list pointers

Jens Axboe (3):
      Merge branch 'master' into for-4.12/post-merge
      Merge branch 'nvme-4.12' of git://git.infradead.org/nvme into for-4.12/post-merge

Jon Derrick (1):
      nvme-scsi: Consider LBA format in IO splitting calculation

 drivers/nvme/host/core.c           |   38 +-
 drivers/nvme/host/fc.c             | 1173 ++++++++++++++++++++++++------------
 drivers/nvme/host/lightnvm.c       |    2 +-
 drivers/nvme/host/scsi.c           |   15 +-
 drivers/nvme/target/fc.c           |    8 +-
 drivers/nvme/target/fcloop.c       |    4 +-
 drivers/scsi/lpfc/lpfc.h           |    5 +-
 drivers/scsi/lpfc/lpfc_attr.c      |   10 +-
 drivers/scsi/lpfc/lpfc_bsg.c       |    4 +
 drivers/scsi/lpfc/lpfc_crtn.h      |    9 +-
 drivers/scsi/lpfc/lpfc_ct.c        |   68 ++-
 drivers/scsi/lpfc/lpfc_debugfs.c   |   67 +-
 drivers/scsi/lpfc/lpfc_disc.h      |    1 +
 drivers/scsi/lpfc/lpfc_els.c       |   68 +--
 drivers/scsi/lpfc/lpfc_hbadisc.c   |  133 ++--
 drivers/scsi/lpfc/lpfc_hw.h        |    3 +
 drivers/scsi/lpfc/lpfc_hw4.h       |    4 +
 drivers/scsi/lpfc/lpfc_init.c      |  202 ++++---
 drivers/scsi/lpfc/lpfc_mbox.c      |    7 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c |    8 +-
 drivers/scsi/lpfc/lpfc_nvme.c      |  157 +++--
 drivers/scsi/lpfc/lpfc_nvme.h      |   11 +-
 drivers/scsi/lpfc/lpfc_nvmet.c     |  377 +++++++++---
 drivers/scsi/lpfc/lpfc_nvmet.h     |   14 +-
 drivers/scsi/lpfc/lpfc_sli.c       |   22 +-
 drivers/scsi/lpfc/lpfc_sli4.h      |    2 +-
 drivers/scsi/lpfc/lpfc_version.h   |    2 +-
 drivers/scsi/lpfc/lpfc_vport.c     |    3 +-
 28 files changed, 1654 insertions(+), 763 deletions(-)

-- 
Jens Axboe
