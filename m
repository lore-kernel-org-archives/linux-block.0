Return-Path: <jthumshirn@suse.de>
Subject: Re: [PATCH] mmc: core: make block layer non-optional
To: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>
References: <20170215095353.23888-1-linus.walleij@linaro.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <98edb25f-79c9-9a3a-9a59-d65262f4ff53@suse.de>
Date: Wed, 15 Feb 2017 11:00:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170215095353.23888-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

some nits below:

On 02/15/2017 10:53 AM, Linus Walleij wrote:
> I do not know at what point people have wanted to have a system
> with MMC/SD support without the block layer. We are anyway now
> so tightly integrated with the block layer that this is onlt
                                                        only ^
> teoretical and it makes no sense to have the block layer interface
  ^ theoretical
> as optional.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
