Return-Path: <tahsin@google.com>
MIME-Version: 1.0
In-Reply-To: <20170301234319.29584-1-tahsin@google.com>
References: <20170301165501.GB3662@htj.duckdns.org> <20170301234319.29584-1-tahsin@google.com>
From: Tahsin Erdogan <tahsin@google.com>
Date: Wed, 1 Mar 2017 15:49:53 -0800
Message-ID: <CAAeU0aOp=VR50ZaSdt7Vqy=UObj3deb+Cb+rUG-x6y+aM-QuxA@mail.gmail.com>
Subject: Re: [PATCH v2] blkcg: allocate struct blkcg_gq outside request queue spinlock
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, David Rientjes <rientjes@google.com>,
	linux-kernel@vger.kernel.org, Tahsin Erdogan <tahsin@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi Tejun,
>
> Ah, indeed, but we can break out allocation of blkg and its
> initialization, right?  It's a bit more work but then we'd be able to
> do something like.
>
>
> retry:
>         new_blkg = alloc;
>         lock;
>         sanity checks;
>         blkg = blkg_lookup_and_create(..., new_blkg);
>         if (!blkg) {
>                 unlock;
>                 goto retry;
>         }
I tried doing it based on the sample above but I wasn't happy with the
result. The amount of code grew too big. I sent a simplified version
that does blkg allocation within blkg_lookup_create(). I think this
version is simpler, let me know what you think.


On Wed, Mar 1, 2017 at 3:43 PM, Tahsin Erdogan <tahsin@google.com> wrote:
> blkg_conf_prep() currently calls blkg_lookup_create() while holding
> request queue spinlock. This means allocating memory for struct
> blkcg_gq has to be made non-blocking. This causes occasional -ENOMEM
> failures in call paths like below:
>
>   pcpu_alloc+0x68f/0x710
>   __alloc_percpu_gfp+0xd/0x10
>   __percpu_counter_init+0x55/0xc0
>   cfq_pd_alloc+0x3b2/0x4e0
>   blkg_alloc+0x187/0x230
>   blkg_create+0x489/0x670
>   blkg_lookup_create+0x9a/0x230
>   blkg_conf_prep+0x1fb/0x240
>   __cfqg_set_weight_device.isra.105+0x5c/0x180
>   cfq_set_weight_on_dfl+0x69/0xc0
>   cgroup_file_write+0x39/0x1c0
>   kernfs_fop_write+0x13f/0x1d0
>   __vfs_write+0x23/0x120
>   vfs_write+0xc2/0x1f0
>   SyS_write+0x44/0xb0
>   entry_SYSCALL_64_fastpath+0x18/0xad
>
> In the code path above, percpu allocator cannot call vmalloc() due to
> queue spinlock.
>
> A failure in this call path gives grief to tools which are trying to
> configure io weights. We see occasional failures happen shortly after
> reboots even when system is not under any memory pressure. Machines
> with a lot of cpus are more vulnerable to this condition.
>
> Add a flag to blkg_lookup_create() to indicate whether releasing locks
> for memory allocation purposes is okay.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Tahsin Erdogan <tahsin@google.com>
> ---
> v2:
>   Moved blkg creation into blkg_lookup_create() to avoid duplicating
>   blkg_lookup_create() logic.
>
>  block/blk-cgroup.c         | 51 +++++++++++++++++++++++++++++++++++++++-------
>  include/linux/blk-cgroup.h |  4 ++--
>  2 files changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 295e98c2c8cc..afb16e998bf3 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -258,18 +258,22 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>   * blkg_lookup_create - lookup blkg, try to create one if not there
>   * @blkcg: blkcg of interest
>   * @q: request_queue of interest
> + * @wait_ok: whether blocking for memory allocations is okay
>   *
>   * Lookup blkg for the @blkcg - @q pair.  If it doesn't exist, try to
>   * create one.  blkg creation is performed recursively from blkcg_root such
>   * that all non-root blkg's have access to the parent blkg.  This function
>   * should be called under RCU read lock and @q->queue_lock.
>   *
> + * When @wait_ok is true, rcu and queue locks may be dropped for allocating
> + * memory. In this case, the locks will be reacquired on return.
> + *
>   * Returns pointer to the looked up or created blkg on success, ERR_PTR()
>   * value on error.  If @q is dead, returns ERR_PTR(-EINVAL).  If @q is not
>   * dead and bypassing, returns ERR_PTR(-EBUSY).
>   */
>  struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
> -                                   struct request_queue *q)
> +                                   struct request_queue *q, bool wait_ok)
>  {
>         struct blkcg_gq *blkg;
>
> @@ -300,7 +304,30 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
>                         parent = blkcg_parent(parent);
>                 }
>
> -               blkg = blkg_create(pos, q, NULL);
> +               if (wait_ok) {
> +                       struct blkcg_gq *new_blkg;
> +
> +                       spin_unlock_irq(q->queue_lock);
> +                       rcu_read_unlock();
> +
> +                       new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
> +
> +                       rcu_read_lock();
> +                       spin_lock_irq(q->queue_lock);
> +
> +                       if (unlikely(!new_blkg))
> +                               return ERR_PTR(-ENOMEM);
> +
> +                       if (unlikely(blk_queue_bypass(q))) {
> +                               blkg_free(new_blkg);
> +                               return ERR_PTR(blk_queue_dying(q) ?
> +                                                       -ENODEV : -EBUSY);
> +                       }
> +
> +                       blkg = blkg_create(pos, q, new_blkg);
> +               } else
> +                       blkg = blkg_create(pos, q, NULL);
> +
>                 if (pos == blkcg || IS_ERR(blkg))
>                         return blkg;
>         }
> @@ -789,6 +816,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  {
>         struct gendisk *disk;
>         struct blkcg_gq *blkg;
> +       struct request_queue *q;
>         struct module *owner;
>         unsigned int major, minor;
>         int key_len, part, ret;
> @@ -812,18 +840,27 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>                 return -ENODEV;
>         }
>
> +       q = disk->queue;
> +
>         rcu_read_lock();
> -       spin_lock_irq(disk->queue->queue_lock);
> +       spin_lock_irq(q->queue_lock);
>
> -       if (blkcg_policy_enabled(disk->queue, pol))
> -               blkg = blkg_lookup_create(blkcg, disk->queue);
> -       else
> +       if (blkcg_policy_enabled(q, pol)) {
> +               blkg = blkg_lookup_create(blkcg, q, true /* wait_ok */);
> +
> +               /*
> +                * blkg_lookup_create() may have dropped and reacquired the
> +                * queue lock. Check policy enabled state again.
> +                */
> +               if (!IS_ERR(blkg) && unlikely(!blkcg_policy_enabled(q, pol)))
> +                       blkg = ERR_PTR(-EOPNOTSUPP);
> +       } else
>                 blkg = ERR_PTR(-EOPNOTSUPP);
>
>         if (IS_ERR(blkg)) {
>                 ret = PTR_ERR(blkg);
>                 rcu_read_unlock();
> -               spin_unlock_irq(disk->queue->queue_lock);
> +               spin_unlock_irq(q->queue_lock);
>                 owner = disk->fops->owner;
>                 put_disk(disk);
>                 module_put(owner);
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index 01b62e7bac74..78067dd59c91 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -172,7 +172,7 @@ extern struct cgroup_subsys_state * const blkcg_root_css;
>  struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
>                                       struct request_queue *q, bool update_hint);
>  struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
> -                                   struct request_queue *q);
> +                                   struct request_queue *q, bool wait_ok);
>  int blkcg_init_queue(struct request_queue *q);
>  void blkcg_drain_queue(struct request_queue *q);
>  void blkcg_exit_queue(struct request_queue *q);
> @@ -694,7 +694,7 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
>         blkg = blkg_lookup(blkcg, q);
>         if (unlikely(!blkg)) {
>                 spin_lock_irq(q->queue_lock);
> -               blkg = blkg_lookup_create(blkcg, q);
> +               blkg = blkg_lookup_create(blkcg, q, false /* wait_ok */);
>                 if (IS_ERR(blkg))
>                         blkg = NULL;
>                 spin_unlock_irq(q->queue_lock);
> --
> 2.12.0.rc1.440.g5b76565f74-goog
>
