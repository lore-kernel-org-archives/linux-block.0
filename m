Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89D7C282D0
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B918620882
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfA2MGV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:06:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37117 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfA2MGR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 07:06:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id t33so21879029qtt.4;
        Tue, 29 Jan 2019 04:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6UWivGwnXezSwl5c7Jks5uXgotkyEftO51X0Q7LkFw=;
        b=SbEvelVsxONFUcVjTYeKla/oBjHRHyPqZWCNYzHHKQdOfocTcwzhOIJd6bcYwJU++5
         hzU/0tmnwCWuljTA1S1MimzZZzF9jvTi//kuJgAvcHhmh/WPJrnZ0vo3TsgJx8xmQwbg
         GFQOu53xazx/4hA/DO5j1hA/chXA9vVgB6Ylzsazm12CE4vw+6nJsOai6nX3//0mevtL
         onwFRi9h10RiGIthBiUG11Dp/tp6yPHwQELj6l4l2zapMk7D2P2FF+1kwxWC5TXJu90o
         EVqu3vARYhcrIwJu022CsuUF5WA45nyQAsszzuM0EKYoBsoM713S+8fnmo3ydhEYuJ1b
         fAsw==
X-Gm-Message-State: AJcUukf5xjfwF92N7DIX3xLxqUUE4E03BeCcZlfhY5k+iWUqlmiO6k/U
        agYFtL++dQii9+aL0BzrJfY7xlhTy56BSWikEPk=
X-Google-Smtp-Source: ALg8bN7/fRZI64yKJTAGuBJKNTQeH3px7jqm07vPmfhPJ4km2mB8cos7GiWTOU2jUWGhp1b2ZsQ3289SyZUJEe1bw7Y=
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr24459103qvr.115.1548763576571;
 Tue, 29 Jan 2019 04:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-6-axboe@kernel.dk>
 <20190128145700.GA9795@lst.de> <CALCETrV30uN2qOUEf+kNGWdphBtps7K3rEk8_8+VAwdtPomRkQ@mail.gmail.com>
 <dab3fa32-3887-3264-9fe1-bc3b7abc58b3@kernel.dk> <20190129064548.GA3280@lst.de>
In-Reply-To: <20190129064548.GA3280@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 29 Jan 2019 13:05:59 +0100
Message-ID: <CAK8P3a0MDbsdVB80pU+SyDSZDDYy+whK6c9vs-7-yunQ21CiDA@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Andy Lutomirski <luto@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 7:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jan 28, 2019 at 06:20:08PM -0700, Jens Axboe wrote:
> > Sure, that would be straight forward. Is there a strong reason to do
> > so outside of "that would be nice"? It's not like it's a huge amount
> > of code.
>
> And it would be really painful for userspace.  Because now you
> can't pass struct iovec through from a higher level, but will instead
> of to copy the iovec to a different type in the submission path.

Agreed. However, if we decide to add the in_compat_syscall() check
to set_user_sigmask()/set_compat_user_sigmask(), we probably want
to do the same thing in import_iovec()/compat_import_iovec() and
rw_copy_check_uvector()/compat_rw_copy_check_uvector().

      Arnd
