Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A1DCA9EBB
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 01:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4242221D71
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 01:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tQdFzrvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfKDB41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:56:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42968 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfKDB40 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Nov 2019 20:56:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id j12so4963899plt.9
        for <linux-block@vger.kernel.org>; Sun, 03 Nov 2019 17:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7OjBCtlRncX4bOEblSUkD/1YtUj162X6xpvSeCxZXjc=;
        b=tQdFzrvcxy+bjwC8dqIolG1B7vwN7orC+qD+ytaJcdjydH+ag1+9NPc92FffDIYc1u
         Z9a9v/XbXeNQPx276C9juJSN2q7pAqha9GhpFqYeqt6GtqnV8BnQAoJ2DzxTUlNUnxwX
         LxZhsQfli1saTq5VtJDFNWrAOW7jwxw/FyGncL/Sd/K9xTPoyYZuGoawZTE8tqf2qmW9
         ksu6YLzd/BNhREE1K7UXYUn+PrsWaa0bJ8gS4t+jOYA5B1p4ScOm36MhAgHmKJHMel5D
         G/2yBnZ0oZPfLxRjWX1zTKn3kKpHZc2neRtrssAldCyUnd5HRe/cmdoFvLVV7z5fYoNk
         /oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7OjBCtlRncX4bOEblSUkD/1YtUj162X6xpvSeCxZXjc=;
        b=fHgq/KdxXf6neiTouB4xd882vhcUl1Bn89BLfUC/GLhB4KnRvJevhBAvTwdH6AO190
         miJq+fMTWE68A5EqUXnoghL+AYttJEhgsQ1i6y1HOl/PUX06ADIu8FSIOg5OBEI8lb+X
         +utZEydOhyY4yoDAeupnjI7mGhfUBry7OYjhOTZjX0Bkx3+BzuP1mwAW5YJblSMM65Ty
         eFoYiQspXn9Hzb0pp6/XHg6e2brLvdw85VNQBorwmqvUunCtwybsQo/YXNHg25i8NNrR
         EStAqLunQQvIuwE4FyD+rleo1ca90OSzo+cYuxz2ua0KiNbkQKasCFoygwlWo64DugD5
         NgAw==
X-Gm-Message-State: APjAAAVkyrWRQcC/cvTZVhVWin11vlNVrU/GITWhHpmFUU2FeDYRd3CD
        2T9OAnVw9l5yYWwKEJ/4K9wQfWl7dv2WbQ==
X-Google-Smtp-Source: APXvYqw2fgn/JdCV8/bj+WbVGyS1XtqIcuVbhcIHeBwpctIlRxT7CYbNVFjGiExfjOXanvTyFggXwA==
X-Received: by 2002:a17:902:349:: with SMTP id 67mr12052828pld.221.1572832583092;
        Sun, 03 Nov 2019 17:56:23 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id r24sm8911816pgu.46.2019.11.03.17.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 17:56:21 -0800 (PST)
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
To:     Ming Lei <tom.leiming@gmail.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20191102080215.20223-1-ming.lei@redhat.com>
 <BYAPR04MB574951ACBF23CBDA280282A0867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CACVXFVO3MafpBcufM+eYZM5A-Yip5JGSqiC4kOgejVNnTNjYOA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a7100fe3-fe27-407a-8237-27dc31df59d0@kernel.dk>
Date:   Sun, 3 Nov 2019 18:56:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVO3MafpBcufM+eYZM5A-Yip5JGSqiC4kOgejVNnTNjYOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/3/19 4:57 PM, Ming Lei wrote:
> On Sun, Nov 3, 2019 at 8:28 AM Chaitanya Kulkarni
> <Chaitanya.Kulkarni@wdc.com> wrote:
>>
>> Ming,
>>
>> On 11/02/2019 01:02 AM, Ming Lei wrote:
>>> It is reported that sysfs buffer overflow can be triggered in case
>>> of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs of
>>> hctx via/sys/block/$DEV/mq/$N/cpu_list.
>>>
>>> So use snprintf for avoiding the potential buffer overflow.
>>>
>>> This version doesn't change the attribute format, and simply stop
>>> to show CPU number if the buffer is to be overflow.
>>
>> Does it make sense to also add a print or WARN_ON in case of overflow ?
> 
> Yes, it does, could you cook a patch for that?

No it doesn't. The WARN_ON brings absolutely nothing. If you're using
a script, it gets the same values out and doesn't see the warning. If
it's a human cat'ing it, they will probably already realize that
we're missing CPUs. Or maybe not even see the warning. It's useless.

We should either make this seqfile, or just kill the file. Those are
the only two options that make any sense.

-- 
Jens Axboe

