Return-Path: <kyle.fortin@oracle.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] block: remove unnecessary NULL checks in bioset_integrity_free()
From: Kyle Fortin <kyle.fortin@oracle.com>
In-Reply-To: <20171005180920.GA121296@debian>
Date: Fri, 6 Oct 2017 12:00:46 -0400
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.levin@one.verizon.com
Message-Id: <5619DDDF-453D-44DD-BDEB-B87DF0A18271@oracle.com>
References: <20171005180920.GA121296@debian>
To: Tim Hansen <devtimhansen@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hi Tim,

On Oct 5, 2017, at 2:09 PM, Tim Hansen <devtimhansen@gmail.com> wrote:
>=20
> mempool_destroy() already checks for a NULL value being passed in, =
this eliminates duplicate checks.
>=20
> This was caught by running make coccicheck M=3Dblock/ on linus' tree =
on commit 77ede3a014a32746002f7889211f0cecf4803163 (current head as of =
this patch).
>=20
> Signed-off-by: Tim Hansen <devtimhansen@gmail.com>
> ---
> block/bio-integrity.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 5df3290..23b42e8 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -485,11 +485,8 @@ EXPORT_SYMBOL(bioset_integrity_create);
>=20
> void bioset_integrity_free(struct bio_set *bs)
> {
> -	if (bs->bio_integrity_pool)
> -		mempool_destroy(bs->bio_integrity_pool);
> -
> -	if (bs->bvec_integrity_pool)
> -		mempool_destroy(bs->bvec_integrity_pool);
> +	mempool_destroy(bs->bio_integrity_pool);
> +	mempool_destroy(bs->bvec_integrity_pool);
> }
> EXPORT_SYMBOL(bioset_integrity_free);
>=20
> --=20
> 2.1.4

Looks good.

Reviewed-by: Kyle Fortin <kyle.fortin@oracle.com>
