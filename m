Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] block, bfq: fix typos in comments about B-WF2Q+ algorithm
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1499844301-6312-1-git-send-email-houtao1@huawei.com>
Date: Wed, 12 Jul 2017 10:59:07 +0200
Cc: linux-block@vger.kernel.org,
 axboe@kernel.dk
Message-Id: <B8B34281-641C-4308-997B-C9A6EF2FAF6A@linaro.org>
References: <1499844301-6312-1-git-send-email-houtao1@huawei.com>
To: Hou Tao <houtao1@huawei.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 12 lug 2017, alle ore 09:25, Hou Tao <houtao1@huawei.com> ha =
scritto:
>=20
> The start time of eligible entity should be less than or equal to
> the current virtual time, and the entity in idle tree has a finish
> time being greater than the current virtual time.
>=20

Thanks for checking and fixing these typos, especially the one about
eligibility.

> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Paolo Valente <paolo.valente@linaro.org>

> ---
> block/bfq-iosched.h | 2 +-
> block/bfq-wf2q.c    | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 5c3bf98..32feddab 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -52,7 +52,7 @@ struct bfq_entity;
> struct bfq_service_tree {
> 	/* tree for active entities (i.e., those backlogged) */
> 	struct rb_root active;
> -	/* tree for idle entities (i.e., not backlogged, with V <=3D =
F_i)*/
> +	/* tree for idle entities (i.e., not backlogged, with V < F_i)*/
> 	struct rb_root idle;
>=20
> 	/* idle entity with minimum F_i */
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 8726ede..d03d7b6 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -1268,7 +1268,7 @@ static void bfq_update_vtime(struct =
bfq_service_tree *st, u64 new_value)
>  *
>  * This function searches the first schedulable entity, starting from =
the
>  * root of the tree and going on the left every time on this side =
there is
> - * a subtree with at least one eligible (start >=3D vtime) entity. =
The path on
> + * a subtree with at least one eligible (start <=3D vtime) entity. =
The path on
>  * the right is followed only if a) the left subtree contains no =
eligible
>  * entities and b) no eligible entity has been found yet.
>  */
> --=20
> 2.5.0
>=20
