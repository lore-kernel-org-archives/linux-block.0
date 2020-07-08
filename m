Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF1C433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 13:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D351720774
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 13:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1nBebmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgGHNaP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:30:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27345 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728148AbgGHNaO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 09:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594215013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T1qSkgV2R0AteB9TwHCozGEIELyskW8ymplK8O90KWI=;
        b=b1nBebmwIvigYEw4as6gMOXUbknBC1k9B6KU7upNom18hUQ/qxxhZEeQjfQLkNkRndj+q9
        zqkUPFZiQaWESxuNqo0wpmUTcJEYQsYhXfZArNXOoEGRpSnywglba9RlG53qokuEIlRjG1
        9sDOt1BxHBv/Xr6e8YD8FwK/Chf3FCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-NqF4KCLJMdyHHqLPr-XKEQ-1; Wed, 08 Jul 2020 09:30:11 -0400
X-MC-Unique: NqF4KCLJMdyHHqLPr-XKEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7469107ACCD;
        Wed,  8 Jul 2020 13:30:09 +0000 (UTC)
Received: from T590 (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F370919D61;
        Wed,  8 Jul 2020 13:30:02 +0000 (UTC)
Date:   Wed, 8 Jul 2020 21:29:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Subject: Re: [PATCH RFC 4/5] block: add a statistic table for io latency
Message-ID: <20200708132958.GC3340386@T590>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-5-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708075819.4531-5-guoqing.jiang@cloud.ionos.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 08, 2020 at 09:58:18AM +0200, Guoqing Jiang wrote:
> Usually, we get the status of block device by cat stat file,
> but we can only know the total time with that file. And we
> would like to know more accurate statistic, such as each
> latency range, which helps people to diagnose if there is
> issue about the hardware.
> 
> Also a new config option is introduced to control if people
> want to know the additional statistics or not, and we also
> use the option for io sector in next patch.
> 
> Signed-off-by: Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  block/Kconfig             |  8 ++++++++
>  block/blk-core.c          | 35 +++++++++++++++++++++++++++++++++++
>  block/genhd.c             | 26 ++++++++++++++++++++++++++
>  include/linux/part_stat.h |  7 +++++++
>  4 files changed, 76 insertions(+)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 9357d7302398..dba71feaa85b 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -175,6 +175,14 @@ config BLK_DEBUG_FS
>  	Unless you are building a kernel for a tiny system, you should
>  	say Y here.
>  
> +config BLK_ADDITIONAL_DISKSTAT
> +	bool "Block layer additional diskstat"
> +	default n
> +	help
> +	Enabling this option adds io latency statistics for each block device.
> +
> +	If unsure, say N.
> +
>  config BLK_DEBUG_FS_ZONED
>         bool
>         default BLK_DEBUG_FS && BLK_DEV_ZONED
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 0e806a8c62fb..7a129c8f1b23 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1411,6 +1411,39 @@ static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
>  	}
>  }
>  
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +/*
> + * Either account additional stat for request if req is not NULL or account for bio.
> + */
> +static void blk_additional_latency(struct hd_struct *part, const int sgrp,
> +				   struct request *req, unsigned long start_ns)
> +{
> +	unsigned int idx;
> +	unsigned long duration, now = ktime_get_ns();
> +
> +	if (req)
> +		duration = (now - req->start_time_ns) / NSEC_PER_MSEC;
> +	else
> +		duration = (now - start_ns) / NSEC_PER_MSEC;
> +
> +	duration /= HZ_TO_MSEC_NUM;
> +	if (likely(duration > 0)) {
> +		idx = ilog2(duration);
> +		if (idx > ADD_STAT_NUM - 1)
> +			idx = ADD_STAT_NUM - 1;
> +	} else
> +		idx = 0;
> +	part_stat_inc(part, latency_table[idx][sgrp]);
> +
> +}
> +#else
> +static void blk_additional_latency(struct hd_struct *part, const int sgrp,
> +				   struct request *req, unsigned long start_jiffies)
> +
> +{
> +}
> +#endif
> +
>  static void blk_account_io_completion(struct request *req, unsigned int bytes)
>  {
>  	if (req->part && blk_do_io_stat(req)) {
> @@ -1440,6 +1473,7 @@ void blk_account_io_done(struct request *req, u64 now)
>  		part = req->part;
>  
>  		update_io_ticks(part, jiffies, true);
> +		blk_additional_latency(part, sgrp, req, 0);
>  		part_stat_inc(part, ios[sgrp]);
>  		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>  		part_stat_unlock();
> @@ -1489,6 +1523,7 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
>  
>  	part_stat_lock();
>  	update_io_ticks(part, now, true);
> +	blk_additional_latency(part, sgrp, NULL, start_time);
>  	part_stat_add(part, nsecs[sgrp], duration);
>  	part_stat_local_dec(part, in_flight[op_is_write(op)]);
>  	part_stat_unlock();
> diff --git a/block/genhd.c b/block/genhd.c
> index 60ae4e1b4d38..a33937a74fb1 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1420,6 +1420,29 @@ static struct device_attribute dev_attr_fail_timeout =
>  	__ATTR(io-timeout-fail, 0644, part_timeout_show, part_timeout_store);
>  #endif
>  
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct hd_struct *p = dev_to_part(dev);
> +	size_t count = 0;
> +	int i, sgrp;
> +
> +	for (i = 0; i < ADD_STAT_NUM; i++) {
> +		count += scnprintf(buf + count, PAGE_SIZE - count, "%5d ms: ",
> +				   (1 << i) * HZ_TO_MSEC_NUM);
> +		for (sgrp = 0; sgrp < NR_STAT_GROUPS; sgrp++)
> +			count += scnprintf(buf + count, PAGE_SIZE - count, "%lu ",
> +					   part_stat_read(p, latency_table[i][sgrp]));
> +		count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
> +	}
> +
> +	return count;
> +}
> +
> +static struct device_attribute dev_attr_io_latency =
> +	__ATTR(io_latency, 0444, io_latency_show, NULL);
> +#endif
> +
>  static struct attribute *disk_attrs[] = {
>  	&dev_attr_range.attr,
>  	&dev_attr_ext_range.attr,
> @@ -1438,6 +1461,9 @@ static struct attribute *disk_attrs[] = {
>  #endif
>  #ifdef CONFIG_FAIL_IO_TIMEOUT
>  	&dev_attr_fail_timeout.attr,
> +#endif
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +	&dev_attr_io_latency.attr,
>  #endif
>  	NULL
>  };
> diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
> index 24125778ef3e..fe3def8c69d7 100644
> --- a/include/linux/part_stat.h
> +++ b/include/linux/part_stat.h
> @@ -9,6 +9,13 @@ struct disk_stats {
>  	unsigned long sectors[NR_STAT_GROUPS];
>  	unsigned long ios[NR_STAT_GROUPS];
>  	unsigned long merges[NR_STAT_GROUPS];
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +/*
> + * We measure latency (ms) for 1, 2, ..., 1024 and >=1024.
> + */
> +#define ADD_STAT_NUM	12
> +	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
> +#endif
>  	unsigned long io_ticks;
>  	local_t in_flight[2];
>  };
> -- 
> 2.17.1
> 

Hi Guoqing,

I believe it isn't hard to write a ebpf based script(bcc or bpftrace) to
collect this kind of performance data, so looks not necessary to do it
in kernel.

Thanks,
Ming

