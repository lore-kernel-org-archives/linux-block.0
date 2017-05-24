Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [block] question about potential null pointer dereference
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170523165213.Horde.iQQotBClh5pVkt5Jp5EHltF@gator4166.hostgator.com>
Date: Wed, 24 May 2017 12:34:19 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <EF1EB4C7-081E-4FA7-AF83-F88E97254D0B@linaro.org>
References: <20170523165213.Horde.iQQotBClh5pVkt5Jp5EHltF@gator4166.hostgator.com>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 23 mag 2017, alle ore 22:52, Gustavo A. R. Silva =
<garsilva@embeddedor.com> ha scritto:
>=20
>=20
> Hello everybody,
>=20

Hi

> While looking into Coverity ID 1408828 I ran into the following piece =
of code at block/bfq-wf2q.c:542:
>=20
> 542static struct rb_node *bfq_find_deepest(struct rb_node *node)
> 543{
> 544        struct rb_node *deepest;
> 545
> 546        if (!node->rb_right && !node->rb_left)
> 547                deepest =3D rb_parent(node);
> 548        else if (!node->rb_right)
> 549                deepest =3D node->rb_left;
> 550        else if (!node->rb_left)
> 551                deepest =3D node->rb_right;
> 552        else {
> 553                deepest =3D rb_next(node);
> 554                if (deepest->rb_right)
> 555                        deepest =3D deepest->rb_right;
> 556                else if (rb_parent(deepest) !=3D node)
> 557                        deepest =3D rb_parent(deepest);
> 558        }
> 559
> 560        return deepest;
> 561}
>=20
> The issue here is that there is a potential NULL pointer dereference =
at line 554, in case function rb_next() returns NULL.
>=20

Can rb_next(node) return NULL, although node is guaranteed to have both
a left and a right child at line 554?

Thanks,
Paolo

> Maybe a patch like the following could be applied in order to avoid =
any chance of a NULL pointer dereference:
>=20
> index 8726ede..28d8b90 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -551,6 +551,8 @@ static struct rb_node *bfq_find_deepest(struct =
rb_node *node)
>                deepest =3D node->rb_right;
>        else {
>                deepest =3D rb_next(node);
> +               if (!deepest)
> +                       return NULL;
>                if (deepest->rb_right)
>                        deepest =3D deepest->rb_right;
>                else if (rb_parent(deepest) !=3D node)
>=20
> What do you think?
>=20
> I'd really appreciate any comment on this.
>=20
> Thank you!
> --
> Gustavo A. R. Silva
>=20
>=20
>=20
>=20
