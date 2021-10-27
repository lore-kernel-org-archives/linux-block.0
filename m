Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2123C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 02:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A616D610A1
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 02:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbhJ0CWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 22:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236281AbhJ0CWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 22:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635301216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mqXh93ZFW8hFzfkQUD4WZhM1OFNU+n4S2OHIXxEnQVk=;
        b=eMif0RIyMSXje+cVfOnCaTkr2IogLn5naw9sf1e92tsOnaW629r9SssFKMF9BL0BjEe48X
        9zFi2H7u5Y5w+JqkgRr+WlKyM9i22NkXO0vQcsrbHpztEX+Pyczu0FNBthsrcaO5NNAGnC
        2DidgcZDy2SCR+owwTnVy1chPLw3pI4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-6qK3KobrNh6jmj3j_e8dDA-1; Tue, 26 Oct 2021 22:20:14 -0400
X-MC-Unique: 6qK3KobrNh6jmj3j_e8dDA-1
Received: by mail-lf1-f70.google.com with SMTP id i1-20020a056512340100b003fdd5b951e0so618727lfr.22
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 19:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqXh93ZFW8hFzfkQUD4WZhM1OFNU+n4S2OHIXxEnQVk=;
        b=W3XZO0xiUI2LHpqHfw3qSyWHcElUeX+2+i6cojIUeWyiJCO9wp2kXpjQiT0RJW2diN
         qfRpYX1ElYIsi71Pd3ovnYHxgs1io6yQRghunrUvPrAd4cwncXnifOWJZx2UnbHRhMD7
         vth1xCH0sUSWCS0ZwxK+56ObyLnsXZ31RIqbrsIjA2vwznp3TivO+QZEpUXRFGJruGsU
         sKonlSxHNikW5Luwx/Vf5gYVD7voNZsLhv1oK0GnLuopxmGsWzbLhluJIXrwOJeLgMpd
         RE8NTWfJvmALSZAkedAVBPGxzJgI9GFf4wWekbUI5HszfvVeCKAMIm7If1jPlPdDXJdq
         S9ow==
X-Gm-Message-State: AOAM530PmRLA4hMv/ndWFTRBs7EhYRjgNB7FmwajeXYTMWfXjqeeHUla
        4i8w5EB4navbLH6V1xRlhfDV92tfmhq5BpX4iwr4qdJwJV6p+I0E2nbIUIFcM0Efjjm0gLA6ZZa
        Cl/+5NJkuKRhSIRolnBnuhVyJ9BNG9msrlTuYFrY=
X-Received: by 2002:ac2:5e7b:: with SMTP id a27mr18585225lfr.103.1635301212862;
        Tue, 26 Oct 2021 19:20:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjJ9eMzhF9j7b0a5ruulTUMfrDQJSlIkrZ30hzGkZMx2g6pfvQe49LM5HOZ0EI4jaW4nP6IDlutoGaAHGMav4=
X-Received: by 2002:ac2:5e7b:: with SMTP id a27mr18585208lfr.103.1635301212668;
 Tue, 26 Oct 2021 19:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210806142914.70556-1-pkalever@redhat.com> <20210806142914.70556-2-pkalever@redhat.com>
 <YUL+1PE1z5aM0eTM@T590> <CANwsLLEgHhrh7uh+awJp-qs8xxxpwQBc6fMkEys3VMU4anvWZg@mail.gmail.com>
In-Reply-To: <CANwsLLEgHhrh7uh+awJp-qs8xxxpwQBc6fMkEys3VMU4anvWZg@mail.gmail.com>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Wed, 27 Oct 2021 07:50:01 +0530
Message-ID: <CANwsLLH03KazGmog6pj6zjTTmAwr8nz1i=ZxLoyWFOUaop8xjA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] block: cleanup: define default command timeout and
 use it
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     Ilya Dryomov <idryomov@redhat.com>, Xiubo Li <xiubli@redhat.com>,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 27, 2021 at 7:48 AM Prasanna Kalever <pkalever@redhat.com> wrote:
>
> On Thu, Sep 16, 2021 at 1:52 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Aug 06, 2021 at 07:59:13PM +0530, pkalever@redhat.com wrote:
> > > From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> > >
> > > defined BLK_DEFAULT_CMD_TIMEOUT and reuse it everywhere else.
> > >
> > > Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> > > ---
> >
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
> Thanks for the review Ming.
>
> Attempting to bring this to the top again for more reviews/acks.

oops! please ignore, this is the wrong thread.

>
>
> BRs,
> --
> Prasanna
>
> >
> > --
> > Ming
> >

