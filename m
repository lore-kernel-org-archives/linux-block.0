Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
References: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 30 Mar 2017 14:42:53 +0200
Message-ID: <CAK8P3a1CGtj5VSVoMM34VWn781WpS8ZcHpq6n0UfNOWWYEq=QQ@mail.gmail.com>
Subject: Re: Outstanding MQ questions from MMC
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 29, 2017 at 5:09 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi folks,
>
> I earlier left some unanswered questions in my MMC to MQ conversion series
> but I figured it is better if I collect them and ask the blk-mq
> maintainers directly
> how to deal with the following situations that occur in the MMC block layer:
>
>
> 1. The current MMC code locks the host when the first request comes in
> from blk_fetch_request() and unlocks it when blk_fetch_request() returns
> NULL twice in a row. Then the polling thread terminated and is not restarted
> until we get called by the mmc_request_fn.
>
> Host locking means that we will not send other commands to the MMC
> card from i.e. userspace, which sometimes can send spurious stuff orthogonal
> to the block layer. If the block layer has locked the host, userspace
> has to wait
> and vice versa. It is not a common contention point but it still happens.
>
> In MQ, I have simply locked the host on the first request and then I never
> release it. Clearly this does not work. I am uncertain on how to handle this
> and whether MQ has a way to tell us that the queue is empty so we may release
> the host. I toyed with the idea to just set up a timer, but a "queue
> empty" callback
> from the block layer is what would be ideal.

Would it be possible to change the userspace code to go through
the block layer instead and queue a request there, to avoid having
to lock the card at all?

       Arnd
