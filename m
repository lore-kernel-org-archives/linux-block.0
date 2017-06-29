Return-Path: <BATV+a3f5f3e6054314e6ea5e+5058+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	mgorman@suse.de,
	Volker.Lendecke@sernet.de,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: non-blockling buffered reads
Date: Thu, 29 Jun 2017 14:25:00 -0700
Message-Id: <20170629212503.15110-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This series resurrects the old patches from Milosz to implement
non-blocking buffered reads.  Thanks to the non-blocking AIO code from
Goldwyn the implementation becomes pretty much trivial.  As that
implementation is in the block tree I would suggest that we merge
these patches through the block tree as well.  I've also forward
ported the test Milosz sent for recent xfsprogs to verify it works
properly, but I'll still have to address the review comments for it.
I'll also volunteer to work with Goldwyn to properly document the
RWF_NOWAIT flag in the man page including this change.

Here are additional details from the original cover letter from Milosz,
where the flag was still called RWF_NONBLOCK:


Background:

 Using a threadpool to emulate non-blocking operations on regular buffered
 files is a common pattern today (samba, libuv, etc...) Applications split the
 work between network bound threads (epoll) and IO threadpool. Not every
 application can use sendfile syscall (TLS / post-processing).

 This common pattern leads to increased request latency. Latency can be due to
 additional synchronization between the threads or fast (cached data) request
 stuck behind slow request (large / uncached data).

 The preadv2 syscall with RWF_NONBLOCK lets userspace applications bypass
 enqueuing operation in the threadpool if it's already available in the
 pagecache.


Performance numbers (newer Samba):

 https://drive.google.com/file/d/0B3maCn0jCvYncndGbXJKbGlhejQ/view?usp=sharing
 https://docs.google.com/spreadsheets/d/1GGTivi-MfZU0doMzomG4XUo9ioWtRvOGQ5FId042L6s/edit?usp=sharing


Performance number (older):

 Some perf data generated using fio comparing the posix aio engine to a version
 of the posix AIO engine that attempts to performs "fast" reads before
 submitting the operations to the queue. This workflow is on ext4 partition on
 raid0 (test / build-rig.) Simulating our database access patern workload using
 16kb read accesses. Our database uses a home-spun posix aio like queue (samba
 does the same thing.)

 f1: ~73% rand read over mostly cached data (zipf med-size dataset)
 f2: ~18% rand read over mostly un-cached data (uniform large-dataset)
 f3: ~9% seq-read over large dataset

 before:

 f1:
     bw (KB  /s): min=   11, max= 9088, per=0.56%, avg=969.54, stdev=827.99
     lat (msec) : 50=0.01%, 100=1.06%, 250=5.88%, 500=4.08%, 750=12.48%
     lat (msec) : 1000=17.27%, 2000=49.86%, >=2000=9.42%
 f2:
     bw (KB  /s): min=    2, max= 1882, per=0.16%, avg=273.28, stdev=220.26
     lat (msec) : 250=5.65%, 500=3.31%, 750=15.64%, 1000=24.59%, 2000=46.56%
     lat (msec) : >=2000=4.33%
 f3:
     bw (KB  /s): min=    0, max=265568, per=99.95%, avg=174575.10,
                  stdev=34526.89
     lat (usec) : 2=0.01%, 4=0.01%, 10=0.02%, 20=0.27%, 50=10.82%
     lat (usec) : 100=50.34%, 250=5.05%, 500=7.12%, 750=6.60%, 1000=4.55%
     lat (msec) : 2=8.73%, 4=3.49%, 10=1.83%, 20=0.89%, 50=0.22%
     lat (msec) : 100=0.05%, 250=0.02%, 500=0.01%
 total:
    READ: io=102365MB, aggrb=174669KB/s, minb=240KB/s, maxb=173599KB/s,
          mint=600001msec, maxt=600113msec

 after (with fast read using preadv2 before submit):

 f1:
     bw (KB  /s): min=    3, max=14897, per=1.28%, avg=2276.69, stdev=2930.39
     lat (usec) : 2=70.63%, 4=0.01%
     lat (msec) : 250=0.20%, 500=2.26%, 750=1.18%, 2000=0.22%, >=2000=25.53%
 f2:
     bw (KB  /s): min=    2, max= 2362, per=0.14%, avg=249.83, stdev=222.00
     lat (msec) : 250=6.35%, 500=1.78%, 750=9.29%, 1000=20.49%, 2000=52.18%
     lat (msec) : >=2000=9.99%
 f3:
     bw (KB  /s): min=    1, max=245448, per=100.00%, avg=177366.50,
                  stdev=35995.60
     lat (usec) : 2=64.04%, 4=0.01%, 10=0.01%, 20=0.06%, 50=0.43%
     lat (usec) : 100=0.20%, 250=1.27%, 500=2.93%, 750=3.93%, 1000=7.35%
     lat (msec) : 2=14.27%, 4=2.88%, 10=1.54%, 20=0.81%, 50=0.22%
     lat (msec) : 100=0.05%, 250=0.02%
 total:
    READ: io=103941MB, aggrb=177339KB/s, minb=213KB/s, maxb=176375KB/s,
          mint=600020msec, maxt=600178msec

 Interpreting the results you can see total bandwidth stays the same but overall
 request latency is decreased in f1 (random, mostly cached) and f3 (sequential)
 workloads. There is a slight bump in latency for since it's random data that's
 unlikely to be cached but we're always trying "fast read".

 In our application we have starting keeping track of "fast read" hits/misses
 and for files / requests that have a lot hit ratio we don't do "fast reads"
 mostly getting rid of extra latency in the uncached cases. In our real world
 work load we were able to reduce average response time by 20 to 30% (depends
 on amount of IO done by request).

 I've performed other benchmarks and I have no observed any perf regressions in
 any of the normal (old) code paths.
