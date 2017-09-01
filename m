Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/5] bfq: Declare local functions static
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170830184211.12471-3-bart.vanassche@wdc.com>
Date: Fri, 1 Sep 2017 19:14:47 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Message-Id: <F0B3C5A2-5581-4364-AA98-D42D04C10ECA@linaro.org>
References: <20170830184211.12471-1-bart.vanassche@wdc.com> <20170830184211.12471-3-bart.vanassche@wdc.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 30 ago 2017, alle ore 20:42, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>=20
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Paolo Valente <paolo.valente@linaro.org>


Acked-by: Paolo Valente <paolo.valente@linaro.org>

> ---
> block/bfq-cgroup.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 78b2e0db4fb2..ceefb9a706d6 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -206,7 +206,7 @@ static void bfqg_get(struct bfq_group *bfqg)
> 	bfqg->ref++;
> }
>=20
> -void bfqg_put(struct bfq_group *bfqg)
> +static void bfqg_put(struct bfq_group *bfqg)
> {
> 	bfqg->ref--;
>=20
> @@ -385,7 +385,7 @@ static struct bfq_group_data =
*blkcg_to_bfqgd(struct blkcg *blkcg)
> 	return cpd_to_bfqgd(blkcg_to_cpd(blkcg, &blkcg_policy_bfq));
> }
>=20
> -struct blkcg_policy_data *bfq_cpd_alloc(gfp_t gfp)
> +static struct blkcg_policy_data *bfq_cpd_alloc(gfp_t gfp)
> {
> 	struct bfq_group_data *bgd;
>=20
> @@ -395,7 +395,7 @@ struct blkcg_policy_data *bfq_cpd_alloc(gfp_t gfp)
> 	return &bgd->pd;
> }
>=20
> -void bfq_cpd_init(struct blkcg_policy_data *cpd)
> +static void bfq_cpd_init(struct blkcg_policy_data *cpd)
> {
> 	struct bfq_group_data *d =3D cpd_to_bfqgd(cpd);
>=20
> @@ -403,12 +403,12 @@ void bfq_cpd_init(struct blkcg_policy_data *cpd)
> 		CGROUP_WEIGHT_DFL : BFQ_WEIGHT_LEGACY_DFL;
> }
>=20
> -void bfq_cpd_free(struct blkcg_policy_data *cpd)
> +static void bfq_cpd_free(struct blkcg_policy_data *cpd)
> {
> 	kfree(cpd_to_bfqgd(cpd));
> }
>=20
> -struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, int node)
> +static struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, int node)
> {
> 	struct bfq_group *bfqg;
>=20
> @@ -426,7 +426,7 @@ struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, =
int node)
> 	return &bfqg->pd;
> }
>=20
> -void bfq_pd_init(struct blkg_policy_data *pd)
> +static void bfq_pd_init(struct blkg_policy_data *pd)
> {
> 	struct blkcg_gq *blkg =3D pd_to_blkg(pd);
> 	struct bfq_group *bfqg =3D blkg_to_bfqg(blkg);
> @@ -445,7 +445,7 @@ void bfq_pd_init(struct blkg_policy_data *pd)
> 	bfqg->rq_pos_tree =3D RB_ROOT;
> }
>=20
> -void bfq_pd_free(struct blkg_policy_data *pd)
> +static void bfq_pd_free(struct blkg_policy_data *pd)
> {
> 	struct bfq_group *bfqg =3D pd_to_bfqg(pd);
>=20
> @@ -453,7 +453,7 @@ void bfq_pd_free(struct blkg_policy_data *pd)
> 	bfqg_put(bfqg);
> }
>=20
> -void bfq_pd_reset_stats(struct blkg_policy_data *pd)
> +static void bfq_pd_reset_stats(struct blkg_policy_data *pd)
> {
> 	struct bfq_group *bfqg =3D pd_to_bfqg(pd);
>=20
> @@ -740,7 +740,7 @@ static void bfq_reparent_active_entities(struct =
bfq_data *bfqd,
>  * blkio already grabs the queue_lock for us, so no need to use
>  * RCU-based magic
>  */
> -void bfq_pd_offline(struct blkg_policy_data *pd)
> +static void bfq_pd_offline(struct blkg_policy_data *pd)
> {
> 	struct bfq_service_tree *st;
> 	struct bfq_group *bfqg =3D pd_to_bfqg(pd);
> --=20
> 2.14.1
>=20
