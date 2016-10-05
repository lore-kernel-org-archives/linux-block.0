Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:32876 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753768AbcJECB6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 22:01:58 -0400
Date: Wed, 5 Oct 2016 11:01:53 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/3] zram: support page-based parallel write
Message-ID: <20161005020153.GA2988@bbox>
References: <1474526565-6676-1-git-send-email-minchan@kernel.org>
 <1474526565-6676-2-git-send-email-minchan@kernel.org>
 <20160929031831.GA1175@swordfish>
 <20160930055221.GA16293@bbox>
 <20161004044314.GA835@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004044314.GA835@swordfish>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Sergey,

On Tue, Oct 04, 2016 at 01:43:14PM +0900, Sergey Senozhatsky wrote:

< snip >

> TEST
> ****
> 
> new tests results; same tests, same conditions, same .config.
> 4-way test:
> - BASE zram, fio direct=1
> - BASE zram, fio fsync_on_close=1
> - NEW zram, fio direct=1
> - NEW zram, fio fsync_on_close=1
> 
> 
> 
> and what I see is that:
>  - new zram is x3 times slower when we do a lot of direct=1 IO
> and
>  - 10% faster when we use buffered IO (fsync_on_close); but not always;
>    for instance, test execution time is longer (a reproducible behavior)
>    when the number of jobs equals the number of CPUs - 4.
> 
> 
> 
> if flushing is a problem for new zram during direct=1 test, then I would
> assume that writing a huge number of small files (creat/write 4k/close)
> would probably have same fsync_on_close=1 performance as direct=1.
> 
> 
> ENV
> ===
> 
>    x86_64 SMP (4 CPUs), "bare zram" 3g, lzo, static compression buffer.
> 
> 
> TEST COMMAND
> ============
> 
>   ZRAM_SIZE=3G ZRAM_COMP_ALG=lzo LOG_SUFFIX={NEW, OLD} FIO_LOOPS=2 ./zram-fio-test.sh
> 
> 
> EXECUTED TESTS
> ==============
> 
>   - [seq-read]
>   - [rand-read]
>   - [seq-write]
>   - [rand-write]
>   - [mixed-seq]
>   - [mixed-rand]
> 
> 
> fio-perf-o-meter.sh test-fio-zram-OLD test-fio-zram-OLD-flush test-fio-zram-NEW test-fio-zram-NEW-flush
> Processing test-fio-zram-OLD
> Processing test-fio-zram-OLD-flush
> Processing test-fio-zram-NEW
> Processing test-fio-zram-NEW-flush
> 
>                 BASE             BASE              NEW             NEW
>                 direct=1         fsync_on_close=1  direct=1        fsync_on_close=1
> 
> #jobs1                         	                	                	                
> READ:           2345.1MB/s	 2177.2MB/s	 2373.2MB/s	 2185.8MB/s
> READ:           1948.2MB/s	 1417.7MB/s	 1987.7MB/s	 1447.4MB/s
> WRITE:          1292.7MB/s	 1406.1MB/s	 275277KB/s	 1521.1MB/s
> WRITE:          1047.5MB/s	 1143.8MB/s	 257140KB/s	 1202.4MB/s
> READ:           429530KB/s	 779523KB/s	 175450KB/s	 782237KB/s
> WRITE:          429840KB/s	 780084KB/s	 175576KB/s	 782800KB/s
> READ:           414074KB/s	 408214KB/s	 164091KB/s	 383426KB/s
> WRITE:          414402KB/s	 408539KB/s	 164221KB/s	 383730KB/s


I tested your benchmark for job 1 on my 4 CPU mahcine with this diff.

Nothing different.

1. just changed ordering of test execution - hope to reduce testing time due to
   block population before the first reading or reading just zero pages
2. used sync_on_close instead of direct io
3. Don't use perf to avoid noise
4. echo 0 > /sys/block/zram0/use_aio to test synchronous IO for old behavior

diff --git a/conf/fio-template-static-buffer b/conf/fio-template-static-buffer
index 1a9a473..22ddee8 100644
--- a/conf/fio-template-static-buffer
+++ b/conf/fio-template-static-buffer
@@ -1,7 +1,7 @@
 [global]
 bs=${BLOCK_SIZE}k
 ioengine=sync
-direct=1
+fsync_on_close=1
 nrfiles=${NRFILES}
 size=${SIZE}
 numjobs=${NUMJOBS}
@@ -14,18 +14,18 @@ new_group
 group_reporting
 threads=1
 
-[seq-read]
-rw=read
-
-[rand-read]
-rw=randread
-
 [seq-write]
 rw=write
 
 [rand-write]
 rw=randwrite
 
+[seq-read]
+rw=read
+
+[rand-read]
+rw=randread
+
 [mixed-seq]
 rw=rw
 
diff --git a/zram-fio-test.sh b/zram-fio-test.sh
index 39c11b3..ca2d065 100755
--- a/zram-fio-test.sh
+++ b/zram-fio-test.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 
 # Sergey Senozhatsky. sergey.senozhatsky@gmail.com
@@ -37,6 +37,7 @@ function create_zram
 	echo $ZRAM_COMP_ALG > /sys/block/zram0/comp_algorithm
 	cat /sys/block/zram0/comp_algorithm
 
+	echo 0 > /sys/block/zram0/use_aio
 	echo $ZRAM_SIZE > /sys/block/zram0/disksize
 	if [ $? != 0 ]; then
 		return -1
@@ -137,7 +138,7 @@ function main
 		echo "#jobs$i fio" >> $LOG
 
 		BLOCK_SIZE=4 SIZE=100% NUMJOBS=$i NRFILES=$i FIO_LOOPS=$FIO_LOOPS \
-			$PERF stat -o $LOG-perf-stat $FIO ./$FIO_TEMPLATE >> $LOG
+			$FIO ./$FIO_TEMPLATE > $LOG
 
 		echo -n "perfstat jobs$i" >> $LOG
 		cat $LOG-perf-stat >> $LOG

And got following result.

1. ZRAM_SIZE=3G ZRAM_COMP_ALG=lzo LOG_SUFFIX=async FIO_LOOPS=2 MAX_ITER=1 ./zram-fio-test.sh
2. modify script to disable aio via /sys/block/zram0/use_aio
   ZRAM_SIZE=3G ZRAM_COMP_ALG=lzo LOG_SUFFIX=sync FIO_LOOPS=2 MAX_ITER=1 ./zram-fio-test.sh

      seq-write     380930     474325     124.52%
     rand-write     286183     357469     124.91%
       seq-read     266813     265731      99.59%
      rand-read     211747     210670      99.49%
   mixed-seq(R)     145750     171232     117.48%
   mixed-seq(W)     145736     171215     117.48%
  mixed-rand(R)     115355     125239     108.57%
  mixed-rand(W)     115371     125256     108.57%

LZO compression is fast and a CPU for queueing while 3 CPU for compressing
it cannot saturate CPU full bandwidth. Nonetheless, it shows 24% enhancement.
It could be more in slow CPU like embedded.

I tested it with deflate. The result is 300% enhancement.

      seq-write      33598     109882     327.05%
     rand-write      32815     102293     311.73%
       seq-read     154323     153765      99.64%
      rand-read     129978     129241      99.43%
   mixed-seq(R)      15887      44995     283.22%
   mixed-seq(W)      15885      44990     283.22%
  mixed-rand(R)      25074      55491     221.31%
  mixed-rand(W)      25078      55499     221.31%

So, curious with your test.
Am my test sync with yours? If you cannot see enhancment in job1, could
you test with deflate? It seems your CPU is really fast.
