Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] block, bfq: dispatch request to prevent queue stalling after the request completion
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1499781495-44090-1-git-send-email-houtao1@huawei.com>
Date: Wed, 12 Jul 2017 11:41:12 +0200
Cc: linux-block@vger.kernel.org,
 axboe@kernel.dk
Message-Id: <3F836EDA-18EA-4678-BA06-21F1AA073E29@linaro.org>
References: <1499781495-44090-1-git-send-email-houtao1@huawei.com>
To: Hou Tao <houtao1@huawei.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 11 lug 2017, alle ore 15:58, Hou Tao <houtao1@huawei.com> ha =
scritto:
>=20
> There are mq devices (eg., virtio-blk, nbd and loopback) which don't
> invoke blk_mq_run_hw_queues() after the completion of a request.
> If bfq is enabled on these devices and the slice_idle attribute or
> strict_guarantees attribute is set as zero,

I guess you meant slice_idle > 0 or strict_guarantees equal to 1 here.

> it is possible that
> after a request completion the remaining requests of busy bfq queue
> will stalled in the bfq schedule until a new request arrives.
>=20
> To fix the scheduler latency problem, we need to check whether or not
> all issued requests have completed and dispatch more requests to =
driver
> if there is no request in driver.
>=20
> Signed-off-by: Hou Tao <houtao1@huawei.com>
>=20

Thanks for this fix.  My only (possible) concern is whether there
would be some more coherent and possibly more efficient solution to
this problem, outside BFQ.  For example, would it make sense to call
blk_mq_run_hw_queues(), after a request completion, from the offended
devices too?  This would make the behavior of these devices coherent
with that of the other devices.  Unfortunately I have no sound answer
to such a question.  Apart from this concern:

Reviewed-by: Paolo Valente <paolo.valente@linaro.org>

> The problem can be reproduced by running the following script
> on a virtio-blk device with nr_hw_queues as 1:
>=20
> #!/bin/sh
>=20
> dev=3Dvdb
> # mount point for dev
> mp=3D/tmp/mnt
> cd $mp
>=20
> job=3Dstrict.job
> cat <<EOF > $job
> [global]
> direct=3D1
> bs=3D4k
> size=3D256M
> rw=3Dwrite
> ioengine=3Dlibaio
> iodepth=3D128
> runtime=3D5
> time_based
>=20
> [1]
> filename=3D1.data
>=20
> [2]
> new_group
> filename=3D2.data
> EOF
>=20
> echo bfq > /sys/block/$dev/queue/scheduler
> echo 1 > /sys/block/$dev/queue/iosched/strict_guarantees
> fio $job
> ---
> block/bfq-iosched.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 12bbc6b..94cd682 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4293,6 +4293,9 @@ static void bfq_completed_request(struct =
bfq_queue *bfqq, struct bfq_data *bfqd)
> 			bfq_bfqq_expire(bfqd, bfqq, false,
> 					BFQQE_NO_MORE_REQUESTS);
> 	}
> +
> +	if (!bfqd->rq_in_driver)
> +		bfq_schedule_dispatch(bfqd);
> }
>=20
> static void bfq_put_rq_priv_body(struct bfq_queue *bfqq)
> --=20
> 2.5.0
>=20
