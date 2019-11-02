Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC8CA9EC7
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 22:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC532084D
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 22:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572732650;
	bh=uWJi/MwEfcXtvMshsyfTyXUwqGP5JBPovIygjDprHms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2BQEXd4pLdBHqtM7cEWJrE5KwdxelWUNzdthW/Ym2oSOMTiwxILxOBLwz1S6txLcz
	 ACZHhXxiFbqy9PBB3NbWqujcxOHiG3YdNlCQ2dEF0QOat3PxiAEJeNjbp8lixdrurM
	 q8aFfjymte6UbZJhmZUoT3D9YA7W3sq5K7lRbh0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfKBWKt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Nov 2019 18:10:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37987 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfKBWKt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Nov 2019 18:10:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so13299722ljc.5
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vTCI0qHuBsBb0Kz5RbeswHqlSoPusOsIRcj6s1CCCCU=;
        b=XRll/5vMVkjx89KHnpq6WWB0oHHUpEHdiN6O6XIbNfDvJpLq9nAHdnvBRo0qcYtdlV
         dDebt2KT4z/UoQ3oT2Pk6vWaFBXKSztN5uuRAQNTvGwr3g3jPPeee0pGSv+auGk2TkT9
         /FiIqnPnAFsk6ubf5wFePKPpQhSpZfg8GPgik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vTCI0qHuBsBb0Kz5RbeswHqlSoPusOsIRcj6s1CCCCU=;
        b=eCAXLMkYokjWO4Tf8ax17KmaGjYEX8/L3HqrK9EEw5QKY55tUUO9dEIrGQceOJa9Vt
         dqola05RxolSMeTg2ZOCAZPeWlFLAdq3RH+K1VgJ66Aneb50uC5jg2B7yLMSlWxris3y
         MMNLySP7tIIEW+6/7z2+Cjf2fvyvLMsbXNo0OiqIstRtf6Uh4A3M/e7+m/cKMsrrFRjO
         4t4gfuy8IoLxw1IwNyXIcoOSIOUrto5stdeeQlDi+w96z1sl3VE3Sa+8ACijXyvAi/HB
         Wf4wynt2zSORiYAWJI0ttku3TXgVqlS5K25Ucqrb5uYNpqVvFDGH3W3PPvx0LxRiND9L
         sFEA==
X-Gm-Message-State: APjAAAW4LFqSvnWKesLKJFKt5UlenvuwoRK/SR/9AW4ZNneTCLO+86qj
        NnOe8DYtqOvn5sL3sD+7ikaRn02pCiY=
X-Google-Smtp-Source: APXvYqxXFcp8umd2blHJbNQZJefGszqjmgAOKhYrhWN6STH80mUBcZlpNQPlazRwAEwNpPY7hd1xjA==
X-Received: by 2002:a2e:2a42:: with SMTP id q63mr7770160ljq.180.1572732646836;
        Sat, 02 Nov 2019 15:10:46 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q15sm4152470lfb.84.2019.11.02.15.10.46
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 15:10:46 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id n5so2686031ljc.9
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 15:10:46 -0700 (PDT)
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr13611187lja.48.1572732239632;
 Sat, 02 Nov 2019 15:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <25886.1572723272@warthog.procyon.org.uk> <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
In-Reply-To: <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 15:03:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
Message-ID: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
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

On Sat, Nov 2, 2019 at 1:31 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Add in the fact that it=E2=80=99s not obvious that vmsplice *can* be used=
 correctly, and I=E2=80=99m wondering if we should just remove it or make i=
t just do write() under the hood.

Sure it can. Just don't modify the data you vmsplice. It's really that simp=
le.

That said, if we don't have any actual users, then we should look at
removing it (maybe turning it into "write()" as you say). Not because
it's hard to use, but simply because it probably doesn't have that
many uses.

               Linus
