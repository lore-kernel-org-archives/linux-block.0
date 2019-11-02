Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C81CA9EC7
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 23:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B72821855
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 23:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572736105;
	bh=hSnc0yPJA8Fxvg0HGf9jnQyd2Q40taHnv9Z4Kk4uSHw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AU54fcaWYOE0E8cHrJGMPhEg2qWqlYHuqH5dYXL3TvZ/l1NzQk38m/h/hOVrQiJO1
	 61beZyTqCLLTcEU3a9T0Iqe1EsOmQ1icRPZjxT2B5f/bgBU0tUPJ8uxH+LnLYtH1RF
	 usJs07JcYcGzzxt4S8WnePgkMEWbrm/8F67Yc1HM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfKBXIY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Nov 2019 19:08:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36297 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfKBXIY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Nov 2019 19:08:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id k15so1662484lja.3
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 16:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYWG+PndMaavSEZTx4tAuPjrZgeMNS1BkWduXMUhlSE=;
        b=NAZiBqRMuLwp18H/qmyeCQUJQSMxLgfDNPb3RDjIM2NaIkVQsPt1S/xuDnF8dcUBgf
         3fZo55nc7Bm/xxbjy/0YjqR9D8Xzg3aKB55yv1y8UMISn+S9dO18XBNHs4wlB45hKZ6I
         TFCoEmlRYzmfAjujVacuTPfMhwBZ5xf+j+Mkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYWG+PndMaavSEZTx4tAuPjrZgeMNS1BkWduXMUhlSE=;
        b=eUmDWzm1+sEjebS3dUgryR2rV6nPjwfBYDgMq3dbSZRFfqCuxkBbhoc4rUL1VCddzi
         C1n306bgQ8W79hfgrZFV8CuPJyOfPLsx+MgdUMR5t0kvpAeoy9S7PJkAh8dojqs4+Vjl
         VHbZanSDOXHaDZSX6jnLdpK4N2tBUQM8wENEF+YG6vRBUPSuHkXF0RakbWXO8d5MNMXD
         pHrq9h9nkKqHdVKBQ1hfuEylmRb2BghPCUOwyt59ZpPfe+9zCQXj6Ld7o7zE7CAlcwl0
         rwIYk1U3tqzZxrHLcPgEecNauqYMwIhCTLGz7/UkZtHvx0BHLgUb1VTXbJaMulDSNpuG
         ydHQ==
X-Gm-Message-State: APjAAAWEMLXnzzCyPr7xak3iYUpKT2Syi8tK0qWWSVHxJTk7OXevev2Z
        KseoRO1XrpZ+b3+HNyUEab8QWDy1WEM=
X-Google-Smtp-Source: APXvYqzVbGM4XX+WDwwHrZRJtx7Vwc7Aa4ykzwEvBgPNdQjDCNbxbM259S1MOmzRL3bc9Q7yTzGfDg==
X-Received: by 2002:a2e:b056:: with SMTP id d22mr13203207ljl.28.1572736101949;
        Sat, 02 Nov 2019 16:08:21 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z20sm4284435ljj.85.2019.11.02.16.08.21
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 16:08:21 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 139so13809934ljf.1
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 16:08:21 -0700 (PDT)
X-Received: by 2002:a2e:819a:: with SMTP id e26mr10124866ljg.26.1572735749049;
 Sat, 02 Nov 2019 16:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
 <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net>
In-Reply-To: <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 16:02:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
Message-ID: <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
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

On Sat, Nov 2, 2019 at 3:30 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> So you allocate memory, vmsplice, and munmap() without reusing it?

You can re-use it as much as you want. Just don't write to it.

So the traditional argument for this was "I do a caching http server".
If you don't ever load the data into user space at all and just push
file data out, you just use splice() from the file to the target. But
if you generate some of the data in memory, and you cache it, you use
vmsplice().

And then it really is very easy to set up: make sure you generate your
caches with a new clean private mmap, and you can throw them out with
munmap (or just over-mmap it with the new cache, of course).

If you don't cache it, then there's no advantage to vmsplice() - just
write() it and forget about it. The whole (and only) point of
vmsplice() is when you want to zero-copy the data, and that's
generally likely only an advantage if you can do it multiple times.

But I don't think anybody actually _did_ any of that. But that's
basically the argument for the three splice operations:
write/vmsplice/splice(). Which one you use depends on the lifetime and
the source of your data. write() is obviously for the copy case (the
source data might not be stable), while splice() is for the "data from
another source", and vmsplace() is "data is from stable data in my
vm".

There's the reverse op, of course, but we never implemented that:
mmap() on the pipe could do the reverse of a vmsplice() (moving from
the pipe to the vm), but it would only work if everything was
page-aligned, which it effectively never is. It's basically a
benchmark-only operation.

And the existence of vmsplice() is because we actually had code to
play games with making write() do a zero-copy but mark the source as
being COW. It was _wonderful_ for benchmarks, and was completely
useless for real world case because in the real world you always took
the COW fault. So vmsplice() is basically a "hey, I know what I'm
doing, and you can just take the page as-is because the source is
stable".

             Linus
