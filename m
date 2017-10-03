Return-Path: <oleksandr@natalenko.name>
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 0/8] block, scsi, md: Improve suspend and resume
Date: Tue, 03 Oct 2017 18:01:47 +0200
Message-ID: <3522439.rgiXQBbUub@natalenko.name>
In-Reply-To: <20171002225218.18548-1-bart.vanassche@wdc.com>
References: <20171002225218.18548-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hello.

I can confirm that this patchset applied on top of v4.14-rc3 also (like Min=
g's=20
one) fixes the issue with suspend/resume+RAID10, reported by me previously.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

On =C3=BAter=C3=BD 3. =C5=99=C3=ADjna 2017 0:52:10 CEST Bart Van Assche wro=
te:
> Hello Jens,
>=20
> It is known that during the resume following a hibernate, especially when
> using an md RAID1 array created on top of SCSI devices, sometimes the
> system hangs instead of coming up properly. This patch series fixes this
> problem. This patch series is an alternative for Ming Lei's "block/scsi:
> safe SCSI quiescing" patch series. The advantages of this patch series are
> that a fix for the md driver is included, that no third argument has been
> added to blk_get_request() and that there is no race between
> blk_get_request() and SCSI quiescing.
>=20
> These patches have been tested on top of a merge of the block layer
> for-next branch and Linus' master tree. Linus' master tree includes
> patch "KVM: x86: Fix the NULL pointer parameter in check_cr_write()"
> but the block layer for-next branch not yet.
>=20
> Please consider these changes for kernel v4.15.
>=20
> Thanks,
>=20
> Bart.
>=20
> Changes between v4 and v5:
> - Split blk_set_preempt_only() into two functions as requested by Christo=
ph.
> - Made blk_get_request() trigger WARN_ONCE() if it is attempted to alloca=
te
> a request while the system is frozen. This is a big help to identify
> drivers that submit I/O while the system is frozen.
> - Since kernel thread freezing is on its way out, reworked the approach f=
or
>   avoiding that the md driver submits I/O while the system is frozen such
> that the approach no longer depends on the kernel thread freeze mechanism.
> - Fixed the (theoretical) deadlock in scsi_device_quiesce() that was
> identified by Ming.
>=20
> Changes between v3 and v4:
> - Made sure that this patch series not only works for scsi-mq but also for
>   the legacy SCSI stack.
> - Removed an smp_rmb()/smp_wmb() pair from the hot path and added a comme=
nt
>   that explains why that is safe.
> - Reordered the patches in this patch series.
>=20
> Changes between v2 and v3:
> - Made md kernel threads freezable.
> - Changed the approach for quiescing SCSI devices again.
> - Addressed Ming's review comments.
>=20
> Changes compared to v1 of this patch series:
> - Changed the approach and rewrote the patch series.
>=20
> Bart Van Assche (7):
>   md: Introduce md_stop_all_writes()
>   md: Neither resync nor reshape while the system is frozen
>   block: Convert RQF_PREEMPT into REQ_PREEMPT
>   block: Add the QUEUE_FLAG_PREEMPT_ONLY request queue flag
>   scsi: Reduce suspend latency
>   scsi: Set QUEUE_FLAG_PREEMPT_ONLY while quiesced
>   block: Make SCSI device suspend and resume work reliably
>=20
> Ming Lei (1):
>   block: Make q_usage_counter also track legacy requests
>=20
>  block/blk-core.c          | 67
> ++++++++++++++++++++++++++++++++++++++++++----- block/blk-mq-debugfs.c   =
 |
>  2 +-
>  block/blk-mq.c            | 14 +++-------
>  block/blk-timeout.c       |  2 +-
>  drivers/ide/ide-atapi.c   |  3 +--
>  drivers/ide/ide-io.c      |  2 +-
>  drivers/ide/ide-pm.c      |  4 +--
>  drivers/md/md.c           | 52 +++++++++++++++++++++++++++++++-----
>  drivers/scsi/scsi_lib.c   | 43 ++++++++++++++++++++----------
>  fs/block_dev.c            |  4 +--
>  include/linux/blk_types.h |  6 +++++
>  include/linux/blkdev.h    | 11 +++++---
>  12 files changed, 160 insertions(+), 50 deletions(-)
