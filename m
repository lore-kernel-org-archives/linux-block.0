Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/16] multiqueue for MMC/SD third try
Date: Thu,  9 Feb 2017 16:33:47 +0100
Message-Id: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The following is the latest attempt at a rewriting the MMC/SD
stack to cope with multiqueueing.

If you just want to grab a branch and test the patches with
your hardware, I put a git branch with this series here:
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-stericsson.git/log/?h=mmc-mq-next-2017-02-09

It's based on Ulf's v4.10-rc3-based tree, so quick reminder:
git checkout -b test v4.10-rc3
git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-mq-next-2017-02-09

Should get you a testable "test" branch.

These patches are clearly v4.12 material. They get increasinly
controversial and needing review the further into the series
you go. The last patch for multiqueue is marked RFC for a
reason.

Every time I do this it seems to be an extensive rewrite of the
whole world. Anyways this is based on the other ~16 patches that
were already merged for the upcoming v4.11.

The rationale for this approach was Arnd's suggestion to try to
switch the MMC/SD stack around so as to complete requests as
quickly as possible from the device driver so that new requests
can be issued. We are doing this now: the polling loop that was
pulling NULL out of the request queue and driving the pipeline
with a loop is gone.

We are not issueing new requests from interrupt context: I still
have to post a work for it. I don't know if that is possible.
There is the retune and background operations that need to be
checked after every command and yeah, it needs to happen in
blocking context as far as I know.

We have parallelism in pre/post hooks also with multiqueue.
All asynchronous optimization that was there for the old block layer
is now also there for multiqueue. There is even a new interesting
optimization that make bounce buffers be bounced asynchronously
with this change.

We still use the trick to set the queue depth to 2 to get two
parallel requests pushed down to the host.

Adrian: I know I made quite extensive violence on your queueue
handling reusing it in a way that is probably totally counter to
your command queueing patch series. I'm sorry. I guess you can
see where it is going if you follow the series. I also killed the
host context, right off, after reducing the synchronization needs
to zero. I hope you will be interested in the result though!

Does this perform? The numbers follow. I will discuss my
conclusions after the figures. All the tests are done on a cold
booted Ux500 system.

Before this patch series, based on my earlier cleanups
and refactorings on Ulf's next branch ending with
"mmc: core: start to break apart mmc_start_areq()":

time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.0GB) copied, 45.126404 seconds, 22.7MB/s
real    0m 45.13s
user    0m 0.02s
sys     0m 7.60s

mount /dev/mmcblk0p1 /mnt/
cd /mnt/
time find . > /dev/null
real    0m 3.61s
user    0m 0.30s
sys     0m 1.56s

Command line used: iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test
Output is in kBytes/sec
                                                   random    random
   kB  reclen    write  rewrite    read    reread    read     write
20480       4     2046     2114     5981     6008     5971       40
20480       8     4825     4622     9104     9118     9070       81
20480      16     5767     5929    12250    12253    12209      166
20480      32     6242     6303    14920    14917    14879      337
20480      64     6598     5907    16758    16760    16739      695
20480     128     6807     6837    17863    17869    17788     1387
20480     256     6922     6925    18497    18490    18482     3076
20480     512     7273     7313    18636    18407    18829     7344
20480    1024     7339     7332    17695    18785    18472     7441
20480    2048     7419     7471    19166    18812    18797     7474
20480    4096     7598     7714    21006    20975    21180     7708
20480    8192     7632     7830    22328    22315    22201     7828
20480   16384     7412     7903    23070    23046    22849     7913


With "mmc: core: move the asynchronous post-processing"

time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.0GB) copied, 52.166992 seconds, 19.6MB/s
real    0m 52.17s
user    0m 0.01s
sys     0m 6.96s

mount /dev/mmcblk0p1 /mnt/
cd /mnt/
time find . > /dev/null
real    0m 3.88s
user    0m 0.35s
sys     0m 1.60s

Command line used: iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test
Output is in kBytes/sec
                                                   random    random
   kB  reclen    write  rewrite    read    reread    read     write
20480       4     2072     2200     6030     6066     6005       40
20480       8     4847     5106     9174     9178     9123       81
20480      16     5791     5934    12301    12299    12260      166
20480      32     6252     6311    14906    14943    14919      337
20480      64     6607     6699    16776    16787    16756      690
20480     128     6836     6880    17868    17880    17873     1419
20480     256     6967     6955    18442    17112    18490     3072
20480     512     7320     7359    18818    18738    18477     7310
20480    1024     7350     7426    18297    18551    18357     7429
20480    2048     7439     7476    18035    19111    17670     7486
20480    4096     7655     7728    19688    19557    19758     7738
20480    8192     7640     7848    20675    20718    20787     7823
20480   16384     7489     7934    21225    21186    21555     7943


With "mmc: queue: issue requests in massive parallel"

time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.0GB) copied, 49.308167 seconds, 20.8MB/s
real    0m 49.31s
user    0m 0.00s
sys     0m 7.11s

mount /dev/mmcblk0p1 /mnt/
cd /mnt/
time find . > /dev/null
real    0m 3.70s
user    0m 0.19s
sys     0m 1.73s

Command line used: iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test
Output is in kBytes/sec
                                                   random    random
   kB  reclen    write  rewrite    read    reread    read     write
20480       4     1709     1761     5963     5321     5909       40
20480       8     4736     5059     9089     9092     9055       81
20480      16     5772     5928    12217    12229    12184      165
20480      32     6237     6279    14898    14899    14875      336
20480      64     6599     6663    16759    16760    16741      683
20480     128     6804     6790    17869    17869    17864     1393
20480     256     6863     6883    18485    18488    18501     3105
20480     512     7223     7249    18807    18810    18812     7259
20480    1024     7311     7321    18684    18467    18201     7328
20480    2048     7405     7457    18560    18044    18343     7451
20480    4096     7596     7684    20742    21154    21153     7711
20480    8192     7593     7802    21743    21721    22090     7804
20480   16384     7399     7873    21539    22670    22828     7876


With "RFC: mmc: switch MMC/SD to use blk-mq multiqueueing v3"

time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.0GB) copied, 46.240479 seconds, 22.1MB/s
real    0m 46.25s
user    0m 0.03s
sys     0m 6.42s

mount /dev/mmcblk0p1 /mnt/
cd /mnt/
time find . > /dev/null
real    0m 4.13s
user    0m 0.40s
sys     0m 1.64s

Command line used: iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test
Output is in kBytes/sec
                                                   random    random
   kB  reclen    write  rewrite    read    reread    read     write
20480       4     1786     1806     6055     6061     5360       40
20480       8     4849     5088     9167     9175     9120       81
20480      16     5807     5975    12273    12256    12240      166
20480      32     6275     6317    14929    14931    14905      338
20480      64     6629     6708    16755    16783    16758      688
20480     128     6856     6884    17890    17804    17873     1420
20480     256     6927     6946    18104    17826    18389     3038
20480     512     7296     7280    18720    18752    18819     7284
20480    1024     7286     7415    18583    18598    18516     7403
20480    2048     7435     7470    18378    18268    18682     7471
20480    4096     7670     7786    21364    21275    20761     7766
20480    8192     7637     7868    22193    21994    22100     7850
20480   16384     7416     7921    23050    23051    22726     7955


The iozone results seem a bit consistent and all values seem to
be noisy and not say much. I don't know why really, maybe the test
is simply not relevant, the tests don't seem to be significantly
affected by any of the patches, so let's focus on the dd and find
tests.

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
  "RFC: mmc: switch MMC/SD to use blk-mq multiqueueing v3"

What immediately jumps out at you is that linear read/writes
perform just as nicely or actually better with MQ than with the
old block layer.

What is amazing is that just a little randomness, such as the
find . > /dev/null immediately seems to visibly regress with MQ.
My best guess is that it is caused by the absence of the block
scheduler.

I do not know if my conclusions are right or anything, please
scrutinize.

Linus Walleij (16):
  mmc: core: move some code in mmc_start_areq()
  mmc: core: refactor asynchronous request finalization
  mmc: core: refactor mmc_request_done()
  mmc: core: move the asynchronous post-processing
  mmc: core: add a kthread for completing requests
  mmc: core: replace waitqueue with worker
  mmc: core: do away with is_done_rcv
  mmc: core: do away with is_new_req
  mmc: core: kill off the context info
  mmc: queue: simplify queue logic
  mmc: block: shuffle retry and error handling
  mmc: queue: stop flushing the pipeline with NULL
  mmc: queue: issue struct mmc_queue_req items
  mmc: queue: get/put struct mmc_queue_req
  mmc: queue: issue requests in massive parallel
  RFC: mmc: switch MMC/SD to use blk-mq multiqueueing v3

 drivers/mmc/core/block.c | 426 +++++++++++++++++++++++------------------------
 drivers/mmc/core/block.h |  10 +-
 drivers/mmc/core/bus.c   |   1 -
 drivers/mmc/core/core.c  | 228 ++++++++++++-------------
 drivers/mmc/core/core.h  |   2 -
 drivers/mmc/core/host.c  |   2 +-
 drivers/mmc/core/queue.c | 337 ++++++++++++++-----------------------
 drivers/mmc/core/queue.h |  21 ++-
 include/linux/mmc/core.h |   9 +-
 include/linux/mmc/host.h |  24 +--
 10 files changed, 481 insertions(+), 579 deletions(-)

-- 
2.9.3
