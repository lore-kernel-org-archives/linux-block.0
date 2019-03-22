Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D15C10F03
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884BE21925
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 16:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfCVQz3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:55:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44834 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfCVQz3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 12:55:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id y5so1600765qkc.11;
        Fri, 22 Mar 2019 09:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tD5n0asYDCO8USwL0aVBFkOPvKyu6yg8H1zkOYw+VU=;
        b=L5HhXIxrNitDaYAe+4bc+ADBXfP1SH1yUEk/HqIQcHq+HWQKWQ7NHJIho4DgINYJoF
         OcCdFhMUZKqQ8+2xLN+qJW8NzWY9rAgbbcTWyhcPTGAVN4SU1EWGsU0yKaiZcG+SXtWr
         YpTeU2TZLGNdRSSDxuZFZc6mn1HxZA1P1A3MfarPDC+WtmrWQ0961icxkWpibyYB752V
         i/81qecbTZGeOmXiF7jgy+5TAINgKAioaRHbiLFc51eZuOR9/8RLntY2uVGpy9D6YAtk
         9/qo1xrew1KUVwvTg3yU4Lkh/EknRWsnEZPiU7IeuKZDn5gKfYOk2WkKlOB43tl0/kxu
         W7Vg==
X-Gm-Message-State: APjAAAXy+UZ25KDQMCpJlQyMuSkXK6b4Kt2kANv7VXAifjQi688c1q3t
        wOmuDlzRiSSgRX9+cQchQTpBfuHFQmkhU96SDf8=
X-Google-Smtp-Source: APXvYqzUHlLilq8ufgw9Oo1yfm8qitDHgXC3S2l6qINFMZdeNe9pB0yyfAog2ZA34poznJq8FC4R2TDnx50ZhLAEqtw=
X-Received: by 2002:a37:b386:: with SMTP id c128mr8060721qkf.330.1553273727904;
 Fri, 22 Mar 2019 09:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190322143643.1317312-1-arnd@arndb.de> <CAOi1vP9scH+DECa1udToEvtYMRTZ1-VMuVajAh8uwpxzuMq0RA@mail.gmail.com>
In-Reply-To: <CAOi1vP9scH+DECa1udToEvtYMRTZ1-VMuVajAh8uwpxzuMq0RA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 17:55:11 +0100
Message-ID: <CAK8P3a2mZ-zyAMrR2zesAUoLO0BiDcmr6VnJzuJb=PFSHj4PWg@mail.gmail.com>
Subject: Re: [PATCH] rbd: avoid clang -Wuninitialized warning
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jason Dillaman <dillaman@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 5:33 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Fri, Mar 22, 2019 at 3:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index 4ba967d65cf9..cbcc3baf3807 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -2399,7 +2399,7 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
> >                                                       &obj_req->bvec_pos);
> >                         break;
> >                 default:
> > -                       rbd_assert(0);
> > +                       BUG();
> >                 }
> >         } else {
> >                 ret = rbd_img_fill_from_bvecs(child_img_req,
>
> Hi Arnd,
>
> You did a couple of these last year in commit c6244b3b2377 ("rbd: avoid
> Wreturn-type warnings").

Ah, I had completely forgotten about that. Different bug and different
compiler, but same solution ;-)

>  Let's change all of those default cases to BUG
> in one go.  Do you want to do that or should I?

I've prepared another patch now and sent it out, please
apply it on top. I'd like this one-line patch to stay separate though
since it captures the warning message and may need to
be backported to stable kernels later.

      Arnd
