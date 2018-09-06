Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: bfq: swap puts in bfqg_and_blkg_put
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <153622114435.533797.15694137158197822778.stgit@buzz>
Date: Thu, 6 Sep 2018 19:30:47 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org
Message-Id: <7EF3FD34-C48D-4612-BAEE-18E6EAEED1CE@linaro.org>
References: <153622114435.533797.15694137158197822778.stgit@buzz>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 06 set 2018, alle ore 10:05, Konstantin Khlebnikov =
<khlebnikov@yandex-team.ru> ha scritto:
>=20
> Fix trivial use-after-free. This could be last reference to bfqg.
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 8f9bebc33dd7 ("block, bfq: access and cache blkg data only when =
safe")
> ---
> block/bfq-cgroup.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 58c6efa9f9a9..9fe5952d117d 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -275,9 +275,9 @@ static void bfqg_and_blkg_get(struct bfq_group =
*bfqg)
>=20
> void bfqg_and_blkg_put(struct bfq_group *bfqg)
> {
> -	bfqg_put(bfqg);
> -
> 	blkg_put(bfqg_to_blkg(bfqg));
> +
> +	bfqg_put(bfqg);
> }
>=20
> /* @stats =3D 0 */
>=20
