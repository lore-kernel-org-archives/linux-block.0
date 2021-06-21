Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F5AC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F690611C1
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhFUXoh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhFUXog (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 19:44:36 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA2C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 16:42:18 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id z1so6936502ils.0
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 16:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zz9bnVf0t3FfSTpwwRt0ie6SngOz8R7fTCpQev9Jwe8=;
        b=wR7BhI27gd3ol0+Mjuw49ogEY6n2D4drnLlyE0yHc7j4SAY19B0pk/EoE10vj3Mx7c
         VaLBwEjTtQTW6tujtq0GeJPIWO6JwIYIe+3zNGGrXu/ZiATpf1jjqLR26ilGXEE74wyk
         vJpaRsZN4V3uBOBlqy6BxpY/LbgYrBfZkoWY0Sws8SQJkFqHOdbit4sEVrwYcL/MR/Al
         c45w475rGPDI+6k2k/7sXZPDtcKET7AblQ+bB7TXASCedpcM9Za9zFzTtEyY45mlEld7
         mAI4zI+dJQLVWU81ppgemk6WPID3TyfGZNkLcVD+R5MjHN6fbri6ykky9my41Sq/Ibr/
         3pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zz9bnVf0t3FfSTpwwRt0ie6SngOz8R7fTCpQev9Jwe8=;
        b=r4emolXN8/JSDxSyiE1WuNutY6Uh6VIO8OGu834BPYSGZG4eyLRa9j5GuI8o5h/PQ4
         ugg4RYrrGYqc0aaVQAzXuG7DRzbc5CYFLMfP7yw5s4h/dPQrQufEIeERpX4G9/G10n2E
         KTQ38JBkbqh2MOgBUsCLACqR0cApwzPGGbouSQ0K4endeUy+KHLW6pfD86akf4x04qIX
         b5Qd/0yDtFKNtDeHiLKTSzcQSALW0A6Aq0z5k7KL72V2QoRwVJXU+gtS+inaMIhuFEwc
         i+u/5Os9cGZ4ICJefsU+tZnEyA9EYnxZLWwOZ3giZZNDlYysxTC98TT8AlaaaRKulUd7
         mEww==
X-Gm-Message-State: AOAM530F55jP668QQ42ZWJOJq+j+Iw3upR3UKfkQIb5zxUPvW4RxL8ZO
        3HdT+0xCbWFyNVh4aJV2ENy8ZNgPjJQtSQ==
X-Google-Smtp-Source: ABdhPJyDXxjc9QwChDtokHiJD3zGW6o0HBuRRgUBnmt3hzf697UKqSYAWe0nCSodn6sWk83G59shTw==
X-Received: by 2002:a92:7b01:: with SMTP id w1mr562372ilc.100.1624318937804;
        Mon, 21 Jun 2021 16:42:17 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id f7sm6972182ilk.50.2021.06.21.16.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:42:17 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e13=2e0?=
 =?UTF-8?Q?-rc6_=28block=2c_b0740de3=29?=
To:     Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        linux-block@vger.kernel.org
References: <cki.3F4F097E3B.299V5OKJ7M@redhat.com>
 <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
 <CA+tGwnn4J2=WuPEFOwmC6ph30rHXJLhjH-iWmvkKLpacmR7wdQ@mail.gmail.com>
 <42b91718-9d70-4e4c-2716-6259321abd64@kernel.dk>
 <CA+tGwn=8KMpRi+6M-Lcs5MjKTkPd36YL5wv84Ji2dEWLjzfDmA@mail.gmail.com>
 <YNELoqls01MVLsuT@casper.infradead.org>
 <8a7b26a3-a17d-e851-690a-5a33b06f5dec@gmail.com>
 <YNEhq/C5/T4J8r2/@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5cf4b5ae-c6aa-d64d-53ec-3e073a77baef@kernel.dk>
Date:   Mon, 21 Jun 2021 17:42:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YNEhq/C5/T4J8r2/@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 5:32 PM, Matthew Wilcox wrote:
> On Mon, Jun 21, 2021 at 11:57:06PM +0100, Pavel Begunkov wrote:
>> On 6/21/21 10:58 PM, Matthew Wilcox wrote:
>>> On Mon, Jun 21, 2021 at 11:07:16PM +0200, Veronika Kabatova wrote:
>>>> On Mon, Jun 21, 2021 at 11:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>> On 6/21/21 2:57 PM, Veronika Kabatova wrote:
>>>>>> On Mon, Jun 21, 2021 at 9:20 PM Veronika Kabatova <vkabatov@redhat.com> wrote:
>>>>>>>
>>>>>>> On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> We ran automated tests on a recent commit from this kernel tree:
>>>>>>>>
>>>>>>>>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>>>>>>             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
>>>>>>>>
>>>>>>>> The results of these automated tests are provided below.
>>>>>>>>
>>>>>>>>     Overall result: FAILED (see details below)
>>>>>>>>              Merge: OK
>>>>>>>>            Compile: FAILED
>>>>>>>>
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> the failure is introduced between this commit and d142f908ebab64955eb48e.
>>>>>>> Currently seeing if I can bisect it closer but maybe someone already has an
>>>>>>> idea what went wrong.
>>>>>>>
>>>>>>
>>>>>> First commit failing the compilation is 7a2b0ef2a3b83733d7.
>>>>>
>>>>> Where's the log? Adding Willy...
>>>>>
>>>>
>>>> Logs and kernel configs for each arch are linked in the original email at
>>>> https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/06/21/324657779
>>>
>>> Which aren't there by the time they get to the original commit author.
>>> You need to do better than this; the Intel build-bot bisects to the
>>> commit which actually causes the error.
>>
>> Matthew, I've just followed the link out of curiosity:
> 
> the link _which isn't in the first email i got_.  the redhat cki system
> is not very useful _because it doesn't do an automatic bisect and cc the
> author of the commit_.

Kinks are still being worked out on that, nobody has claimed it's
perfect yet. Some manual input/labor is still required.

But it's useful, as this report has indicated. So maybe try and be a bit
nicer and appreciative, instead of grumpy and dismissive. It did find a
problem with YOUR patch, fwiw.

-- 
Jens Axboe

