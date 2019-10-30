Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49983CA9EC9
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 22:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1542087F
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 22:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="g33Q4U/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfJ3Wip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:38:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35723 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ3Wip (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 18:38:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so4150437wrb.2
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2019 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qfICZRpjv9MzZUR3Km31YoPnMoXWt4BCtsBGyOPs+MA=;
        b=g33Q4U/Y/PsWl2LTH18JY6gpMyFVmPxV9qqWkrT57lR2a/GCy9kyBDrbLXWbaa2fps
         tOVndw1p6l/7VQHVRvGpLmhpFDr4RJXRgrTPx4hhh43FE6ruFdAPV73fa0XTmGA/7rmy
         ly6YasutyEzFhYEmiEDQkruKueLdPUY1jDjaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qfICZRpjv9MzZUR3Km31YoPnMoXWt4BCtsBGyOPs+MA=;
        b=slEnbYSs8Zf6u7FpuarJbZg0ntSNSbVzNA68HFds8tlHlKtVxFzPxid8QmV9K1sQr3
         TDrSk62tUW9i5N2XtjGZaGSws29N0J0ZRSmM0iVgQMugl8Bh2FeFXl+7AOi6cefrxhQL
         B1Y7PYglpfFcxrZvcVh7J7SkahoXJNMfKl5DShLBf9OuRzofqrE+XGpVI/WHaQiBqDFo
         5DZjKQORNSfTVUjxKPd+pf0BPF7IW0fggCUcJe331kHXaRXuGs3P/Jne8yEu4io1Zwy4
         GUAr1KimDdYxDl+P01duAsFW9a9/Q4OAnCw0soTrwN2ckWg8W4tidl1mt+AnkqWb+pkF
         jTDg==
X-Gm-Message-State: APjAAAXS9PWuCINWtXgPKqOVPHwvgb0fs3ckGCfTeQLxLZdxDvNoNMVx
        5G4CcP/ARRpJplhydnjtJBfnYA==
X-Google-Smtp-Source: APXvYqwy8Lp9RkPFYIcCKVwNc4bwfuBSBiCYr98GupWsvuOSYztGZY5yvtxoKwr5rWH+K4PLLBTR+g==
X-Received: by 2002:adf:d1a3:: with SMTP id w3mr2258782wrc.9.1572475121267;
        Wed, 30 Oct 2019 15:38:41 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id t24sm1858665wra.55.2019.10.30.15.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 15:38:40 -0700 (PDT)
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <CAOi1vP97DMX8zweOLfBDOFstrjC78=6RgxK3PPj_mehCOSeoaw@mail.gmail.com>
 <4892d186-8eb0-a282-e7e6-e79958431a54@rasmusvillemoes.dk>
 <CAOi1vP9paV2-2_S0NgfbZDE6+5kqHXVc9xabHVC-2Ss1MmXkCg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d08d13d9-8eee-9c1e-2f8d-e846063882d7@rasmusvillemoes.dk>
Date:   Wed, 30 Oct 2019 23:38:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOi1vP9paV2-2_S0NgfbZDE6+5kqHXVc9xabHVC-2Ss1MmXkCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/10/2019 23.16, Ilya Dryomov wrote:
> On Wed, Oct 30, 2019 at 9:35 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 30/10/2019 17.19, Ilya Dryomov wrote:
>>> On Thu, Oct 24, 2019 at 11:49 AM David Howells <dhowells@redhat.com> wrote:
>>>>  /*
>>>> - * We use a start+len construction, which provides full use of the
>>>> - * allocated memory.
>>>> - * -- Florian Coosmann (FGC)
>>>> - *
>>>> + * We use head and tail indices that aren't masked off, except at the point of
>>>> + * dereference, but rather they're allowed to wrap naturally.  This means there
>>>> + * isn't a dead spot in the buffer, provided the ring size < INT_MAX.
>>>> + * -- David Howells 2019-09-23.
>>>
>>> Hi David,
>>>
>>> Is "ring size < INT_MAX" constraint correct?
>>
>> No. As long as one always uses a[idx % size] to access the array, the
>> only requirement is that size is representable in an unsigned int. Then
>> because one also wants to do the % using simple bitmasking, that further
>> restricts one to sizes that are a power of 2, so the end result is that
>> the max size is 2^31 (aka INT_MAX+1).
> 
> I think the fact that indices are free running and wrap at a power of
> two already restricts you to sizes the are a power of two,

Ah, yes, of course. When reducing indices mod n that may already have
been implicitly reduced mod N, N must be a multiple of n for the result
to be well-defined.

Rasmus
