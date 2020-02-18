Return-Path: <SRS0=AW5R=4G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B7C34026
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 16:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCA421D56
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 16:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBI24QLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgBRQMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:12:05 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39866 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRQMF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 11:12:05 -0500
Received: by mail-oi1-f180.google.com with SMTP id z2so20616180oih.6
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2020 08:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNVXd7GvQijAf9sUVbG2f1QgUfkHVv1jwB+UDYOWbyY=;
        b=sBI24QLXeAMxnYobfUFiAmd4xR2PTbf+BdHJLpEnENN3qmIvaSodggHdxVC0a8TFor
         daiCdzzMriYxSKIJDxlEJfBopsHtk8VdOYbkisI/98VtSvYnBm/rESBdpNEJJPXu0FF8
         0BOofIxPjKHH2UCJaaashNaSc+UrHk7gBR97j07A04GcQwrzuXuIgsQCEq/JmIEOeDi/
         mfRYWHmCsOX35tJZn56nzIQq+sayeHW3VdvXIXHmKnTOmW5kNVP/nDcGO4e6Plhn6dWU
         U5qibufJ9kPP1ziTSLn4iP65+lhELzA/Z1ZgW2XEkCMDGEs440z34HMvlcKrmZoj1Nu0
         Wv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNVXd7GvQijAf9sUVbG2f1QgUfkHVv1jwB+UDYOWbyY=;
        b=YKOFtFe2kzm+DFx1nH+58XzgZzW9Fehj4MmzNjghEq+GPciuu97otySj2aTany45vR
         QIEk5cADm9ddAmUVZbnmLXy4HnbAC27TaGPdv6hb7F1oU3p9FtqU/9jbIpLtUMFVteQt
         5tq1dzNauFCTfEM6Ano8xA+IoX8/gIZauN4ro6Rs9tmxD/JHOHfnjqIxlxh1oSjeU57c
         39shz4qktRIFF7k3tL3kXFF6DWM+mthI8V2ePwKxg60gcZbwJXX3LBCfoAPQmHPukRIa
         adjGfsfe3V9BELYlt6BRqQH2b6hXUA22LWu5RHlgM335f7szqITpnO901lYv1Dox5B/N
         Le1w==
X-Gm-Message-State: APjAAAWvSIERCRDzLUNVUaBfWrxH1jw+8aW7KMR6T8cBM/RD5Su7Q6V9
        47J765LWY60NB24sSS/fgc1+Qj4wu11m4pZEyv7JAg==
X-Google-Smtp-Source: APXvYqyItQcqBDeH/j9bd5sgRpZfMvMbTo7/hzatU4ZDPYxeI+o76a9irGBqbSncYfhrdjrsgUL2OhHxhb9qaNUNIWU=
X-Received: by 2002:aca:fcc1:: with SMTP id a184mr1665266oii.36.1582042324768;
 Tue, 18 Feb 2020 08:12:04 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p> <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
 <de7b841c-a195-1b1e-eb60-02cbd6ba4e0a@acm.org> <CACVXFVP114+QBhw1bXqwgKRw_s4tBM_ZkuvjdXEU7nwkbJuH1Q@mail.gmail.com>
 <CAKUOC8Xss0YPefhKfwBiBar-7QQ=QrVh3d_8NBfidCCxUuxcgg@mail.gmail.com> <20200215034652.GA19867@ming.t460p>
In-Reply-To: <20200215034652.GA19867@ming.t460p>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Tue, 18 Feb 2020 08:11:53 -0800
Message-ID: <CAJmaN=miqzhnZUTqaTOPp+OWY8+QYhXoE=h5apSucMkEU4nvtA@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Salman Qazi <sqazi@google.com>, Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 14, 2020 at 7:47 PM Ming Lei <ming.lei@redhat.com> wrote:
> What are the 'other operations'? Are they block IOs?
>
> If yes, that is why I suggest to fix submit_bio_wait(), which should cover
> most of sync bio submission.
>
> Anyway, the fix is simple & generic enough, I'd plan to post a formal
> patch if no one figures out better doable approaches.

Yeah I think any block I/O operation that occurs after the
BLKSECDISCARD is submitted will also potentially be affected by the
hung task timeouts, and I think your patch will address that.  My only
concern with it is that it might hide some other I/O "hangs" that are
due to device misbehavior instead.  Yes driver and device timeouts
should generally catch those, but with this in place we might miss a
few bugs.

Given the nature of these types of storage devices though, I think
that's a minor issue and not worth blocking the patch on, given that
it should prevent a lot of false positive hang reports as Salman
demonstrated.

Thanks,
Jesse
