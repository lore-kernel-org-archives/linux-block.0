Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4088C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF81205C9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bOY95U5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF81205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeLERam (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:30:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53664 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeLERal (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:30:41 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so22587020ita.3
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/rKu2mV256RF+eYkBHmIlbTpx/wAWH9dkytuD+UFYgs=;
        b=bOY95U5QI9Y5KIDvun8WAMRLXod82bcmuUS4kim5913aAEpu4yrf3ynl5xKJrqb+34
         /SySz+w2rYVqtktW336TvIzdznLp0SAXS6mq1JvCHDJxUMbHpd7GRmyH/ysRMJUWe4Ov
         s0kKQ3tCuLl9AKOXbJNuXwpK59Tss8jrKIa35/E/gqKUo6NWMVND67qhzGPbIZW6BLTv
         z8Ic15f7WIIwPynzyc/ZPbdR4X4oReHJ+ErzxsCv18VdSw3Lps5ZJMYsKxYRmEifyhhh
         TPE1COqpIG6OzEZ14QB2Oeh3soZizMSIeF64L3CovJbQA3En4tlvPU2Wd3AgZ2gCg+ef
         TJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/rKu2mV256RF+eYkBHmIlbTpx/wAWH9dkytuD+UFYgs=;
        b=PSjG73NnQgKmjpd9EvN6PXZ3WaI2esRqVF9Jrn8LaOWcqM7k1/dGO1cUkj5PkneEqi
         O7OMLOyqPMye6l06afFZCNSr7aiiZQwQqCknmiQEdwVBg0K7T5rV5AWUlzZNzFjEigio
         ko3YehxxALlYoar9qqC6reP4hbWqtk+mAEz5SOC6uxDrAxA+mA74cP6hBvl5/10m34qx
         CLi/iR/Mzi/hUp0+03V1eEN8sfEPVOkQs3a3onTWvvLpSRUNBfPQRs3uzkVxb2Fu7F7P
         ySdVydVlL4gG3rqw4mt1TjoAUxvDD/PDysByAJ6E1lOfIDfTtUv3MW3H47OXURtqxs2r
         lKmQ==
X-Gm-Message-State: AA+aEWYazm90SMwtRUFQo/U6afRxRMmJrfyPC33P1AN8kEBDQSvmzbJU
        8W7v5cZwv12aqiLpOvtiVlQpZAq+G2I=
X-Google-Smtp-Source: AFSGD/Xpb+HGBk8Ysx6zifKY6+NU7Wuwt57ZZ/ZERfEZ7l3GyMooAYngEAAveH8CkRoM52NnahbjpA==
X-Received: by 2002:a24:b003:: with SMTP id d3mr16086097itf.55.1544031040583;
        Wed, 05 Dec 2018 09:30:40 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l3sm7468976itb.43.2018.12.05.09.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:30:39 -0800 (PST)
Subject: Re: [PATCH v2 4/6] block: switch to per-cpu in-flight counters
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20181130222226.77216-1-snitzer@redhat.com>
 <20181130222226.77216-5-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d6a741cd-ea75-19d0-13e3-eb1321e617b4@kernel.dk>
Date:   Wed, 5 Dec 2018 10:30:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130222226.77216-5-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 3:22 PM, Mike Snitzer wrote:
> diff --git a/block/genhd.c b/block/genhd.c
> index cdf174d7d329..d4c9dd65def6 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -45,53 +45,76 @@ static void disk_add_events(struct gendisk *disk);
>  static void disk_del_events(struct gendisk *disk);
>  static void disk_release_events(struct gendisk *disk);
>  
> -void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
> +void part_inc_in_flight(struct request_queue *q, int cpu, struct hd_struct *part, int rw)
>  {
>  	if (queue_is_mq(q))
>  		return;
>  
> -	atomic_inc(&part->in_flight[rw]);
> +	local_inc(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);

I mentioned this in a previous email, but why isn't this just using
this_cpu_inc? There's also no need to pass in the cpu, if we're not
running with preempt disabled already we have a problem.

-- 
Jens Axboe

