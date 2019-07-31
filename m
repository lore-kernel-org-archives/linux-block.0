Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE401C433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 19:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94322206B8
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 19:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqKSaJnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfGaTsH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:48:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37461 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGaTsH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 15:48:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so67773167qto.4;
        Wed, 31 Jul 2019 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4ThdQGVBATX5UW51gPtaZR8VaZdoaqY85bZCDNitnU=;
        b=cqKSaJnUU6IyUb7AVNz0kGQRw48j8UF9qqD/afuBGcjSXsHVzpD1MM6GXMFcTNyJHK
         68CugZ2jVNvnBWIXz5Ey8iCf8NFBFDJwbRxvnY4FaMngooIkHbMWapbQj29wbturlceT
         nXQb9P8ApdCU0wnxs6u6x1Ooi02mHjNdcnVKJZPSsdxpVoV2dqhToNuqf5Ie/AdzwmAw
         vx4HR1MF4y5/kxXVmQLanG7A+6XGAHnHitSnSmJ6mvNwBCrYd+gqZn7g3mNTl9er6R0n
         eSEzsvmARLWbm3rrX81yP6DZerKZc8BEVu4HcMc4kPQxt/4o6BT8SlwEuXPM3wcCxAgQ
         6aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4ThdQGVBATX5UW51gPtaZR8VaZdoaqY85bZCDNitnU=;
        b=c8kta/MOBnrTmJiUl6b61rC6JaT579eU8252/vtC8z0DfWucfKom3a1H8W5dxwDYM5
         bcmvAFKSSJmXTk26TMgUIGZsS8i+MUXmcX5ll6TSn5VSbwvuUnVGw0BCAbxdTmmMhwNA
         Q96Y5QFnjbl6leg6xXSExVR89wi92CvQ0km/3Z3nKREEJaGh9Bbhibi6+x3/shPM+KwU
         j6QEshQApp6a6dwjMG9+SktcpwdXvq97jJq6AHChqTsmqJrEk+tGEz55W+2/6Zvof3Bg
         qt7SeeU/3V3fsyJakNCDCmNY7IhBigduf13HiyP18lCOC21oY+cTOMCWYMIxmo2RLH+S
         mU9A==
X-Gm-Message-State: APjAAAVOjjYWjjENIYiB+bTBAgTyhVakR0Yg4i8QqmHevQqddNSzMoFW
        aGncsVRMfSo9XwgoGOaF3mQ945fILki4o0v0m6k=
X-Google-Smtp-Source: APXvYqwun7y8X5PX4twGro6+r4qzgqvWKHZsH1GiyxzF3Cp2J87Q7dbt9/bUPE9AjFE3UGCHOgIrSPFmoEfKpsOO9g4=
X-Received: by 2002:ac8:25e7:: with SMTP id f36mr87184016qtf.139.1564602486802;
 Wed, 31 Jul 2019 12:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190729203135.12934-1-gpiccoli@canonical.com>
 <20190729203135.12934-2-gpiccoli@canonical.com> <d730c417-a328-3df3-1e31-32b6df48b6ad@oracle.com>
 <87ftmnkpxi.fsf@notabene.neil.brown.name> <9dd836f8-7358-834f-8d29-cd0db717d01b@canonical.com>
In-Reply-To: <9dd836f8-7358-834f-8d29-cd0db717d01b@canonical.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 31 Jul 2019 12:47:55 -0700
Message-ID: <CAPhsuW5cAS6mR4PGnzOsuhU8Grs2yN=e5mF4A9+zDQ9DGn9pGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for raid0
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     NeilBrown <neilb@suse.com>, Bob Liu <bob.liu@oracle.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Song Liu <songliubraving@fb.com>, dm-devel@redhat.com,
        Neil F Brown <nfbrown@suse.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 31, 2019 at 6:05 AM Guilherme G. Piccoli
<gpiccoli@canonical.com> wrote:
>
> On 30/07/2019 21:28, NeilBrown wrote:
> > On Tue, Jul 30 2019, Bob Liu wrote:
> >>
> >>
> >> Curious why only raid0 has this issue?
> >
> > Actually, it isn't only raid0.  'linear' has the same issue.
> > Probably the fix for raid0 should be applied to linear too.
> >
> > NeilBrown
> >
>
> Thanks Neil, it makes sense! I didn't considered "linear" and indeed,
> after some testing, it reacts exactly as raid0/stripping.
>
> In case this patch gets good acceptance I can certainly include
> md/linear in that!
> Cheers,

This looks good. Please include Neil's feedback in v2.

Btw, there is no 2/2 in this set, right?

Song
