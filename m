Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 4 Jul 2017 12:34:59 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ben Mezger <su@seds.nl>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block/Kconfig.iosched: Enable BFQ on DEFAULT_IOSCHED
Message-ID: <20170704193459.GA6360@vader.DHCP.thefacebook.com>
References: <26128c0d-7607-05e7-acb3-4a52139c232d@seds.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26128c0d-7607-05e7-acb3-4a52139c232d@seds.nl>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 04, 2017 at 01:35:18PM -0300, Ben Mezger wrote:
> This patch, allows BFQ to be chosen in the Default I/O scheduler prompt.

Nak, this doesn't work. The default scheduler Kconfig option is for the
legacy block path, but BFQ is a blk-mq scheduler.

> Signed-off-by: Ben Mezger <me@benmezger.nl>
> ---
>  block/Kconfig.iosched | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
> index fd2cefa47d35..5be248ce447c 100644
> --- a/block/Kconfig.iosched
> +++ b/block/Kconfig.iosched
> @@ -56,6 +56,9 @@ choice
>         config DEFAULT_NOOP
>                 bool "No-op"
> 
> +       config DEFAULT_BFQ
> +               bool "BFQ" if IOSCHED_BFQ=y
> +
>  endchoice
> 
>  config DEFAULT_IOSCHED
> @@ -63,6 +66,7 @@ config DEFAULT_IOSCHED
>         default "deadline" if DEFAULT_DEADLINE
>         default "cfq" if DEFAULT_CFQ
>         default "noop" if DEFAULT_NOOP
> +       default "bfq" if DEFAULT_BFQ
> 
>  config MQ_IOSCHED_DEADLINE
>         tristate "MQ deadline I/O scheduler"
> --
> 2.13.2
> 
> -- 
> - seds
> https://seds.nl
> 
