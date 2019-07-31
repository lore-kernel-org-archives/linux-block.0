Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6244C32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 19:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E4B206A3
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 19:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLVc2vbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfGaTyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:54:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38653 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfGaTyb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 15:54:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so50175938qkk.5;
        Wed, 31 Jul 2019 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwTO9Eavd0UF8NNzgiLY/DTfzq+He1QSvlunSShZZCI=;
        b=jLVc2vbRk3FO+KAaEQZIQ2UqIQVz2YrnNxb2mnbtQpNU1UdNcTL+QjMRHT9olEvIRY
         WHV+rj6InrpOpVpvOk8KfTvl/kE5rT3c7JTzXJcZj8v4S9xawPucuTnXsF5JWcF01G4I
         JMSda063mpc77bVTJLRrerayMF1SO7gnmjDosmZCF6eoeocvD8byD7+SbVEv8aCACUtL
         nj+f3XQY/6xqXKnbicIUJ1hpO47OxKvawO5s2269ahK/xgt2nqCBQoPZp67896eYb6dZ
         BaL31sbM077lySAC8v9WvQHBZBmVkERJSrRZyDF7/t+1kW0v9zNEMM+R7Q7FCl6qpM78
         VX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwTO9Eavd0UF8NNzgiLY/DTfzq+He1QSvlunSShZZCI=;
        b=WimnMBhgnA3Y9azkuNwRkf7Vo4nNfyhoCQ0OERag/3AWnP2Pq9qIARIXui2OUJTHpt
         EyeJDtKDDPwWEkor4XkyNNjR72BQAalrnMXKdBTvSHqyF9dg/mpdTiN4+aOJs2qVx6w5
         1VaRfGUTeCUwsMcqaZfRZEioMxZR+pUdkyFoabypSM0mLHnRfLobuVFUKXUYeSJAteTJ
         j5aFyMvgrDwqu06x4Fxb3uQNPF+gnMrrWbBpk6QWGhG6jq8RatiHveSMcBao+0LQfwSr
         o5Yt9PQ80OMEhp+urjsFWP4L3YofI5y4lGo3rT0EcYVjEtF/OuxUgUtUiPSi89xXy619
         YA8Q==
X-Gm-Message-State: APjAAAUGgnk4xo6xD8CkKUPSs9leSasLTWox65NCu/DYlIuJYsuoujOd
        Y40jTbnnT8+k/QZofAh0DBdTnbqAV7TXlN+aWiw=
X-Google-Smtp-Source: APXvYqxFxYNaX0I5Vz7oxFiKHE2Lv102UKOj6S01zk3l81RVq6qguh3qpGIhPesMQEXEKTou9qHfCjoSzPkDTr8j7C0=
X-Received: by 2002:a37:4d82:: with SMTP id a124mr79464398qkb.72.1564602870746;
 Wed, 31 Jul 2019 12:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190729193359.11040-1-gpiccoli@canonical.com>
 <87zhkwl6ya.fsf@notabene.neil.brown.name> <6400083b-3cf3-cbc6-650a-c3ae6629b14c@canonical.com>
In-Reply-To: <6400083b-3cf3-cbc6-650a-c3ae6629b14c@canonical.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 31 Jul 2019 12:54:19 -0700
Message-ID: <CAPhsuW69YrpHqBCOob2b5wzzWS9FM087sfe3iC0odX8kZWRwmA@mail.gmail.com>
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is gone
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Song Liu <songliubraving@fb.com>, dm-devel@redhat.com,
        Neil F Brown <nfbrown@suse.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 30, 2019 at 5:31 AM Guilherme G. Piccoli
<gpiccoli@canonical.com> wrote:
>
> On 29/07/2019 21:08, NeilBrown wrote:
> >[...]
> >> +    if (unlikely(test_bit(MD_BROKEN, &mddev->flags))) {
> >> +            bio_io_error(bio);
> >> +            return BLK_QC_T_NONE;
> >> +    }
> >
> > I think this should only fail WRITE requests, not READ requests.
> >
> > Otherwise the patch is probably reasonable.
> >
> > NeilBrown
>
> Thanks for the feedback Neil! I thought about it; it seemed to me better
> to deny/fail the reads instead of returning "wrong" reads, since a file
> read in a raid0 will be incomplete if one member is missing.
> But it's fine for me to change that in the next iteration of this patch.

For reads at block/page level, we will either get EIO or valid data, right?

If that's not the case, we should fail all writes.

Thanks,
Song
