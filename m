Return-Path: <adrian.hunter@intel.com>
Subject: Re: [PATCH 00/12 v4] multiqueue for MMC/SD
To: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Paolo Valente <paolo.valente@linaro.org>,
 Avri Altman <Avri.Altman@sandisk.com>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <0ab6b0b7-74e7-f7d3-9137-baf259282914@intel.com>
Date: Thu, 26 Oct 2017 16:34:35 +0300
MIME-Version: 1.0
In-Reply-To: <20171026125757.10200-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 26/10/17 15:57, Linus Walleij wrote:
> This switches the MMC/SD stack over to unconditionally
> using the multiqueue block interface for block access.
> This modernizes the MMC/SD stack and makes it possible
> to enable BFQ scheduling on these single-queue devices.
> 
> This is the v4 version of this v3 patch set from february:
> https://marc.info/?l=linux-mmc&m=148665788227015&w=2
> 
> The patches are available in a git branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git/log/?h=mmc-mq-v4.14-rc4
> 
> You can pull it to a clean kernel tree like this:
> git checkout -b mmc-test v4.14-rc4
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-mq-v4.14-rc4
> 
> I have now worked on it for more than a year. I was side
> tracked to clean up some code, move request allocation to
> be handled by the block layer, delete bounce buffer handling
> and refactoring the RPMB support. With the changes to request
> allocation, the patch set is a better fit and has shrunk
> from 16 to 12 patches as a result.

None of which was necessary for blk-mq support.

> 
> It is still quite invasive. Yet it is something I think would
> be nice to merge for v4.16...
> 
> The rationale for this approach was Arnd's suggestion to try to
> switch the MMC/SD stack around so as to complete requests as
> quickly as possible when they return from the device driver
> so that new requests can be issued. We are doing this now:
> the polling loop that was pulling NULL out of the request
> queue and driving the pipeline with a loop is gone with
> the next-to last patch ("block: issue requests in massive
> parallel"). This sets the stage for MQ to go in and hammer
> requests on the asynchronous issuing layer.
> 
> We use the trick to set the queue depth to 2 to get two
> parallel requests pushed down to the host. I tried to set this
> to 4, the code survives it, the queue just have three items
> waiting to be submitted all the time.

The queue depth also sets the number of requests, so you are strangling the
I/O scheduler.

> 
> In my opinion this is also a better fit for command queueuing.

Not true.  CQE support worked perfectly before blk-mq and did not depend on
blk-mq in any way.  Obviously the current CQE patch set actually implements
the CQE requirements for blk-mq - which this patch set does not.

> Handling command queueing needs to happen in the asynchronous
> submission codepath, so instead of waiting on a pending
> areq, we just stack up requests in the command queue.

That is how CQE has always worked.  It worked that way just fine without blk-mq.

> 
> It sounds simple but I bet this drives a truck through Adrians
> patch series. Sorry. :(

I waited a long time for your patches but I had to give up waiting when Ulf
belated insisted on blk-mq before CQE.  I am not sure what you are expecting
now it seems too late.
