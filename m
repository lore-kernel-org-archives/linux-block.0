Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
Date: Mon, 02 Jan 2017 10:40:15 +0100
Message-ID: <2360959.cyJgAELf50@wuerfel>
In-Reply-To: <CACRpkdb2zyjRz_zniT5nLxWCeLwagn1ZiTWwXc6bHW229NmfPQ@mail.gmail.com>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org> <20161228085503.GA340@lst.de> <CACRpkdb2zyjRz_zniT5nLxWCeLwagn1ZiTWwXc6bHW229NmfPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Thursday, December 29, 2016 12:59:51 AM CET Linus Walleij wrote:
> On Wed, Dec 28, 2016 at 9:55 AM, Christoph Hellwig <hch@lst.de> wrote:
> > On Tue, Dec 27, 2016 at 01:21:28PM +0100, Linus Walleij wrote:
> 
> >> On the contrary we expect a performance regression as mq has no
> >> scheduling. MQ is created for the usecase where you have multiple
> >> hardware queues and they are so hungry for work that you have a problem
> >> feeding them all. Needless to say, on eMMC/SD we don't have that problem
> >> right now atleast.
> >
> > That's not entirely correct.  blk-mq is designed to replace the legacy
> > request code eventually.  The focus is on not wasting CPU cycles, and
> > to support multiple queues (but not require them).
> 
> OK! Performance is paramount, so this indeed confirms that we need
> to re-engineer the MMC/SD stack to not rely on this kthread to "drive"
> transactions, instead we need to complete them quickly from the driver
> callbacks and let MQ drive.
> 
> A problem here is that issueing the requests are in blocking context
> while completion is in IRQ context (for most drivers) so we need to
> look into this.

I think whether issuing an mmc request requires blocking should ideally
be up to the host device driver, at least I'd hope that we can end up
with something like this driving latency to the absolute minimum:

a) with MMC CMDQ support:
  - report actual queue depth
  - have blk-mq push requests directly into the device through
    the mmc-block driver and the host driver
  - if a host driver needs to block, make it use a private workqueue

b) without MMC CMDQ support:
  - report queue depth of '2'
  - first request gets handled as above
  - if one request is pending, prepare the second request and
    add a pointer to the mmc host structure (not that different
    from what we do today)
  - when the host driver completes a request, have it immediately
    issue the next one from the interrupt handler. In case we need
    to sleep here, use a threaded IRQ, or a workqueue. This should
    avoid the need for the NULL requests

c) possible optimization for command packing without CMDQ:
   - similar to b)
   - report a longer queue (e.g. 8, maybe user selectable, to
     balance throughput against latency)
   - any request of the same type (read or write) as the one that
     is currently added to the host as the 'next' one can be
     added to that request so they get issued together
   - if the types are different, report the queue to be busy

	Arnd
