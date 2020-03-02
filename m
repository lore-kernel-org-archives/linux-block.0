Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E29C3F2D8
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 13:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF6121556
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 13:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="V+LYYpn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCBNvR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:51:17 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:50556 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbgCBNvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Mar 2020 08:51:16 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 977102E15DF;
        Mon,  2 Mar 2020 16:51:13 +0300 (MSK)
Received: from vla1-5a8b76e65344.qloud-c.yandex.net (vla1-5a8b76e65344.qloud-c.yandex.net [2a02:6b8:c0d:3183:0:640:5a8b:76e6])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id JSAbmXMoJM-pDDe8Yw0;
        Mon, 02 Mar 2020 16:51:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1583157073; bh=wktUfavwfLnvfoMtc7ILBXstgqnlxp/m6Im5xGOv+VM=;
        h=In-Reply-To:Message-ID:Date:References:To:From:Subject:Cc;
        b=V+LYYpn+jJgw2yMh2gLWtctTnF0zFdYROQ4Cy64V+vCb3uQ2Tqu5ZlqITCHZW7daV
         ZebzAJTirz0pt75/023MjBEu5Iv0M+DJQOCne4OcwvCy6Xj6ahixduqNBhXcnke4kF
         IaHPaP1I5xQd/Pgt/n4Sk5BLY4qD87fw1QG4wwVI=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:7cd4:25a8:c7e3:39e2])
        by vla1-5a8b76e65344.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 67CYjl57Ra-pD3qM2Jp;
        Mon, 02 Mar 2020 16:51:13 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH 2/3] block/diskstats: accumulate all per-cpu counters in
 one pass
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
References: <158314549775.1788.6529015932237292177.stgit@buzz>
 <158314549980.1788.322398190605021664.stgit@buzz>
Message-ID: <6fd92550-9252-a3ca-90b7-f55d6e39b63c@yandex-team.ru>
Date:   Mon, 2 Mar 2020 16:51:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158314549980.1788.322398190605021664.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 02/03/2020 13.38, Konstantin Khlebnikov wrote:
> Reading /proc/diskstats iterates over all cpus for summing each field.
> It's faster to sum all fields in one pass.
> 
> Hammering /proc/diskstats with fio shows 2x performance improvement:
> 
> fio --name=test --numjobs=$JOBS --filename=/proc/diskstats \
>      --size=1k --bs=1k --fallocate=none --create_on_open=1 \
>      --time_based=1 --runtime=10 --invalidate=0 --group_report
> 
> 	  JOBS=1	JOBS=10
> Before:	  7k iops	64k iops
> After:	 18k iops      120k iops
> 
> Also this way code is more compact:
> 
> add/remove: 1/0 grow/shrink: 0/2 up/down: 194/-1540 (-1346)
> Function                                     old     new   delta
> part_stat_read_all                             -     194    +194
> diskstats_show                              1344     631    -713
> part_stat_show                              1219     392    -827
> Total: Before=14966947, After=14965601, chg -0.01%
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   block/genhd.c             |   62 +++++++++++++++++++++++++++++++++------------
>   block/partition-generic.c |   35 ++++++++++++++-----------
>   include/linux/genhd.h     |   10 +++++--
>   3 files changed, 72 insertions(+), 35 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index ff6268970ddc..fcc597c243f7 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -46,6 +46,29 @@ static void disk_add_events(struct gendisk *disk);
>   static void disk_del_events(struct gendisk *disk);
>   static void disk_release_events(struct gendisk *disk);
>   
> +#ifdef CONFIG_SMP
> +void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
> +{
> +	int cpu;
> +
> +	memset(stat, 0, sizeof(struct disk_stats));
> +	for_each_possible_cpu(cpu) {
> +		struct disk_stats *ptr = per_cpu_ptr(part->dkstats, cpu);
> +		int group;
> +
> +		for (group = 0; group < NR_STAT_GROUPS; group++) {
> +			stat->nsecs[group] += ptr->nsecs[group];
> +			stat->sectors[group] += ptr->sectors[group];
> +			stat->ios[group] += ptr->ios[group];
> +			stat->merges[group] += ptr->merges[group];
> +		}
> +
> +		stat->io_ticks += ptr->io_ticks;
> +		stat->time_in_queue += ptr->time_in_queue;
> +	}
> +}
> +#endif /* CONFIG_SMP */
> +
>   void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
>   {
>   	if (queue_is_mq(q))
> @@ -1369,6 +1392,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>   	struct hd_struct *hd;
>   	char buf[BDEVNAME_SIZE];
>   	unsigned int inflight;
> +	struct disk_stats stat;
>   
>   	/*
>   	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
> @@ -1380,7 +1404,9 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>   
>   	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
>   	while ((hd = disk_part_iter_next(&piter))) {
> +		part_stat_read_all(hd, &stat);
>   		inflight = part_in_flight(gp->queue, hd);
> +
>   		seq_printf(seqf, "%4d %7d %s "
>   			   "%lu %lu %lu %u "
>   			   "%lu %lu %lu %u "
> @@ -1390,23 +1416,27 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>   			   "\n",
>   			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
>   			   disk_name(gp, hd->partno, buf),
> -			   part_stat_read(hd, ios[STAT_READ]),
> -			   part_stat_read(hd, merges[STAT_READ]),
> -			   part_stat_read(hd, sectors[STAT_READ]),
> -			   (unsigned int)part_stat_read_msecs(hd, STAT_READ),
> -			   part_stat_read(hd, ios[STAT_WRITE]),
> -			   part_stat_read(hd, merges[STAT_WRITE]),
> -			   part_stat_read(hd, sectors[STAT_WRITE]),
> -			   (unsigned int)part_stat_read_msecs(hd, STAT_WRITE),
> +			   stat.ios[STAT_READ],
> +			   stat.merges[STAT_READ],
> +			   stat.sectors[STAT_READ],
> +			   (unsigned int)div_u64(stat.nsecs[STAT_READ],
> +							NSEC_PER_MSEC),
> +			   stat.ios[STAT_WRITE],
> +			   stat.merges[STAT_WRITE],
> +			   stat.sectors[STAT_WRITE],
> +			   (unsigned int)div_u64(stat.nsecs[STAT_WRITE],
> +							NSEC_PER_MSEC),
>   			   inflight,
> -			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
> -			   jiffies_to_msecs(part_stat_read(hd, time_in_queue)),
> -			   part_stat_read(hd, ios[STAT_DISCARD]),
> -			   part_stat_read(hd, merges[STAT_DISCARD]),
> -			   part_stat_read(hd, sectors[STAT_DISCARD]),
> -			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD),
> -			   part_stat_read(hd, ios[STAT_FLUSH]),
> -			   (unsigned int)part_stat_read_msecs(hd, STAT_FLUSH)
> +			   jiffies_to_msecs(stat.io_ticks),
> +			   jiffies_to_msecs(stat.time_in_queue),
> +			   stat.ios[STAT_DISCARD],
> +			   stat.merges[STAT_DISCARD],
> +			   stat.sectors[STAT_DISCARD],
> +			   (unsigned int)div_u64(stat.nsecs[STAT_DISCARD],
> +						 NSEC_PER_MSEC),
> +			   stat.ios[STAT_FLUSH],
> +			   (unsigned int)div_u64(stat.nsecs[STAT_FLUSH],
> +						 NSEC_PER_MSEC)
>   			);
>   	}
>   	disk_part_iter_exit(&piter);
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 564fae77711d..6d3fcb5187cb 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -120,9 +120,12 @@ ssize_t part_stat_show(struct device *dev,
>   {
>   	struct hd_struct *p = dev_to_part(dev);
>   	struct request_queue *q = part_to_disk(p)->queue;
> +	struct disk_stats stat;
>   	unsigned int inflight;
>   
> +	part_stat_read_all(p, &stat);
>   	inflight = part_in_flight(q, p);
> +
>   	return sprintf(buf,
>   		"%8lu %8lu %8llu %8u "
>   		"%8lu %8lu %8llu %8u "
> @@ -130,23 +133,23 @@ ssize_t part_stat_show(struct device *dev,
>   		"%8lu %8lu %8llu %8u "
>   		"%8lu %8u"
>   		"\n",
> -		part_stat_read(p, ios[STAT_READ]),
> -		part_stat_read(p, merges[STAT_READ]),
> -		(unsigned long long)part_stat_read(p, sectors[STAT_READ]),
> -		(unsigned int)part_stat_read_msecs(p, STAT_READ),
> -		part_stat_read(p, ios[STAT_WRITE]),
> -		part_stat_read(p, merges[STAT_WRITE]),
> -		(unsigned long long)part_stat_read(p, sectors[STAT_WRITE]),
> -		(unsigned int)part_stat_read_msecs(p, STAT_WRITE),
> +		stat.ios[STAT_READ],
> +		stat.merges[STAT_READ],
> +		(unsigned long long)stat.sectors[STAT_READ],
> +		(unsigned int)div_u64(stat.nsecs[STAT_READ], NSEC_PER_MSEC),
> +		stat.ios[STAT_WRITE],
> +		stat.merges[STAT_WRITE],
> +		(unsigned long long)stat.sectors[STAT_WRITE],
> +		(unsigned int)div_u64(stat.nsecs[STAT_WRITE], NSEC_PER_MSEC),
>   		inflight,
> -		jiffies_to_msecs(part_stat_read(p, io_ticks)),
> -		jiffies_to_msecs(part_stat_read(p, time_in_queue)),
> -		part_stat_read(p, ios[STAT_DISCARD]),
> -		part_stat_read(p, merges[STAT_DISCARD]),
> -		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
> -		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),
> -		part_stat_read(p, ios[STAT_FLUSH]),
> -		(unsigned int)part_stat_read_msecs(p, STAT_FLUSH));
> +		jiffies_to_msecs(stat.io_ticks),
> +		jiffies_to_msecs(stat.time_in_queue),
> +		stat.ios[STAT_DISCARD],
> +		stat.merges[STAT_DISCARD],
> +		(unsigned long long)stat.sectors[STAT_DISCARD],
> +		(unsigned int)div_u64(stat.nsecs[STAT_DISCARD], NSEC_PER_MSEC),
> +		stat.ios[STAT_FLUSH],
> +		(unsigned int)div_u64(stat.nsecs[STAT_FLUSH], NSEC_PER_MSEC));
>   }
>   
>   ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index d5ff7023daa8..f1fca2c57092 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -339,6 +339,8 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
>   				sizeof(struct disk_stats));
>   }
>   
> +void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat);
> +
>   static inline int init_part_stats(struct hd_struct *part)
>   {
>   	part->dkstats = alloc_percpu(struct disk_stats);
> @@ -365,6 +367,11 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
>   	memset(&part->dkstats, value, sizeof(struct disk_stats));
>   }
>   
> +void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)

^-- forgot "static inline" here

> +{
> +	memcpy(stat, &part->dkstats, sizeof(struct disk_stats));
> +}
> +
>   static inline int init_part_stats(struct hd_struct *part)
>   {
>   	return 1;
> @@ -376,9 +383,6 @@ static inline void free_part_stats(struct hd_struct *part)
>   
>   #endif /* CONFIG_SMP */
>   
> -#define part_stat_read_msecs(part, which)				\
> -	div_u64(part_stat_read(part, nsecs[which]), NSEC_PER_MSEC)
> -
>   #define part_stat_read_accum(part, field)				\
>   	(part_stat_read(part, field[STAT_READ]) +			\
>   	 part_stat_read(part, field[STAT_WRITE]) +			\
> 
