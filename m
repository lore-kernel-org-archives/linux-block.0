Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97ECCA9EC7
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 22:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAF421783
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 22:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572732571;
	bh=M91BK//G0AGxiPTVbAufD9sXjzn7Sec8N7JlW6FjSq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pHGpRSZYlI6dh5xZxoQtmZe42QoTMd5VwpYmwTeHMbi2xTsRugBaLPpXzc8MbnrwX
	 bbT0yKKe/AgeXhWA+bCndCUraEo/wRdbBd5wjWPqKMYztq3JtNI1Ku1toV4BN2YJp6
	 1Diy4j5oxqUxkMhWwAyb4BzyJa6BQHBiN8Eg56Hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKBWJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Nov 2019 18:09:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46942 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKBWJa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Nov 2019 18:09:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id e9so395430ljp.13
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 15:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w/G6EKdeKHyA10XyqtoNEQBxMdg61j9NrYNZ+OC/8O0=;
        b=fiTiutJMMhzHoUatnMj/i0xks6LRSmy0r7/BRz4Oo2NzE6YmtOVVD9WTTp3vp/4Ftl
         susZvLuDrEDv2Y0EisfAoYbNX8c8ba0GWiLrv658sEXczCmotmacJTxLnXp7ikF2o1OS
         tH5KGMhlSFlbvPUr5HFJ0KdvbB3vKmi6HfEto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w/G6EKdeKHyA10XyqtoNEQBxMdg61j9NrYNZ+OC/8O0=;
        b=d3B4yaS8Qoe1L3nuanBZQUzH8mDNZpweN5SY4lxYHY+I28fu7ZCNw5ginuKNNzMiVy
         j7cAZNWZTf6GnF9co5x6d2asBV57S5lyAC92+gtGfjTG6kjSkYeTjrlPC/zRAo4q+LN6
         Bg+6v3ggopC4etHowAV4KUrvZCrBhBuFi0MAb4AskijJBkw3gMYOpgKEBAMdIS4KfdLC
         Y8ZbmFVFTv6PO5cSxlV+UfW0YEWAAKHIMSRZhqONCQ+0bVZb3KLXt3d9zP0Bn7GeaOiV
         TMAVAN+pnHtgEvWuCfJkzpdAIBogGxd9zW5mQP7yXm2yhjO2dqgRrOJBJmSc9badqcrp
         R2xg==
X-Gm-Message-State: APjAAAUpI+wmcOZ8c8Ybz7UKahV3uaeFlZArSslqcoxFgQTT8AvB91MR
        9CZehZyG5DY+A01nGC1AC8Mii0UORz8=
X-Google-Smtp-Source: APXvYqwZAZXOq/EkAlbjz9HXh5NFRdQlHZ1WCoPAn90uL3SlTo/LRVfNBvhIJmv0VgIoRvY7Ha0pTQ==
X-Received: by 2002:a2e:94c4:: with SMTP id r4mr13491247ljh.34.1572732568377;
        Sat, 02 Nov 2019 15:09:28 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q8sm3801866lfd.53.2019.11.02.15.09.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 15:09:26 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id j5so9583286lfh.10
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 15:09:25 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr11937953lfc.79.1572732565288;
 Sat, 02 Nov 2019 15:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <25886.1572723272@warthog.procyon.org.uk> <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
 <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
In-Reply-To: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 15:09:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNJYdEcomZKaD034S==-gEXg_V3JpW+DpKXFi5fJuruw@mail.gmail.com>
Message-ID: <CAHk-=wiNJYdEcomZKaD034S==-gEXg_V3JpW+DpKXFi5fJuruw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 2, 2019 at 3:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Nov 2, 2019 at 1:31 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:
> >
> > Add in the fact that it=E2=80=99s not obvious that vmsplice *can* be us=
ed correctly, and I=E2=80=99m wondering if we should just remove it or make=
 it just do write() under the hood.
>
> Sure it can. Just don't modify the data you vmsplice. It's really that si=
mple.
>
> That said, if we don't have any actual users, then we should look at
> removing it (maybe turning it into "write()" as you say). Not because
> it's hard to use, but simply because it probably doesn't have that
> many uses.

Looking at debian code search, there are _some_ uses (including
openssl and fuse):

  https://codesearch.debian.net/search?q=3D%3D+vmsplice%28&literal=3D1

but I didn't check any more closely what they do.

             Linus
