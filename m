Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F975C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 04:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B4B6196D
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 04:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbhCVEQJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 00:16:09 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:38802 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVEP7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 00:15:59 -0400
Received: by mail-pj1-f42.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso9704021pji.3;
        Sun, 21 Mar 2021 21:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Efirn7mPRYjnQYb6tYB8IzX6m7msSwDo1WIP+IniqI=;
        b=mqMzSidnIDS8QVW3ije1URBy6GNkZ9vmfL7/R+y2gH0rZCwbyBD01LJbk9llFQyiGY
         I4KvCSJm4kjx26JNKMsZ+Q+t9BENKe5oPkQrFFwIRhX6gRhfZEwmFcL1uRQAIjdOw8yX
         WEDLiN3sG4IAxL7kY/t1VARNvV1n0wuiblBS5LOlqF25EJWdvu0ZZM/XM02JTG6YGphe
         IoDGZ7imFGCs6qBzwtvWbHEbIaHSJxB3QYzbGPYWzFT0qspHaIFYcQH60FI705IGoaa8
         gR3SulvklHYjcaQ333/thmxU9PGkclRNBqxiLRqi1nDTxC3KpbYKIfHFa8/L7UAyGFK7
         Pkpg==
X-Gm-Message-State: AOAM533bsuH+/P7Clu+ZGiuVREJck21bLglcl8JW+IH3yVFARER0Th76
        TAR+11UPKbp4W6H00abaxotbeuZv9KM=
X-Google-Smtp-Source: ABdhPJyy4hzCQbrpDcMR1K1eXIm5TbjtV0xn05BUHoQXK4Hs10asXJH43++Y75HVrvoGvmredwk8Nw==
X-Received: by 2002:a17:90b:b0d:: with SMTP id bf13mr10929428pjb.7.1616386558671;
        Sun, 21 Mar 2021 21:15:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:73ba:f946:66fe:d3aa? ([2601:647:4000:d7:73ba:f946:66fe:d3aa])
        by smtp.gmail.com with ESMTPSA id 9sm10411801pgy.79.2021.03.21.21.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 21:15:57 -0700 (PDT)
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Hillf Danton <hdanton@sina.com>
References: <00000000000053da9405bd7d2644@google.com>
 <f40ed33d-8ca2-a2f2-e534-9db9920570ad@acm.org>
 <CACVXFVP0un7xv0_rZHV9d-jtDSSKpJcrFcmDsDiaj4j2CqV+DQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <954345c8-6010-71b5-a723-192cd1556d6d@acm.org>
Date:   Sun, 21 Mar 2021 21:15:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVP0un7xv0_rZHV9d-jtDSSKpJcrFcmDsDiaj4j2CqV+DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/21 7:35 PM, Ming Lei wrote:
> On Mon, Mar 22, 2021 at 7:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 3/14/21 4:08 AM, syzbot wrote:
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    280d542f Merge tag 'drm-fixes-2021-03-05' of git://anongit..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15ade5aed00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=952047a9dbff6a6a
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
>>
>> #syz test: https://github.com/bvanassche/linux a5f35387ebdc
> 
> It should be the same issue which was addressed by
> 
>    aebf5db91705 block: fix use-after-free in disk_part_iter_next
> 
> but converting to xarray introduced the issue again.

Hi Ming,

Since that patch does not re-apply cleanly, do you want to convert that
patch to the latest kernel version or do you perhaps expect me to do that?

Thanks,

Bart.

