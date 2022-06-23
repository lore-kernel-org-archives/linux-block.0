Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A42C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 12:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiFWMFN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 08:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiFWMFL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 08:05:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDAD4969A
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 05:05:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 68so13515401pgb.10
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7fTUfh8oa0k/yFUAPepSS4rewtDXGbbOzBk2gx6tB4A=;
        b=jMhJWnJ3C6Gqm7C5NNvcQdJOhIQcAh5TU8WzfDuhsEwZWTBVy9cbZRume/Pw7HG2ua
         kHfo3HE+GYqtWwB3uhILkRWEpGqsovQwWGMONlIgI+S3KwEL/kkg0RyG7Vl7Fya+n1Jg
         FGJ//2vcHELQQlQuAVpyZvVE6zrmblUHupOcjm8FH9cjSf42bT6uRMSXNrDuznsfr41a
         j0nlGJRaIxxgJo8Nzpuwfuablv36B4HmHC8MiyT58sDPDQsu943OrP7fRkKU/qZ8SZMK
         9I/T7GZR/z7T86ks/LeiOXXdD7ozHZ3Kbqu5BmWaJAF5OWucryeDApxUlj1dR+hUgqn2
         DUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7fTUfh8oa0k/yFUAPepSS4rewtDXGbbOzBk2gx6tB4A=;
        b=JwsJVrrmk4d/ktWEUKBJ+1fprbAJByCTEszCp2e29p4Q0bKVxLX/i/hdf0Z4oRwFVE
         Tn9rF9H3BLkbu333/NxvfcRyPbMA3C7nBwacq3Pl1pIfMrv9OWCDurC9AQpj4QQvllFZ
         nM/SCXleI+03MTuCQx0NPNLKZAhQeJeSTqZ2go0T9Vq/fICzvhlaS7KHSc+aiQEMfZEm
         1BrNaMNBHbkfRjI266KqXEMyS42juDLr0tol3SsN0p9tDV/1yFxm4/viRMaUszO7oj9M
         7Lz+2xtuViboZqqr7xZelULx6TJUIzHPxdIZy/aWEi42MUhHIyHK3Preg1BrOVrl+MGh
         Bftw==
X-Gm-Message-State: AJIora90+dB77icD+jdGW9CpAaG6nq7kXNNs82KoGFFo90UwlHw9pIuL
        IUop22rcwl7jITnA03wjRjMcrg==
X-Google-Smtp-Source: AGRyM1v7pm8vWIsKlmFANwgtZHb6z/lgHPYUzfzpOg1iMHcCN5WHBdp9BLENdkvpv6xTNthapQsRaA==
X-Received: by 2002:a05:6a00:ad0:b0:50a:51b3:1e3d with SMTP id c16-20020a056a000ad000b0050a51b31e3dmr40716979pfl.18.1655985908712;
        Thu, 23 Jun 2022 05:05:08 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e30-20020a17090a6fa100b001eafa265869sm1701374pjk.56.2022.06.23.05.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 05:05:08 -0700 (PDT)
Message-ID: <394d2490-def0-30c0-7341-983bc93b8c57@kernel.dk>
Date:   Thu, 23 Jun 2022 06:05:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] block: pop cached rq before potentially blocking
 rq_qos_throttle()
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dylan Yudaken <dylany@fb.com>
References: <65187802-413a-7425-234e-68cf0b281a91@kernel.dk>
 <20220623085559.csg72pmamhwgkcbx@shindev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220623085559.csg72pmamhwgkcbx@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 2:56 AM, Shinichiro Kawasaki wrote:
> On Jun 21, 2022 / 10:07, Jens Axboe wrote:
>> If rq_qos_throttle() ends up blocking, then we will have invalidated and
>> flushed our current plug. Since blk_mq_get_cached_request() hasn't
>> popped the cached request off the plug list just yet, we end holding a
>> pointer to a request that is no longer valid. This insta-crashes with
>> rq->mq_hctx being NULL in the validity checks just after.
>>
>> Pop the request off the cached list before doing rq_qos_throttle() to
>> avoid using a potentially stale request.
>>
>> Fixes: 0a5aa8d161d1 ("block: fix blk_mq_attempt_bio_merge and rq_qos_throttle protection")
>> Reported-by: Dylan Yudaken <dylany@fb.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Thank you for the fix and sorry for the trouble. The patch passed my test set:
> 
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> 
> BTW, may I know the workload or script which triggers the failure? I'm
> interested in if we can add a blktests test case to exercises qos throttle
> and prevent similar bugs in the future.

Not sure if there are others, but specifically blk-iocost will do an
explicit schedule() for some conditions. See the bottom of
ioc_rqos_throttle().

-- 
Jens Axboe

