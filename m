Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170904081451.swq52kn2x24guphz@techsingularity.net>
References: <20170831064631.2223-1-paolo.valente@linaro.org>
 <20170831144257.oa5nm6vzihpam6kw@techsingularity.net> <20170904081451.swq52kn2x24guphz@techsingularity.net>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 4 Sep 2017 17:07:14 +0800
Message-ID: <CACVXFVOjtyKWTOwetpAdkz8kwaF3trrVMUmF2YDAN8OCGk7dJw@mail.gmail.com>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/3] three bfq fixes restoring
 service guarantees with random sync writes in bg
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org,
	Mark Brown <broonie@kernel.org>, lee.tibbert@gmail.com, oleksandr@natalenko.name
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 4, 2017 at 4:14 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
> On Thu, Aug 31, 2017 at 03:42:57PM +0100, Mel Gorman wrote:
>> On Thu, Aug 31, 2017 at 08:46:28AM +0200, Paolo Valente wrote:
>> > [SECOND TAKE, with just the name of one of the tester fixed]
>> >
>> > Hi,
>> > while testing the read-write unfairness issues reported by Mel, I
>> > found BFQ failing to guarantee good responsiveness against heavy
>> > random sync writes in the background, i.e., multiple writers doing
>> > random writes and systematic fdatasync [1]. The failure was caused by
>> > three related bugs, because of which BFQ failed to guarantee to
>> > high-weight processes the expected fraction of the throughput.
>> >
>>
>> Queued on top of Ming's most recent series even though that's still a work
>> in progress. I should know in a few days how things stand.
>>
>
> The problems with parallel heavy writers seem to have disappeared with this
> series. There are still revisions taking place on Ming's to overall setting
> of legacy vs mq is still a work in progress but this series looks good.

Hi Mel and Paolo,

BTW, no actual functional change in V4.

Also could you guys provide one tested-by since looks you are using
it in your test?

Thanks,
Ming Lei
