Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10139C10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 13:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44E920724
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 13:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xVN31Wh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgCMNod (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:44:33 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39843 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgCMNod (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 09:44:33 -0400
Received: by mail-io1-f67.google.com with SMTP id c19so8317332ioo.6
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2020 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2PKl7mOydp1dSq5W+BYL11Bbntt3JxpW4oa0TO2j57E=;
        b=xVN31Wh3UPZBXwZtWvgfVifg6tKgq+SE4D4MwdJnSQRD4keGzzVMuRXne3AcGXKqo7
         sg4+Ah9DZ/6DI9TjkWmQWLHVUvHVSk060gVdW3Y9owssU50SLcTVHmTPu7kXOBnq9trO
         cda8qNnwp3b0qb9S+a3IOdcGrCX23ZaJ8vQ1sqgHcpwChd4Gf23KY8h0b1BZiMqawcyC
         9mpZzLNV9vdtu6+gWO4rvuLW5QP7M2eEs9QlSKn3g2Pjjp9CWPxecbLmuUjjWB1FzH8Y
         Mpl0vL83i4tqHn0pdG6QWoYwO8WbwxYMTSG2EveTTk1iADux+VjdWgnexzLacqnySpR+
         gXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2PKl7mOydp1dSq5W+BYL11Bbntt3JxpW4oa0TO2j57E=;
        b=tTAHFEkXwO0YCa4Eh1otscN4D3CfNaNzjnhi+PAO+5gj8TzxIbJoOGE7qIrQdrA8+8
         PUAFoW4eTYJwuYrZCLd8xedoCZ3y98LSU+rR/pVUFG7zCv6l7iqKx/A3ebDjDh8vK0dS
         w/KNdNs0lGWmAvHfSNdzM8IUsHFtl4bLHyXhmVc8lOi8AYMWAe0IPwsPpQ7y3YXDpaZA
         qwGB6cJeFNiPQ9qiiVqMLzbXoRErzWYo8cC0cCnhwttbvbJPg5boX4FNWoJkosvWbocW
         ycdIUgdLdOzPfGCtP3B0qLsJJFz5LVzoDomL2+pmm2rPUP3BPkxiXbXeE0OWQ8NkzjkL
         Csag==
X-Gm-Message-State: ANhLgQ1RXidI+abVA98ohTk9xsaxCS+dIaMBXl8lwJfi5u+wHMnBpOah
        F+3kmync4DNNR0Ty9MIoyxlMXg==
X-Google-Smtp-Source: ADFU+vvTArKVcsvjf0+YA1gvmwN4Nd+x7C/4VW4XQAavD7JHa2lx0B5g3FL7tPyDLsnpdATidvmxQw==
X-Received: by 2002:a6b:5103:: with SMTP id f3mr12482583iob.181.1584107070497;
        Fri, 13 Mar 2020 06:44:30 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m2sm10042180iok.6.2020.03.13.06.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 06:44:29 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: insert flush request to the front of dispatch
 queue
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20200312091548.25237-1-ming.lei@redhat.com>
 <7fd41813-0491-4cce-d3a3-d13e37ad2e69@kernel.dk>
 <20200313053311.rzwwhy37bxj2ho2v@shindev.dhcp.fujisawa.hgst.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <66d24d4f-bd8a-6f25-85ab-06ac2589549e@kernel.dk>
Date:   Fri, 13 Mar 2020 07:44:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313053311.rzwwhy37bxj2ho2v@shindev.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/20 11:33 PM, Shinichiro Kawasaki wrote:
> On Mar 12, 2020 / 07:26, Jens Axboe wrote:
>> On 3/12/20 3:15 AM, Ming Lei wrote:
>>> commit 01e99aeca397 ("blk-mq: insert passthrough request into
>>> hctx->dispatch directly") may change to add flush request to the tail
>>> of dispatch by applying the 'add_head' parameter of
>>> blk_mq_sched_insert_request.
>>>
>>> Turns out this way causes performance regression on NCQ controller because
>>> flush is non-NCQ command, which can't be queued when there is any in-flight
>>> NCQ command. When adding flush rq to the front of hctx->dispatch, it is
>>> easier to introduce extra time to flush rq's latency compared with adding
>>> to the tail of dispatch queue because of S_SCHED_RESTART, then chance of
>>> flush merge is increased, and less flush requests may be issued to
>>> controller.
>>>
>>> So always insert flush request to the front of dispatch queue just like
>>> before applying commit 01e99aeca397 ("blk-mq: insert passthrough request
>>> into hctx->dispatch directly").
>>
>> Applied, thanks.
> 
> Ming, thank you so much for the patch. Using my SMR SATA drive I confirmed it
> reduces blktests block/004 runtime as expected. With this patch, the runtime is
> like before the commit 01e99aeca397. Good.

Thanks for testing, it'll go into 5.6.

-- 
Jens Axboe

