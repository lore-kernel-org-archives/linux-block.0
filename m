Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"longli@exchange.microsoft.com" <longli@exchange.microsoft.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "sthemmin@microsoft.com" <sthemmin@microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>
Subject: Re: [PATCH] block-mq: set both block queue and hardware queue restart
 bit for restart
Date: Thu, 6 Apr 2017 00:32:16 +0000
Message-ID: <1491438735.2787.18.camel@sandisk.com>
References: <1491437781-3565-1-git-send-email-longli@exchange.microsoft.com>
In-Reply-To: <1491437781-3565-1-git-send-email-longli@exchange.microsoft.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-04-05 at 17:16 -0700, Long Li wrote:
> Under heavy I/O, one hardware queue may be unable to dispatch any I/O to =
the=20
> device layer. This poses a problem with restarting this hardware queue on=
 I/O
> finish in blk_mq_sched_restart_queues(), becaue there is nothing pending =
that
> will finish in future on this hardware qeueu. This will result in deadloc=
k.
>=20
> With this patch, we check for all possible stalled hardware queues when I=
/O
> finishes on any hardware queues. This prevents this deadlock.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  block/blk-mq-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 09af8ff..f7f3d44 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -202,7 +202,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_=
ctx *hctx)
>  	 * needing a restart in that case.
>  	 */
>  	if (!list_empty(&rq_list)) {
> -		blk_mq_sched_mark_restart_hctx(hctx);
> +		blk_mq_sched_mark_restart_queue(hctx);
>  		did_work =3D blk_mq_dispatch_rq_list(hctx, &rq_list);
>  	} else if (!has_sched_dispatch) {
>  		blk_mq_flush_busy_ctxs(hctx, &rq_list);

Please drop this patch. I'm working on a better solution.

Thanks,

Bart.=
