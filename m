Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v5] Make background writeback great again for the first
 time
To: Jan Kara <jack@suse.cz>
References: <1461686131-22999-1-git-send-email-axboe@fb.com>
 <20160427180105.GA17362@quack2.suse.cz> <5721021E.8060006@fb.com>
 <20160427203708.GA25397@kernel.dk> <20160427205915.GC25397@kernel.dk>
 <20160428115401.GD17362@quack2.suse.cz> <57225A91.50002@kernel.dk>
 <20160503121719.GA25436@quack2.suse.cz>
 <20160511163608.GG14744@quack2.suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, dchinner@redhat.com, sedat.dilek@gmail.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57361CF6.3040202@kernel.dk>
Date: Fri, 13 May 2016 12:29:10 -0600
MIME-Version: 1.0
In-Reply-To: <20160511163608.GG14744@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/11/2016 10:36 AM, Jan Kara wrote:
> On Tue 03-05-16 14:17:19, Jan Kara wrote:
>> The question remains how common a pattern where throttling of background
>> writeback delays also something else is. I'll schedule a couple of
>> benchmarks to measure impact of your patches for a wider range of workloads
>> (but sadly pretty limited set of hw). If ext3 is the only one seeing
>> issues, I would be willing to accept that ext3 takes the hit since it is
>> doing something rather stupid (but inherent in its journal design) and we
>> have a way to deal with this either by enabling delayed allocation or by
>> turning off the writeback throttling...
>
> So I've run some benchmarks on a machine with 6 GB of RAM and SSD with
> queue depth 32. The filesystem on the disk was XFS this time. I've found
> couple of regressions. A clear one is with dbench (version 4). The average
> throughput numbers look like:
>
> 			Baseline		WBT
> Hmean    mb/sec-1         30.26 (  0.00%)       18.67 (-38.28%)
> Hmean    mb/sec-2         40.71 (  0.00%)       31.25 (-23.23%)
> Hmean    mb/sec-4         52.67 (  0.00%)       46.83 (-11.09%)
> Hmean    mb/sec-8         69.51 (  0.00%)       64.35 ( -7.42%)
> Hmean    mb/sec-16        91.07 (  0.00%)       86.46 ( -5.07%)
> Hmean    mb/sec-32       115.10 (  0.00%)      110.29 ( -4.18%)
> Hmean    mb/sec-64       145.14 (  0.00%)      134.97 ( -7.00%)
> Hmean    mb/sec-512       93.99 (  0.00%)      133.85 ( 42.41%)
>
> There were also some losses in a filebench webproxy workload (I can give
> you exact details of the settings if you want to reproduce it).
>
> Also, and this really puzzles me, I've seen higher read latencies in some
> cases (I've verified they are not just noise by rerunning the test for
> kernel with writeback throttling patches). For example with the following
> fio job file:
>
> [global]
> direct=0
> ioengine=sync
> runtime=300
> time_based
> invalidate=1
> blocksize=4096
> size=10g        # Just random value, we are running time based workload
> log_avg_msec=10
> group_reporting=1
>
> [writer]
> nrfiles=1
> filesize=1g
> fdatasync=256
> readwrite=randwrite
> numjobs=4
>
> [reader]
> # Simulate random reading from different files, switching to different file
> # after 16 ios. This somewhat simulates application startup.
> new_group
> filesize=100m
> nrfiles=20
> file_service_type=random:16
> readwrite=randread
>
> I get the following results:
>
> Throughput			Baseline		WBT
> Hmean    kb/sec-writer-write      591.60 (  0.00%)      507.00 (-14.30%)
> Hmean    kb/sec-reader-read       211.81 (  0.00%)      137.53 (-35.07%)
>
> So both read and write throughput have suffered. And latencies don't offset
> for the loss either:
>
> FIO read latency
> Min         latency-read     1383.00 (  0.00%)     1519.00 ( -9.83%)
> 1st-qrtle   latency-read     3485.00 (  0.00%)     5235.00 (-50.22%)
> 2nd-qrtle   latency-read     4708.00 (  0.00%)    15028.00 (-219.20%)
> 3rd-qrtle   latency-read    10286.00 (  0.00%)    57622.00 (-460.20%)
> Max-90%     latency-read   195834.00 (  0.00%)   167149.00 ( 14.65%)
> Max-93%     latency-read   273145.00 (  0.00%)   200319.00 ( 26.66%)
> Max-95%     latency-read   335434.00 (  0.00%)   220695.00 ( 34.21%)
> Max-99%     latency-read   537017.00 (  0.00%)   347174.00 ( 35.35%)
> Max         latency-read   991101.00 (  0.00%)   485835.00 ( 50.98%)
> Mean        latency-read    51282.79 (  0.00%)    49953.95 (  2.59%)
>
> So we have reduced the extra high read latencies which is nice but on
> average there is no change.
>
> And another fio jobfile which doesn't look great:
>
> [global]
> direct=0
> ioengine=sync
> runtime=300
> blocksize=4096
> invalidate=1
> time_based
> ramp_time=5     # Let the flusher thread start before taking measurements
> log_avg_msec=10
> group_reporting=1
>
> [writer]
> nrfiles=1
> filesize=$((MEMTOTAL_BYTES*2))
> readwrite=randwrite
>
> [reader]
> # Simulate random reading from different files, switching to different file
> # after 16 ios. This somewhat simulates application startup.
> new_group
> filesize=100m
> nrfiles=20
> file_service_type=random:16
> readwrite=randread
>
> The throughput numbers look like:
> Hmean    kb/sec-writer-write    24707.22 (  0.00%)    19912.23 (-19.41%)
> Hmean    kb/sec-reader-read       886.65 (  0.00%)      905.71 (  2.15%)
>
> So we've got significant hit in writes not really offset by a big increase
> in reads. Read latency numbers look like (I show the WBT numbers for two runs
> just so that one can see how variable the latency numbers are because I was
> puzzled by very high max latency for WBT kernels - quartiles seem rather
> stable higher percentiles and min/max are rather variable):
>
> 			   Baseline		WBT			WBT
> Min         latency-read     1230.00 (  0.00%)     1560.00 (-26.83%)	1100.00 ( 10.57%)
> 1st-qrtle   latency-read     3357.00 (  0.00%)     3351.00 (  0.18%)	3351.00 (  0.18%)
> 2nd-qrtle   latency-read     4074.00 (  0.00%)     4056.00 (  0.44%)	4022.00 (  1.28%)
> 3rd-qrtle   latency-read     5198.00 (  0.00%)     5145.00 (  1.02%)	5095.00 (  1.98%)
> Max-90%     latency-read     6594.00 (  0.00%)     6370.00 (  3.40%)	6130.00 (  7.04%)
> Max-93%     latency-read    11251.00 (  0.00%)     9410.00 ( 16.36%)	6654.00 ( 40.86%)
> Max-95%     latency-read    14769.00 (  0.00%)    13231.00 ( 10.41%)	10306.00 ( 30.22%)
> Max-99%     latency-read    27826.00 (  0.00%)    28728.00 ( -3.24%)	25077.00 (  9.88%)
> Max         latency-read    80202.00 (  0.00%)   186491.00 (-132.53%)	141346.00 (-76.24%)
> Mean        latency-read     5356.12 (  0.00%)     5229.00 (  2.37%)	4927.23 (  8.01%)
>
> I have run also other tests but they have mostly shown no significant
> difference.

Thanks Jan, this is great and super useful! I'm revamping certain parts 
of it to deal with write back caching better, and I'll take a look at 
the regressions that you reported.

What kind of SSD is this? I'm assuming it's SATA (QD=32), and then it 
would probably be a safe assumption that it's flagging itself as having 
a volatile write back cache, would that be a correct assumption?

Are you using scsi-mq, or do you have an IO scheduler attached to it?

-- 
Jens Axboe
