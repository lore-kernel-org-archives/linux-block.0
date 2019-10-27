Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2FDCA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 14:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FAD20679
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572185036;
	bh=SF8ID9dlHeFbRYwBzozNy7Dlal4q4YlkPN2xgNlo7gQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=h5undnn0oeBnRpUYNUW8FDl6hqfh94m+RYMVUvHNMILEbQIvsNsl7wg4YQMVh7Yyy
	 AUdjSfxT0zt1lQ7zy58E6hPPjA/Cm3WRhl+M0IuQHDMp1AEakr2iuRHydm11+Wi4Sv
	 CQWn7ABhMlJEMBpSdWk3X5QgzaRh/EtNopWa2Qcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJ0ODz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:03:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35800 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfJ0ODz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 10:03:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so8570581lji.2
        for <linux-block@vger.kernel.org>; Sun, 27 Oct 2019 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUtxqBrTqUG2JQM67qlbeu/gWrmsCKLHs/nf3HjwR6o=;
        b=UBVoDLidxhGRZnO3t3s9odW+975NWscpsgyn72pMoIFtMXrLI8gYCDX8RoEk4dUGpu
         XShVkulYmvYa4f4vPiGJkAOAAjj/NBHXSLZISLlhGaOzl5SAbZ6BhT9CpKJEgEzb8LhN
         G2c7dQQvyPPapIvGT5FeHB9zbcHI3CN4A0Ff0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUtxqBrTqUG2JQM67qlbeu/gWrmsCKLHs/nf3HjwR6o=;
        b=iE1oFfxMS2HwylWUjoI9lvMXqoXnpyU8IW0yIuoc9d21IYAKZhal4mxmLfED7JwrbX
         jNsIYPA4vB6eMRrKgkMLHP6zRCbpM6krXXhQrwnonUwgvb9HI6jRXdFp7hLPziVMGeKp
         DOZ0+N03VRq7OYKSElUEH5N2MOt89eKdDktVfrM3ae7m7LHwJTR62o/1RCnydKuJKhZi
         lOdhmdVHyIBekMCgCXl5vJgttBmRFKdLInAHKYVd+mbDoGdalwgR7VU/waO/5DnBuct4
         /2ZOW7/yzLJRcX6Erzs75jjHS+H1JNY0cwNFXP+ET+T9ASIYlAYk0Sox2sbP4STXGg7a
         cztw==
X-Gm-Message-State: APjAAAUnigSNEIyMq5VcOAB/lXDMHUglPzAVAu0FRAzTpjYHqkhK5LCH
        u7QQBDJTBsk3NiNBeDT2od+XuYoTDFzpRw==
X-Google-Smtp-Source: APXvYqyPlSkx5WQKUgLKKB229T6ojZS9cKHb8u4dx8XtYhaPyxK2LW2p6vLKoYIIxvkN60I8XQKY8g==
X-Received: by 2002:a2e:8947:: with SMTP id b7mr2933734ljk.29.1572185033138;
        Sun, 27 Oct 2019 07:03:53 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k82sm6231113lje.101.2019.10.27.07.03.52
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 139so8375312ljf.1
        for <linux-block@vger.kernel.org>; Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr8760744ljp.133.1572185032112;
 Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Oct 2019 10:03:35 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh7cf3ANq-G9MmwSQiUK2d-=083C0HV_8hTGe2Mb4X7JA@mail.gmail.com>
Message-ID: <CAHk-=wh7cf3ANq-G9MmwSQiUK2d-=083C0HV_8hTGe2Mb4X7JA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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

This still has signs of that earlier series:

On Wed, Oct 23, 2019 at 4:17 PM David Howells <dhowells@redhat.com> wrote:
>
>                 if (rem >= ibuf->len) {
>                         *obuf = *ibuf;
>                         ibuf->ops = NULL;
> -                       pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
> -                       pipe->nrbufs--;
> +                       tail++;
> +                       pipe_commit_read(pipe, tail);
>                 } else {
>                         if (!pipe_buf_get(pipe, ibuf))
>                                 goto out_free;

with those odd "pipe_commit_read/write()" helpers.

They make no sense, and they don't make things more legible.

It's shorter and more obvious to just write

   pipe->head = head;

than it is to write

   pipe_commit_write(pipe, head);

Even when the addition of the notifications,  it's all under the
pipe->wait.lock, so it's all just regular assignments.

Now, if at some point it starts doing fancy lockless things, at _that_
point the updates might become more complex, but that's a potential
future thing that wouldn't be relevant for a while, and isn't a reason
to make the code more obscure now.

Hmm?

             Linus
