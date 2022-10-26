Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E09C38A2D
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 00:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiJZAx2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 20:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiJZAx1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 20:53:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C00FEEA81
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 17:53:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d10so13729657pfh.6
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BeIQrWdV7ri3khplWK2ZiFNyIA9PB6YDg0bsV9xNWQ=;
        b=K/1DQamFZf1Pl5aT14H8LDRCBmSSq+yZAyfo3rhIrcJZD4yMeD92bLzbtl7sN4+2cI
         mr+mwLfjO7w7RSF9MHv3AWRKbQZbdQVBMif3WS/jtYNRMaFuM1wL7IFVxIqLqA8VokMb
         iVsG4OGo7JYK2Qlc2sNetp7M3ZgduBwQ20hLKI3C2uI60baFHHtYHEqOQ/gr0J8FypmW
         Y9F9Xfol8f9+9Ja40Ymzi1jeg4PXdy/Ben53UConU4/qVlMzUV6IvqVJvB5D7dbxNHSJ
         3jGxvkLwdECK53WFEpN4bIR3eBUoweHtlaCYaof9PX11UQ1IoNTMhGVexfxHD3jJ8Q/T
         xSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BeIQrWdV7ri3khplWK2ZiFNyIA9PB6YDg0bsV9xNWQ=;
        b=pt33hkwZajoQgp16ANBfBvhwlUQA1m6+rQYFWwJDu16F8L+9mvjQ+FBChm+0CY14fy
         38oKOWjOsKRalXuM3bZhtxNzfY2D/OXCHM//GpAd0w7MxeLF55KrRVpbjlYuzSdmTb/S
         XfadE1bzinv+JgklIwIhCKQSyKatnuL+ZP8Jt0zMEW4NjMzCXX12NL8ZbHVNTlG3cElv
         OsWV6wxu/oBd9E1R+NiXdC4sVLqSm7MsK6WtrA42gfm0Xd4ok4WO834oc0VwBeFQk1Wz
         Pz5p5TYvYOXkvfa1Sai/2bLdFIYZH0UBcYbASsEoAgxWLklgtXetovs0osPMfX/oxQ/j
         lafg==
X-Gm-Message-State: ACrzQf25E+nEq5aWDykiZYdhbmfAut5eM13Og2RahHXfExWXzhHQ3/Qr
        Auu/7tN8f8HlAhNpFEWA4bGsVg==
X-Google-Smtp-Source: AMsMyM6lSF0wma+b6hQ9iTBOfapH6Y9ERDVrz686bQsT/qUuGRIWkfXEHJMO2x0vtYbCrHhkUAYwlw==
X-Received: by 2002:a63:66c6:0:b0:46e:c05d:b8d6 with SMTP id a189-20020a6366c6000000b0046ec05db8d6mr20927251pgc.474.1666745605460;
        Tue, 25 Oct 2022 17:53:25 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r26-20020aa79eda000000b0056b8b17f914sm1931421pfq.216.2022.10.25.17.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 17:53:24 -0700 (PDT)
Message-ID: <6af0ad92-8e31-d79f-9655-8819c12082a0@kernel.dk>
Date:   Tue, 25 Oct 2022 18:53:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] blk-mq: avoid double ->queue_rq() because of early
 timeout
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        virtualization@lists.linux-foundation.org
References: <20221025005501.281460-1-ming.lei@redhat.com>
 <bf375891-667f-1bcc-bd63-b90e757f5322@kernel.dk> <Y1h9fiY8TYD8HK5v@T590>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y1h9fiY8TYD8HK5v@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/22 6:21 PM, Ming Lei wrote:
> On Tue, Oct 25, 2022 at 12:11:39PM -0600, Jens Axboe wrote:
>> On 10/24/22 6:55 PM, Ming Lei wrote:
>>> @@ -1593,10 +1598,18 @@ static void blk_mq_timeout_work(struct work_struct *work)
>>>  	if (!percpu_ref_tryget(&q->q_usage_counter))
>>>  		return;
>>>  
>>> -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
>>> +	/*
>>> +	 * Before walking tags, we must ensure any submit started before
>>> +	 * the current time has finished. Since the submit uses srcu or rcu,
>>> +	 * wait for a synchronization point to ensure all running submits
>>> +	 * have finished
>>> +	 */
>>> +	blk_mq_wait_quiesce_done(q);
>>
>> I'm a little worried about this bit - so we'll basically do a sync RCU
>> every time the timeout timer runs... Depending on machine load, that
>> can take a long time.
> 
> Yeah, the per-queue timeout timer is never canceled after request is
> completed, so most of times the timeout work does nothing.

Yep, it just keeps going, that's the point of the rolling timeout timer.

> Can we run the sync RCU only if there is timed out request found? Then
> the wait is only needed in case that timeout handling is required. Also
> sync rcu is already done in some driver's ->timeout().

That was going to be my suggestion, if it can get done only for when
there's actually a potential timeout candidate, then that would be
orders of magnitude better.

-- 
Jens Axboe
