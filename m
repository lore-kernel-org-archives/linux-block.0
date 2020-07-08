Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C703C433E1
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 14:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CCF20786
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 14:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="SZHSJQxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgGHOCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbgGHOCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 10:02:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BB3C08C5CE
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 07:02:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n26so36762285ejx.0
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xBqfUGQFJEzPmvQMGn6nklTGsSp7G56fYYjdka7qpTU=;
        b=SZHSJQxzQspxK+IoSdsc0z5HAdzxihstA26dwbR+z9XKESAOsiP6Uz9kebxQ7kQQQt
         AG5yOxKIpY5kwBjsqXHPTCDkiv9V+agAxOdUJwkibUPHPcYr+TpBoWHHyPiZAgSQsaVy
         DG75XTGrFd5l8km4qIntUQnJAUzQzGErNvcrxj6OYvTerdE0xfnozQgi68TpuF7zipsG
         qNPTUN+UWvLmumzTdeky+Stn8C8RDRErv3JkhayvhPnRdn2s6OX/38lIXL/P1H+MCUIb
         g+9u2l1IctuQnKVGrb4iKnxYW0D8CQNR6XTKxlxVDU59tOM6ZRMWYB8hSSPvtOg95bdV
         Jutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xBqfUGQFJEzPmvQMGn6nklTGsSp7G56fYYjdka7qpTU=;
        b=pQTRWOxzQypqc5G9s27eMiP6Kpq2Wcl2m1wi8wfNrk1BWio2dTHJzGeFJyR/lu2bcs
         6mMY3uVR9GeeGNDyL2pRl07yiV1XFuGitS+7iiuJOgEXxJbLrqTKIJ8lqNBX9jG496lS
         Plfxuvxrc2WziRVF3KRGtOKdyALFMdwsXLPW0Eu/cvRhA3QTQmeg1Uwakqoi5wcrSWBt
         cm+NGxe8NrWXvEBIL7z6R6/AMuTqp5yeCNl6vmmJ3p+A+KUkWXZIlIjq/SyoFXTQyu1o
         beIeQkWXVg+ATDGe6WNCCyPdF9HMHAA4zf6Txu/bx3qTpxTdsXv97honMz4vN/YIQJuV
         60Vw==
X-Gm-Message-State: AOAM532CrubNUMVYpkpvDavBJI8CgjCY/4gdULVses1elX8FZDBN8NI+
        6vbw/9l1BZ+jGzap2rPlVfe07w==
X-Google-Smtp-Source: ABdhPJwtQoYoNHqTf8wtXTu8fLVRvRLyMSAve0PsOm+l+gedy487gblopozrldaNk0/RmPkg2cXYow==
X-Received: by 2002:a17:906:eb93:: with SMTP id mh19mr50453022ejb.552.1594216960254;
        Wed, 08 Jul 2020 07:02:40 -0700 (PDT)
Received: from [192.168.178.33] (i5C746C99.versanet.de. [92.116.108.153])
        by smtp.gmail.com with ESMTPSA id x64sm31267045edc.95.2020.07.08.07.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 07:02:39 -0700 (PDT)
Subject: Re: [PATCH RFC 4/5] block: add a statistic table for io latency
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-5-guoqing.jiang@cloud.ionos.com>
 <20200708132958.GC3340386@T590>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <eb2cf4d0-4260-8f10-0ba9-3cbf4ff85449@cloud.ionos.com>
Date:   Wed, 8 Jul 2020 16:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708132958.GC3340386@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/20 3:29 PM, Ming Lei wrote:
> On Wed, Jul 08, 2020 at 09:58:18AM +0200, Guoqing Jiang wrote:
>> Usually, we get the status of block device by cat stat file,
>> but we can only know the total time with that file. And we
>> would like to know more accurate statistic, such as each
>> latency range, which helps people to diagnose if there is
>> issue about the hardware.
>>
>> Also a new config option is introduced to control if people
>> want to know the additional statistics or not, and we also
>> use the option for io sector in next patch.
>>
>> Signed-off-by: Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   block/Kconfig             |  8 ++++++++
>>   block/blk-core.c          | 35 +++++++++++++++++++++++++++++++++++
>>   block/genhd.c             | 26 ++++++++++++++++++++++++++
>>   include/linux/part_stat.h |  7 +++++++
>>   4 files changed, 76 insertions(+)
>>
>> diff --git a/block/Kconfig b/block/Kconfig
>> index 9357d7302398..dba71feaa85b 100644
>> --- a/block/Kconfig
>> +++ b/block/Kconfig
>> @@ -175,6 +175,14 @@ config BLK_DEBUG_FS
>>   	Unless you are building a kernel for a tiny system, you should
>>   	say Y here.
>>   
>> +config BLK_ADDITIONAL_DISKSTAT
>> +	bool "Block layer additional diskstat"
>> +	default n
>> +	help
>> +	Enabling this option adds io latency statistics for each block device.
>> +
>> +	If unsure, say N.
>> +
>>   config BLK_DEBUG_FS_ZONED
>>          bool
>>          default BLK_DEBUG_FS && BLK_DEV_ZONED
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 0e806a8c62fb..7a129c8f1b23 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1411,6 +1411,39 @@ static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
>>   	}
>>   }
>>   
>> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
>> +/*
>> + * Either account additional stat for request if req is not NULL or account for bio.
>> + */
>> +static void blk_additional_latency(struct hd_struct *part, const int sgrp,
>> +				   struct request *req, unsigned long start_ns)
>> +{
>> +	unsigned int idx;
>> +	unsigned long duration, now = ktime_get_ns();
>> +
>> +	if (req)
>> +		duration = (now - req->start_time_ns) / NSEC_PER_MSEC;
>> +	else
>> +		duration = (now - start_ns) / NSEC_PER_MSEC;
>> +
>> +	duration /= HZ_TO_MSEC_NUM;
>> +	if (likely(duration > 0)) {
>> +		idx = ilog2(duration);
>> +		if (idx > ADD_STAT_NUM - 1)
>> +			idx = ADD_STAT_NUM - 1;
>> +	} else
>> +		idx = 0;
>> +	part_stat_inc(part, latency_table[idx][sgrp]);
>> +
>> +}
>> +#else
>> +static void blk_additional_latency(struct hd_struct *part, const int sgrp,
>> +				   struct request *req, unsigned long start_jiffies)
>> +
>> +{
>> +}
>> +#endif
>> +
>>   static void blk_account_io_completion(struct request *req, unsigned int bytes)
>>   {
>>   	if (req->part && blk_do_io_stat(req)) {
>> @@ -1440,6 +1473,7 @@ void blk_account_io_done(struct request *req, u64 now)
>>   		part = req->part;
>>   
>>   		update_io_ticks(part, jiffies, true);
>> +		blk_additional_latency(part, sgrp, req, 0);
>>   		part_stat_inc(part, ios[sgrp]);
>>   		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>>   		part_stat_unlock();
>> @@ -1489,6 +1523,7 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
>>   
>>   	part_stat_lock();
>>   	update_io_ticks(part, now, true);
>> +	blk_additional_latency(part, sgrp, NULL, start_time);
>>   	part_stat_add(part, nsecs[sgrp], duration);
>>   	part_stat_local_dec(part, in_flight[op_is_write(op)]);
>>   	part_stat_unlock();
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 60ae4e1b4d38..a33937a74fb1 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -1420,6 +1420,29 @@ static struct device_attribute dev_attr_fail_timeout =
>>   	__ATTR(io-timeout-fail, 0644, part_timeout_show, part_timeout_store);
>>   #endif
>>   
>> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
>> +static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct hd_struct *p = dev_to_part(dev);
>> +	size_t count = 0;
>> +	int i, sgrp;
>> +
>> +	for (i = 0; i < ADD_STAT_NUM; i++) {
>> +		count += scnprintf(buf + count, PAGE_SIZE - count, "%5d ms: ",
>> +				   (1 << i) * HZ_TO_MSEC_NUM);
>> +		for (sgrp = 0; sgrp < NR_STAT_GROUPS; sgrp++)
>> +			count += scnprintf(buf + count, PAGE_SIZE - count, "%lu ",
>> +					   part_stat_read(p, latency_table[i][sgrp]));
>> +		count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static struct device_attribute dev_attr_io_latency =
>> +	__ATTR(io_latency, 0444, io_latency_show, NULL);
>> +#endif
>> +
>>   static struct attribute *disk_attrs[] = {
>>   	&dev_attr_range.attr,
>>   	&dev_attr_ext_range.attr,
>> @@ -1438,6 +1461,9 @@ static struct attribute *disk_attrs[] = {
>>   #endif
>>   #ifdef CONFIG_FAIL_IO_TIMEOUT
>>   	&dev_attr_fail_timeout.attr,
>> +#endif
>> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
>> +	&dev_attr_io_latency.attr,
>>   #endif
>>   	NULL
>>   };
>> diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
>> index 24125778ef3e..fe3def8c69d7 100644
>> --- a/include/linux/part_stat.h
>> +++ b/include/linux/part_stat.h
>> @@ -9,6 +9,13 @@ struct disk_stats {
>>   	unsigned long sectors[NR_STAT_GROUPS];
>>   	unsigned long ios[NR_STAT_GROUPS];
>>   	unsigned long merges[NR_STAT_GROUPS];
>> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
>> +/*
>> + * We measure latency (ms) for 1, 2, ..., 1024 and >=1024.
>> + */
>> +#define ADD_STAT_NUM	12
>> +	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
>> +#endif
>>   	unsigned long io_ticks;
>>   	local_t in_flight[2];
>>   };
>> -- 
>> 2.17.1
>>
> Hi Guoqing,
>
> I believe it isn't hard to write a ebpf based script(bcc or bpftrace) to
> collect this kind of performance data, so looks not necessary to do it
> in kernel.

Hi Ming,

Sorry, I don't know well about bcc or bpftrace, but I assume they need to
read the latency value from somewhere inside kernel. Could you point
how can I get the latency value? Thanks in advance!

Thanks,
Guoqing

