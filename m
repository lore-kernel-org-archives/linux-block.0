Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] blkcg: not hold blkcg lock when deactivating policy.
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1523949033-91148-1-git-send-email-jiang.biao2@zte.com.cn>
Date: Tue, 17 Apr 2018 14:32:39 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tejun Heo <tj@kernel.org>,
 zhong.weidong@zte.com.cn,
 wen.yang99@zte.com.cn,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <661CB1A2-5BAC-439D-BCE2-64F9A0CD280E@linaro.org>
References: <1523949033-91148-1-git-send-email-jiang.biao2@zte.com.cn>
To: Jiang Biao <jiang.biao2@zte.com.cn>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 17 apr 2018, alle ore 09:10, Jiang Biao =
<jiang.biao2@zte.com.cn> ha scritto:
>=20
> As described in the comment of blkcg_activate_policy(),
> *Update of each blkg is protected by both queue and blkcg locks so
> that holding either lock and testing blkcg_policy_enabled() is
> always enough for dereferencing policy data.*
> with queue lock held, there is no need to hold blkcg lock in
> blkcg_deactivate_policy(). Similar case is in
> blkcg_activate_policy(), which has removed holding of blkcg lock in
> commit 4c55f4f9ad3001ac1fefdd8d8ca7641d18558e23.
>=20

Hi,
by chance, did you check whether this may cause problems with bfq,
being the latter not protected by the queue lock as cfq?

Thanks,
Paolo

> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Tejun Heo <tj@kernel.org>
> CC: Jens Axboe <axboe@kernel.dk>
> ---
> block/blk-cgroup.c | 5 -----
> 1 file changed, 5 deletions(-)
>=20
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index c2033a2..2b7f8d0 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1367,17 +1367,12 @@ void blkcg_deactivate_policy(struct =
request_queue *q,
> 	__clear_bit(pol->plid, q->blkcg_pols);
>=20
> 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
> -		/* grab blkcg lock too while removing @pd from @blkg */
> -		spin_lock(&blkg->blkcg->lock);
> -
> 		if (blkg->pd[pol->plid]) {
> 			if (pol->pd_offline_fn)
> 				pol->pd_offline_fn(blkg->pd[pol->plid]);
> 			pol->pd_free_fn(blkg->pd[pol->plid]);
> 			blkg->pd[pol->plid] =3D NULL;
> 		}
> -
> -		spin_unlock(&blkg->blkcg->lock);
> 	}
>=20
> 	spin_unlock_irq(q->queue_lock);
> --=20
> 2.7.4
>=20
