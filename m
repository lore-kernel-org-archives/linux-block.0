Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4055C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Apr 2022 19:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiD1T4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Apr 2022 15:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiD1T4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Apr 2022 15:56:00 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722C0BF310
        for <linux-block@vger.kernel.org>; Thu, 28 Apr 2022 12:52:44 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id iq10so5242920pjb.0
        for <linux-block@vger.kernel.org>; Thu, 28 Apr 2022 12:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V6J1YyzUPMbytdnVTVfM86Q/b7IKzy8rWJuvLclF/fg=;
        b=TzVsjz6KXcgWRbiAYCF+dyNE0M3o9N3FnPiq9+NFmFjwKCDRTe8OQcHhPh99PzBkNG
         yI9Wh23YiINAm9ijnPAhup2huM6XMnYJoyjQbstDXN1tq7uHoQV0lAk9C8ewpGz9YrYa
         T0N7Yni2l0ua7i99bH5QDxJkmInijViEZZxoz4h8qOU8B/JVOTaVdd1/N+fIYfZNZ8c6
         FP545NHHUcWtYl1UvTNuU2mJjwSFhmh6x1Cgecs5wwtN0nDdypGx6bPENAsCLvGpS+I5
         vVjn0yJntlG2+9iewFrkrd9WJUZsmgPui5yArZz+1X7NqWf/5G0iPa16ps8zLz0UixCI
         I/ng==
X-Gm-Message-State: AOAM533qqgkPUp0yWoLyX4GzqChub3llaoeGbIeZ9kqko9Yodx2QCNX5
        PEI9u1X4wxlPzguaxWpwHhKKXVp1J2WKQw==
X-Google-Smtp-Source: ABdhPJxj727hISEwknO8/ZQt18IN7j+y7ZVNiDA1/2xb7DLCZKLfbgo4CSUJcyMhMWHaZXxRTDW8og==
X-Received: by 2002:a17:90a:fd10:b0:1d9:2a41:6fe6 with SMTP id cv16-20020a17090afd1000b001d92a416fe6mr33624177pjb.196.1651175563848;
        Thu, 28 Apr 2022 12:52:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6f14:f527:3ca8:ecbf? ([2620:15c:211:201:6f14:f527:3ca8:ecbf])
        by smtp.gmail.com with ESMTPSA id n19-20020a6563d3000000b003c14af5063dsm3654435pgv.85.2022.04.28.12.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 12:52:43 -0700 (PDT)
Message-ID: <deaf359d-584f-f328-0b0a-1f3ce0e0937e@acm.org>
Date:   Thu, 28 Apr 2022 12:52:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH blktests 2/3] Add I/O scheduler tests for queue depth 1
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20220427213143.2490653-1-bvanassche@acm.org>
 <20220427213143.2490653-3-bvanassche@acm.org>
 <20220428062659.udpifr26qgsqfysh@fedora>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220428062659.udpifr26qgsqfysh@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/22 23:27, Shinichiro Kawasaki wrote:
> On Apr 27, 2022 / 14:31, Bart Van Assche wrote:
>> Some block devices, e.g. USB sticks, only support queue depth 1. The
>> QD=1 code paths do not get tested routinely. Hence add tests for the
>> QD=1 use case.
>>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> I tried this new test case on recent Fedora kernel 5.16.20-200.fc35.x86_64 and
> Intel Core i9 machine, then observed failure:
> 
> $ sudo ./check block/032
> block/032 (test I/O scheduler performance of null_blk with queue_depth 1) [failed]
>      bfq          679 vs 243: fail  ...  679 vs 252: fail
>      kyber        542 vs 243: fail  ...  551 vs 252: fail
>      mq-deadline  577 vs 243: fail  ...  572 vs 252: fail
>      runtime      20.514s           ...  20.660s
>      --- tests/block/032.out     2022-04-27 22:02:46.602861565 -0700
>      +++ /home/shin/kts/kernel-test-suite/src/blktests/results/nodev/block/032.out.bad2022-04-27 23:18:48.470170788 -0700
>      @@ -1,2 +1,2 @@
>       Running block/032
>      -Test complete
>      +Test failed
> 
> I tried v5.18-rcX kernel versions and machines (QEMU or VMware) but the test
> case failed on all of the trials. Do I miss anything to make the test case pass?

Hi Shinichiro,

The two tests added by this patch pass when using the legacy block layer 
(kernel v4.19) but not when using blk-mq. I see this as a (performance) 
bug in blk-mq. With blk-mq an excessive number of queue runs is 
triggered for QD=1 if multiple processes try to submit I/O concurrently.

Thanks,

Bart.


