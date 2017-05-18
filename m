Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <eb50dffe-5cb9-d8d3-e218-399de512b074@intel.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <20170510082418.10513-3-linus.walleij@linaro.org> <f432dc3d-f66a-fcfe-fd8f-ac764b29c9db@intel.com>
 <CACRpkdaZuyZNDV=bjy2maZ0HYMEZCkNctkbEivThNM4jDT_c8Q@mail.gmail.com> <eb50dffe-5cb9-d8d3-e218-399de512b074@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 18 May 2017 15:31:53 +0200
Message-ID: <CACRpkdZMNWp2PmTf-ypn=hxHa8GPCbVhA5OKdCWp5FBRUQu22Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc: core: Allocate per-request data using the block
 layer core
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, May 18, 2017 at 2:42 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 18/05/17 11:21, Linus Walleij wrote:

>> It's better to do what everyone else does and let the core do this
>> allocation of extra data (tag) instead.
>
> I agree it is much nicer, but the extra bounce buffer allocations still seem
> gratuitous.  Maybe we should allocate them as needed from a memory pool,
> instead of for every request.

Incidentally IIRC that is what happens when we migrate to MQ.
In the old block layer, the per-request data is indeed initialized for
every request as you say, but in MQ the same struct request *'s
are reused from a pool, they are only initialized once, i.e. when
you add the block device.

(If I remember my logs right.)

Yours,
Linus Walleij
