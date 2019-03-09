Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C59C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 05:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791C820868
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 05:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552110097;
	bh=dkhQNHzUEFosrBpUtaF7T5YlUipn7ZuxJ+nfeE+q708=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dbcMGlgdWOQLuTQtvI8RQ28mGBzS8FNBQnathekIJEqqX8w9pBmiM2SZpmd6nEste
	 UMsoDn39AlUHSwPyowBnaQi6/0JOyXuMG7m7OYco+kIFkRDqoIMTVLut61NeE+7x8E
	 Ix7NVD4ONp9bqdDmfQMTKBxMIpsBV0RBoLmDsBhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbfCIFlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:41:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38074 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfCIFlg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Mar 2019 00:41:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id k136so5433075lfg.5
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 21:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zx58gQ1225eg41oPvRYXOcbuQw99bWrFGf2mLzZsf6g=;
        b=N6DgUML6NlpbhOek26MUIbRA2CTaocp3hglgfT8TelbBJQ54C0tNdx13bxqeeZaQUU
         fIQnrqfzcdd1JD9jysnlQrC49G9jKPtb3x6Lr+27pX1Xrd+oP0Dr0iThBlVUf+/FCvPb
         GeBpEPElJ2cqA3CFbwc48HlBE01hKkRYnqidI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zx58gQ1225eg41oPvRYXOcbuQw99bWrFGf2mLzZsf6g=;
        b=UKRmOhDIZzeirphBkM3TJI2Pl+JDwYj9hYlkgbyHZg3sF5Uvn76WpBeKJ5lAcVLCO4
         UHbTA34CAK3jG4Z/5aB1crTDhoXcjGpvqOtnE6np59c1XPnXcYLzaDEOpU1kWAo7SV5l
         gNHwny3Cuq5o6l7ggtitGlUD94JKJLdbV6xJREmUU7ODp3OfPhaZlnvmMoYozuiP1J1V
         Zl4LmAjXm6HCLA9PqLDF9lQbwYXRy3vS+eZdL+5S8pWjqrZ0YSuTfN2y0ZEiepO0o/QU
         8E8BPrLL1l3zxFaTpPj7oZZu3G96lN9TRUy2eLySYpSubR+7RVlIjNcZPnfj6gZgzH5o
         1elg==
X-Gm-Message-State: APjAAAXuyumPizNdqtFXXLofXqex12K6gThEJcqkD8ju2pT8Bu4J1k4C
        Xp7CqYiKSgDbZxkEfKlwjj+nvHMfk9g=
X-Google-Smtp-Source: APXvYqydJCianZxMZxYe6zAHLK89WqvacywRv0Hf0NUnLc6kYTn2k4HXZXkhJokHxAiEL/C/+n8F2Q==
X-Received: by 2002:ac2:5294:: with SMTP id q20mr12754604lfm.12.1552110093059;
        Fri, 08 Mar 2019 21:41:33 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y187sm1862243lfc.62.2019.03.08.21.41.32
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 21:41:32 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id z20so19185015ljj.10
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 21:41:31 -0800 (PST)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr10735290ljg.94.1552110091598;
 Fri, 08 Mar 2019 21:41:31 -0800 (PST)
MIME-Version: 1.0
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
 <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk> <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
 <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
 <CAHk-=whu3uojbKwdtaq8vwGfsvSpVUPfhvJPv+LMR=6kNT0XgA@mail.gmail.com>
 <CAHk-=wh36F+2iXMz1dxGxVebfFYtqypGXRchqttJuJ_=A9ctZw@mail.gmail.com>
 <6cc0763f-8a48-c61a-b831-4326345aa68c@kernel.dk> <CAHk-=wjF5Pbuo-cOUzCESA4mrrQXA26OsYDvnXr3+W8ve9a=MA@mail.gmail.com>
 <ac1db664-b02e-3cae-28b8-4ce1d216e6c9@kernel.dk>
In-Reply-To: <ac1db664-b02e-3cae-28b8-4ce1d216e6c9@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Mar 2019 21:41:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+7Jp_w+vZ1SyekQq3VGJXrfg=VY9ug+QktxhNdA8Tnw@mail.gmail.com>
Message-ID: <CAHk-=wj+7Jp_w+vZ1SyekQq3VGJXrfg=VY9ug+QktxhNdA8Tnw@mail.gmail.com>
Subject: Re: [GIT PULL] Support for the io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 8, 2019 at 8:39 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> If all else fails, it's also trivial to yank the poll command support for
> now, which would kill the io_req refs.

No, it really wouldn't.

The poll() code thinks it needs the refs, and the poll code is right -
but the refs are just badly done and there's a ref leak in a special
case and just generally ugly code.

The read/write code thinks it _doesn't_ need the refs, and the
read-write code is *WRONG*. It actually does need them.

So what the fs/aio.c and now fs/io_ring.c code *thinks* it can do is:

 - I'm submitting IO

 - I'm not touching the iocb after submission

 - so I'm done with the iocb, and all I need to do is to say that if
the IO submission succeeded, then the completion of the IO will free
the iocb.

That sounds simple, but it is *WRONG*.

Here's roughly what happens for the write code on the submission side:

  call_write_iter(file, req, &iter)
    file->f_op->write_iter(kio, iter);
      filesystem_file_write_iter()
        inode_lock(inode);
        __generic_file_write_iter(iocb, from);
        inode_unlock(inode);
        if (ret > 0)
                ret = generic_write_sync(iocb, ret);

and guess what? The IO completion might for example happen *while*
__generic_file_write_iter() is running, which might be calling
generic_file_direct_write(), and the IO might just effectively finish
immediately.

What happens then? The iocb is released as part of IO completion, and
now that whole *submission* side that is still accessing the inode,
still accessing the file, and still even accessing the "iocb" (for
that "write_sync" case) is all touching something that may not exist
any more, because it's all been released!

See what's going on?

The thing is, the *submission* path absolutely has to keep a reference
to the iocb until the submission is fully and entirely done. So read
and write need to have that ref on the iocb too, and one ref is given
to the actual IO part, while another ref is held by the submission
side.

So it's really not "poll does ref handling wrong, nobody else needs it".

No, poll at least _tries_ to do ref handling, and admittedly gets it
slightly wrong, but at least it gets a B for _effort_.

The read/write paths don't even try. They get an F. They think they
don't need a ref at all, and they are very much mistaken.

So this is why the io_get_req() function simply should never return
that "ref 0" io_kiocb. It should always be initialized with a
ref-count of 2: one for the submission side (which should do a final
io_put() after it has finished submission, so that the iocb and the
file and the inode are guaranteed to stay around for the _whole_ IO
callchain), and one for the actual IO side (which should do it as part
of io_complete).

This is why Al's branch has that whole series that starts off with
that "pin iocb through aio" commit that does that

-   refcount_set(&req->ki_refcnt, 0);
+   refcount_set(&req->ki_refcnt, 2);

in aio_get_req(), and then works at keeping the iocb around until it's
been fully submitted. And then Al fixes all the small details that
I've glossed over above because aio_poll() had various ugly cases, and
cleans things up a bit.

                  Linus
