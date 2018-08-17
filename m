Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] cfq: clear queue pointers from cfqg after unpinning them
 in cfq_pd_offline
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <ba086112-65b1-c20f-0694-35d1ca0415d9@maciej.szmigiero.name>
Date: Fri, 17 Aug 2018 19:30:11 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Tejun Heo <tj@kernel.org>,
 jiufei.xue@linux.alibaba.com,
 Caspar Zhang <caspar@linux.alibaba.com>
Message-Id: <4FF39F18-108B-43BD-85A2-A09DB7755865@linaro.org>
References: <ba086112-65b1-c20f-0694-35d1ca0415d9@maciej.szmigiero.name>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 17 ago 2018, alle ore 19:28, Maciej S. Szmigiero =
<mail@maciej.szmigiero.name> ha scritto:
>=20
> The current linux-block, 4.18 and 4.17 can reliably be crashed within =
few
> minutes by running the following bash snippet:
>=20
> mkfs.ext4 -v /dev/sda3 && mount /dev/sda3 /mnt/test/ -t ext4;
> while true; do
> 	mkdir /sys/fs/cgroup/unified/test/;
> 	echo $$ >/sys/fs/cgroup/unified/test/cgroup.procs;
> 	dd if=3D/dev/zero of=3D/mnt/test/test-$(( RANDOM * 10 / 32768 )) =
bs=3D1M count=3D1024 &
> 	echo $$ >/sys/fs/cgroup/unified/cgroup.procs;
> 	sleep 1;
> 	kill -KILL $!; wait $!;
> 	rmdir /sys/fs/cgroup/unified/test;
> done
>=20
> # cat /sys/block/sda/queue/scheduler
> noop [cfq]
> # cat /sys/block/sda/queue/rotational
> 1
> # cat /sys/fs/cgroup/unified/cgroup.subtree_control
> cpu io memory pids
>=20
> The backtraces vary but often they are NULL pointer dereferences due =
to
> various cfqq fields being NULL.
> Or BUG_ON(cfqq->ref <=3D 0) in cfq_put_queue() triggers due to cfqq =
reference
> count being zero.
>=20
> Bisection points at
> commit 4c6994806f70 ("blk-throttle: fix race between =
blkcg_bio_issue_check() and cgroup_rmdir()").
> The prime suspect looked like .pd_offline_fn() method being called =
multiple
> times, but from analyzing the mentioned commit this didn't seem =
possible
> and runtime trials have confirmed that.
>=20
> However, CFQ's cfq_pd_offline() implementation of the above method =
were
> leaving queue pointers intact in cfqg after unpinning them.
> After making sure that they are cleared to NULL in this function I can =
no
> longer reproduce the crash.
>=20

By chance, did you check whether is BFQ is ok in this respect?

Thanks,
Paolo

> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Fixes: 4c6994806f70 ("blk-throttle: fix race between =
blkcg_bio_issue_check() and cgroup_rmdir()").
> Cc: stable@vger.kernel.org
> ---
> block/cfq-iosched.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index 2eb87444b157..ed41aa978c4a 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -1644,14 +1644,20 @@ static void cfq_pd_offline(struct =
blkg_policy_data *pd)
> 	int i;
>=20
> 	for (i =3D 0; i < IOPRIO_BE_NR; i++) {
> -		if (cfqg->async_cfqq[0][i])
> +		if (cfqg->async_cfqq[0][i]) {
> 			cfq_put_queue(cfqg->async_cfqq[0][i]);
> -		if (cfqg->async_cfqq[1][i])
> +			cfqg->async_cfqq[0][i] =3D NULL;
> +		}
> +		if (cfqg->async_cfqq[1][i]) {
> 			cfq_put_queue(cfqg->async_cfqq[1][i]);
> +			cfqg->async_cfqq[1][i] =3D NULL;
> +		}
> 	}
>=20
> -	if (cfqg->async_idle_cfqq)
> +	if (cfqg->async_idle_cfqq) {
> 		cfq_put_queue(cfqg->async_idle_cfqq);
> +		cfqg->async_idle_cfqq =3D NULL;
> +	}
>=20
> 	/*
> 	 * @blkg is going offline and will be ignored by
