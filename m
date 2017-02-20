Return-Path: <adrian.hunter@intel.com>
Subject: Re: Some throughput tests with MQ and BFQ on MMC/SD
To: Ziji Hu <huziji@marvell.com>, Linus Walleij <linus.walleij@linaro.org>
References: <CACRpkdYXk_MKhaeQLqGA+8Q4g5qy-DkRymC0Ecf+_qsm+cBoBQ@mail.gmail.com>
 <e4836ece-d990-667c-27d0-4b19a2b4b160@marvell.com>
 <CACRpkda+p4erE9CdMUWi55-Ji8rj8TNOeJadHeOkHT7a1wbLmA@mail.gmail.com>
 <2995d066-ebee-c05c-a4cc-63d5b86df0be@intel.com>
 <02cc3bc1-3ca6-2561-c914-a7993403c424@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Ritesh Harjani <riteshh@codeaurora.org>,
 Avri Altman <Avri.Altman@sandisk.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Paolo Valente <paolo.valente@linaro.org>, =?UTF-8?Q?Per_F=c3=b6rlin?=
 <per.forlin@axis.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <7422bef9-2b9f-9c17-6046-922f465de3f5@intel.com>
Date: Mon, 20 Feb 2017 13:19:10 +0200
MIME-Version: 1.0
In-Reply-To: <02cc3bc1-3ca6-2561-c914-a7993403c424@marvell.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 20/02/17 13:04, Ziji Hu wrote:
> Hi Adrian,
> 
> On 2017/2/20 16:03, Adrian Hunter wrote:
>> On 17/02/17 15:22, Linus Walleij wrote:
>>> On Fri, Feb 17, 2017 at 12:53 PM, Ziji Hu <huziji@marvell.com> wrote:
> <snip>
>>> Ulf describes it: we want to switch MMC/SD to MQ.
>>>
>>> To me, there are two reasons for that (no secret agendas...)
>>>
>>> 1. To get away from the legacy codebase in the old block layer.
>>>    Christoph and Jens have been very clear stating that the old block
>>>    layer is in maintenance mode and should be phased out, and they
>>>    asked explicitly for out help to do so. Currently
>>>    MMC/SD is a big fat roadblock to these plans so it is win-win for
>>>    MMC/SD and the block layer if we can just switch over to MQ.
>>>
>>> 2. My colleague Paolo Valente is working on the next generation
>>>   block scheduler BFQ which has very promising potential for
>>>   interactive loads. (Like taking a backup of your harddrive while
>>>   playing 1080p video let's say.) Since the
>>>   old block layer is no longer maintained, this scheduler will only
>>>   be merged and made available for systems deploying MQ. He's
>>>   already working full steam on that.
>>>
>>> I would like to make 1+2 happen in the next merge window
>>> ultimately, but yeah, maybe I'm overly optimistic. But I will sure
>>> try.
>>>
>>> Maybe I should add:
>>>
>>> 3. MQ is a better and future-proof fit for command queueing.
>>
>> MQ is not better - it is just different.  Because mmc devices do not have
>> multiple hardware queues, blk-mq essentially offers nothing but a different
>> way of doing the same thing.  And there are problems, such as blk-mq assumes
>> that the primary arbiter of whether a request can be issued is the queue
>> depth.  As I wrote here:
>>   https://marc.info/?l=linux-mmc&m=148336571720463&w=2
>> that is not the case for mmc, even with command queuing.
>>
> 	I guess it might benefit CMDQ since multi-thread can more easily let
> 	CMDQ achieve full performance. It is just my guess. We shall wait for
> 	the test result.
> 
> 	Based on my own experience on developing CMDQ driver, some of the issues, like different
> 	partition and ioctl, can be solved by getting and putting mmc_host (mmc_claim_host/mmc_release_host).
> 	The key issue is Direct-CMD, It will be more complex to handle Direct-CMD with blk-mq,
> 	than doing it with current block layer. With current block layer, I just let CMDQ driver
> 	borrow existing non-CMDQ transfer routine, and turn back to CMDQ transfer routine
> 	after DCMD completes. But I'm not the effort we need with blk-mq.
> 
> 	My key point is, please correct me if I'm wrong, shall we avoid binding CMDQ and
> 	non-CMDQ card layer together?
> 	To be honest, I don't think CMDQ is a good design. It will bring a lot of troubles.
> 	In my very own opinion, if we try to develop a single routine to support both CMDQ
> 	and non-CMDQ, it will be painful to both sides.

Not sure what you mean, but the patches linked below support DCMD and
non-DCMD for flush, and the regular approach for discards:

	https://marc.info/?l=linux-mmc&m=148673270920906

CQE can be used for reads/writes only, or reads/writes/flushes.  Everything
else is done the regular way.


> 
> 	Thank you.
> 
> Best regards,
> Hu Ziji
> 
>> Also I wouldn't be surprise if BFQ needs some changes to work well with
>> command queuing.
>>
>> It would be better if blk-mq support was experimental until we can see how
>> well it works in practice.
>>
> 
