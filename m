Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30075C282DA
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25A62192C
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DiBorQqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBGTIs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:08:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36702 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfBGTIp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:08:45 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so2547460itj.1
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2nE7qIiS+6gxKEBlirTtJrR36SmIXPOF3JmCVu6kGM=;
        b=DiBorQqs1Ek9B2OqqvtMvESlRjKQ87XsTHAmupJIwJeBoTaaY4XUDhJdXPHui3J0nJ
         y1vqLYDV/E2HpfS/ASGdf5XMJ1fyUa+WM8MgyLPMy912wv0f2p9Ua/FFm4iC3o9DHObL
         6ncxsuDKnYEt3i+uUx1YzJD5Y2QzpbZl0IjYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2nE7qIiS+6gxKEBlirTtJrR36SmIXPOF3JmCVu6kGM=;
        b=MCyeXGck0XPpxf8xiZrbDNVXCXouDt6Z9eCvOmm0CWPjQcJXjbuWYRxdMmcWyNoAlu
         uDEiz9PefZIxYSbfgcy2oUnrYz0ZhalugQeaJHrhitCN/bwn9XOvuzW7hxVAk71xH/Fm
         wAVsv54jyUsaAk07QYmgTS/nUkku39ytY51PqNdGMO16cpNM1rz9zreNaPqY347pZLJ6
         Ck4YnhtRSaFq2DEKylVoOrTBaDqtVwqRhHoR/dKShLcq+PS3vIzjhfOLnFLsJUGH1Ykm
         Wm+jXGOrfKsjfXeEAvoJr+msTZF++2f35E6EIZLZSuGuAefNrE8r0XDpUIi92Q1k8EjL
         ofnQ==
X-Gm-Message-State: AHQUAuZOsy1MiR/rkLEvZPM2dEwGxmqho6jYS3BmYePG0QEK0Y9Ub+8T
        aGTBgs1g8eJX91cqRXj3JswXO+aQ1qcgP/bGXt+qHA==
X-Google-Smtp-Source: AHgI3IYcbNj07Gt2/Dteg7tD6dKOfVWRzUy4aoKp8OW1W7fzdXKQLCaP7OZy241J9MVtWb5uqOeHyu9pxF9veOw/6DI=
X-Received: by 2002:a24:7907:: with SMTP id z7mr5044663itc.69.1549566524315;
 Thu, 07 Feb 2019 11:08:44 -0800 (PST)
MIME-Version: 1.0
References: <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk> <20190206005638.GU2217@ZenIV.linux.org.uk>
 <8f124de2-d6da-d656-25e4-b4d9e58f880e@kernel.dk> <20190207040058.GW2217@ZenIV.linux.org.uk>
 <20190207092253.GD19821@veci.piliscsaba.redhat.com> <20190207133135.GZ2217@ZenIV.linux.org.uk>
 <CAJfpegutRaXZ8EC_Am_PomxwdmSoH7eQkxAewaLfUrMALjym-w@mail.gmail.com>
 <20190207152002.GC2217@ZenIV.linux.org.uk> <CAJfpegvayM_ZmuVetfYzpK+qqZJPkVzfQVRQ7OO98f1=reqiYA@mail.gmail.com>
 <20190207162605.GD2217@ZenIV.linux.org.uk>
In-Reply-To: <20190207162605.GD2217@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Feb 2019 20:08:32 +0100
Message-ID: <CAJfpegvkC=jinq6_XW_88vMfsNOHDNOzTsKw1YJ2HBmqffX5JQ@mail.gmail.com>
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
        linux-aio <linux-aio@kvack.org>, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Avi Kivity <avi@scylladb.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 7, 2019 at 5:26 PM Al Viro <viro@zeniv.linux.org.uk> wrote:

> I'm trying to put together some formal description of what's going on in there.
> Another question, BTW: updates of user->unix_inflight would seem to be movable
> into the callers of unix_{not,}inflight().  Any objections against lifting
> it into unix_{attach,detach}_fds()?  We do, after all, have fp->count right
> there, so what's the point incrementing/decrementing the sucker one-by-one?
> _And_ we are checking it right there (in too_many_unix_fds() called from
> unix_attach_fds())...

I see no issues with that.

Also shouldn't the rlimit check be made against user->unix_inflight +
fp->count?  Althought I'm not quite following if fp->user can end up
different from current_user() and what should happen in that case...

Thanks,
Miklos
