Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9B0CA9EC7
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 23:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B85E21855
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572736216;
	bh=yT2xfdk7VhanLkx0HAZLMAhJ+HGrris22TSXnZ7QnSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XctVNXL2VZHUDBSdyJ1pylMfSuntIGJIcoRwDDH7EwwFCVazl5VfcvAWGY2VubCTY
	 iS3KM9e7pJNcmrc9u4wUdFaWIEcfu3aOy8wfpuaE9hgwT+MNyKfdirpbzX1qGwXExA
	 yhjEhdW9y2etoCFIIRnfF6UxnUTvFSACixU0t25c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKBXKP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Nov 2019 19:10:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43693 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfKBXKP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Nov 2019 19:10:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so2857038ljh.10
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh8/ql1swcZ/RLJ8zkeObExj1w6DyGVNWtfZIlFMpeo=;
        b=Vx52JGJ2fL2ca9BB2NXhwTThadLFJNdykQ5Qc2uEp2vn5uwNFrfyadC6EXLjhvKklV
         KXMcjJQrv3h80vcy/cZZjfo/5qqKgj2fI2pWR4TA74i3RLzoy9MP14q5tRVf25F8gLLb
         ceXpd5ICYbOD7PSidUN5wWZK5ccyx9qRkG23Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh8/ql1swcZ/RLJ8zkeObExj1w6DyGVNWtfZIlFMpeo=;
        b=DOQ78hZe8lu8sAxVF4Z7pYbHukvOfw5NrvvLYGzJiwJQrMgGks7YB0rntNuN5W189d
         bq10/xaIF0lCGfIoHhB4tQTn56KSEaalt7mbfrHCwF2TwUec0gQ53wplpPtKGbkcsesQ
         SUaTdWzKg/UKK8u74qaaWmtxuDZ5veDcv393LZ+auwNqpcl1t/gE4hvr0cMWv0hGVVB8
         O2Fd0wXzac/Vri/R9ZtxFuub/pJM2Tw7AEJCfJVg9Y1eIpY5x8MnI28jOCjwf6uD8Fh2
         hkWjquSCQWqLJ19Zrij5xzQFxHI6inDPQBAoA6SJMi2ChgSZNDioiqY5irNSAW7HMrLr
         aKmg==
X-Gm-Message-State: APjAAAUZWDzYSFzTMhCFFXnpqjsUZfzCQzR/y0Z+25dlTPBu6XlfIp52
        tHoWe80VqzgWCEYs0/Ix3BtdeNW7UM8=
X-Google-Smtp-Source: APXvYqw9cI9M6riK60yTim5C07aX3sBuSFXeURmWJ6qx/fr4lN1DuZ5TstU1iXU/cYouzhqg+eR1UA==
X-Received: by 2002:a2e:870b:: with SMTP id m11mr9674068lji.249.1572736212568;
        Sat, 02 Nov 2019 16:10:12 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id z14sm4457442lfh.30.2019.11.02.16.10.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id y23so13362924ljc.5
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr1543119lji.97.1572736211179;
 Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
 <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net> <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 16:09:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
Message-ID: <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 2, 2019 at 4:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I don't think anybody actually _did_ any of that. But that's
> basically the argument for the three splice operations:
> write/vmsplice/splice(). Which one you use depends on the lifetime and
> the source of your data. write() is obviously for the copy case (the
> source data might not be stable), while splice() is for the "data from
> another source", and vmsplace() is "data is from stable data in my
> vm".

Btw, it's really worth noting that "splice()" and friends are from a
more happy-go-lucky time when we were experimenting with new
interfaces, and in a day and age when people thought that interfaces
like "sendpage()" and zero-copy and playing games with the VM was a
great thing to do.

It turns out that VM games are almost always more expensive than just
copying the data in the first place, but hey, people didn't know that,
and zero-copy was seen a big deal.

The reality is that almost nobody uses splice and vmsplice at all, and
they have been a much bigger headache than they are worth. If I could
go back in time and not do them, I would. But there have been a few
very special uses that seem to actually like the interfaces.

But it's entirely possible that we should kill vmsplice() (likely by
just implementing the semantics as "write()") because it's not common
enough to have the complexity.

             Linus
