Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <2995d066-ebee-c05c-a4cc-63d5b86df0be@intel.com>
References: <CACRpkdYXk_MKhaeQLqGA+8Q4g5qy-DkRymC0Ecf+_qsm+cBoBQ@mail.gmail.com>
 <e4836ece-d990-667c-27d0-4b19a2b4b160@marvell.com> <CACRpkda+p4erE9CdMUWi55-Ji8rj8TNOeJadHeOkHT7a1wbLmA@mail.gmail.com>
 <2995d066-ebee-c05c-a4cc-63d5b86df0be@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Feb 2017 14:46:12 +0100
Message-ID: <CACRpkdZADpiD8KNUqyhqdpf4HoVJQx3Z2_5dkw6BG2MG-5r8Jg@mail.gmail.com>
Subject: Re: Some throughput tests with MQ and BFQ on MMC/SD
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ziji Hu <huziji@marvell.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>,
	Avri Altman <Avri.Altman@sandisk.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
	=?UTF-8?Q?Per_F=C3=B6rlin?= <per.forlin@axis.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 20, 2017 at 9:03 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> MQ is not better - it is just different.

Well it is better in the sense that it has active maintainers and is
not scheduled
for depreciation.

> Because mmc devices do not have
> multiple hardware queues, blk-mq essentially offers nothing but a different
> way of doing the same thing.

I think what Ziji is pointing out is the hourglass-shaped structure of MQ.
It has multiple *issue* queues as well, not just multiple *hardware*
queues. That means that processes can have issue queues on different
CPUs and not all requests end up in a single nexus like with the old blk
layer.

Whether it benefits MMC/SD in the end is a good question. It might,
testing on multicores with multiple issue threads is needed.

> It would be better if blk-mq support was experimental until we can see how
> well it works in practice.

Do you mean experimental in the MMC/SD stack, such that we should
merge it as an additional scheduler instead of as the only scheduler
replacement?

I think SCSI did/still does things like that. On the other hand, UBI
just replaced the old block layer with MQ in commit
ff1f48ee3bb3, and it is also very widely
used, so there are example of both approaches. (How typical.)

Yours,
Linus Walleij
