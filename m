Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 16 Jun 2017 18:11:18 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] NVMe updates for Linux 4.13
Message-ID: <20170616161118.a3h2vc5inincfrmq@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

here is a large chunk of NVMe updates for 4.13.  I don't think we
are quite done for this merge window yet, but I'd like to get
this large batch into your tree and linux-next.

Highlights:

 - UUID identifier support from Johannes
 - Lots of cleanups from Sagi
 - Host Memory Buffer support from me

And lots of cleanups and smaller fixes of course.

Note that the UUID identifier changes are based on top of the uuid tree.
I am the maintainer of that tree and will send it to Linus as soon as
4.12 is released as various other trees depend on it as well (and the
diffstat includes those changes unfortunately)


The following changes since commit f06345add95f388519e83ec398134853e0f64ac9:

  blk-mq: fixup type of 'ret' in __blk_mq_try_issue_directly() (2017-06-12 11:22:46 -0600)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.13

for you to fetch changes up to 6b8190d61a622e095f04451437953acd2d74b371:

  nvme: implement NS Optimal IO Boundary from 1.3 Spec (2017-06-16 08:25:54 +0200)

----------------------------------------------------------------
Amir Goldstein (4):
      xfs: use uuid_copy() helper to abstract uuid_t
      md: namespace private helper names
      xfs: use the common helper uuid_is_null()
      tmpfs: generate random sb->s_uuid

Andy Shevchenko (6):
      acpi, nfit: Switch to use new generic UUID API
      ACPI / APEI: Switch to use new generic UUID API
      ACPI / bus: Switch to use new generic UUID API
      ACPI / extlog: Switch to use new generic UUID API
      ACPI: Switch to use generic guid_t in acpi_evaluate_dsm()
      thermal: int340x_thermal: Switch to use new generic UUID API

Arnav Dawn (1):
      nvme.h: add dword 12 - 15 fields to struct nvme_features

Bart Van Assche (1):
      nvmet-fc: Remove a set-but-not-used variable

Christoph Hellwig (33):
      uuid,afs: move struct uuid_v1 back into afs
      xfs: use uuid_be to implement the uuid_t type
      nfsd: namespace-prefix uuid_parse
      uuid: remove uuid_be defintions from the uapi header
      uuid: rename uuid types
      uuid: don't export guid_index and uuid_index
      uuid: hoist helpers uuid_equal() and uuid_copy() from xfs
      uuid: hoist uuid_is_null() helper from libnvdimm
      S390/sysinfo: use uuid_is_null instead of opencoding it
      xfs: remove uuid_getnodeuniq and xfs_uu_t
      block: remove blk_part_pack_uuid
      ima/policy: switch to use uuid_t
      fs: switch ->s_uuid to uuid_t
      overlayfs: use uuid_t instead of uuid_be
      partitions/ldm: switch to use uuid_t
      sysctl: switch to use uuid_t
      nvme: switch to uuid_t
      scsi_debug: switch to uuid_t
      MAINTAINERS: add uuid entry
      acpi: always include uuid.h
      thermal: int340x_thermal: fix compile after the UUID API switch
      Merge branch 'uuid-types' of bombadil.infradead.org:public_git/uuid into nvme-base
      nvme.h: add struct nvme_host_mem_buf_desc and HMB flags
      nvme: save hmpre and hmmin in struct nvme_ctrl
      nvme-pci: implement host memory buffer support
      nvme: mark shutdown_timeout static
      nvme: move protection information check into nvme_setup_rw
      nvme-rdma: merge init_request and exit_request methods
      nvme-fc: merge init_request methods
      nvme-loop: merge init_request methods
      nvme-pci: merge init_request methods
      nvme: move reset workqueue handling to common code
      nvme: no need to wait for the reset when keepalive fails

Dan Carpenter (1):
      nvme-rdma: fix error code in nvme_rdma_create_ctrl()

Guan Junxiong (2):
      nvme: add fields into identify controller data structure
      nvmf: keep track of nvmet connect error status

Johannes Thumshirn (10):
      scatterlist: add sg_zero_buffer() helper
      nvmet: use NVME_IDENTIFY_DATA_SIZE
      nvme: introduce NVMe Namespace Identification Descriptor structures
      nvme: rename uuid to nguid in nvme_ns
      nvme: get list of namespace descriptors
      nvme: provide UUID value to userspace
      nvmet: implement namespace identify descriptor list
      nvmet: add uuid field to nvme_ns and populate via configfs
      nvmet: allow overriding the NVMe VS via configfs
      nvme: use ctrl->device consistently for logging

Keith Busch (1):
      nvme-pci: Remove watchdog timer

Sagi Grimberg (13):
      nvme-loop: get rid of unused controller lock
      nvme-rdma: get rid of unused ctrl lock
      nvme-rdma: Make queue flags bit numbers and not shifts
      nvme-rdma: Don't rearm the CQ when polling directly
      nvme-rdma: make nvme_rdma_[create|destroy]_queue_ib symmetrical
      nvme-rdma: rework rdma connection establishment error path
      nvme-rdma: Get rid of CONNECTED state
      nvme: Don't allow to reset a reconnecting controller
      nvme: Move transports to use nvme-core workqueue
      nvme: queue ns scanning and async request from nvme_wq
      nvme: move nr_reconnects to nvme_ctrl
      nvme-pci: remove redundant includes
      nvme: don't hard code size of struct t10_pi_tuple

Scott Bauer (1):
      nvme: implement NS Optimal IO Boundary from 1.3 Spec

Xu Yu (1):
      nvme-pci: remap BAR0 to cover admin CQ doorbell for large stride

 MAINTAINERS                                        |  11 +
 arch/s390/include/asm/sysinfo.h                    |   4 +-
 arch/s390/kernel/sysinfo.c                         |   2 +-
 block/partitions/ldm.c                             |  10 +-
 block/partitions/ldm.h                             |   6 +-
 drivers/acpi/acpi_extlog.c                         |  20 +-
 drivers/acpi/apei/ghes.c                           |   8 +-
 drivers/acpi/bus.c                                 |  29 +-
 drivers/acpi/nfit/core.c                           |  54 +--
 drivers/acpi/nfit/nfit.h                           |   3 +-
 drivers/acpi/utils.c                               |  16 +-
 drivers/char/tpm/tpm_crb.c                         |   9 +-
 drivers/char/tpm/tpm_ppi.c                         |  20 +-
 drivers/gpu/drm/i915/intel_acpi.c                  |  14 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |  20 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c     |   9 +-
 drivers/hid/i2c-hid/i2c-hid.c                      |   9 +-
 drivers/iommu/dmar.c                               |  11 +-
 drivers/md/md.c                                    |   8 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   9 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |  15 +-
 drivers/nvdimm/btt_devs.c                          |   9 +-
 drivers/nvme/host/core.c                           | 202 +++++++--
 drivers/nvme/host/fabrics.c                        |  28 +-
 drivers/nvme/host/fabrics.h                        |   4 +-
 drivers/nvme/host/fc.c                             |  85 +---
 drivers/nvme/host/lightnvm.c                       |   2 +-
 drivers/nvme/host/nvme.h                           |  16 +-
 drivers/nvme/host/pci.c                            | 474 +++++++++++++--------
 drivers/nvme/host/rdma.c                           | 166 +++-----
 drivers/nvme/target/admin-cmd.c                    |  65 ++-
 drivers/nvme/target/configfs.c                     |  68 +++
 drivers/nvme/target/core.c                         |   3 +-
 drivers/nvme/target/discovery.c                    |   2 +-
 drivers/nvme/target/fcloop.c                       |   2 -
 drivers/nvme/target/loop.c                         |  45 +-
 drivers/nvme/target/nvmet.h                        |   2 +
 drivers/pci/pci-acpi.c                             |  13 +-
 drivers/pci/pci-label.c                            |   4 +-
 drivers/scsi/scsi_debug.c                          |  10 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |   8 +-
 drivers/usb/dwc3/dwc3-pci.c                        |  10 +-
 drivers/usb/host/xhci-pci.c                        |   9 +-
 drivers/usb/misc/ucsi.c                            |   6 +-
 drivers/usb/typec/typec_wcove.c                    |   8 +-
 drivers/xen/tmem.c                                 |   6 +-
 fs/afs/cmservice.c                                 |  16 +-
 fs/afs/internal.h                                  |  11 +-
 fs/afs/main.c                                      |   2 +-
 fs/ext4/super.c                                    |   2 +-
 fs/f2fs/super.c                                    |   2 +-
 fs/gfs2/ops_fstype.c                               |   2 +-
 fs/gfs2/sys.c                                      |  22 +-
 fs/nfsd/export.c                                   |   4 +-
 fs/ocfs2/super.c                                   |   2 +-
 fs/overlayfs/copy_up.c                             |   7 +-
 fs/overlayfs/namei.c                               |   2 +-
 fs/overlayfs/overlayfs.h                           |   2 +-
 fs/xfs/Makefile                                    |   3 +-
 fs/xfs/uuid.c                                      |  63 ---
 fs/xfs/uuid.h                                      |  35 --
 fs/xfs/xfs_inode_item.c                            |   8 +-
 fs/xfs/xfs_linux.h                                 |   2 +-
 fs/xfs/xfs_log_recover.c                           |   6 +-
 fs/xfs/xfs_mount.c                                 |  16 +-
 include/acpi/acpi_bus.h                            |  11 +-
 include/linux/acpi.h                               |   4 +-
 include/linux/cleancache.h                         |   2 +-
 include/linux/fs.h                                 |   5 +-
 include/linux/genhd.h                              |  11 -
 include/linux/nvme-fc.h                            |   3 +-
 include/linux/nvme.h                               |  55 ++-
 include/linux/pci-acpi.h                           |   2 +-
 include/linux/scatterlist.h                        |   2 +
 include/linux/uuid.h                               |  99 +++--
 include/uapi/linux/uuid.h                          |  28 +-
 kernel/sysctl_binary.c                             |   4 +-
 lib/scatterlist.c                                  |  35 ++
 lib/test_uuid.c                                    |  36 +-
 lib/uuid.c                                         |  33 +-
 lib/vsprintf.c                                     |   4 +-
 mm/cleancache.c                                    |   2 +-
 mm/shmem.c                                         |   2 +
 security/integrity/evm/evm_crypto.c                |   2 +-
 security/integrity/ima/ima_policy.c                |  12 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |   7 +-
 tools/testing/nvdimm/test/iomap.c                  |   6 +-
 tools/testing/nvdimm/test/nfit.c                   |   2 +-
 tools/testing/nvdimm/test/nfit_test.h              |   4 +-
 89 files changed, 1176 insertions(+), 936 deletions(-)
 delete mode 100644 fs/xfs/uuid.c
 delete mode 100644 fs/xfs/uuid.h
