Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82504C31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 07:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CF8205ED
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 07:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390208AbfFLHIL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:08:11 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:33866 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390376AbfFLHIL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 03:08:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TTytGML_1560323285;
Received: from 30.5.114.20(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TTytGML_1560323285)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Jun 2019 15:08:06 +0800
Subject: Re: [RFC] block: add counter to track io request's d2c time
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>
References: <20190604012855.1679-1-xiaoguang.wang@linux.alibaba.com>
 <BYAPR04MB5749B89B96684EA3540E0DE886150@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <1f1e0aec-eb3c-a5b0-3ea1-f7c89d12e8af@linux.alibaba.com>
Date:   Wed, 12 Jun 2019 15:08:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749B89B96684EA3540E0DE886150@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: multipart/mixed;
 boundary="------------3219CC6A25AF2399A29A01E4"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------3219CC6A25AF2399A29A01E4
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit

hi,

Sorry for being late.
I had written a simple iostat patch to show requests's d2c time, the output looks like
below:
Device            r/s     rMB/s   rrqm/s  %rrqm r_await r_d2c_await rareq-sz     w/s     wMB/s   wrqm/s  %wrqm w_await w_d2c_await wareq-sz     d/s     dMB/s   drqm/s  %drqm d_await d_d2c_await 
dareq-sz  aqu-sz  %util
vdb            132.00      3.54     0.50   0.38   21.07       21.02    27.47 6125.00     94.62  5998.00  49.48    3.99        3.55    15.82    0.00      0.00     0.00   0.00    0.00        0.00 
0.00   24.43  47.65


Device            r/s     rMB/s   rrqm/s  %rrqm r_await r_d2c_await rareq-sz     w/s     wMB/s   wrqm/s  %wrqm w_await w_d2c_await wareq-sz     d/s     dMB/s   drqm/s  %drqm d_await d_d2c_await 
dareq-sz  aqu-sz  %util
vdb             84.50      2.42     0.00   0.00   36.98       36.72    29.33 3000.00     48.85  3028.50  50.24    4.82        4.17    16.67    0.00      0.00     0.00   0.00    0.00        0.00 
0.00   16.23  29.55


Device            r/s     rMB/s   rrqm/s  %rrqm r_await r_d2c_await rareq-sz     w/s     wMB/s   wrqm/s  %wrqm w_await w_d2c_await wareq-sz     d/s     dMB/s   drqm/s  %drqm d_await d_d2c_await 
dareq-sz  aqu-sz  %util
vdb            114.50      2.84     0.00   0.00   27.83       27.83    25.43 4830.00     76.91  4819.00  49.94    2.58        2.40    16.30    0.00      0.00     0.00   0.00    0.00        0.00 
0.00   13.31  33.75

You can check r_d2c_await, w_d2c_await and d_d2c_await fields, I think these d2c info
are useful, we can cleary see io's latency distribution. For example, if d2c await is high,
it's much likely that storage device's bottleneck is reached.

Here I put this patch in attachment, please have a check, and currently this patch
is just a trial, I'll make a formal iostat patch to sysstat community if the kernel patch
has been thought useful :)

Regards,
Xiaoguang Wang


> In case I missed, is it possible to include iostat patch corresponding
> to this kernel patch ?
> 
> On 6/3/19 6:29 PM, Xiaoguang Wang wrote:
>> Indeed tool iostat's await is not good enough, which is somewhat sketchy
>> and could not show request's latency on device driver's side.
>>
>> Here we add a new counter to track io request's d2c time, also with this
>> patch, we can extend iostat to show this value easily.
>>
>> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
>> ---
>>    block/blk-core.c          | 3 +++
>>    block/genhd.c             | 7 +++++--
>>    block/partition-generic.c | 8 ++++++--
>>    include/linux/genhd.h     | 4 ++++
>>    4 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index ee1b35fe8572..b0449ec80a7d 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1257,6 +1257,9 @@ void blk_account_io_done(struct request *req, u64 now)
>>    		update_io_ticks(part, jiffies);
>>    		part_stat_inc(part, ios[sgrp]);
>>    		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>> +		if (req->io_start_time_ns)
>> +			part_stat_add(part, d2c_nsecs[sgrp],
>> +				      now - req->io_start_time_ns);
>>    		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
>>    		part_dec_in_flight(req->q, part, rq_data_dir(req));
>>    
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 24654e1d83e6..727bc1de1a74 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -1377,7 +1377,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>>    			   "%lu %lu %lu %u "
>>    			   "%lu %lu %lu %u "
>>    			   "%u %u %u "
>> -			   "%lu %lu %lu %u\n",
>> +			   "%lu %lu %lu %u %u %u %u\n",
>>    			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
>>    			   disk_name(gp, hd->partno, buf),
>>    			   part_stat_read(hd, ios[STAT_READ]),
>> @@ -1394,7 +1394,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>>    			   part_stat_read(hd, ios[STAT_DISCARD]),
>>    			   part_stat_read(hd, merges[STAT_DISCARD]),
>>    			   part_stat_read(hd, sectors[STAT_DISCARD]),
>> -			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD)
>> +			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD),
>> +			   (unsigned int)part_stat_read_d2c_msecs(hd, STAT_READ),
>> +			   (unsigned int)part_stat_read_d2c_msecs(hd, STAT_WRITE),
>> +			   (unsigned int)part_stat_read_d2c_msecs(hd, STAT_DISCARD)
>>    			);
>>    	}
>>    	disk_part_iter_exit(&piter);
>> diff --git a/block/partition-generic.c b/block/partition-generic.c
>> index aee643ce13d1..0635a46a31dd 100644
>> --- a/block/partition-generic.c
>> +++ b/block/partition-generic.c
>> @@ -127,7 +127,7 @@ ssize_t part_stat_show(struct device *dev,
>>    		"%8lu %8lu %8llu %8u "
>>    		"%8lu %8lu %8llu %8u "
>>    		"%8u %8u %8u "
>> -		"%8lu %8lu %8llu %8u"
>> +		"%8lu %8lu %8llu %8u %8u %8u %8u %8u"
>>    		"\n",
>>    		part_stat_read(p, ios[STAT_READ]),
>>    		part_stat_read(p, merges[STAT_READ]),
>> @@ -143,7 +143,11 @@ ssize_t part_stat_show(struct device *dev,
>>    		part_stat_read(p, ios[STAT_DISCARD]),
>>    		part_stat_read(p, merges[STAT_DISCARD]),
>>    		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
>> -		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD));
>> +		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),
>> +		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),
>> +		(unsigned int)part_stat_read_d2c_msecs(p, STAT_READ),
>> +		(unsigned int)part_stat_read_d2c_msecs(p, STAT_WRITE),
>> +		(unsigned int)part_stat_read_d2c_msecs(p, STAT_DISCARD));
>>    }
>>    
>>    ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>> index 8b5330dd5ac0..f80ba947cac2 100644
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -85,6 +85,7 @@ struct partition {
>>    
>>    struct disk_stats {
>>    	u64 nsecs[NR_STAT_GROUPS];
>> +	u64 d2c_nsecs[NR_STAT_GROUPS];
>>    	unsigned long sectors[NR_STAT_GROUPS];
>>    	unsigned long ios[NR_STAT_GROUPS];
>>    	unsigned long merges[NR_STAT_GROUPS];
>> @@ -367,6 +368,9 @@ static inline void free_part_stats(struct hd_struct *part)
>>    #define part_stat_read_msecs(part, which)				\
>>    	div_u64(part_stat_read(part, nsecs[which]), NSEC_PER_MSEC)
>>    
>> +#define part_stat_read_d2c_msecs(part, which)				\
>> +	div_u64(part_stat_read(part, d2c_nsecs[which]), NSEC_PER_MSEC)
>> +
>>    #define part_stat_read_accum(part, field)				\
>>    	(part_stat_read(part, field[STAT_READ]) +			\
>>    	 part_stat_read(part, field[STAT_WRITE]) +			\
>>
> 

--------------3219CC6A25AF2399A29A01E4
Content-Type: text/plain; charset=UTF-8;
 name="0001-iostat-add-initial-support-for-io-s-d2c-info.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-iostat-add-initial-support-for-io-s-d2c-info.patch"

From 48348a9a079c0d9e05c5620d09a85bc082ee7dc2 Mon Sep 17 00:00:00 2001
From: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Date: Wed, 12 Jun 2019 14:26:23 +0800
Subject: [PATCH] iostat: add initial support for io's d2c info

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 iostat.c    | 77 +++++++++++++++++++++++++++++++++++++++++++++--------
 iostat.h    | 12 +++++++++
 raw_stats.c |  8 +++++-
 rd_stats.h  |  3 +++
 4 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/iostat.c b/iostat.c
index 897104e..ccce008 100644
--- a/iostat.c
+++ b/iostat.c
@@ -524,15 +524,17 @@ int read_sysfs_file_stat(int curr, char *filename, char *dev_name, int iodev_nr)
 	unsigned long rd_ios, rd_merges_or_rd_sec, wr_ios, wr_merges;
 	unsigned long rd_sec_or_wr_ios, wr_sec, rd_ticks_or_wr_sec;
 	unsigned long dc_ios, dc_merges, dc_sec, dc_ticks;
+	unsigned long rd_d2c_ticks, wr_d2c_ticks, dc_d2c_ticks;
 
 	/* Try to read given stat file */
 	if ((fp = fopen(filename, "r")) == NULL)
 		return 0;
 
-	i = fscanf(fp, "%lu %lu %lu %lu %lu %lu %lu %u %u %u %u %lu %lu %lu %lu",
+	i = fscanf(fp, "%lu %lu %lu %lu %lu %lu %lu %u %u %u %u %lu %lu %lu %lu %lu %lu %lu",
 		   &rd_ios, &rd_merges_or_rd_sec, &rd_sec_or_wr_ios, &rd_ticks_or_wr_sec,
 		   &wr_ios, &wr_merges, &wr_sec, &wr_ticks, &ios_pgr, &tot_ticks, &rq_ticks,
-		   &dc_ios, &dc_merges, &dc_sec, &dc_ticks);
+		   &dc_ios, &dc_merges, &dc_sec, &dc_ticks, &rd_d2c_ticks, &wr_d2c_ticks,
+		   &dc_d2c_ticks);
 
 	memset(&sdev, 0, sizeof(struct io_stats));
 
@@ -557,6 +559,13 @@ int read_sysfs_file_stat(int curr, char *filename, char *dev_name, int iodev_nr)
 			sdev.dc_sectors = dc_sec;
 			sdev.dc_ticks   = dc_ticks;
 		}
+
+		if (i == 18) {
+			/* D2c time of io request */
+			sdev.rd_d2c_ticks = rd_d2c_ticks;
+			sdev.wr_d2c_ticks = wr_d2c_ticks;
+			sdev.dc_d2c_ticks = dc_d2c_ticks;
+		}
 	}
 	else if (i == 4) {
 		/* Partition without extended statistics */
@@ -734,6 +743,7 @@ void read_diskstats_stat(int curr, int iodev_nr, int dlist_idx)
 	unsigned long rd_ios, rd_merges_or_rd_sec, rd_ticks_or_wr_sec, wr_ios;
 	unsigned long wr_merges, rd_sec_or_wr_ios, wr_sec;
 	unsigned long dc_ios, dc_merges, dc_sec, dc_ticks;
+	unsigned long rd_d2c_ticks, wr_d2c_ticks, dc_d2c_ticks;
 	char *ioc_dname;
 	unsigned int major, minor;
 
@@ -748,11 +758,12 @@ void read_diskstats_stat(int curr, int iodev_nr, int dlist_idx)
 	while (fgets(line, sizeof(line), fp) != NULL) {
 
 		/* major minor name rio rmerge rsect ruse wio wmerge wsect wuse running use aveq dcio dcmerge dcsect dcuse*/
-		i = sscanf(line, "%u %u %s %lu %lu %lu %lu %lu %lu %lu %u %u %u %u %lu %lu %lu %lu",
+		i = sscanf(line, "%u %u %s %lu %lu %lu %lu %lu %lu %lu %u %u %u %u %lu %lu %lu %lu %lu %lu %lu",
 			   &major, &minor, dev_name,
 			   &rd_ios, &rd_merges_or_rd_sec, &rd_sec_or_wr_ios, &rd_ticks_or_wr_sec,
 			   &wr_ios, &wr_merges, &wr_sec, &wr_ticks, &ios_pgr, &tot_ticks, &rq_ticks,
-			   &dc_ios, &dc_merges, &dc_sec, &dc_ticks);
+			   &dc_ios, &dc_merges, &dc_sec, &dc_ticks, &rd_d2c_ticks, &wr_d2c_ticks,
+			   &dc_d2c_ticks);
 
 		if (i >= 14) {
 			/* Device or partition */
@@ -778,6 +789,13 @@ void read_diskstats_stat(int curr, int iodev_nr, int dlist_idx)
 				sdev.dc_sectors = dc_sec;
 				sdev.dc_ticks   = dc_ticks;
 			}
+
+			if (i == 21) {
+				/* D2c time of io request */
+				sdev.rd_d2c_ticks = rd_d2c_ticks;
+				sdev.wr_d2c_ticks = wr_d2c_ticks;
+				sdev.dc_d2c_ticks = dc_d2c_ticks;
+			}
 		}
 		else if (i == 7) {
 			/* Partition without extended statistics */
@@ -858,14 +876,17 @@ void compute_device_groups_stats(int curr, int iodev_nr)
 			gdev.rd_merges  += ioi->rd_merges;
 			gdev.rd_sectors += ioi->rd_sectors;
 			gdev.rd_ticks   += ioi->rd_ticks;
+			gdev.rd_d2c_ticks   += ioi->rd_d2c_ticks;
 			gdev.wr_ios     += ioi->wr_ios;
 			gdev.wr_merges  += ioi->wr_merges;
 			gdev.wr_sectors += ioi->wr_sectors;
 			gdev.wr_ticks   += ioi->wr_ticks;
+			gdev.wr_d2c_ticks   += ioi->wr_d2c_ticks;
 			gdev.dc_ios     += ioi->dc_ios;
 			gdev.dc_merges  += ioi->dc_merges;
 			gdev.dc_sectors += ioi->dc_sectors;
 			gdev.dc_ticks   += ioi->dc_ticks;
+			gdev.dc_d2c_ticks   += ioi->dc_d2c_ticks;
 			gdev.ios_pgr    += ioi->ios_pgr;
 			gdev.tot_ticks  += ioi->tot_ticks;
 			gdev.rq_ticks   += ioi->rq_ticks;
@@ -1078,15 +1099,15 @@ void write_disk_stat_header(int *fctr, int *tab, int hpart)
 		}
 		else {
 			if ((hpart == 1) || !hpart) {
-				printf("     r/s    %sr%s/s   rrqm/s  %%rrqm r_await rareq-sz",
+				printf("     r/s    %sr%s/s   rrqm/s  %%rrqm r_await r_d2c_await rareq-sz",
 				       spc, units);
 			}
 			if ((hpart == 2) || !hpart) {
-				printf("     w/s    %sw%s/s   wrqm/s  %%wrqm w_await wareq-sz",
+				printf("     w/s    %sw%s/s   wrqm/s  %%wrqm w_await w_d2c_await wareq-sz",
 				       spc, units);
 			}
 			if ((hpart == 3) || !hpart) {
-			       printf("     d/s    %sd%s/s   drqm/s  %%drqm d_await dareq-sz",
+			       printf("     d/s    %sd%s/s   drqm/s  %%drqm d_await d_d2c_await dareq-sz",
 				      spc, units);
 			}
 			if ((hpart == 4) || !hpart) {
@@ -1193,6 +1214,10 @@ void write_plain_ext_stat(unsigned long long itv, int fctr, int hpart,
 			/* r_await */
 			cprintf_f(NO_UNIT, 1, 7, 2,
 				  xios->r_await);
+
+			/* r_d2c_await */
+			cprintf_f(NO_UNIT, 1, 11, 2,
+				  xios->r_d2c_await);
 			/* rareq-sz  (in kB, not sectors) */
 			cprintf_f(DISPLAY_UNIT(flags) ? UNIT_KILOBYTE : NO_UNIT, 1, 8, 2,
 				  xios->rarqsz / 2);
@@ -1216,6 +1241,10 @@ void write_plain_ext_stat(unsigned long long itv, int fctr, int hpart,
 			/* w_await */
 			cprintf_f(NO_UNIT, 1, 7, 2,
 				  xios->w_await);
+
+			/* w_d2c_await */
+			cprintf_f(NO_UNIT, 1, 11, 2,
+				  xios->w_d2c_await);
 			/* wareq-sz (in kB, not sectors) */
 			cprintf_f(DISPLAY_UNIT(flags) ? UNIT_KILOBYTE : NO_UNIT, 1, 8, 2,
 				  xios->warqsz / 2);
@@ -1239,6 +1268,11 @@ void write_plain_ext_stat(unsigned long long itv, int fctr, int hpart,
 			/* d_await */
 			cprintf_f(NO_UNIT, 1, 7, 2,
 				  xios->d_await);
+
+			/* d_d2c_await */
+			cprintf_f(NO_UNIT, 1, 11, 2,
+				  xios->d_d2c_await);
+
 			/* dareq-sz (in kB, not sectors) */
 			cprintf_f(DISPLAY_UNIT(flags) ? UNIT_KILOBYTE : NO_UNIT, 1, 8, 2,
 				  xios->darqsz / 2);
@@ -1402,10 +1436,16 @@ void write_ext_stat(unsigned long long itv, int fctr, int hpart,
 
 		sdc.rd_ticks  = ioi->rd_ticks;
 		sdp.rd_ticks  = ioj->rd_ticks;
+		sdc.rd_d2c_ticks  = ioi->rd_d2c_ticks;
+		sdp.rd_d2c_ticks  = ioj->rd_d2c_ticks;
 		sdc.wr_ticks  = ioi->wr_ticks;
 		sdp.wr_ticks  = ioj->wr_ticks;
+		sdc.wr_d2c_ticks  = ioi->wr_d2c_ticks;
+		sdp.wr_d2c_ticks  = ioj->wr_d2c_ticks;
 		sdc.dc_ticks  = ioi->dc_ticks;
-		sdp.dc_ticks  = ioj->dc_ticks;
+		sdp.dc_d2c_ticks  = ioj->dc_d2c_ticks;
+		sdp.dc_d2c_ticks  = ioj->dc_d2c_ticks;
+
 
 		sdc.rd_sect   = ioi->rd_sectors;
 		sdp.rd_sect   = ioj->rd_sectors;
@@ -1436,6 +1476,10 @@ void write_ext_stat(unsigned long long itv, int fctr, int hpart,
 			xios.r_await = (ioi->rd_ios - ioj->rd_ios) ?
 				       (ioi->rd_ticks - ioj->rd_ticks) /
 				       ((double) (ioi->rd_ios - ioj->rd_ios)) : 0.0;
+			/* r_d2c_await */
+			xios.r_d2c_await = (ioi->rd_ios - ioj->rd_ios) ?
+				       (ioi->rd_d2c_ticks - ioj->rd_d2c_ticks) /
+				       ((double) (ioi->rd_ios - ioj->rd_ios)) : 0.0;
 			/* rareq-sz (still in sectors, not kB) */
 			xios.rarqsz = (ioi->rd_ios - ioj->rd_ios) ?
 				      (ioi->rd_sectors - ioj->rd_sectors) / ((double) (ioi->rd_ios - ioj->rd_ios)) :
@@ -1451,6 +1495,10 @@ void write_ext_stat(unsigned long long itv, int fctr, int hpart,
 			xios.w_await = (ioi->wr_ios - ioj->wr_ios) ?
 				       (ioi->wr_ticks - ioj->wr_ticks) /
 				       ((double) (ioi->wr_ios - ioj->wr_ios)) : 0.0;
+			/* w_d2c_await */
+			xios.w_d2c_await = (ioi->wr_ios - ioj->wr_ios) ?
+				       (ioi->wr_d2c_ticks - ioj->wr_d2c_ticks) /
+				       ((double) (ioi->wr_ios - ioj->wr_ios)) : 0.0;
 			/* wareq-sz (still in sectors, not kB) */
 			xios.warqsz = (ioi->wr_ios - ioj->wr_ios) ?
 				      (ioi->wr_sectors - ioj->wr_sectors) / ((double) (ioi->wr_ios - ioj->wr_ios)) :
@@ -1466,6 +1514,10 @@ void write_ext_stat(unsigned long long itv, int fctr, int hpart,
 			xios.d_await = (ioi->dc_ios - ioj->dc_ios) ?
 				       (ioi->dc_ticks - ioj->dc_ticks) /
 				       ((double) (ioi->dc_ios - ioj->dc_ios)) : 0.0;
+			/* d_d2c_await */
+			xios.d_d2c_await = (ioi->dc_ios - ioj->dc_ios) ?
+				       (ioi->dc_d2c_ticks - ioj->dc_d2c_ticks) /
+				       ((double) (ioi->dc_ios - ioj->dc_ios)) : 0.0;
 			/* dareq-sz (still in sectors, not kB) */
 			xios.darqsz = (ioi->dc_ios - ioj->dc_ios) ?
 				      (ioi->dc_sectors - ioj->dc_sectors) / ((double) (ioi->dc_ios - ioj->dc_ios)) :
@@ -1776,9 +1828,9 @@ void write_stats(int curr, struct tm *rectime, int iodev_nr, int dlist_idx)
 						fprintf(stderr,
 							"name=%s itv=%llu fctr=%d ioi{ rd_sectors=%lu "
 							"wr_sectors=%lu dc_sectors=%lu "
-							"rd_ios=%lu rd_merges=%lu rd_ticks=%u "
-							"wr_ios=%lu wr_merges=%lu wr_ticks=%u "
-							"dc_ios=%lu dc_merges=%lu dc_ticks=%u "
+							"rd_ios=%lu rd_merges=%lu rd_ticks=%u rd_d2c_ticks=%lu "
+							"wr_ios=%lu wr_merges=%lu wr_ticks=%u wr_d2c_ticks=%lu "
+							"dc_ios=%lu dc_merges=%lu dc_ticks=%u dc_d2c_ticks=%lu "
 							"ios_pgr=%u tot_ticks=%u "
 							"rq_ticks=%u }\n",
 							shi->name,
@@ -1790,12 +1842,15 @@ void write_stats(int curr, struct tm *rectime, int iodev_nr, int dlist_idx)
 							ioi->rd_ios,
 							ioi->rd_merges,
 							ioi->rd_ticks,
+							ioi->rd_d2c_ticks,
 							ioi->wr_ios,
 							ioi->wr_merges,
 							ioi->wr_ticks,
+							ioi->wr_d2c_ticks,
 							ioi->dc_ios,
 							ioi->dc_merges,
 							ioi->dc_ticks,
+							ioi->dc_d2c_ticks,
 							ioi->ios_pgr,
 							ioi->tot_ticks,
 							ioi->rq_ticks);
diff --git a/iostat.h b/iostat.h
index ce6ccc1..8804b4a 100644
--- a/iostat.h
+++ b/iostat.h
@@ -93,10 +93,16 @@ struct io_stats {
 	unsigned long dc_merges		__attribute__ ((packed));
 	/* Time of read requests in queue */
 	unsigned int  rd_ticks		__attribute__ ((packed));
+	/* D2c time of read requests in queue */
+	unsigned int  rd_d2c_ticks	__attribute__ ((packed));
 	/* Time of write requests in queue */
 	unsigned int  wr_ticks		__attribute__ ((packed));
+	/* D2c time of write requests in queue */
+	unsigned int  wr_d2c_ticks	__attribute__ ((packed));
 	/* Time of discard requests in queue */
 	unsigned int  dc_ticks		__attribute__ ((packed));
+	/* D2c ime of discard requests in queue */
+	unsigned int  dc_d2c_ticks	__attribute__ ((packed));
 	/* # of I/Os in progress */
 	unsigned int  ios_pgr		__attribute__ ((packed));
 	/* # of ticks total (for this device) for I/O */
@@ -110,10 +116,16 @@ struct io_stats {
 struct ext_io_stats {
 	/* r_await */
 	double r_await;
+	/* r_d2c_await */
+	double r_d2c_await;
 	/* w_await */
 	double w_await;
+	/* w_d2c_await */
+	double w_d2c_await;
 	/* d_await */
 	double d_await;
+	/* d_d2c_await */
+	double d_d2c_await;
 	/* rsec/s */
 	double rsectors;
 	/* wsec/s */
diff --git a/raw_stats.c b/raw_stats.c
index efa1f81..15db172 100644
--- a/raw_stats.c
+++ b/raw_stats.c
@@ -567,10 +567,16 @@ __print_funct_t raw_print_disk_stats(struct activity *a, char *timestr, int curr
 		pval((unsigned long long) sdp->dc_sect, (unsigned long long) sdc->dc_sect);
 		printf(" rd_ticks");
 		pval((unsigned long long) sdp->rd_ticks, (unsigned long long) sdc->rd_ticks);
+		printf(" rd_d2c_ticks");
+		pval((unsigned long long) sdp->rd_d2c_ticks, (unsigned long long) sdc->rd_d2c_ticks);
 		printf(" wr_ticks");
 		pval((unsigned long long) sdp->wr_ticks, (unsigned long long) sdc->wr_ticks);
+		printf(" wr_d2c_ticks");
+		pval((unsigned long long) sdp->wr_d2c_ticks, (unsigned long long) sdc->wr_d2c_ticks);
 		printf(" dc_ticks");
-		pval((unsigned long long) sdp->dc_ticks, (unsigned long long) sdc->dc_ticks);
+		pval((unsigned long long) sdp->dc_ticks, (unsigned long long) sdc->dc_d2c_ticks);
+		printf(" dc_d2c_ticks");
+		pval((unsigned long long) sdp->dc_d2c_ticks, (unsigned long long) sdc->dc_ticks);
 		printf(" tot_ticks");
 		pval((unsigned long long) sdp->tot_ticks, (unsigned long long) sdc->tot_ticks);
 		pfield(NULL, 0); /* Skip areq-sz */
diff --git a/rd_stats.h b/rd_stats.h
index bc99127..2ea079b 100644
--- a/rd_stats.h
+++ b/rd_stats.h
@@ -272,6 +272,9 @@ struct stats_disk {
 	unsigned int	   major;
 	unsigned int	   minor;
 	unsigned int	   dc_ticks;
+	unsigned int	   rd_d2c_ticks;
+	unsigned int	   wr_d2c_ticks;
+	unsigned int	   dc_d2c_ticks;
 };
 
 #define STATS_DISK_SIZE	(sizeof(struct stats_disk))
-- 
2.17.2


--------------3219CC6A25AF2399A29A01E4--
