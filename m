Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A209C4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 21:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E819F235DD
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 21:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgLPVOG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 16:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgLPVOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 16:14:06 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B933BC061794
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 13:13:25 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u18so51980110lfd.9
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 13:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNqKJ23WJs0AxfwfQ1Wn+Y/jwydGnxztR76T2aQQk4Q=;
        b=X/pBwrARbVmjBI3j3NatlzMBH7TUVNRauB689iM5X5djm/F8NQw7NXTRHng2OY033X
         kj20GpF/7iV5c4msbnH9VpKqoEDYBJINTbPy4mT9MlgihPTnACAKkTL7+BC1ZDwTuS39
         gnEDtgcLO5yBUrGbOA7Pyum0E6yUITUlg5Mio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNqKJ23WJs0AxfwfQ1Wn+Y/jwydGnxztR76T2aQQk4Q=;
        b=plI5GIZHw9xtv3smFO+Oo9PDG8GbriYzXyuH/JRfvldxoz9NJbaAO0dCA3udyX/RHC
         war+N8vlzsaY36rQ8IanJ40HV0h6rxOcs8IIELAjQ97CX26SjAecV5QT1ESLQcQJmVn5
         QJfuy/9qNMLXZkEzsNno3qCoK/Hg/RSSxVfO7HPlnlLc29RhxAjCJuN1bD7RthprTHlg
         3095rw2qSFh8fIoR8/Hk1FOuIgLNxMxk+/vHO62dUKPwm3fo6QpDi8bFVz8Y15FdQMNd
         Oy1RiruD/0ijRPkE2Ax1qdwgVeSkOvFfNpZBKF2/h7urYtjtloLsJ4nxolLUvmn2o18f
         n6cA==
X-Gm-Message-State: AOAM53199mmT1MnvLR5v43GLtyqx6jJW4oPmwtfLbg0zVoaNKiZyeydW
        HFCGRwNRL3o5zC4aYxrsw8i8h4fHsZdB+g==
X-Google-Smtp-Source: ABdhPJxJ9o0t5WQ6C79Rynw9bS1tuNen0BhcdSukuh2hycNrYtIHvopL0PaQcE+3xSX4FtddsYVmAg==
X-Received: by 2002:a05:651c:200a:: with SMTP id s10mr14847631ljo.492.1608153203812;
        Wed, 16 Dec 2020 13:13:23 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id v25sm351745lfg.88.2020.12.16.13.13.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 13:13:23 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 23so51968402lfg.10
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 13:13:22 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr15931858ljj.220.1608153202492;
 Wed, 16 Dec 2020 13:13:22 -0800 (PST)
MIME-Version: 1.0
References: <8238bb43-756b-e0dc-2484-7e1e21928c0c@kernel.dk>
In-Reply-To: <8238bb43-756b-e0dc-2484-7e1e21928c0c@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Dec 2020 13:13:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjRm36zBu2Vj=VyntiA9Hdc1_uFVeY93d3oYQntXzERag@mail.gmail.com>
Message-ID: <CAHk-=wjRm36zBu2Vj=VyntiA9Hdc1_uFVeY93d3oYQntXzERag@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.11
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 14, 2020 at 7:30 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Note that this throws a merge conflict in drivers/md/raid10.c, again due
> to the late md discard revert for 5.10. Resolution is straight forward,
> __make_request() just needs to use the non-HEAD part of the resolution:
>
> r10_bio->read_slot = -1;
> memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->geo.raid_disks);

What?

No, that can't be right. That undoes part of the revert.

The proper resolution looks to be

+       r10_bio->read_slot = -1;
 -      memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) *
conf->geo.raid_disks);
 +      memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->copies);

as far as I can tell.

Am I missing something?

            Linus
