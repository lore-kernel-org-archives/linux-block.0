Return-Path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Chunyan Zhang <zhang.chunyan@linaro.org>,
 Baolin Wang <baolin.wang@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
Date: Tue, 20 Dec 2016 17:21:53 +0100
Message-id: <1765500.ifISjAj14y@amdc3058>
In-reply-to: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>


Hi,

On Tuesday, December 20, 2016 03:01:48 PM Linus Walleij wrote:
> HACK ALERT: DO NOT MERGE THIS! IT IS A FYI PATCH FOR DISCUSSION
> ONLY.
> 
> This hack switches the MMC/SD subsystem from using the legacy blk
> layer to using blk-mq. It does this by registering one single
> hardware queue, since MMC/SD has only one command pipe. I kill
> off the worker thread altogether and let the MQ core logic fire
> sleepable requests directly into the MMC core.
> 
> We emulate the 2 elements deep pipeline by specifying queue depth
> 2, which is an elaborate lie that makes the block layer issue
> another request while a previous request is in transit. It't not
> neat but it works.
> 
> As the pipeline needs to be flushed by pushing in a NULL request
> after the last block layer request I added a delayed work with a
> timeout of zero. This will fire as soon as the block layer stops
> pushing in requests: as long as there are new requests the MQ
> block layer will just repeatedly cancel this pipeline flush work
> and push new requests into the pipeline, but once the requests
> stop coming the NULL request will be flushed into the pipeline.
> 
> It's not pretty but it works... Look at the following performance
> statistics:
> 
> BEFORE this patch:
> 
> time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.0GB) copied, 45.145874 seconds, 22.7MB/s
> real    0m 45.15s
> user    0m 0.02s
> sys     0m 7.51s
> 
> mount /dev/mmcblk0p1 /mnt/
> cd /mnt/
> time find . > /dev/null
> real    0m 3.70s
> user    0m 0.29s
> sys     0m 1.63s
> 
> AFTER this patch:
> 
> time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.0GB) copied, 45.285431 seconds, 22.6MB/s
> real    0m 45.29s
> user    0m 0.02s
> sys     0m 6.58s
> 
> mount /dev/mmcblk0p1 /mnt/
> cd /mnt/
> time find . > /dev/null
> real    0m 4.37s
> user    0m 0.27s
> sys     0m 1.65s
> 
> The results are consistent.
> 
> As you can see, for a straight dd-like task, we get more or less the
> same nice parallelism as for the old framework. I have confirmed
> through debugprints that indeed this is because the two-stage pipeline
> is full at all times.
> 
> However, for spurious reads in the find command, we already see a big
> performance regression.
> 
> This is because there are many small operations requireing a flush of
> the pipeline, which used to happen immediately with the old block
> layer interface code that used to pull a few NULL requests off the
> queue and feed them into the pipeline immediately after the last
> request, but happens after the delayed work is executed in this
> new framework. The delayed work is never quick enough to terminate
> all these small operations even if we schedule it immediately after
> the last request.
> 
> AFAICT the only way forward to provide proper performance with MQ
> for MMC/SD is to get the requests to complete out-of-sync, i.e. when
> the driver calls back to MMC/SD core to notify that a request is
> complete, it should not notify any main thread with a completion
> as is done right now, but instead directly call blk_end_request_all()
> and only schedule some extra communication with the card if necessary
> for example to handle an error condition.

To do this I think that SCSI subsystem-like error handling should be
added to MMC core (in my uber-ugly blk-mq patches I just commented
most of error handling out and added direct request completion call).

> This rework needs a bigger rewrite so we can get rid of the paradigm
> of the block layer "driving" the requests throgh the pipeline.

IMHO for now blk-mq should be added as an add-on to MMC core with
leaving the old code in-place (again SCSI layer serves as inspiration
for that).

It should be easier to test and merge blk-mq support without causing
regressions this way (i.e. blk-mq handling of schedulers is only now
being worked on).

You may also consider re-basing your work on Adrian's swcmdq patches
(up to "mmc: core: Do not prepare a new request twice" patch) as they
cleanup MMC core queuing code significantly (some of the patches have
been merged upstream recently):

http://git.infradead.org/users/ahunter/linux-sdhci.git/shortlog/refs/heads/swcmdq

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
