Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170215095353.23888-1-linus.walleij@linaro.org>
References: <20170215095353.23888-1-linus.walleij@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Feb 2017 11:13:14 +0100
Message-ID: <CAK8P3a3kmxhODYZyqX_O4qhKz8hjH+FXxFAcmi-20dm2mNW9Mw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: make block layer non-optional
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 15, 2017 at 10:53 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> I do not know at what point people have wanted to have a system
> with MMC/SD support without the block layer. We are anyway now
> so tightly integrated with the block layer that this is onlt
> teoretical and it makes no sense to have the block layer interface
> as optional.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/Kconfig  | 12 ------------
>  drivers/mmc/core/Makefile |  5 ++---
>  2 files changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index cdfa8520a4b1..2920bc4351ed 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -23,19 +23,8 @@ config PWRSEQ_SIMPLE
>           This driver can also be built as a module. If so, the module
>           will be called pwrseq_simple.
>
> -config MMC_BLOCK
> -       tristate "MMC block device driver"
> -       depends on BLOCK

Now you need to move the "depends on BLOCK" into the top-level
option. In theory you could have a system that has no MMC storage
and no block device but boots from NOR flash and uses an SDIO
wifi card, such as this these

https://getchip.com/pages/chip
http://wiki.chumby.com/index.php?title=Main_Page
https://wikidevi.com/wiki/GlobalScale_DreamPlug
https://wikidevi.com/wiki/Linksys_HA1000
https://wikidevi.com/wiki/Google_Chromecast_(H2G2-42)
https://wikidevi.com/wiki/D-Link_DCH-G021

Most are not too memory constrained, but sometimes you want to
squeeze out some kernel memory by turning off CONFIG_BLOCK.

    Arnd
