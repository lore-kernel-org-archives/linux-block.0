Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3E5C636D4
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 23:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBOXil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 18:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOXik (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 18:38:40 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F532E80D
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 15:38:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so419360pjw.2
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 15:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDCpb29t0UOaC1MkXys54Xi2iDlQT7Hj8EdfzSBM6Lw=;
        b=ooUMFSMYqVHfp7oufrV8cnWf7GisKlzRW+n+xT+UiX8RRYzpzcGkj2ZvYEI5xIq7tM
         pa/2fKI7jwufzoYNs29yl12amh2A8vlJNnD+ObgSHsLi7YLVoCavX2pm2yj1EcpDshEy
         dhhQyBvTOuWjDODh+jM4jvkCcQt6kmGvkGH42tgaayV3/dLY6MQfFZxBo9A8oI96LhFM
         xPS7taKb2TPn373/3wtLM/xgQNkXeNSk9RvrZE0dT04BV7dDlZ4LI4wKIGwTo6vbfl48
         EGTK0zVYs6N1OMWgivkklTyGH4DbGdVfGMhr53h7jSlXicooZYXwEvstgbKVlzVb5cul
         Homw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDCpb29t0UOaC1MkXys54Xi2iDlQT7Hj8EdfzSBM6Lw=;
        b=JBH9VXaGNEn49UkhButN9YehJvnr15eUrIXcbFgymCYjdinZ3Q9JNSSixV82szq8rL
         ftiTvmG7ixGmb94V11iy4ofxgTYVxgSRx35Y4xja+DFeEfVfh50yoqVe/9vnZqcKp3Mr
         shBWimotPGtS/LuKKKqd/cheSGKsaVWSuPBML5d497brZkwEaCL0QLBpjB7vrWYewsyT
         nqBzgA1AdLIJUQsmNmLoA/T8YB+HtxL+/c2jcg/t75yG1NAbGE83TBCgVC6Nrpj56dWL
         NyQnimCniV4WUTxf+D6qTgKVhIICOPQUzSmb3HWE/GI4MHvTb0RjokXrh7Ycn0KmhAtG
         Bj9g==
X-Gm-Message-State: AO0yUKWge+9QbjI7H+q+EJoQN4HIHh0yIcYC0dgBjL4TPf/1clNWO1zV
        l3zpbLS+AieMC3UeHM9HnF7EwQ==
X-Google-Smtp-Source: AK7set8k02XAPtfzpqa5nUCCGxyjbiXdailh3Y2/KSnDrN1njFVWb7k8v3nywfnxtokFnjg5pGa94g==
X-Received: by 2002:a17:903:41cc:b0:199:3f82:ef62 with SMTP id u12-20020a17090341cc00b001993f82ef62mr4513914ple.5.1676504318127;
        Wed, 15 Feb 2023 15:38:38 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c15100b0019a70a85e8fsm10719620plj.220.2023.02.15.15.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 15:38:37 -0800 (PST)
Message-ID: <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
Date:   Wed, 15 Feb 2023 16:38:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     hch@lst.de, mcgrof@kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
 <20230203103005.31290-1-p.raghav@samsung.com> <Y+Gsu0PiXBIf8fFU@T590>
 <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com> <Y+nwh7V5xehxMWDR@T590>
 <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/14/23 7:48?AM, Pankaj Raghav wrote:
> Hi Ming,
> 
> On 2023-02-13 13:40, Ming Lei wrote:
>>>>
>>>> Can you share perf data on other non-io_uring engine often used? The
>>>> thing is that we still have lots of non-io_uring workloads, which can't
>>>> be hurt now.
>>>>
>>> Sounds good. Does psync and libaio along with io_uring suffice?
>>
>> Yeah, it should be enough.
>>
> 
> Performance regression is noticed for libaio and psync. I did the same
> tests on null_blk with bio and blk-mq backends, and noticed a similar pattern.
> 
> Should we add a module parameter to switch between bio and blk-mq back-end
> in brd, similar to null_blk? The default option would be bio to avoid
> regression on existing workloads.
> 
> There is a clear performance gain for some workloads with blk-mq support in
> brd. Let me know your thoughts. See below the performance results.
> 
> Results for brd with --direct enabled:

I think your numbers are skewed because brd isn't flagg nowait, can you
try with this?

I ran some quick testing here, using the current tree:

		without patch		with patch
io_uring	~430K IOPS		~3.4M IOPS
libaio		~895K IOPS		~895K IOPS

which is a pretty substantial difference...

-- 
Jens Axboe

