Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE2C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C9D214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hQ7HvTsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfA2PUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:20:46 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46133 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfA2PUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 10:20:46 -0500
Received: by mail-io1-f66.google.com with SMTP id s8so16546150iob.13
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 07:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HvOWC8vhdvsaJ2X9QmZ+4rhGUeZhnB5ELHxNFWAEQM0=;
        b=hQ7HvTsaiz3dTm/GyhcnfesYyFv7nXpAdEhVApqLTkhxUJeIVgDek8WRNXae3OkV+1
         P0+bAz7d5HUcn5lKfVSrwkSofBeaZ9LaCS0jvE+kEBeR2ChqI3rfS6F96U/6xlPiu78x
         0jpolWw6H2yvsTOOAIse4ciNb87usvoCXqCNNnvZ6GKlnRC9u0StXvii38X+97NG9OeO
         ZkWR2PRh/uSdm3dnKlMs/EOPhjGgfQZvv6m7Zb22GVI8xfezl9n1nlHoaCJc9BInhyoC
         kHZb+oVx146ksKwApmdYdN8jDX6EcWSfRyWcVLBVCOJgOAOqBCfzSreH140t639yMzR8
         2EOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HvOWC8vhdvsaJ2X9QmZ+4rhGUeZhnB5ELHxNFWAEQM0=;
        b=SjOzpRchU+yG+dMpmRusJxdU1ukxc7pwxtiXatyxoBpcemZI11aZlF/2FH7ikbBWF5
         0bVQT5D+8uS301nHR6Y22Fm0t72IU/eUhgKDamhVwVJg8lJBa4739CaVKHT+0NRvaN7t
         PEklnZ9bTlPF4rxqqSw3aEe/iATumte9sHTAbkcLilC7QRrArXTTOS5DTpB6USC3wHwS
         sgpeiu7qgE/P1D/4lqvHb1DwsZjgXLtcHj1xMAKY5hlc7RDTrve85OyLLkBRhT1prH7F
         whhcMvLwN2vTzqFiehLB+kIWmJDERtx44YgRzBpO/Etp4O6/tFB+4mBU4NSF4oLKBjCF
         kikw==
X-Gm-Message-State: AHQUAuamP/FI7KjDXAegDmQx0oaMip+mT9WYHU96Unmr1+3c8MR7kLeK
        SZXgRNXYKJFCkucCRBRjHVJjTw==
X-Google-Smtp-Source: AHgI3IaOsKM6bhps9My07XbuXvcy2esiC58CcjgbALRS5ScqoE4jfKcb+cJhayyavkw3TDyZUJUTiQ==
X-Received: by 2002:a5e:8306:: with SMTP id x6mr538273iom.229.1548775244856;
        Tue, 29 Jan 2019 07:20:44 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h64sm1858951itb.14.2019.01.29.07.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:20:43 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de>
 <2729ab43-b2bf-44b0-d41d-dbb495ddffbf@kernel.dk>
 <20190129063043.GC2996@lst.de>
 <CAK8P3a1x4BsFfacxOmaDXKOKmmQ2j0ypX2+mCNCbjH3E7nC4DQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b12d149-99f7-0b2e-0c3f-9b477ce48520@kernel.dk>
Date:   Tue, 29 Jan 2019 08:20:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1x4BsFfacxOmaDXKOKmmQ2j0ypX2+mCNCbjH3E7nC4DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 4:58 AM, Arnd Bergmann wrote:
> On Tue, Jan 29, 2019 at 7:30 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Mon, Jan 28, 2019 at 11:25:12AM -0700, Jens Axboe wrote:
>>>> Especially with poll support now in the series, don't we need a ѕigmask
>>>> argument similar to pselect/ppoll/io_pgetevents now to deal with signal
>>>> blocking during waiting for events?
>>>
>>> Is there any way to avoid passing in the sigset_t size? If it's just a
>>> 32-bit/64-bit thing, surely the in_compat_syscall() could cover it? Or
>>> are there other cases that need to be catered to?
>>
>> As far as I can tell we never look at it, never looked at it and don't
>> have any plans to look at it anytime soon.  But when I tried to omit
>> it for io_pgetevents I got stong pushback and thus had to add the
>> crazy double indirection calling convention.
> 
> Deepa has recently reworked the handling for the sigset_t handling
> to be more consistent. As I understand it, we only ever check the
> size argument to ensure that user and kernel space agree on
> the size, as it there had been some historic differences.
> 
> If you pass a signal mask to a syscall, you should now just use the
> set_user_sigmask()/set_compat_user_sigmask()/restore_user_sigmask()
> helpers. The compat version is required for the incompatible bit order
> between 32-bit and 64-bit big-endian architectures (on little-endian, compat
> and native signal masks are compatible), and to deal with the one
> architecture that has an _NSIG defined to something other than 64:
> MIPS uses 128 because of a historic accident.
> 
> I think Deepa originally suggested combining set_user_sigmask()
> and set_compat_user_sigmask(), using an in_compat_syscall()
> check. This would let us simplify a number of compat syscalls
> (ppoll, ppoll_time32, pselect6, pselect6_time32, epoll_pwait()
> io_pgetevents_time64, io_pgetevents_time32). I advised against
> changing it at the time for consistency with other compat syscalls,
> but it's something we can still do now.

That's good info. I am currently using set_user_sigmask() for it.
I'd really like to avoid having to pass in a sigset_t size for the
system call, however. What's the best way of achieving that? Can I get
away with doing something like this:

	if (in_compat_syscall()) {
		const compat_sigset_t __user *compat_sig;

		compat_sig = (const compat_sigset_t __user *) sig;
		ret = set_compat_user_sigmask(compat_sig, &ksigmask,
						&sigsaved, _NSIG_WORDS);
	} else {
		ret = set_user_sigmask(sig, &ksigmask, &sigsaved,
						_NSIG_WORDS);
	}

-- 
Jens Axboe

