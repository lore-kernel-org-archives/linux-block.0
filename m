Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A51CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 14:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E03E222C6
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 14:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VifYIvVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405743AbfJROkq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:40:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42642 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410103AbfJROkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 10:40:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id i185so5382180oif.9
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2019 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtLlVAPgNcP/pu360Q9fx5qOSTZTD6zW/EEPtvw7TMc=;
        b=VifYIvVOAu4VO7pp7AxwFN8dcaJx6cmHP4N/rx1dmjN0Cm4SAyeGkVz+MvEdozI0WY
         SyidyCckmbA0wuguVWwuR8hiofg6vyiuylZBgMnMHl2DRHS5GpOlzeWm8O06/Nopboao
         jLtPQIGhyZKWAzVT/Gk1KwgBFGVLcv4yCwZmA9E00vy9GPskRCvtrFLvklcGVAZ0obdH
         8/CvnRbkD7ABY42mUBPT0jpLkTTyMXM//WUBixGZC9DQa/LGRQnicV+IUY11zFITAW06
         v68MNDrQtGKfcsMUnWBKaE5cL3lAcM+hJVMxXEbS9Zp0AkDVV4OufGcymfJ5EwSf7E7k
         TSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtLlVAPgNcP/pu360Q9fx5qOSTZTD6zW/EEPtvw7TMc=;
        b=fmdpiuMrBwddZWMpW7VnYqovGlfpAyeMgx+VGkq9Av/Z8zEPFHe88GHHrXwqpbYQdg
         1dYHm0/tSsIzwPj/xYDMBX1f3msrkXeJH5FfN0C0JR3TpfEP7V2LMVUjdcJjsaRBCVM1
         85BIg5t8emssWHuQoZfSXpVM+OWuFzuBGB17Z8j8h5/Uhr9aUDzhZ/DKEowc6duYFRU9
         ZPHF1+dLvyYKTUjNnia422u7gYSZ+n7hC7YiLCJfuxWSemk6gajgCVSSLJ82i6GrFGmD
         j+n5dlSIpeHazVeQZDs4/x3ea0PPEZYdooKSVdankyNH9y1nZR0gpHVdsSIupgz7TXAK
         HlSQ==
X-Gm-Message-State: APjAAAU5RmmcHcsZSPP9LynfIHlUd/Ot6R6FHZhI3w/2HSSsDmFSpv2z
        /a7zkPMgIZ1dTH1fuCBIs5q9zbk1f9yl07I5KqVfM77h6B7YYQ==
X-Google-Smtp-Source: APXvYqxBQKEqWjtAQPq9kbc+1AeiN6ubDEHEQhhKKfkXXGAYjALjDz/xZr5TwpJ1iSKrJ8ZrWJwvxhshF8yyf2iklSA=
X-Received: by 2002:aca:da41:: with SMTP id r62mr7974009oig.47.1571409643882;
 Fri, 18 Oct 2019 07:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191017212858.13230-1-axboe@kernel.dk> <20191017212858.13230-2-axboe@kernel.dk>
 <CAG48ez0G2y0JS9=S2KmePO3xq-5DuzgovrLFiX4TJL-G897LCA@mail.gmail.com>
 <0fb9d9a0-6251-c4bd-71b0-6e34c6a1aab8@kernel.dk> <CAG48ez181=JoYudXee0KbU0vDZ=EbxmgB7q0mmjaA0gyp6MFBQ@mail.gmail.com>
 <a54329d5-a128-3ccd-7a12-f6cadaa20dbf@kernel.dk>
In-Reply-To: <a54329d5-a128-3ccd-7a12-f6cadaa20dbf@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Oct 2019 16:40:17 +0200
Message-ID: <CAG48ez1SDQNHjgFku4ft4qw9hdv1g6-sf7-dxuU_tJSx+ofV-w@mail.gmail.com>
Subject: Re: [PATCH 1/3] io_uring: add support for async work inheriting files table
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 18, 2019 at 4:37 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/18/19 8:34 AM, Jann Horn wrote:
> > On Fri, Oct 18, 2019 at 4:01 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> On 10/17/19 8:41 PM, Jann Horn wrote:
> >>> On Fri, Oct 18, 2019 at 4:01 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>> This is in preparation for adding opcodes that need to modify files
> >>>> in a process file table, either adding new ones or closing old ones.
> > [...]
> >> Updated patch1:
> >>
> >> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring-test&id=df6caac708dae8ee9a74c9016e479b02ad78d436
> >
> > I don't understand what you're doing with old_files in there. In the
> > "s->files && !old_files" branch, "current->files = s->files" happens
> > without holding task_lock(), but current->files and s->files are also
> > the same already at that point anyway. And what's the intent behind
> > assigning stuff to old_files inside the loop? Isn't that going to
> > cause the workqueue to keep a modified current->files beyond the
> > runtime of the work?
>
> I simply forgot to remove the old block, it should only have this one:
>
> if (s->files && s->files != cur_files) {
>         task_lock(current);
>         current->files = s->files;
>         task_unlock(current);
>         if (cur_files)
>                 put_files_struct(cur_files);
>         cur_files = s->files;
> }

Don't you still need a put_files_struct() in the case where "s->files
== cur_files"?
