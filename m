Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C039BC10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F91A2175B
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1NfduaH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfDVQcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:32:35 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:37608 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbfDVQcf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 12:32:35 -0400
Received: by mail-it1-f169.google.com with SMTP id u65so19086140itc.2
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T5gNEUpY6UvQF7xoppj/WgrZVl4YlLjgakn5tQ80U34=;
        b=1NfduaH9VjN3m+4+TDMr2Esgd93LfzIGD1ebDYHdg0xah9blEqq3DkBt5X1LB3LPm4
         gnQ3uQCDLS65yNQ7l3IZdAyuXGSOeRw344Jh5yL8os5Xq1PE66QB5AdCZLJUTvhsX+XQ
         PwZTKw95HUbxnRBdYbnqunfFh7gOyKOlVFd90IOX6Rnq5/At0ikw64deMHiXe8zqGgI6
         JYPEbn4/nKnfjJFtMkuQcV8GGmqhA4Yjgy/vAqeTtpE+VQ41UUnU6gFPolNxSqRenSSy
         nJxxXeC0qK4eEtX6aeurfLSqUATKd2wm0DElL2XUfMKoXr7uOFBqpg/2hIAUbRZOIF73
         mqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T5gNEUpY6UvQF7xoppj/WgrZVl4YlLjgakn5tQ80U34=;
        b=jqkhO24LZmUFk60Sw38X2DNP2CK5dI2n3jU0Ilf73ocD3GmM8anU6qeTLamnCwQSpI
         bug4IukAuwP7tb4/deeSYoAvA7cpLvXj1KGL1VvO4gA1sodwJvWeEfDcD0nS2O+8QIYn
         1lFqX+/lFHmACHIPIlMHyqU92p7GBt/tpFOBGUfLS6OvZlozS7lzmJlt7zWyZ5/b9MgF
         G0Fx1wttEKPg1lM5/obV/9HwCLI7CGMoB9nGggbIO79VAvB9zRObGkfal37byoJTcvk8
         XdDceOEdoiYlZNGxhiCdlQ2dakoXIEZUuOBC8vB4GURb234sOL0g9HZ9aVvsPVh3J3xH
         vLtQ==
X-Gm-Message-State: APjAAAWsV94Ky8wAZEUyouu1G6xoLrAfB6hv5nKb7q8hFDKTyQOQIFzL
        nyYGZSz22JjnUAxU4GlIwpZC4Q==
X-Google-Smtp-Source: APXvYqzEsPPb6pe5G6YSbBS5DFCCjIAs9gvpOGwWW/pmaYLOKHSgVB2LtNsiZE/mUG6oYXnq8YYQ2Q==
X-Received: by 2002:a24:2244:: with SMTP id o65mr13582805ito.126.1555950754781;
        Mon, 22 Apr 2019 09:32:34 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 64sm6111169ite.42.2019.04.22.09.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:32:33 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53a17444-9539-5810-82a0-ceeefa742508@kernel.dk>
Date:   Mon, 22 Apr 2019 10:32:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/19 10:27 AM, Linus Torvalds wrote:
> [ Crossed emails ]
> 
> On Mon, Apr 22, 2019 at 9:23 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I think the below should fix this. Very early versions of io_uring didn't
>> have this issue, since we did the percpu ref tryget for io_uring_register().
> 
> Ok, so I like your patch better than mine, but note how syzbot
> bisected this to the initial merge of the io_uring code.

Yes, I did think about that too...

> I agree that code shouldn't have had this particular issue, but it
> looks like it does.
> 
> Is there some way to race with io_ring_ctx_wait_and_kill(), which
> _also_ does that ref_kill() thing? I'm not seeing how that could
> happen, but maybe if the file ref counts get screwed up you have
> ->release() called early..

I just tried on the current code and it triggers easily, but that's
with that mutex patch in there. I agree it should not trigger before
that, unless something is wonky. I'll try and play around with it a bit
and see what is going on (or if I can trigger it at all with the mutex
change reverted).

-- 
Jens Axboe

