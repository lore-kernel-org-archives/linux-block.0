Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E7AC10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCEF21738
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HARsNYU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfDVQvA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:51:00 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:40862 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfDVQu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 12:50:59 -0400
Received: by mail-it1-f169.google.com with SMTP id k64so19172979itb.5
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2dbBBh9t0iowJHslezHA4ZI/3Wpcgqn3HcJk4izQPg=;
        b=HARsNYU4REyrMUOR63OaCVeXUc4X+T6Cg+FPYkZKajRxHBjNiCnepMzS1MpLGG+SGY
         kkRDJV8AP2z3txhL4VIBfdglXiH2GWO/P5GQQhvEqCK/oBxL1owsNA26bJrP4z+xgkV+
         Kd7suDz7lP76CmaNgm+IqTt52MLiRq9mUJbrQpfStE1WwLNMkhA1rldnnMA7KPvCRWAW
         85qAbeeKCS76BZHHE5KgYHeRJRwHYwPF7+bxes6qcPl888f4QMdbVEQsVlW2YB/Q4ans
         aYye7O9f+kqPLLKwzS4TXf3ZlRHBtfSBKIh1kXg2RFrYNabcjjqc7IN4w2HdCd5h6aI+
         obHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2dbBBh9t0iowJHslezHA4ZI/3Wpcgqn3HcJk4izQPg=;
        b=oEIA+iKhO2hiy7ufQ5WDqKJskp7LhICwJoth3fQ5yXjkK5Mf8WenFDmwV4FnXXvQBg
         M/c0EMdeprFgYa0W9L1yQaE8tgq3pK/oMf9yGVgUssIMpOYCnjQcMgIxx9u6rcOxNZon
         Fspq1zoTDaE3hhkSP++g0SvEgcp9qYdvW2o7vxFKXnH8DUAuW3/x3J1hRxq3Yyochmoa
         bj6tHsKPDcN2FUWa+42MRy3XlMxWdTxDAGfV3tl2SKqP1w6RrfOoPPv7tbvr3ZX84+Yp
         oZQ0w5lY/M0c7+wtkJzgWBYmOzxZV2lcU8VTiL3e54Em6TrtKyFffPDzF7sjexAqRoso
         +Xyw==
X-Gm-Message-State: APjAAAXjLg/ntnb+siXt3nAviK20dK0uo8Bf4QUNYTT27Hcb6+MZ18rp
        GHy4vej169RepbwEYDkr6/BjiA==
X-Google-Smtp-Source: APXvYqyP1Axp3Ers5w70J7EzBKP3oGOF47aDrFAk4nmvE4iXG42mrgYyIcLa12prNynFIV6/wfzvCg==
X-Received: by 2002:a24:ac45:: with SMTP id m5mr6373117iti.28.1555951858965;
        Mon, 22 Apr 2019 09:50:58 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id p67sm6428046itb.11.2019.04.22.09.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:50:58 -0700 (PDT)
Subject: Re: WARNING in percpu_ref_kill_and_confirm
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        the arch/x86 maintainers <x86@kernel.org>
References: <00000000000043fe9c058720a5d3@google.com>
 <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
 <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
 <53a17444-9539-5810-82a0-ceeefa742508@kernel.dk>
 <cfa6be6d-4125-6d1e-8993-e9ec9dbaa7bb@kernel.dk>
 <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4179bb56-0285-9e14-5ae9-7a16957b6210@kernel.dk>
Date:   Mon, 22 Apr 2019 10:50:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/19 10:48 AM, Linus Torvalds wrote:
> On Mon, Apr 22, 2019 at 9:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> With the mutex change in, I can trigger it in a second or so. Just ran
>> the reproducer with that change reverted, and I'm not seeing any badness.
>> So I do wonder if the bisect results are accurate?
> 
> Looking at the syzbot report, it's syzbot being confused.
> 
> The actual WARNING in percpu_ref_kill_and_confirm() only happens with
> recent kernels.
> 
> But then syzbot mixes it up with a completely different bug:
> 
>    crash: BUG: MAX_STACK_TRACE_ENTRIES too low!
>    BUG: MAX_STACK_TRACE_ENTRIES too low!
> 
> and for some reason decides that *that* bug is the same thing entirely.
> 
> So yeah, I think the simple percpu_ref_is_dying() check is sufficient,
> and that the syzbot bisection is completely bogus.

Ah good, that makes me feel better. I'll queue the fix up, thanks.

-- 
Jens Axboe

