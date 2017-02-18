Return-Path: <huziji@marvell.com>
Subject: Re: Some throughput tests with MQ and BFQ on MMC/SD
To: Linus Walleij <linus.walleij@linaro.org>
References: <CACRpkdYXk_MKhaeQLqGA+8Q4g5qy-DkRymC0Ecf+_qsm+cBoBQ@mail.gmail.com>
 <e4836ece-d990-667c-27d0-4b19a2b4b160@marvell.com>
 <CACRpkda+p4erE9CdMUWi55-Ji8rj8TNOeJadHeOkHT7a1wbLmA@mail.gmail.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-block@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian
 Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Avri Altman <Avri.Altman@sandisk.com>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente
	<paolo.valente@linaro.org>,
        =?UTF-8?Q?Per_F=c3=b6rlin?= <per.forlin@axis.com>
From: Ziji Hu <huziji@marvell.com>
Message-ID: <631e1706-620e-0247-1d77-7c7d6374ce65@marvell.com>
Date: Sat, 18 Feb 2017 12:57:20 +0800
MIME-Version: 1.0
In-Reply-To: <CACRpkda+p4erE9CdMUWi55-Ji8rj8TNOeJadHeOkHT7a1wbLmA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

On 2017/2/17 21:22, Linus Walleij wrote:
> On Fri, Feb 17, 2017 at 12:53 PM, Ziji Hu <huziji@marvell.com> wrote:
> 
>>         I would like to suggest that you should try the multiple thread
>>         test mode of iozone, since you are testing *Multi* Queue.
> 
> Good point. This target has only 2 CPUs but still, maybe it performs!
>
	In my very own opinion, (although I'm not the expert of marketing),
	quad-core platforms will be more and more popular.
	Quad-core might have a different result, especially when we are
	testing multiple threads. 

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
	Actually, there is a parameter to limit the size of test file in iozone.
	I'm not sure why you need to scan the whole eMMC. But I personally
	believe it is unnecessary.

	Sorry for delay reply. Hope your eMMC is not broken yet. :p
	eMMC usually contains much more physical pages than the capacity
	it shows. Thus I guess your eMMC should be fine unless you torture
	it by entirely writing it again and again.

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
	I see. Thank you for the details.
> 
> Maybe I should add:
> 
> 3. MQ is a better and future-proof fit for command queueing.
	I strongly agree with you on it.

	Thank you.

Best regards,
Hu Ziji


> 
> Yours,
> Linus Walleij
> 
