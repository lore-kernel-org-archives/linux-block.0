Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D4C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFC06109F
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 21:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFUVDF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUVDE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 17:03:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D51C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 14:00:50 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id o5so15662566iob.4
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mRuVjQebYc2LtN3HpGIbEBCB3y/AwoizRPXlpsceZqQ=;
        b=0m8NY2j+T2jjCvIfmg0bqw9bvD1Ff+gezgnmyRwtNQ/gN8zmgeC1gdKljF1AJnOSUR
         zV/jF4D071ETUgyZH2VxTWHIXODRjKTUqGf5LNGhULb7I6ML8VW7GBOhVFKJ+uqFVgrs
         SiANSsn4zpGMbnMelaYFsIeC/Tz8aaoufwUWDquX+d3AYHPlaJv+ELs6Yikj0zfSWYjY
         HTpF2Dbe/z+/RRrL3qMEXd5CeD+hfsuadNYnko6FD8aWFai9Uuftq6SPl8hyWPbCRqQI
         0M+IMvbPHyvJzueRfWCicLvHw4JFwk2cy+s6JT6WboaJ79JQBE+5srByZS5PCHpRJQlr
         AA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mRuVjQebYc2LtN3HpGIbEBCB3y/AwoizRPXlpsceZqQ=;
        b=EstbQA7kWuz0oemCsssgsC9xmUdsl231qQqEeNBgpA+tXUxoKwK4D2OkR5GMzJfM4K
         nXbFXpqjHdSwuk0zvNWWz5vf3qlgLqVndIn9TeTQ3esQGIxvyBxDn+SoShTcLsot43n3
         iBAR74StoJfPIzYWb71e0dRsBYCXPYOW/9Y7XYtuw7tNECfo9Rf4vtrslyheNgY+aWby
         z2SMMa4TcyMVEMsgz6coWIXmMbAZ9nkmk31yxs1G0zwb7p0HJY0CowASUER8e83fjonr
         xMwzmDhvxQJXo0Cs8+/Kc80miBUWrNYb0gSJ883FA5ulPph2ZkSikW4aMA7s/KswiM+G
         wRcA==
X-Gm-Message-State: AOAM531r3dzoytPzuxNCM+8noAq0mM6onLDniNxGQEUrJkcz0PdVMKo7
        K/zAB5lOqhxO1o5rqDZOEImyCA==
X-Google-Smtp-Source: ABdhPJwQI+KkCsZ0X0x81equNYFyuqM0evt+ifnmZDmQEqsrQ+TQzmdWWHH2ddyK6Ykj7PiRuOkRTw==
X-Received: by 2002:a02:666d:: with SMTP id l45mr400907jaf.0.1624309249467;
        Mon, 21 Jun 2021 14:00:49 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id x13sm6716415ilo.11.2021.06.21.14.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 14:00:49 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e13=2e0?=
 =?UTF-8?Q?-rc6_=28block=2c_b0740de3=29?=
To:     Veronika Kabatova <vkabatov@redhat.com>,
        CKI Project <cki-project@redhat.com>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <cki.3F4F097E3B.299V5OKJ7M@redhat.com>
 <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
 <CA+tGwnn4J2=WuPEFOwmC6ph30rHXJLhjH-iWmvkKLpacmR7wdQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <42b91718-9d70-4e4c-2716-6259321abd64@kernel.dk>
Date:   Mon, 21 Jun 2021 15:00:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+tGwnn4J2=WuPEFOwmC6ph30rHXJLhjH-iWmvkKLpacmR7wdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 2:57 PM, Veronika Kabatova wrote:
> On Mon, Jun 21, 2021 at 9:20 PM Veronika Kabatova <vkabatov@redhat.com> wrote:
>>
>> On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
>>>
>>>
>>> Hello,
>>>
>>> We ran automated tests on a recent commit from this kernel tree:
>>>
>>>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
>>>
>>> The results of these automated tests are provided below.
>>>
>>>     Overall result: FAILED (see details below)
>>>              Merge: OK
>>>            Compile: FAILED
>>>
>>
>> Hi,
>>
>> the failure is introduced between this commit and d142f908ebab64955eb48e.
>> Currently seeing if I can bisect it closer but maybe someone already has an
>> idea what went wrong.
>>
> 
> First commit failing the compilation is 7a2b0ef2a3b83733d7.

Where's the log? Adding Willy...

-- 
Jens Axboe

