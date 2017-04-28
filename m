Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] MAINTAINERS: bfq: Add Paolo as maintainer for the BFQ I/O scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1493374236-26221-1-git-send-email-ulf.hansson@linaro.org>
Date: Fri, 28 Apr 2017 12:13:15 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <FBD964D7-AB46-4633-B7CF-E55E9CEC849B@linaro.org>
References: <1493374236-26221-1-git-send-email-ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 28 apr 2017, alle ore 12:10, Ulf Hansson =
<ulf.hansson@linaro.org> ha scritto:
>=20
> Seems like this was forgotten in the bfq-series from Paolo. Let's do =
it now
> so people don't miss out involving Paolo for any future changes or =
when
> reporting bugs.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> ---
> MAINTAINERS | 8 ++++++++
> 1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38d3e4e..1bb06c5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2544,6 +2544,14 @@ F:	block/
> F:	kernel/trace/blktrace.c
> F:	lib/sbitmap.c
>=20
> +BFQ I/O SCHEDULER
> +M:	Paolo Valente <paolo.valente@linaro.org>
> +M:	Jens Axboe <axboe@kernel.dk>
> +L:	linux-block@vger.kernel.org
> +S:	Maintained
> +F:	block/bfq-*
> +F:	Documentation/block/bfq-iosched.txt
> +
> BLOCK2MTD DRIVER
> M:	Joern Engel <joern@lazybastard.org>
> L:	linux-mtd@lists.infradead.org
> --=20
> 2.7.4
>=20
