Return-Path: <SRS0=xEhu=UI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C9C28EBD
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 06:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34D420840
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 06:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MdYVVU+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfFIGAD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jun 2019 02:00:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44441 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfFIGAD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jun 2019 02:00:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id b17so5913746wrq.11
        for <linux-block@vger.kernel.org>; Sat, 08 Jun 2019 23:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cuvG6phDqsDpLgetQDLcQ2Hswsbo2VL+lEaL/ocZJnk=;
        b=MdYVVU+olXwpRqvsrvwo6nX58rtKjjkbHvWtro4+n4mC1QSlimoEp1XxKL7EWwuYZJ
         +BBCRPKJFPWvu/a7nTLKgZYzOEY5sxeQXlfM+K5P4nZ2A3cNFHhFRHKFqGZiUm0bBQTS
         ZCEMYPJeLh1IVCLMc/kXXXoP55+Gr1e5m0t1GO6gln84HR7Vg7vHY3I3Nt+ajyalTTsG
         MgBeKzCkQ/ILg2kVWfh/K9Hj6r9U1YiywCQIghfDgVbGxMPwd4yf5zH/EMBAvj3/4h2s
         W/MXCWI310xZDTsEuyhOQ8x/fPELjXy6+umFNqofSjWCvhb8IuFbM1Y34wIAmqOOjuxt
         p3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cuvG6phDqsDpLgetQDLcQ2Hswsbo2VL+lEaL/ocZJnk=;
        b=BQ3N9qtVH19NZ0B0WtAwMhdQ6qOAhS799W0Wlc5lx3b6PIKZGR0KctkcqIr2gYsZEv
         hBcZL+BZGyymFz3RXx0T1sjc1L6JdHoFL4kRdzbJC+H1AFxt6L1epkWnSzjEetyKyuaH
         Tzl3MJwbqiU2yVL0jzB5FpPpi9fDWIX6I0/bYuUb5E/xd4KZWHPIC4FIO4t7P+FGTTLc
         yMNmG/5m/VEzWdj3EZcGtd72LMH657tC3jmBI31r0yMQJcVKYFIvAOC6ijCc6MLTPyiM
         Sw8WpliLzkCWBHqxRr+Nbt6mCsFmQ5VV7g5preyUjhzeQABU2dT0yfzibDiDvAGvcGT+
         U3+g==
X-Gm-Message-State: APjAAAUn1SSjxOeERzdEIiodRGAbvqZgD3crFtqXKkGB2fp66NkJOT6J
        tRKfcu/xyGV03g85Mx/EUsfnmu/ogphy8e6Y
X-Google-Smtp-Source: APXvYqyFNKjqH7C4ynYh2v86MbqfY98ydY996BiiiWEcfTO2ACx2/15oiX2SVI3qQvR8LXaN4jbVsA==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr1675498wrx.125.1560060001620;
        Sat, 08 Jun 2019 23:00:01 -0700 (PDT)
Received: from [10.97.4.179] (aputeaux-682-1-82-78.w90-86.abo.wanadoo.fr. [90.86.61.78])
        by smtp.gmail.com with ESMTPSA id 34sm7929927wre.32.2019.06.08.23.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 23:00:00 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.2-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
 <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
Date:   Sat, 8 Jun 2019 23:59:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/19 1:28 PM, Linus Torvalds wrote:
> On Sat, Jun 8, 2019 at 1:21 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Angelo Ruocco (2):
>>        cgroup: let a symlink too be created with a cftype file
> 
> So I'm not seeing any acks by the cgroup people who actually maintain
> that file, and honestly, the patch looks butt-ugly to me.
> 
> Why are you adding an odd "write_link_name" boolean argument to
> cgroup_file_name() that is really hard to explain?
> 
> When you see this line of code, what does that "false" tell you?
> 
>          return cgroup_fill_name(cgrp, cft, buf, false);
> 
> Does that look legible to you?
> 
> It looks to me like it would have been much easier and straightforward
> - and legible - to just pass in the name itself, and make
> cgroup_file_name() do
> 
>          return cgroup_fill_name(cgrp, cft, buf, cft->name);
> 
> instead, and now the code kind of explains itself, in ways that
> "false" does not. (And cgroup_link_name() would obviously just pass in
> "cft->link_name").
> 
> That would have simplified the code, and I think would have made the
> call be a lot more obvious than passing in a random "true/false"
> parameter that makes no conceptual sense and just looks odd in that
> context.
> 
> Maybe there's something I'm missing and there's some advantage to the
> incomprehensible bool argument?
> 
> I've pulled this, but seriously - when you change files that aren't
> maintained by you, you should get their approval.
> 
> And if this had been a completely trivial one-liner, I wouldn't care,
> but when the change looks _ugly_, I really want that ack.

FWIW, the concept/idea goes back a few months and was discussed with
the cgroup folks. But I totally agree that the implementation could
have been cleaner, especially at this point in time.

I'm fine with you reverting those two patches for 5.2 if you want to,
and the BFQ folks can do this more cleanly for 5.3.

-- 
Jens Axboe

