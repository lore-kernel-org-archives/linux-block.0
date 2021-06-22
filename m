Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3739BC4743C
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 00:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9EC61289
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 00:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFVAuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFVAue (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 20:50:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04F1C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 17:48:18 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id q18so16948140ile.10
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 17:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kbcQjN8MVAZM0FwGPkinh9qCyh3jo4RCpZr8Jex4Yd8=;
        b=b9hwXg1j8oWHhJsnCyvgdpHPGsaq+K0eMuXe2CZcbDVW3Vi7Cx5bUumoHa6o648QY6
         K4EdB917pTsw1WIBH9iLizCqp68spdj1T472NMnDbdM6vg4EuMEDs5gf8cqkfcUE9V8v
         /CKWo//vlBD9X4IZ8iAVWSnaeHcKIkTw+ttkM7kaYz3tEzfIcBGr+V/cSuSrugvJbuQf
         yGnXs+zTktxbdvFu4oQiYbsd9wqCF6zRZY6Jmaq91AxiRZM07nMVYbZn+v5wRBo8E4r5
         6bhOw6Sr9xk+kBJWVTJtObXoLjIOYwc7WugwDyDdWUC56WAiTYYWVsSxMaHj1lgE6KmP
         +PZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kbcQjN8MVAZM0FwGPkinh9qCyh3jo4RCpZr8Jex4Yd8=;
        b=jwLzxAtAxNDY9Wai13vwpsgV+IIhO83v8dcwqKnnrVEY9ecMRRSGV8sM5ep6sFecBj
         B/5zSkJfty0LKlzngrdn51sC0+FVbSOlld3VX/nTkB55tqpsrNqm0QI2hLw4owRdVbkr
         O8n6KH6ay/Dbfn+kvvUp5j5gtVAPc4N1DETCdgWQgUBPmpCRR5Tdsa7cRVQ/G9isGlIX
         7zr16xOBrMdR4u04NnSxLwBzvKd1TA/yu61JYm7yjM/QT7bHFh01g37zm3M4+S9BwGWs
         WdGi7tQraVfMhPox3vsldgAgO0mI3zc1ND48JJFVp4BLFHOpGdFsEfhv6tBqVHIp9QOg
         FOfg==
X-Gm-Message-State: AOAM531fOkflkE6g+nPP4JV7QMXsZwojTSwaP9xY9puyw7Pg87QNQjpf
        rNyVbQYGPs0nAy5ekosQkb+8fSEBwZr70g==
X-Google-Smtp-Source: ABdhPJxjzSJ21WigdMeiKr1eAL/JhW8AWeEoPoLjdtP1IYA+xppOLTXhw7s55E2i7em9JucKq4kaEw==
X-Received: by 2002:a92:6705:: with SMTP id b5mr683868ilc.55.1624322898040;
        Mon, 21 Jun 2021 17:48:18 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id i1sm10572906iol.16.2021.06.21.17.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 17:48:17 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e13=2e0?=
 =?UTF-8?Q?-rc6_=28block=2c_b0740de3=29?=
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
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
 <5cf4b5ae-c6aa-d64d-53ec-3e073a77baef@kernel.dk>
 <YNElkvvd83KboK3Q@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b169a16a-20c2-d713-4d66-cd087c0dca23@kernel.dk>
Date:   Mon, 21 Jun 2021 18:48:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YNElkvvd83KboK3Q@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 5:49 PM, Matthew Wilcox wrote:
> On Mon, Jun 21, 2021 at 05:42:15PM -0600, Jens Axboe wrote:
>> On 6/21/21 5:32 PM, Matthew Wilcox wrote:
>>> On Mon, Jun 21, 2021 at 11:57:06PM +0100, Pavel Begunkov wrote:
>>>> On 6/21/21 10:58 PM, Matthew Wilcox wrote:
>>>>> On Mon, Jun 21, 2021 at 11:07:16PM +0200, Veronika Kabatova wrote:
>>>>>> On Mon, Jun 21, 2021 at 11:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>
>>>>>>> On 6/21/21 2:57 PM, Veronika Kabatova wrote:
>>>>>>>> On Mon, Jun 21, 2021 at 9:20 PM Veronika Kabatova <vkabatov@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> We ran automated tests on a recent commit from this kernel tree:
>>>>>>>>>>
>>>>>>>>>>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>>>>>>>>             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
>>>>>>>>>>
>>>>>>>>>> The results of these automated tests are provided below.
>>>>>>>>>>
>>>>>>>>>>     Overall result: FAILED (see details below)
>>>>>>>>>>              Merge: OK
>>>>>>>>>>            Compile: FAILED
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> the failure is introduced between this commit and d142f908ebab64955eb48e.
>>>>>>>>> Currently seeing if I can bisect it closer but maybe someone already has an
>>>>>>>>> idea what went wrong.
>>>>>>>>>
>>>>>>>>
>>>>>>>> First commit failing the compilation is 7a2b0ef2a3b83733d7.
>>>>>>>
>>>>>>> Where's the log? Adding Willy...
>>>>>>>
>>>>>>
>>>>>> Logs and kernel configs for each arch are linked in the original email at
>>>>>> https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/06/21/324657779
>>>>>
>>>>> Which aren't there by the time they get to the original commit author.
>>>>> You need to do better than this; the Intel build-bot bisects to the
>>>>> commit which actually causes the error.
>>>>
>>>> Matthew, I've just followed the link out of curiosity:
>>>
>>> the link _which isn't in the first email i got_.  the redhat cki system
>>> is not very useful _because it doesn't do an automatic bisect and cc the
>>> author of the commit_.
>>
>> Kinks are still being worked out on that, nobody has claimed it's
>> perfect yet. Some manual input/labor is still required.
>>
>> But it's useful, as this report has indicated. So maybe try and be a bit
>> nicer and appreciative, instead of grumpy and dismissive. It did find a
>> problem with YOUR patch, fwiw.
> 
> and i've already fixed it, and tested it with a make allmodconfig.

Which should have been done before submitting a patch like this.

> turned out to be the only missing place.
> 
> i get grumpy when people implement auto-harassing systems badly.

It's a bad look of entitlement when complaints are made about everything
not being served on a silver platter. The service has been useful to me,
and it was useful in this particular case. Can it be improved? Surely,
everything can, and this one is a bit more rough around the edges than
the intel build bot. Which, coincidentally, has been around for many
years, so hardly surprising. This one triggered quickly, the intel bot
sometimes takes _days_ to produce anything. Improvements can be made in
both cases.

And _I_ was the one that CC'ed you on the report, as it was your commit
that broke the build, not the bot. Nobody got auto-harassed here.

-- 
Jens Axboe

