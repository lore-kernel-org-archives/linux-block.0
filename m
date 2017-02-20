Return-Path: <adrian.hunter@intel.com>
Subject: Re: Some throughput tests with MQ and BFQ on MMC/SD
To: Linus Walleij <linus.walleij@linaro.org>, Ziji Hu <huziji@marvell.com>
References: <CACRpkdYXk_MKhaeQLqGA+8Q4g5qy-DkRymC0Ecf+_qsm+cBoBQ@mail.gmail.com>
 <e4836ece-d990-667c-27d0-4b19a2b4b160@marvell.com>
 <CACRpkda+p4erE9CdMUWi55-Ji8rj8TNOeJadHeOkHT7a1wbLmA@mail.gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Ritesh Harjani <riteshh@codeaurora.org>,
 Avri Altman <Avri.Altman@sandisk.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Paolo Valente <paolo.valente@linaro.org>, =?UTF-8?Q?Per_F=c3=b6rlin?=
 <per.forlin@axis.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <2995d066-ebee-c05c-a4cc-63d5b86df0be@intel.com>
Date: Mon, 20 Feb 2017 10:03:35 +0200
MIME-Version: 1.0
In-Reply-To: <CACRpkda+p4erE9CdMUWi55-Ji8rj8TNOeJadHeOkHT7a1wbLmA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 17/02/17 15:22, Linus Walleij wrote:
> On Fri, Feb 17, 2017 at 12:53 PM, Ziji Hu <huziji@marvell.com> wrote:
> 
>>         I would like to suggest that you should try the multiple thread
>>         test mode of iozone, since you are testing *Multi* Queue.
> 
> Good point. This target has only 2 CPUs but still, maybe it performs!
> 
>>         Besides, it seems that your eMMC transfer speed is quite low.
>>         It is normal that read speed can reach more than 100MB/s in HS400.
>>         Could you try a higher speed mode? The test result might be
>>         limited by the bus clock frequency.
> 
> The iozone tests are done on an SDcard. And I only did read tests on
> the eMMC I have.
> 
> It's because I'm afriad of wearing out my eMMC :(
> 
> But OK I'll just take the risk and run iozone on the eMMC.
> 
>>         Actually I have been following your thread for some time.
>>         But currently I'm a little confused.
>>         May I know the purpose of your patch?
> 
> Ulf describes it: we want to switch MMC/SD to MQ.
> 
> To me, there are two reasons for that (no secret agendas...)
> 
> 1. To get away from the legacy codebase in the old block layer.
>    Christoph and Jens have been very clear stating that the old block
>    layer is in maintenance mode and should be phased out, and they
>    asked explicitly for out help to do so. Currently
>    MMC/SD is a big fat roadblock to these plans so it is win-win for
>    MMC/SD and the block layer if we can just switch over to MQ.
> 
> 2. My colleague Paolo Valente is working on the next generation
>   block scheduler BFQ which has very promising potential for
>   interactive loads. (Like taking a backup of your harddrive while
>   playing 1080p video let's say.) Since the
>   old block layer is no longer maintained, this scheduler will only
>   be merged and made available for systems deploying MQ. He's
>   already working full steam on that.
> 
> I would like to make 1+2 happen in the next merge window
> ultimately, but yeah, maybe I'm overly optimistic. But I will sure
> try.
> 
> Maybe I should add:
> 
> 3. MQ is a better and future-proof fit for command queueing.

MQ is not better - it is just different.  Because mmc devices do not have
multiple hardware queues, blk-mq essentially offers nothing but a different
way of doing the same thing.  And there are problems, such as blk-mq assumes
that the primary arbiter of whether a request can be issued is the queue
depth.  As I wrote here:
  https://marc.info/?l=linux-mmc&m=148336571720463&w=2
that is not the case for mmc, even with command queuing.

Also I wouldn't be surprise if BFQ needs some changes to work well with
command queuing.

It would be better if blk-mq support was experimental until we can see how
well it works in practice.
