Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932482AbdABLGI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Jan 2017 06:06:08 -0500
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
To: Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
 <20161228085503.GA340@lst.de>
 <CACRpkdb2zyjRz_zniT5nLxWCeLwagn1ZiTWwXc6bHW229NmfPQ@mail.gmail.com>
 <2360959.cyJgAELf50@wuerfel>
Cc: Christoph Hellwig <hch@lst.de>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <68863f25-7faa-88b5-78bb-21027f772ab6@suse.de>
Date: Mon, 2 Jan 2017 12:06:04 +0100
MIME-Version: 1.0
In-Reply-To: <2360959.cyJgAELf50@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/02/2017 10:40 AM, Arnd Bergmann wrote:
> On Thursday, December 29, 2016 12:59:51 AM CET Linus Walleij wrote:
>> On Wed, Dec 28, 2016 at 9:55 AM, Christoph Hellwig <hch@lst.de> wrote:
>>> On Tue, Dec 27, 2016 at 01:21:28PM +0100, Linus Walleij wrote:
>>
>>>> On the contrary we expect a performance regression as mq has no
>>>> scheduling. MQ is created for the usecase where you have multiple
>>>> hardware queues and they are so hungry for work that you have a problem
>>>> feeding them all. Needless to say, on eMMC/SD we don't have that problem
>>>> right now atleast.
>>>
>>> That's not entirely correct.  blk-mq is designed to replace the legacy
>>> request code eventually.  The focus is on not wasting CPU cycles, and
>>> to support multiple queues (but not require them).
>>
>> OK! Performance is paramount, so this indeed confirms that we need
>> to re-engineer the MMC/SD stack to not rely on this kthread to "drive"
>> transactions, instead we need to complete them quickly from the driver
>> callbacks and let MQ drive.
>>
>> A problem here is that issueing the requests are in blocking context
>> while completion is in IRQ context (for most drivers) so we need to
>> look into this.
> 
> I think whether issuing an mmc request requires blocking should ideally
> be up to the host device driver, at least I'd hope that we can end up
> with something like this driving latency to the absolute minimum:
> 
> a) with MMC CMDQ support:
>   - report actual queue depth
>   - have blk-mq push requests directly into the device through
>     the mmc-block driver and the host driver
>   - if a host driver needs to block, make it use a private workqueue
> 
> b) without MMC CMDQ support:
>   - report queue depth of '2'
>   - first request gets handled as above
>   - if one request is pending, prepare the second request and
>     add a pointer to the mmc host structure (not that different
>     from what we do today)
>   - when the host driver completes a request, have it immediately
>     issue the next one from the interrupt handler. In case we need
>     to sleep here, use a threaded IRQ, or a workqueue. This should
>     avoid the need for the NULL requests
> 
> c) possible optimization for command packing without CMDQ:
>    - similar to b)
>    - report a longer queue (e.g. 8, maybe user selectable, to
>      balance throughput against latency)
>    - any request of the same type (read or write) as the one that
>      is currently added to the host as the 'next' one can be
>      added to that request so they get issued together
>    - if the types are different, report the queue to be busy
> 
Hmm. But that would amount to implement yet another queuing mechanism
within the driver/mmc subsystem, wouldn't it?

Which is, incidentally, the same method the S/390 DASD driver uses
nowadays; report an arbitrary queue depth to the block layer and queue
all requests internally to better saturate the device.

However I'd really like to get rid of this, and tweak the block layer to
handle these cases.

One idea I had was to use a 'prep' function for mq; it would be executed
once the request is added to the queue.
Key point here is that 'prep' and 'queue_rq' would be two distinct
steps; the driver could do all required setup functionality during
'prep', and then do the actual submission via 'queue_rq'.
That would allow to better distribute the load for timing-sensitive
devices, and with a bit of luck remove the need for a separate queuing
inside the driver.

In any case, it looks like a proper subject for LSF/MM...
Linus? Arnd? Are you up for it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
