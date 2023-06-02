Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F2C7EE24
	for <linux-block@archiver.kernel.org>; Fri,  2 Jun 2023 15:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjFBP4r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jun 2023 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjFBP4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jun 2023 11:56:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57F2197
        for <linux-block@vger.kernel.org>; Fri,  2 Jun 2023 08:56:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9700219be87so317187266b.1
        for <linux-block@vger.kernel.org>; Fri, 02 Jun 2023 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685721404; x=1688313404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTIlBkKGXE2l4f5yMVZhwf3bgHS8bCAZRCZxQNYneag=;
        b=I9gZjkSc3j2sbyA7jPNU2z7EBpSkvzesSE8Hh0YrjlbtThrhtoOf29IoWQkdrRTvev
         HCZZeWMxad72jwVa6ox72ha2736hodvHjFDAmtNrvAGWLVeqATzvSKQuO5LEUWKh691o
         ZAUaBLQe4Nl+FY7yC3pL6sHuqrh4xK/8rqF0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685721404; x=1688313404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTIlBkKGXE2l4f5yMVZhwf3bgHS8bCAZRCZxQNYneag=;
        b=a1pX2HMP4pS0TDgIwRgpTrDNRGLb0B9bXQOwArs58BBTab04Et3oaRqG7ICtD2LHiO
         WtoZP37WBE7W2JKXWtwEhDZUk3iU40wcbNDwYoyVseUUiO9OIqJsP5ewU12M4pIj90sI
         rIyE+X1jCgINSmqQL8kOeftbxl50EP+7vNmDQrH4vOX8YZUVVl1TrI3OF7EnlleCpCy+
         Ai05U1vVrJgUiCY5WW4pXnUpUSeWF8pB1rylgF+9gLazb2H2oxPnG8R/neAkFsBRMGR+
         swvPufCHBvzmTj6A1E4FWPTcJ8W5nMb+a0SDlH1ogUGs8VSBQM/6TvnwHu6MTlORe+1g
         x5Tg==
X-Gm-Message-State: AC+VfDzWGa4vaX713TbHXPYvRjtF6myrNpohwdQIiyh8xZRIy9bMJwF1
        +2Aw0pNgJnV6TWjnFZMjHxOKATNgEEeqS8fq/xRp3Vbn
X-Google-Smtp-Source: ACHHUZ5UWudZW78lcnlsVnvNoVv0lfBBUea+qMpVRlqcbe1ILT1rX5f6DHLo7osokBZe85v2n3tGjg==
X-Received: by 2002:a17:907:a414:b0:957:2e48:5657 with SMTP id sg20-20020a170907a41400b009572e485657mr10307667ejc.68.1685721404032;
        Fri, 02 Jun 2023 08:56:44 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id lh20-20020a170906f8d400b0094f698073e0sm892210ejb.123.2023.06.02.08.56.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 08:56:43 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso3192572a12.1
        for <linux-block@vger.kernel.org>; Fri, 02 Jun 2023 08:56:43 -0700 (PDT)
X-Received: by 2002:a05:6402:219:b0:516:4107:7847 with SMTP id
 t25-20020a056402021900b0051641077847mr949599edv.3.1685721402875; Fri, 02 Jun
 2023 08:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072829.1258286-1-hch@lst.de> <20230601072829.1258286-4-hch@lst.de>
 <CAHk-=wj3TrM-NWUcFUivefNwzbfGdfcgDGfGP12m6WBfH9JpWg@mail.gmail.com> <20230602154130.GA26710@lst.de>
In-Reply-To: <20230602154130.GA26710@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 11:56:26 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjggN+tR1j21UenO3jVTeSSoOKru==0zgkYYh=frdgCgQ@mail.gmail.com>
Message-ID: <CAHk-=wjggN+tR1j21UenO3jVTeSSoOKru==0zgkYYh=frdgCgQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: fail writes to read-only devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 2, 2023 at 11:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Except the whole make a thing readonly just for fun is the corner case.
> DM does it, and we have a sysfs file to allow it.  But the usual
> case is that a block device has been read-only all the time, or has
> been force to be read-only by the actual storage device, which
> doesn't know anything about the file descriptor model, and will
> not be happy.

The "it's always been read-only" case is unambiguous.

So I do wonder if we should have two read-only bits: a "hard" and
"soft" bit, and make the open-time one the hard bit.

Anyway, I'm ok trying this simple thing once more, but if we end up
getting reports of breakage again, I think you may just need to accept
the fact that "somebody turned the device read-only after the fact"
may just be something the kernel will have to continue to deal with.

We might be able to squirrell the "read-only at time of open" bit away
in the file descriptor in the FMODE_CAN_WRITE bit or something like
that (although that would gives the wrong error for write(): -EINVAL
instead of -EROFS or whatever)

                 Linus
