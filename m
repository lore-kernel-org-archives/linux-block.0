Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753163AbdDDLXK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Apr 2017 07:23:10 -0400
Date: Tue, 4 Apr 2017 13:23:07 +0200
From: Michal Hocko <mhocko@kernel.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop: Add PF_LESS_THROTTLE to block/loop device thread.
Message-ID: <20170404112307.GA15490@dhcp22.suse.cz>
References: <871staffus.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871staffus.fsf@notabene.neil.brown.name>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon 03-04-17 11:18:51, NeilBrown wrote:
> 
> When a filesystem is mounted from a loop device, writes are
> throttled by balance_dirty_pages() twice: once when writing
> to the filesystem and once when the loop_handle_cmd() writes
> to the backing file.  This double-throttling can trigger
> positive feedback loops that create significant delays.  The
> throttling at the lower level is seen by the upper level as
> a slow device, so it throttles extra hard.
> 
> The PF_LESS_THROTTLE flag was created to handle exactly this
> circumstance, though with an NFS filesystem mounted from a
> local NFS server.  It reduces the throttling on the lower
> layer so that it can proceed largely unthrottled.
> 
> To demonstrate this, create a filesystem on a loop device
> and write (e.g. with dd) several large files which combine
> to consume significantly more than the limit set by
> /proc/sys/vm/dirty_ratio or dirty_bytes.  Measure the total
> time taken.
> 
> When I do this directly on a device (no loop device) the
> total time for several runs (mkfs, mount, write 200 files,
> umount) is fairly stable: 28-35 seconds.
> When I do this over a loop device the times are much worse
> and less stable.  52-460 seconds.  Half below 100seconds,
> half above.
> When I apply this patch, the times become stable again,
> though not as fast as the no-loop-back case: 53-72 seconds.
> 
> There may be room for further improvement as the total overhead still
> seems too high, but this is a big improvement.

Yes this makes sense to me

> Signed-off-by: NeilBrown <neilb@suse.com>

Acked-by: Michal Hocko <mhocko@suse.com>

one nit below

> ---
>  drivers/block/loop.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 0ecb6461ed81..a7e1dd215fc2 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1694,8 +1694,11 @@ static void loop_queue_work(struct kthread_work *work)
>  {
>  	struct loop_cmd *cmd =
>  		container_of(work, struct loop_cmd, work);
> +	int oldflags = current->flags & PF_LESS_THROTTLE;
>  
> +	current->flags |= PF_LESS_THROTTLE;
>  	loop_handle_cmd(cmd);
> +	current->flags = (current->flags & ~PF_LESS_THROTTLE) | oldflags;

we have a helper for this tsk_restore_flags(). It is not used
consistently and maybe we want a dedicated api like we have for the
scope NOIO/NOFS but that is a separate thing. I would find
tsk_restore_flags easier to read.

-- 
Michal Hocko
SUSE Labs
