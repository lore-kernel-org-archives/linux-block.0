Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:46968 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753559AbdKQAow (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Nov 2017 19:44:52 -0500
Received: by mail-qt0-f180.google.com with SMTP id r39so2184204qtr.13
        for <linux-block@vger.kernel.org>; Thu, 16 Nov 2017 16:44:51 -0800 (PST)
MIME-Version: 1.0
From: Ivan Babrou <ibobrik@gmail.com>
Date: Thu, 16 Nov 2017 16:44:20 -0800
Message-ID: <CANWdNRA0uspz0SESyPLfBS8tXgtpzz8Ez2JrBZ=QVwPtbUDDuA@mail.gmail.com>
Subject: Buffered IO performance hit
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

We are seeing high IO spikes during writeback. While writes can
obviously slow down reads, we don't see the issue with direct IO. We
tested different schedulers, writeback throttling and a bunch of
different machines with on 4.9 and 4.14 with both SATA and NVMe
devices. The results are very consistent.

There's a bunch of numbers, but please bear with me. TL;DR: writeback
elevates latencies a lot more than direct writes.

Consider the following fio scenario:

[global]
direct=1
runtime=30m
group_reporting
time_based

[randread]
rw=randread
size=1g
bs=4k
numjobs=20

We run this on 4.9.59 with XFS on Micron 1100 SSD with deadline
scheduler. It's a dedicated disk with no activity besides our tests.
With no writes present, xfsdist from bcc-tools reports the following
latency distribution (in milliseconds):

$ sudo /usr/share/bcc/tools/xfsdist -m
Tracing XFS operation latency... Hit Ctrl-C to end.
^C

operation = 'read'
     msecs               : count     distribution
         0 -> 1          : 482298   |****************************************|

All reads completing under a millisecond here. Here's the output from fio:

$ sudo fio ~/slowread.fio
randread: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=sync, iodepth=1
...
fio-2.1.11
Starting 20 processes
^Cbs: 20 (f=20): [r(20)] [3.8% done] [312.1MB/0KB/0KB /s] [80.2K/0/0
iops] [eta 28m:52s]
fio: terminating on signal 2

randread: (groupid=0, jobs=20): err= 0: pid=11804: Wed Nov 15 01:22:00 2017
  read : io=21197MB, bw=317816KB/s, iops=79453, runt= 68297msec
    clat (usec): min=64, max=6860, avg=250.49, stdev=93.80
     lat (usec): min=64, max=6860, avg=250.56, stdev=93.80
    clat percentiles (usec):
     |  1.00th=[  149],  5.00th=[  159], 10.00th=[  165], 20.00th=[  177],
     | 30.00th=[  189], 40.00th=[  207], 50.00th=[  225], 60.00th=[  245],
     | 70.00th=[  270], 80.00th=[  310], 90.00th=[  374], 95.00th=[  438],
     | 99.00th=[  580], 99.50th=[  644], 99.90th=[  764], 99.95th=[  820],
     | 99.99th=[  940]
    bw (KB  /s): min=13096, max=16432, per=5.00%, avg=15898.70, stdev=196.77
    lat (usec) : 100=0.01%, 250=61.93%, 500=35.54%, 750=2.40%, 1000=0.12%
    lat (msec) : 2=0.01%, 10=0.01%
  cpu          : usr=0.91%, sys=3.48%, ctx=5426681, majf=0, minf=142
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=5426464/w=0/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: io=21197MB, aggrb=317815KB/s, minb=317815KB/s,
maxb=317815KB/s, mint=68297msec, maxt=68297msec

Disk stats (read/write):
  sdb: ios=5416500/2, merge=0/0, ticks=1323879/1, in_queue=1325625, util=100.00%

All good here.

Let's measure pure write performance:

$ sudo dd if=/dev/zero of=/cache2/zeros bs=1M count=2K oflag=direct
2048+0 records in
2048+0 records out
2147483648 bytes (2.1 GB) copied, 5.06064 s, 424 MB/s

$ sudo /usr/share/bcc/tools/xfsdist -m
Tracing XFS operation latency... Hit Ctrl-C to end.
^C

operation = 'write'
     msecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 2042     |****************************************|
         4 -> 7          : 0        |                                        |
         8 -> 15         : 6        |                                        |

operation = 'open'
     msecs               : count     distribution
         0 -> 1          : 4        |****************************************|


Baseline is between 2ms and 3ms plus a few 8ms spikes.

If we do buffered writes instead of direct writes:

$ sudo dd if=/dev/zero of=/cache2/zeros bs=1M count=2K
2048+0 records in
2048+0 records out
2147483648 bytes (2.1 GB) copied, 4.70492 s, 456 MB/s

ivan@504m5:~$ sudo /usr/share/bcc/tools/xfsdist -m
Tracing XFS operation latency... Hit Ctrl-C to end.
^C

operation = 'write'
     msecs               : count     distribution
         0 -> 1          : 2048     |****************************************|

operation = 'open'
     msecs               : count     distribution
         0 -> 1          : 4        |****************************************|

Latency is lower, which is probably expected.

Let's now mix these scenarios.

* Reads and direct writes

$ sudo fio ~/slowread.fio
randread: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=sync, iodepth=1
...
fio-2.1.11
Starting 20 processes
^Cbs: 20 (f=20): [r(20)] [1.2% done] [311.9MB/0KB/0KB /s] [79.9K/0/0
iops] [eta 29m:40s]
fio: terminating on signal 2

randread: (groupid=0, jobs=20): err= 0: pid=11965: Wed Nov 15 01:25:46 2017
  read : io=5026.1MB, bw=253054KB/s, iops=63263, runt= 20342msec
    clat (usec): min=131, max=14120, avg=314.79, stdev=441.68
     lat (usec): min=131, max=14121, avg=314.87, stdev=441.75
    clat percentiles (usec):
     |  1.00th=[  149],  5.00th=[  157], 10.00th=[  165], 20.00th=[  177],
     | 30.00th=[  191], 40.00th=[  207], 50.00th=[  227], 60.00th=[  249],
     | 70.00th=[  278], 80.00th=[  322], 90.00th=[  402], 95.00th=[  502],
     | 99.00th=[ 2672], 99.50th=[ 3664], 99.90th=[ 4384], 99.95th=[ 4448],
     | 99.99th=[ 4768]
    bw (KB  /s): min= 1197, max=16416, per=4.98%, avg=12608.77, stdev=5953.29
    lat (usec) : 250=60.53%, 500=34.40%, 750=2.32%, 1000=0.19%
    lat (msec) : 2=0.26%, 4=1.82%, 10=0.47%, 20=0.01%
  cpu          : usr=0.65%, sys=2.96%, ctx=1286981, majf=0, minf=139
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=1286905/w=0/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: io=5026.1MB, aggrb=253053KB/s, minb=253053KB/s,
maxb=253053KB/s, mint=20342msec, maxt=20342msec

Disk stats (read/write):
  sdb: ios=1271838/4099, merge=0/1, ticks=392418/6967,
in_queue=399788, util=99.60%

$ sudo dd if=/dev/zero of=/cache2/zeros bs=1M count=2K oflag=direct
2048+0 records in
2048+0 records out
2147483648 bytes (2.1 GB) copied, 4.69243 s, 458 MB/s

$ sudo /usr/share/bcc/tools/xfsdist -m
Tracing XFS operation latency... Hit Ctrl-C to end.
^C

operation = 'read'
     msecs               : count     distribution
         0 -> 1          : 792289   |****************************************|
         2 -> 3          : 22484    |*                                       |
         4 -> 7          : 5817     |                                        |
         8 -> 15         : 112      |                                        |

operation = 'write'
     msecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 2042     |****************************************|
         4 -> 7          : 0        |                                        |
         8 -> 15         : 6        |                                        |

operation = 'open'
     msecs               : count     distribution
         0 -> 1          : 1        |****************************************|

Reads are definitely slower now. This is expected, because writes
occupy some bandwidth.

* Reads and buffered writes

$ sudo fio ~/slowread.fio
randread: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=sync, iodepth=1
...
fio-2.1.11
Starting 20 processes
^Cbs: 20 (f=20): [r(20)] [1.2% done] [309.6MB/0KB/0KB /s] [79.3K/0/0
iops] [eta 29m:38s]
fio: terminating on signal 2

randread: (groupid=0, jobs=20): err= 0: pid=12011: Wed Nov 15 01:27:00 2017
  read : io=5344.6MB, bw=255500KB/s, iops=63874, runt= 21420msec
    clat (usec): min=88, max=129414, avg=311.99, stdev=2022.27
     lat (usec): min=88, max=129415, avg=312.06, stdev=2022.29
    clat percentiles (usec):
     |  1.00th=[  149],  5.00th=[  157], 10.00th=[  165], 20.00th=[  177],
     | 30.00th=[  191], 40.00th=[  207], 50.00th=[  225], 60.00th=[  247],
     | 70.00th=[  274], 80.00th=[  310], 90.00th=[  378], 95.00th=[  442],
     | 99.00th=[  596], 99.50th=[  660], 99.90th=[ 1012], 99.95th=[64256],
     | 99.99th=[75264]
    bw (KB  /s): min=   40, max=16448, per=5.06%, avg=12924.17, stdev=5972.12
    lat (usec) : 100=0.01%, 250=61.56%, 500=35.78%, 750=2.44%, 1000=0.12%
    lat (msec) : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
    lat (msec) : 100=0.08%, 250=0.01%
  cpu          : usr=0.46%, sys=3.19%, ctx=1368274, majf=0, minf=134
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=1368200/w=0/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: io=5344.6MB, aggrb=255499KB/s, minb=255499KB/s,
maxb=255499KB/s, mint=21420msec, maxt=21420msec

Disk stats (read/write):
  sdb: ios=1366013/2048, merge=0/0, ticks=417412/573945,
in_queue=993029, util=99.87%

$ sudo dd if=/dev/zero of=/cache2/zeros bs=1M count=2K
2048+0 records in
2048+0 records out
2147483648 bytes (2.1 GB) copied, 4.83031 s, 445 MB/s

$ sudo /usr/share/bcc/tools/xfsdist -m
Tracing XFS operation latency... Hit Ctrl-C to end.
^C

operation = 'read'
     msecs               : count     distribution
         0 -> 1          : 892854   |****************************************|
         2 -> 3          : 12       |                                        |
         4 -> 7          : 8        |                                        |
         8 -> 15         : 1        |                                        |
        16 -> 31         : 37       |                                        |
        32 -> 63         : 483      |                                        |
        64 -> 127        : 787      |                                        |
       128 -> 255        : 3        |                                        |

operation = 'write'
     msecs               : count     distribution
         0 -> 1          : 2048     |****************************************|

operation = 'open'
     msecs               : count     distribution
         0 -> 1          : 1        |****************************************|

This is a lot worse, even though we wrote the same amount of data into
the same disk. Some reads went up into 100ms+ range, which is not
great for an SSD. Read IOPS in fio drop from 70000 into 700 during
writeback. This doesn't seem right.

Deadline scheduler is the best case here, with cfq we saw 4096ms+
latencies for reads.

Is this expected? How can we improve situation to avoid hitting high latencies?

Thanks.
