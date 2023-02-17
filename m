Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D4BC636D4
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 13:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBQNE2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 08:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBQNE1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 08:04:27 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFD75B753
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 05:04:26 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 23so473456pgg.8
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 05:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676639066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDBrPBq8XL5glWMxx9hm8uOcauMlswK+K6PfljAGBlg=;
        b=3hP2Hgumwep4ynYmjuKPUIl3niSp2MjEWvP5UhSYbgY7MI1sx3YzfHgHE9VCxHQkJ9
         9G5rbJdMzWlyYfwAYwYAOTn53SKPMf32eUUOrTFl0ew6DwThLXWHnC8N9VJhRTTufnID
         R5HxF6ebWl+fUIbKq2ZDT6nJS98mz7Oe8tRZjhr36M8o1c54FJLPDj1HZ4TOsb7N0eGI
         nsmU2Pu+sGOm3dxMvh5NwdkxPBETQlubhvOtBgQaVkNGbzOKrhyvThQo5faKbArEdv7R
         OL6xMVAbAQ2ppQ3vTB5ujEP/lsKy8jgs1KYd3TJvSJr6Q3XU80uYgvWKsw+6IE5lc7AL
         xHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676639066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDBrPBq8XL5glWMxx9hm8uOcauMlswK+K6PfljAGBlg=;
        b=ZAD3Nzbm0qaXKAzhVlbkTWyz+vcZqktXA2hEoHc4zTYkTFVjAc919OaqXLnAa0910t
         qpC1fpNkYDNqZZ00XxupOkauw/t1acI2SqbLgq9a2bZQtAPVJZV3aGkt2llay+yRJumE
         0W2ZOR/BnvlATNbKgHPEx8P6I9w0lR7tndMcx4WnxJ3ZnIbMCzBN40ZrOPkMlIQH84wX
         duykP8rONijDXIE9mFiKv22su4ypfrMy3USZIBJTc9N44YeWuBRU58jQz7TS2mXUogWH
         qR3X4nmVug/yhddt4iien2ux51njGw+K2Riv0JIlHTs9yTL/oesXj+vO4awzcgSOTqpI
         4vbw==
X-Gm-Message-State: AO0yUKWZZ3xmRAD2+2CjVj9TZOR/JejECbu+c5cz98UHKqGufRy9bsyK
        pMIDbUjhgZn0BfeYDZUtJKgykmKgza+ZMvzG
X-Google-Smtp-Source: AK7set+aybvXLVsiXzfNRFwHlOz3ZVQaZ7GXgL3pCnLpG86KXCfKYRYR/oZF8kCQdINpfqpTplogoA==
X-Received: by 2002:a05:6a00:1c92:b0:5a9:c2d5:136c with SMTP id y18-20020a056a001c9200b005a9c2d5136cmr3502368pfw.3.1676639065446;
        Fri, 17 Feb 2023 05:04:25 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z20-20020aa791d4000000b00590684f016bsm3028697pfa.137.2023.02.17.05.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 05:04:25 -0800 (PST)
Message-ID: <443e30c3-26fe-c151-6522-373f0a816457@kernel.dk>
Date:   Fri, 17 Feb 2023 06:04:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] brd: use radix_tree_maybe_preload instead of
 radix_tree_preload
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hch@lst.de, gost.dev@samsung.com, linux-block@vger.kernel.org
References: <CGME20230217121602eucas1p1b85aa17f46f6b602446a9d83ccf67708@eucas1p1.samsung.com>
 <20230217121442.33914-1-p.raghav@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230217121442.33914-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/17/23 5:14 AM, Pankaj Raghav wrote:
> Unconditionally calling radix_tree_preload_end() results in a OOPS
> message as the preload is only conditionally called for
> gfpflags_allow_blocking().
> 
> [   20.267323] BUG: using smp_processor_id() in preemptible [00000000] code: fio/416
> [   20.267837] caller is brd_insert_page.part.0+0xbe/0x190 [brd]
> [   20.269436] Call Trace:
> [   20.269598]  <TASK>
> [   20.269742]  dump_stack_lvl+0x32/0x50
> [   20.269982]  check_preemption_disabled+0xd1/0xe0
> [   20.270289]  brd_insert_page.part.0+0xbe/0x190 [brd]
> [   20.270664]  brd_submit_bio+0x33f/0xf40 [brd]
> 
> Use radix_tree_maybe_preload() which does preload only if
> gfpflags_allow_blocking() is true but also takes the lock. Therefore,
> unconditionally calling radix_tree_preload_end() should not create any
> issues and the message disappears.

Thanks, I wonder why I didn't see this in my testing which did both.
But it's certainly an oversight!

-- 
Jens Axboe


