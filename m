Return-Path: <SRS0=tJY/=UH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B419EC28CC5
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4BD2146E
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560022138;
	bh=tM06VgIJjrr41cRfSzCi2jm1P0TKJ6xrEuV0vLdWZ8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DjkAjGHEPR25jXIMoIRmPuubqIyUr3VptmyDKC8E3XmYeIMXNBWCaLi3SDy80RUPi
	 hoLO7eLqq9yXu2Rg0ISCuK04HQqduZ+EbGTly6UM9Ex0sbWLaOD49ffWhfERV1ldLV
	 tW4HeG71oL2tosfR1yMWL5EZnHK+TW3Gd+d9XqrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfFHT25 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:28:57 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:43858 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfFHT25 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 Jun 2019 15:28:57 -0400
Received: by mail-lf1-f46.google.com with SMTP id j29so3982280lfk.10
        for <linux-block@vger.kernel.org>; Sat, 08 Jun 2019 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dgw3VNLZ5MpaSAPfYMRjCPU5+xSGv5Ni3OvdHSGnNqg=;
        b=K3sYxTgujDsbKIZY9F4sGyewq8C22NtKy8HHzOXCHqvwRJ0yYh0UPWS6g1ZQDcn2UH
         kexoTB+fX2Ddh+PxrET0UN0h2IiJ0I6W9ydvUWGwOlcDq9SP1D0WQ1pQnsU2wPLOE3x8
         IIWWMgOehCvdqNPtno2gP5sqmPQSDjtBEsV80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dgw3VNLZ5MpaSAPfYMRjCPU5+xSGv5Ni3OvdHSGnNqg=;
        b=JfBmkyjB4NJ7vPV3T6ozZe1y2Df4AIaQ9hsMFQubxShEdtA4JvL2G0NrbozKJvz6to
         0yqTByJBhZ60sgjPe7LyDJ0tAcUfT+aiipTpZ42F6XmFo0k18StqicFkSlk4gZGlJZ5B
         bol8dTnGb3zaiYxudpQvTe3GeDmYGXV1OGKwN5yZPLx338vW0MmsYO+CBaI4/IR39JFL
         MdJ80ncyOQT2X2gIUMOZDngyvcQtTXNt5rN9TKYdiLAXIEZs23DmFPvZOQkmt2mscBOC
         m9ZS4S0JlKTiR9XC9i/gi9HLrm6Qb+L0EGjbPnitaga6GfbdzacPfpU2B8cKynXXh+hb
         xnlQ==
X-Gm-Message-State: APjAAAUY238R3v+Z0GjzFLWDmCLLBWyiqOITfzqm8chzxnAmoMihAdwc
        tnRK4exnVyhg1LKwNEXVv/B6HBjyAu0=
X-Google-Smtp-Source: APXvYqzzD8mzdshDGmB+0cDaWeg8G2IEvFHFEubkmOjif8pD/69Jal8hRAMMLj5LTdRlVeyilSyphg==
X-Received: by 2002:a19:2948:: with SMTP id p69mr29740197lfp.160.1560022135324;
        Sat, 08 Jun 2019 12:28:55 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id m17sm1002032lji.16.2019.06.08.12.28.54
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:28:54 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 16so4534097ljv.10
        for <linux-block@vger.kernel.org>; Sat, 08 Jun 2019 12:28:54 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr31601330lja.44.1560022133863;
 Sat, 08 Jun 2019 12:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
In-Reply-To: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jun 2019 12:28:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
Message-ID: <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.2-rc4
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jun 8, 2019 at 1:21 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Angelo Ruocco (2):
>       cgroup: let a symlink too be created with a cftype file

So I'm not seeing any acks by the cgroup people who actually maintain
that file, and honestly, the patch looks butt-ugly to me.

Why are you adding an odd "write_link_name" boolean argument to
cgroup_file_name() that is really hard to explain?

When you see this line of code, what does that "false" tell you?

        return cgroup_fill_name(cgrp, cft, buf, false);

Does that look legible to you?

It looks to me like it would have been much easier and straightforward
- and legible - to just pass in the name itself, and make
cgroup_file_name() do

        return cgroup_fill_name(cgrp, cft, buf, cft->name);

instead, and now the code kind of explains itself, in ways that
"false" does not. (And cgroup_link_name() would obviously just pass in
"cft->link_name").

That would have simplified the code, and I think would have made the
call be a lot more obvious than passing in a random "true/false"
parameter that makes no conceptual sense and just looks odd in that
context.

Maybe there's something I'm missing and there's some advantage to the
incomprehensible bool argument?

I've pulled this, but seriously - when you change files that aren't
maintained by you, you should get their approval.

And if this had been a completely trivial one-liner, I wouldn't care,
but when the change looks _ugly_, I really want that ack.

We've had enough block layer problems over the years that it's not ok
to start just randomly changing other sub-areas without even notifying
people.

                 Linus
