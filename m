Return-Path: <roman.penyaev@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <1453803006-12812-1-git-send-email-roman.penyaev@profitbricks.com>
References: <1453803006-12812-1-git-send-email-roman.penyaev@profitbricks.com>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Mon, 1 Feb 2016 17:29:37 +0100
Message-ID: <CAJrWOzBYNBzGuStrqjzLirUxhC1K02PE9kPdY+GuJF6ynRBZgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: fix race between opening blkext device and
 freeing it
Cc: Roman Pen <roman.penyaev@profitbricks.com>, Keith Busch <keith.busch@intel.com>,
	stable@kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hello, Jens.

Could you please take a look at this patch.
This issue happens quite often on our servers, when udevd
tries to get detailed info about md raid starting mdadm,
but this raid device is already in closing state and is
about to free internal structures, afterwards an oops
happens and mdadm gets killed.

--
Roman


On Tue, Jan 26, 2016 at 11:10 AM, Roman Pen
<roman.penyaev@profitbricks.com> wrote:
> There is a race introduced by the commit 2da78092dda13f1e, which causes
> oops with the following stack and preceding warning:
>
> WARNING: CPU: 2 PID: 28311 at include/linux/kref.h:47 kobject_get+0x42/0x50()
> Call Trace:
>  [<ffffffff815c8ea4>] dump_stack+0x46/0x58
>  [<ffffffff81050e6c>] warn_slowpath_common+0x8c/0xc0
>  [<ffffffff81050eba>] warn_slowpath_null+0x1a/0x20
>  [<ffffffff81307392>] kobject_get+0x42/0x50
>  [<ffffffff812ef415>] get_disk+0x45/0x80
>  [<ffffffff812ef959>] get_gendisk+0xb9/0x140
>  [<ffffffff811bd880>] __blkdev_get+0x140/0x4a0
>  [<ffffffff811bdd75>] blkdev_get+0x195/0x2e0
>  [<ffffffff811bdf1f>] blkdev_open+0x5f/0x90
>  [<ffffffff81184752>] do_dentry_open.isra.14+0xf2/0x310
>  [<ffffffff81185d12>] vfs_open+0x52/0x60
>  [<ffffffff811932f4>] do_last.isra.62+0x1f4/0xce0
>  [<ffffffff8119513e>] path_openat+0xbe/0x600
>  [<ffffffff81196d23>] do_filp_open+0x43/0xa0
>  [<ffffffff811860ac>] do_sys_open+0x13c/0x230
>  [<ffffffff811861c2>] SyS_open+0x22/0x30
>  [<ffffffff815d0409>] system_call_fastpath+0x12/0x17
>
> and immediately oops on attempt to dereference disk->part_tbl inside
> disk_get_part():
>
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> IP: [<ffffffff812ef7ed>] disk_get_part+0xd/0x50
> Call Trace:
>  [<ffffffff811bd9d5>] __blkdev_get+0x295/0x4a0
>  [<ffffffff811bdd75>] blkdev_get+0x195/0x2e0
>  [<ffffffff811bdf1f>] blkdev_open+0x5f/0x90
>  [<ffffffff81184752>] do_dentry_open.isra.14+0xf2/0x310
>  [<ffffffff81185d12>] vfs_open+0x52/0x60
>  [<ffffffff811932f4>] do_last.isra.62+0x1f4/0xce0
>  [<ffffffff8119513e>] path_openat+0xbe/0x600
>  [<ffffffff81196d23>] do_filp_open+0x43/0xa0
>  [<ffffffff811860ac>] do_sys_open+0x13c/0x230
>  [<ffffffff811861c2>] SyS_open+0x22/0x30
>  [<ffffffff815d0409>] system_call_fastpath+0x12/0x17
>
> The problem is obvious: the partition removal in commit 2da78092dda13f1e was
> moved just before final kobject free, when all references are already put,
> thus breaking atomic idr_find(),kobject_get() sequence.
>
> This patch replaces partition pointer on NULL before putting the reference
> on a kobject, but keeping the devt number still occupied till the last free.
>
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: stable@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  block/genhd.c             | 25 ++++++++++++++++++++++---
>  block/partition-generic.c |  1 +
>  include/linux/genhd.h     |  1 +
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/block/genhd.c b/block/genhd.c
> index eb05dfc..fe33efb 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -441,9 +441,6 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
>   * @devt: dev_t to free
>   *
>   * Free @devt which was allocated using blk_alloc_devt().
> - *
> - * CONTEXT:
> - * Might sleep.
>   */
>  void blk_free_devt(dev_t devt)
>  {
> @@ -457,6 +454,27 @@ void blk_free_devt(dev_t devt)
>         }
>  }
>
> +/**
> + * blk_disable_devt - keep a dev_t in an array, but replace corresponding
> + *                    partition pointer with NULL.  We need that to avoid
> + *                    allocation of the same dev_t, but still to indicate
> + *                    that partition is not available any more.
> + * @devt: dev_t to disable
> + *
> + * Disable @devt which was allocated using blk_alloc_devt().
> + */
> +void blk_disable_devt(dev_t devt)
> +{
> +       if (devt == MKDEV(0, 0))
> +               return;
> +
> +       if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
> +               spin_lock(&ext_devt_lock);
> +               idr_replace(&ext_devt_idr, NULL, blk_mangle_minor(MINOR(devt)));
> +               spin_unlock(&ext_devt_lock);
> +       }
> +}
> +
>  static char *bdevt_str(dev_t devt, char *buf)
>  {
>         if (MAJOR(devt) <= 0xff && MINOR(devt) <= 0xff) {
> @@ -669,6 +687,7 @@ void del_gendisk(struct gendisk *disk)
>                 sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
>         pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
>         device_del(disk_to_dev(disk));
> +       blk_disable_devt(disk_to_dev(disk)->devt);
>  }
>  EXPORT_SYMBOL(del_gendisk);
>
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 746935a..8eceda0 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -254,6 +254,7 @@ void delete_partition(struct gendisk *disk, int partno)
>         rcu_assign_pointer(ptbl->last_lookup, NULL);
>         kobject_put(part->holder_dir);
>         device_del(part_to_dev(part));
> +       blk_disable_devt(part_devt(part));
>
>         hd_struct_kill(part);
>  }
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 5c70676..9e4e547 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -615,6 +615,7 @@ struct unixware_disklabel {
>
>  extern int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
>  extern void blk_free_devt(dev_t devt);
> +extern void blk_disable_devt(dev_t devt);
>  extern dev_t blk_lookup_devt(const char *name, int partno);
>  extern char *disk_name (struct gendisk *hd, int partno, char *buf);
>
> --
> 2.6.2
>
