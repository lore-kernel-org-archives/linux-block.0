Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/12 v4] multiqueue for MMC/SD
Date: Thu, 26 Oct 2017 14:57:45 +0200
Message-Id: <20171026125757.10200-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This switches the MMC/SD stack over to unconditionally
using the multiqueue block interface for block access.
This modernizes the MMC/SD stack and makes it possible
to enable BFQ scheduling on these single-queue devices.

This is the v4 version of this v3 patch set from february:
https://marc.info/?l=linux-mmc&m=148665788227015&w=2

The patches are available in a git branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git/log/?h=mmc-mq-v4.14-rc4

You can pull it to a clean kernel tree like this:
git checkout -b mmc-test v4.14-rc4
git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-mq-v4.14-rc4

I have now worked on it for more than a year. I was side
tracked to clean up some code, move request allocation to
be handled by the block layer, delete bounce buffer handling
and refactoring the RPMB support. With the changes to request
allocation, the patch set is a better fit and has shrunk
from 16 to 12 patches as a result.

It is still quite invasive. Yet it is something I think would
be nice to merge for v4.16...

The rationale for this approach was Arnd's suggestion to try to
switch the MMC/SD stack around so as to complete requests as
quickly as possible when they return from the device driver
so that new requests can be issued. We are doing this now:
the polling loop that was pulling NULL out of the request
queue and driving the pipeline with a loop is gone with
the next-to last patch ("block: issue requests in massive
parallel"). This sets the stage for MQ to go in and hammer
requests on the asynchronous issuing layer.

We use the trick to set the queue depth to 2 to get two
parallel requests pushed down to the host. I tried to set this
to 4, the code survives it, the queue just have three items
waiting to be submitted all the time.

In my opinion this is also a better fit for command queueuing.
Handling command queueing needs to happen in the asynchronous
submission codepath, so instead of waiting on a pending
areq, we just stack up requests in the command queue.

It sounds simple but I bet this drives a truck through Adrians
patch series. Sorry. :(

We are not issueing new requests from interrupt context: I still
have to post a work on a workqueue for it. Since there is the
retune and background operations that need to be checked after
every command and yeah, it needs to happen in blocking context
as far as I know.

I might make a hack trying to strip out the retune (etc) and
instead run request until something fail and report requests
back to the block layer in interrupt context. It would be an
interesting experiment, but for later.

We have parallelism in pre/post hooks also with multiqueue.
All asynchronous optimization that was there for the old block
layer is now also there for multiqueue.

Last time I followed up with some open questions
https://marc.info/?l=linux-mmc&m=149075698610224&w=2
I think these are now resolved.

As a result, the last patch is no longer in RFC state. I
think this works. (Famous last words, OK there WILL be
regressions but hey, we need to do this.)
You can see there are three steps:

- I do some necessary refactoring and need to move postprocessing
  to after the requests have been completed. This clearly, as you
  can see, introduce a performance regression in the dd test with
  the patch:
  "mmc: core: move the asynchronous post-processing"
  It seems the random seek with find isn't much affected.

- I continue the refactoring and get to the point of issueing
  requests immediately after every successful transfer, and the
  dd performance is restored with patch
  "mmc: queue: issue requests in massive parallel"

- Then I add multiqueue on top of the cake. So before the change
  we have the nice performance we want so we can study the effect
  of just introducing multiqueueing in the last patch
  "mmc: switch MMC/SD to use blk-mq multiqueueing v4"


PERFORMANCE BEFORE AND AFTER:

BEFORE this patch series, on Ulf's next branch ending with
commit cf653c788a29fa70e07b86492a7599c471c705de (mmc-next)
Merge: 4dda8e1f70f8 eb701ce16a45 ("Merge branch 'fixes' into next")

sync
echo 3 > /proc/sys/vm/drop_caches
sync
time dd if=/dev/mmcblk3 of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.0GB) copied, 23.966583 seconds, 42.7MB/s
real    0m 23.97s
user    0m 0.01s
sys     0m 3.74s

mount /dev/mmcblk3p1 /mnt/
cd /mnt/
sync
echo 3 > /proc/sys/vm/drop_caches
sync
time find . > /dev/null
real    0m 3.24s
user    0m 0.22s
sys     0m 1.23s

sync
echo 3 > /proc/sys/vm/drop_caches
sync
iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test

                                                   random    random
   kB  reclen    write  rewrite    read    reread    read     write
20480       4     1598     1559     6782     6740     6751      536
20480       8     2134     2281    11449    11449    11407     1145
20480      16     3695     4171    17676    17677    17638     1234
20480      32     5751     7475    23622    23622    23584     3004
20480      64     6778     8648    27937    27950    27914     3445
20480     128     6073     8115    29091    29080    29070     4892
20480     256     7106     7208    29658    29670    29657     6743
20480     512     8828     9953    29911    29905    29901     7424
20480    1024     6566     7199    27233    27236    27209     6808
20480    2048     7370     7403    27492    27490    27475     7428
20480    4096     7352     7456    28124    28123    28109     7411
20480    8192     7271     7462    28371    28369    28359     7458
20480   16384     7097     7478    28540    28538    28528     7464

AFTER this patch series ending with
"mmc: switch MMC/SD to use blk-mq multiqueueing v4":

sync
echo 3 > /proc/sys/vm/drop_caches
sync
time dd if=/dev/mmcblk3 of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.0GB) copied, 24.358276 seconds, 42.0MB/s
real    0m 24.36s
user    0m 0.00s
sys     0m 3.92s

mount /dev/mmcblk3p1 /mnt/
cd /mnt/
sync
echo 3 > /proc/sys/vm/drop_caches
sync
time find . > /dev/null
real    0m 3.92s
user    0m 0.26s
sys     0m 1.21s

sync
echo 3 > /proc/sys/vm/drop_caches
sync
iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test

                                                   random    random
   kB  reclen    write  rewrite    read    reread    read     write
20480       4     1614     1569     6913     6889     6876      531
20480       8     2147     2301    11628    11625    11581     1165
20480      16     3820     4256    17760    17764    17725     1549
20480      32     5814     7508    23148    23145    23123     3561
20480      64     7396     8161    27513    27527    27500     4177
20480     128     6707     9025    29160    29166    29139     5199
20480     256     7902     7860    29459    29456    29462     7307
20480     512     8061    11343    29888    29891    29881     6800
20480    1024     7076     7442    27702    27704    27700     7445
20480    2048     6846     8194    27417    27419    27418     6781
20480    4096     8115     6810    28113    28113    28109     8191
20480    8192     7254     7434    28413    28419    28414     7476
20480   16384     7090     7481    28623    28619    28625     7454


As you can see, performance is not affected, errors are in the noise
margin.

Linus Walleij (12):
  mmc: core: move the asynchronous post-processing
  mmc: core: add a workqueue for completing requests
  mmc: core: replace waitqueue with worker
  mmc: core: do away with is_done_rcv
  mmc: core: do away with is_new_req
  mmc: core: kill off the context info
  mmc: queue: simplify queue logic
  mmc: block: shuffle retry and error handling
  mmc: queue: stop flushing the pipeline with NULL
  mmc: queue/block: pass around struct mmc_queue_req*s
  mmc: block: issue requests in massive parallel
  mmc: switch MMC/SD to use blk-mq multiqueueing v4

 drivers/mmc/core/block.c    | 539 ++++++++++++++++++++++----------------------
 drivers/mmc/core/block.h    |   5 +-
 drivers/mmc/core/bus.c      |   1 -
 drivers/mmc/core/core.c     | 194 +++++++++-------
 drivers/mmc/core/core.h     |  11 +-
 drivers/mmc/core/host.c     |   1 -
 drivers/mmc/core/mmc_test.c |  31 +--
 drivers/mmc/core/queue.c    | 238 ++++++++-----------
 drivers/mmc/core/queue.h    |  16 +-
 include/linux/mmc/core.h    |   3 +-
 include/linux/mmc/host.h    |  27 +--
 11 files changed, 503 insertions(+), 563 deletions(-)

-- 
2.13.6
