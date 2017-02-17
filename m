Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <e4836ece-d990-667c-27d0-4b19a2b4b160@marvell.com>
References: <CACRpkdYXk_MKhaeQLqGA+8Q4g5qy-DkRymC0Ecf+_qsm+cBoBQ@mail.gmail.com>
 <e4836ece-d990-667c-27d0-4b19a2b4b160@marvell.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Feb 2017 13:09:47 +0100
Message-ID: <CAPDyKFo_-SykPX5LjUB2VMBVaa05EPJ0OYzpCLCpCO9Sug+Feg@mail.gmail.com>
Subject: Re: Some throughput tests with MQ and BFQ on MMC/SD
To: Ziji Hu <huziji@marvell.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>, Ritesh Harjani <riteshh@codeaurora.org>,
	Avri Altman <Avri.Altman@sandisk.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
	=?UTF-8?Q?Per_F=C3=B6rlin?= <per.forlin@axis.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

[...]

>
>         I would like to suggest that you should try the multiple thread
>         test mode of iozone, since you are testing *Multi* Queue.

Yes. That seems reasonable.

However, the most important part here is the comparison between the
different code bases.

>
>         Besides, it seems that your eMMC transfer speed is quite low.
>         It is normal that read speed can reach more than 100MB/s in HS400.
>         Could you try a higher speed mode? The test result might be
>         limited by the bus clock frequency.

Perhaps if Linus can share a branch of the code integrated for the
different tests, we all can help out running them on those HW we have
at hand. Would you be willing to help out here?

>
>>
>> As you can see there are no huge performance regressions with these
>> kinds of "raw" throughput tests.
>>
>> These iozone figures are unintuitive unless your head can
>> plot logarithmic, look at the charts here for a more visual presentation
>> of the iozone results:
>> https://docs.google.com/spreadsheets/d/1rm72TiGlTnzDeGLR__aqvjcJ2UkA-Ro3-XyKA8r1M-c
>>
>> Compare this to the performance change we got when first introducing
>> the asynchronous requests:
>> https://wiki.linaro.org/WorkingGroups/KernelArchived/Specs/StoragePerfMMC-async-req
>>
>> The patches need some issues fixed from the build server
>> complaints and some robustness hammering, but after that I
>> think they will be ripe for merging for v4.12.
>>
>
>         Actually I have been following your thread for some time.
>         But currently I'm a little confused.
>         May I know the purpose of your patch?

I want MMC to move to the new BLKMQ interface and I want that because
of several reasons, see below.

1. It's new blk interface, all new development happens here. We should
use it to benefit from that.
2. The BLKMQ interface allow the MMC block device driver to be
significantly cleaner implemented - and I need that to be able to
maintain the code.
3. We want to make use of Paolo's BFQ-MK I/O scheduler, which
addresses provides guaranteed low latency. For example being able to
play a video clip, while doing a disc backup without getting frame
drops.

Kind regards
Uffe
