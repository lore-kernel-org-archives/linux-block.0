Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3950EC433DB
	for <linux-block@archiver.kernel.org>; Fri, 26 Feb 2021 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C8764DAF
	for <linux-block@archiver.kernel.org>; Fri, 26 Feb 2021 18:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhBZSkP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Feb 2021 13:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhBZSkL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Feb 2021 13:40:11 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A78CC06174A
        for <linux-block@vger.kernel.org>; Fri, 26 Feb 2021 10:39:30 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m6so6843505pfk.1
        for <linux-block@vger.kernel.org>; Fri, 26 Feb 2021 10:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5TKey9ScIqE1QVqAmzRm7Pa4QrBfTm9Rk2AGeQ0kJow=;
        b=fUN2KwZrbraD0MKMQlWDp0oZdDMQ1OraOoZMs6OKbwOz/1JY23qoqgI9lu1qelp/HZ
         zNPT3pg8qJ7OEqkPEhTz6sOZA2F7jAchAdVzkQXSPUC7/XcV3gIVyAj7/Yw+D3BetLC/
         H+eZzgpJmBuoPO7A3mAYDpDb4DVxV7f7zuxduq/PbSyTSDAWf3vu3LVAy+sMKEUe261s
         HoGUOvinMVZJdUSNpr+G1ACrC8IOkbFn+qzUSSKPVAjut7qjbrWHEh7LUKu8+2bUikY+
         1DflO9TTeJJ6iQRTVc4pPczfqyJ6VpVhIqAaAYwEMQHm+sE+d21vxlxD5w3WapmPrkgw
         DDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5TKey9ScIqE1QVqAmzRm7Pa4QrBfTm9Rk2AGeQ0kJow=;
        b=MctItH/CFJHuTFXq0AZXl2diYokjjNwjonUtCTFbNEbmsKvKbJlmLc7V92pD0L68LX
         rj0qtLQOYEXwYu9EyIGHxbB3KPY9ByzAx3fGWOok6O4kzFdxYBZPXLQTQIvzrCqZPfAL
         +VQfFScDoRFcHH+jwIMT7yDvTtyDGmoXdFzabHcQMXEMQLe/HJcLuHMLa1I9W00EwFX6
         y0hAhrlZ0IGN8GgIJ669XOj2bcnZBrYA8xNbfBp+mHOGoCla+kfhVI6ZGBnWXj7sLHAt
         fhVj/FI3NzgAJzAHDqCGvCmKTqBPraJT5a5lMHrCY5sSpjIJnhMIfFHPzr6hQbJX+BpC
         LhZg==
X-Gm-Message-State: AOAM53287Rd7ffhfUM/+xyHP7vk88NXqsGWu1VktJnbObd1ZKJ7pPfb5
        aD3ksfvGhtFgAxajoGJ67F1Rphxls43LcLkG
X-Google-Smtp-Source: ABdhPJy8+qr4YNNvR4swIeojRSfHn774tb24hJI9RxD5ui4LFMl+xjjEfPSsZ+2jEB/0yy/r1c+mNg==
X-Received: by 2002:a05:6602:99:: with SMTP id h25mr3721659iob.168.1614364283829;
        Fri, 26 Feb 2021 10:31:23 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g6sm4896443ilf.3.2021.02.26.10.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 10:31:23 -0800 (PST)
Subject: Re: Stray reference to RQF_SORTED
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <3f5f3d34220d882ca20696da0df1b9feeeaba879.camel@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <26ca21d3-ef5b-5715-ef24-05a1242be6aa@kernel.dk>
Date:   Fri, 26 Feb 2021 11:31:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3f5f3d34220d882ca20696da0df1b9feeeaba879.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/26/21 2:52 AM, Jean Delvare wrote:
> Hi Jens,
> 
> In commit a1ce35fa49852db60fc6e268038530be533c5b15 ("block: remove dead
> elevator code") you removed all users of RQF_SORTED. However there is
> still one reference left to it:
> 
> block/blk-mq-sched.c:412:               rq->rq_flags |= RQF_SORTED;
> 
> This in effect is dead code now. Should this statement have been
> removed as part of the aforementioned commit? And then maybe also the
> definition of RQF_SORTED, to prevent further confusion?

It's just a leftover, feel free to send a patch to kill it.

-- 
Jens Axboe

