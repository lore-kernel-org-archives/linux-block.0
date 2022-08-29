Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BD6ECAAA2
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 03:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiH2Daw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Aug 2022 23:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiH2Dav (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Aug 2022 23:30:51 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33B71EC57
        for <linux-block@vger.kernel.org>; Sun, 28 Aug 2022 20:30:49 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so196702pja.4
        for <linux-block@vger.kernel.org>; Sun, 28 Aug 2022 20:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=euuNRCHum+BxvFSas9ULJVPRpdf2sR1Xdf6yPAhw4gg=;
        b=LUyj5ejMM5QFXfd7TZOX7HB6Ug7tneKInmN3xO+IOvx1RPJ7JKCS7duI9co6IY18+4
         n2GXJ9ywIXKkBh23boJN9hlnC6WX8kvOh8XzOruIlf3BRV6HNQrySNISzVldiF1OVuFV
         5i11itha+vdiBNc3fdLXnFfbKYn44zt0QYuaH51Q8fL6xJ8y1h8Qao9uOK7KFPM3Yrnp
         ZzfiJGGb5Ty+53nf0x3aaQxtZS0DxGCMie1Hu5dd/pHL4n7nHKfG7oV4vWoBLNPB0Ymb
         NM92uOtVGEeZPcCN4lP1pcdwut+8yDX3ghT1pPf0SzpgYipZrxeXg8cwT5wIQhft3LWT
         q7vw==
X-Gm-Message-State: ACgBeo238QEe5p+W6wjfHRI4JDqRnbvo8KpyGzFm3NVEUYMeI7yen8B0
        p27LQfM/qxlzReFBKDK/544=
X-Google-Smtp-Source: AA6agR4pDHdrhOMdjIRvl/wP/YFpRlaG00Ygs9wymI+UVl6HaXPQU0wGgjZhPPlTwzlg3hwsRJPY0A==
X-Received: by 2002:a17:902:e94f:b0:173:d0d:c4f5 with SMTP id b15-20020a170902e94f00b001730d0dc4f5mr14529877pll.167.1661743849234;
        Sun, 28 Aug 2022 20:30:49 -0700 (PDT)
Received: from [172.20.0.236] ([12.219.165.6])
        by smtp.gmail.com with ESMTPSA id nh16-20020a17090b365000b001fd8316db51sm1930643pjb.7.2022.08.28.20.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 20:30:48 -0700 (PDT)
Message-ID: <19dcc0d6-fe26-a9db-4d39-794ec78c94be@acm.org>
Date:   Sun, 28 Aug 2022 20:30:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] block: I/O error occurs during SATA disk stress test
Content-Language: en-US
To:     gumi@linux.alibaba.com, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org
References: <002001d8bb57$000eabe0$002c03a0$@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <002001d8bb57$000eabe0$002c03a0$@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/28/22 20:25, gumi@linux.alibaba.com wrote:
> This problem occurs on kernel version 5.10, and i read this commit
> you mentioned. The problem I observed is not a problem of req re-used
> fixed by commit 2e315dc07df0, but a different problem. The specific
> scene is this: A new IO has called blk_mq_start_request() to start
> sending, and an instruction out of sequence occurs between
> blk_add_timer() and WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in
> blk_mq_start_request(), so the req->state is set to MQ_RQ_IN_FLIGHT,
> but req->deadline still 0, and at this very moment, timeout
> handler(blk_mq_check_expired()) check if this new IO times out,  this
> condition(if (time_after_eq(jiffies, deadline)) in
> blk_mq_req_expired() called by blk_mq_check_expired()) will is true.
> The end result is that this new IO is considered to have timed out. I
> looked at the latest kernel code and the problem persists, do you
> agree with my analysis process?
It seems unlikely to me that the above analysis is correct. If this 
problem would occur with recent kernel versions, I think that it would 
already have been reported by other Linux users.

Thanks,

Bart.
