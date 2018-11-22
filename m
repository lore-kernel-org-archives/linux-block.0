Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E94C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A899B20878
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 21:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kEonLD+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A899B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407273AbeKWHm5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:42:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44474 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407250AbeKWHm4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 02:42:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so2374217pfh.11
        for <linux-block@vger.kernel.org>; Thu, 22 Nov 2018 13:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9bi8KEbI1mjb9xGjLoSU9H6rIUkZEpEWb50XSR1CMhI=;
        b=kEonLD+1/9OKL650Q4Qi4Z/qluy0ck5tt7mA2UHinN7E8MwZmleteuaj5IPKvzVyt7
         SOCDbgeKXXprONpX7Poj7tNiReJMH/x7hKe2zuzMhX2ta9/3NCq9E8jhnDDwHrmMf8QM
         O0RjL/7k9yqyDvfhi/RoH6pJOqPSckLt4rypZJ1J83S9Nnb+4hwVlczZhRMQuji86U/X
         3f9fFc1ZDN0bPEgW1/e7kOLxFBjmycNkipWdvQBdSk3Fq9KPH+x8yWltb8AthM1htqD2
         WOTKRajEHNUVSDNQ0zF5TGJT3coOF/JtmpSVzkW7oySJMzro8ZGBDjrF9+tlP2pxsBrV
         UKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9bi8KEbI1mjb9xGjLoSU9H6rIUkZEpEWb50XSR1CMhI=;
        b=SAhfms5CnWIKs/qCgfQpZPz2xiNWFHjivEckkLeOJOBZdSezdXxjx76P5AMRRwkogI
         JYV1/epn4n+HlPBo0O4uihGEPSPeTjyDG6ny2zzcJoOziNgJ6XBScwrhTKPz+1fIfkgf
         ayK8+eNQvMi1dNZrMgM8hwRCGrMZI7+2G7k0Ae7hXWYKmdt8w7ZmGww2TL/yIo71s8hb
         p56kL5yR5XHId+qnquPQw+AAW+rROL8qVE5ax36lU1ASAa9Wo0IAPBg8KiJjXPGbsfGl
         xYlOleyP4bvlHyxBl+nN+4iheoBcHweL8fqICzM1Cmj8VFF1s6swqtyNfYWsy+5kKLR8
         MIwQ==
X-Gm-Message-State: AA+aEWY3i51TnheEiGPAi4ppUUr17hU5rdw35Z3mWZd3sJx0ugBuGicC
        TwLbCqAwTKQemfbnZC3LoyGxDinnsHo=
X-Google-Smtp-Source: AFSGD/U0m7R9ZyQum7vKJu0i5tX1LAIFHoHHEYdkpiZxutlftU4WvNunX3ix++HCRt4Oby+TU5a4Rg==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr10963898pgi.105.1542920509456;
        Thu, 22 Nov 2018 13:01:49 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q195sm54650525pgq.7.2018.11.22.13.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 13:01:47 -0800 (PST)
Subject: Re: [PATCH 8/8] aio: support for IO polling
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20181120171953.1258-1-axboe@kernel.dk>
 <20181120171953.1258-9-axboe@kernel.dk>
 <20181122111351.GD9840@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <42b38b07-3120-095e-44ac-bcda88b6412c@kernel.dk>
Date:   Thu, 22 Nov 2018 14:01:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122111351.GD9840@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/22/18 4:13 AM, Jan Kara wrote:
> 
> On Tue 20-11-18 10:19:53, Jens Axboe wrote:
>> +/*
>> + * We can't just wait for polled events to come to us, we have to actively
>> + * find and complete them.
>> + */
>> +static void aio_iopoll_reap_events(struct kioctx *ctx)
>> +{
>> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
>> +		return;
>> +
>> +	while (!list_empty_careful(&ctx->poll_submitted) ||
>> +	       !list_empty(&ctx->poll_completing)) {
>> +		unsigned int nr_events = 0;
>> +
>> +		__aio_iopoll_check(ctx, NULL, &nr_events, 1, UINT_MAX);
>> +	}
>> +}
>> +
>> +static int aio_iopoll_check(struct kioctx *ctx, long min_nr, long nr,
>> +			    struct io_event __user *event)
>> +{
>> +	unsigned int nr_events = 0;
>> +	int ret = 0;
>> +
>> +	/* * Only allow one thread polling at a time */
>> +	if (test_and_set_bit(0, &ctx->getevents_busy))
>> +		return -EBUSY;
>> +
>> +	while (!nr_events || !need_resched()) {
>> +		int tmin = 0;
>> +
>> +		if (nr_events < min_nr)
>> +			tmin = min_nr - nr_events;
>> +
>> +		ret = __aio_iopoll_check(ctx, event, &nr_events, tmin, nr);
>> +		if (ret <= 0)
>> +			break;
>> +		ret = 0;
>> +	}
>> +
>> +	clear_bit(0, &ctx->getevents_busy);
>> +	return nr_events ? nr_events : ret;
>> +}
> 
> Hum, what if userspace calls io_destroy() while another process is polling
> for events on the same kioctx? It seems we'd be reaping events from two
> processes in parallel in that case which will result in various
> "interesting" effects like ctx->poll_completing list corruption...

I've replaced the ->getevents_busy with a mutex, and we also protect
the ->dead check inside that mutex. That ensures that destroy can't
proceed before a potential caller is inside getevents(), and that
getevents() sees if the ctx is being destroyed.

-- 
Jens Axboe

