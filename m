Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35619 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdDEFFf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 01:05:35 -0400
MIME-Version: 1.0
In-Reply-To: <87wpazh3rl.fsf@notabene.neil.brown.name>
References: <871staffus.fsf@notabene.neil.brown.name> <87wpazh3rl.fsf@notabene.neil.brown.name>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 5 Apr 2017 13:05:33 +0800
Message-ID: <CACVXFVPLoKM3-eY7MHx7o1fcmsvc84xMxY+Ns9QO3POd9+NP8Q@mail.gmail.com>
Subject: Re: [PATCH v2] loop: Add PF_LESS_THROTTLE to block/loop device thread.
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 5, 2017 at 12:33 PM, NeilBrown <neilb@suse.com> wrote:
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
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

> ---
>
> I moved where the flag is set, thanks to suggestion from
> Ming Lei.
> I've preserved the *-by: tags I was offered despite the code
> being different, as the concept is identical.
>
> Thanks,
> NeilBrown
>
>
>  drivers/block/loop.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 0ecb6461ed81..44b3506fd086 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -852,6 +852,7 @@ static int loop_prepare_queue(struct loop_device *lo)
>         if (IS_ERR(lo->worker_task))
>                 return -ENOMEM;
>         set_user_nice(lo->worker_task, MIN_NICE);
> +       lo->worker_task->flags |= PF_LESS_THROTTLE;
>         return 0;
>  }
>
> --
> 2.12.2
>
