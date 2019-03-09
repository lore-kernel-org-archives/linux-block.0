Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7D9C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 04:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBF8207E0
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 04:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552106044;
	bh=L+sdmcfGyFcDfTr8kEKTDaAfwkgcohfqDnBhXNKlEPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=agFSXU7x5ikWN3VtFUmya5dG8EtMi4gWhdIsoGBPUrkScFekg79NiZTyoGyctH5wU
	 JHWudGBDwVqa+TGn5Lk837A73NgRUgZNf2v+HYQ8e8G3cgzhwRg1rDi/o3Mv+o0rf7
	 u7QlpLf5zY+UOwRcinBWI10K6iHb7/ECe7nF+/L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCIEeD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:34:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41506 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCIEeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 23:34:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id y7so15682121lfg.8
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 20:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/tHncBJ0rEn1VsXokWCKc1iYTqPyf+ci++Vqf0JFs4=;
        b=gwlVtSKpQypAnhE8kcbAZ2CVl9bXX2+2NrUbJ4pIrTKO5wFkFufCT0BUF3Yzfh0U44
         sudB2+HcCuCKA4q/vhtgujRqXw5HdsA+/UlnPruFXQj6Gg6Z7HMhw5grXeBrVpNIhpRA
         D4WGXGXWFQI1o1r201wYGDg8nF/dJzrn+CuJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/tHncBJ0rEn1VsXokWCKc1iYTqPyf+ci++Vqf0JFs4=;
        b=a0r+39XX/IFysoxLbnzGxk798WzpvtLwWsQTG9gqZIAbzSlqauFR6F2KznddXo0k1S
         NwURsrYhP0k0BSzYRxjJ+trkchw1KaXl8KbNQ3G0ThaUVh0rF+PhA7LA6Feejs30yY2l
         dvXGlMTb3/+IyWTgoMc2W1/LuaMeIBY3L5AyggKXYSTvKPJBYbsknguynFjVT2xFdYS8
         O+hElCW8ZIKJL9fMVY954mYmiw/q5Q3f5I9bt5yx8aAmq+0VVj2BE6U3trD7+QbcQsHI
         vLfhzcNtEX/ZorEDBIHz03/h/yeAAsjHeFFECbbaboO1EnZCqhhgm+Jmx3Cny13Ah5l7
         blsw==
X-Gm-Message-State: APjAAAWgHIKjF9nPkYiUPxJ9eIq99cEexnkRoQPCkxXAlbX2WE7Y6wJd
        WR8a3TrOl/jFLAnHb6mUQSHN0GS5/l4=
X-Google-Smtp-Source: APXvYqysgR5dr4Rs4WRyty7FmKcr56TbxuPRrk+x3UqFc19/XYfeTVBGZnJgn3L+sy5fR72MGktDeQ==
X-Received: by 2002:ac2:52a1:: with SMTP id r1mr6976795lfm.155.1552106040434;
        Fri, 08 Mar 2019 20:34:00 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id t14sm1838875lfe.51.2019.03.08.20.33.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:33:59 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id z25so19145336ljk.8
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 20:33:59 -0800 (PST)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr10811680lji.125.1552106039085;
 Fri, 08 Mar 2019 20:33:59 -0800 (PST)
MIME-Version: 1.0
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
 <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk> <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
 <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
 <CAHk-=whu3uojbKwdtaq8vwGfsvSpVUPfhvJPv+LMR=6kNT0XgA@mail.gmail.com>
 <CAHk-=wh36F+2iXMz1dxGxVebfFYtqypGXRchqttJuJ_=A9ctZw@mail.gmail.com> <6cc0763f-8a48-c61a-b831-4326345aa68c@kernel.dk>
In-Reply-To: <6cc0763f-8a48-c61a-b831-4326345aa68c@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Mar 2019 20:33:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjF5Pbuo-cOUzCESA4mrrQXA26OsYDvnXr3+W8ve9a=MA@mail.gmail.com>
Message-ID: <CAHk-=wjF5Pbuo-cOUzCESA4mrrQXA26OsYDvnXr3+W8ve9a=MA@mail.gmail.com>
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

On Fri, Mar 8, 2019 at 8:25 PM Jens Axboe <axboe@kernel.dk> wrote:
>
>              I'll take a look
> at the patches that went into aio and apply the same fix(es) to
> io_uring.

Note that they are not upstream yet, there's a work-in-progress branch
in Al's tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.aio

so you can see what the fixes are, but they are not in their final form yet.

              Linus
