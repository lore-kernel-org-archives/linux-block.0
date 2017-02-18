Return-Path: <huziji@marvell.com>
Subject: Re: Some throughput tests with MQ and BFQ on MMC/SD
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <CACRpkdYXk_MKhaeQLqGA+8Q4g5qy-DkRymC0Ecf+_qsm+cBoBQ@mail.gmail.com>
 <e4836ece-d990-667c-27d0-4b19a2b4b160@marvell.com>
 <CAPDyKFo_-SykPX5LjUB2VMBVaa05EPJ0OYzpCLCpCO9Sug+Feg@mail.gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Avri
 Altman <Avri.Altman@sandisk.com>, Arnd Bergmann <arnd@arndb.de>,
        Christoph
 Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente
	<paolo.valente@linaro.org>,
        =?UTF-8?Q?Per_F=c3=b6rlin?= <per.forlin@axis.com>
From: Ziji Hu <huziji@marvell.com>
Message-ID: <6c65cd92-117f-9d40-caaa-05163160923a@marvell.com>
Date: Sat, 18 Feb 2017 12:36:53 +0800
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo_-SykPX5LjUB2VMBVaa05EPJ0OYzpCLCpCO9Sug+Feg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

Hi Ulf,

On 2017/2/17 20:09, Ulf Hansson wrote:
> [...]
> 
>>
>>         I would like to suggest that you should try the multiple thread
>>         test mode of iozone, since you are testing *Multi* Queue.
> 
> Yes. That seems reasonable.
> 
> However, the most important part here is the comparison between the
> different code bases.
> 
>>
>>         Besides, it seems that your eMMC transfer speed is quite low.
>>         It is normal that read speed can reach more than 100MB/s in HS400.
>>         Could you try a higher speed mode? The test result might be
>>         limited by the bus clock frequency.
> 
> Perhaps if Linus can share a branch of the code integrated for the
> different tests, we all can help out running them on those HW we have
> at hand. Would you be willing to help out here?
> 
	I'm glad to.
	But my available platforms all stay in Linux v4.4/v4.1.
	I can help when my platforms can upgrade.

>>
>>>
>>> As you can see there are no huge performance regressions with these
>>> kinds of "raw" throughput tests.
>>>
>>> These iozone figures are unintuitive unless your head can
>>> plot logarithmic, look at the charts here for a more visual presentation
>>> of the iozone results:
>>> https://docs.google.com/spreadsheets/d/1rm72TiGlTnzDeGLR__aqvjcJ2UkA-Ro3-XyKA8r1M-c
>>>
>>> Compare this to the performance change we got when first introducing
>>> the asynchronous requests:
>>> https://wiki.linaro.org/WorkingGroups/KernelArchived/Specs/StoragePerfMMC-async-req
>>>
>>> The patches need some issues fixed from the build server
>>> complaints and some robustness hammering, but after that I
>>> think they will be ripe for merging for v4.12.
>>>
>>
>>         Actually I have been following your thread for some time.
>>         But currently I'm a little confused.
>>         May I know the purpose of your patch?
> 
> I want MMC to move to the new BLKMQ interface and I want that because
> of several reasons, see below.
> 
> 1. It's new blk interface, all new development happens here. We should
> use it to benefit from that.
> 2. The BLKMQ interface allow the MMC block device driver to be
> significantly cleaner implemented - and I need that to be able to
> maintain the code.
> 3. We want to make use of Paolo's BFQ-MK I/O scheduler, which
> addresses provides guaranteed low latency. For example being able to
> play a video clip, while doing a disc backup without getting frame
> drops.
> 
	Got it. Thanks a lot for your detailed explanation.
	If we focus on the low latency, we shall get a cleaner result
	of IOPS in tests.
	IOPS is a more common performance index in eMMC/SD.

	Thank you.

Best regards,
Hu Ziji
> Kind regards
> Uffe
> 
