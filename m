Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A2C0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 09:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6176620665
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 09:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbfG3JhO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:37:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59710 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731374AbfG3JhO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 05:37:14 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.lenton@canonical.com>)
        id 1hsOZE-0000l6-Fk
        for linux-block@vger.kernel.org; Tue, 30 Jul 2019 09:37:12 +0000
Received: by mail-wm1-f71.google.com with SMTP id y127so14525699wmd.0
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 02:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIoGjqbhWNKi5QbCIDEg2SCwp6+ZZT93N1wpiU5DUxk=;
        b=FCWHY4yywN9hkHeMr0wHsneggHN7GtSTRhSv5jkO9MlkDzwOUAdw/3Tc3Godomsgdv
         iBoTQ8ZPwzTzCYOnOkOhTmo/yC/L6SyoNouaJOcLb2ZJ3c/JRj5CDPCylKtkhl79KALJ
         q2QGBn2z93eKayzYKet741vECZKjRG5/VSFMkqKYNHxdF+46KMOYuAEE9BPzuMfuZRW3
         J09NrSy11ckq7ehI22A9QrnT1uFUStAmHZVedOu2HyymPoibFWIijkW7WNgqjCaLLd7e
         0raTn1wy9YHmgbA/pWPEnvO8ZIZcUSnk8omwoQXLzckBIkmDOOLopTRql3QZFxo69OJt
         l/wQ==
X-Gm-Message-State: APjAAAVInoWqCftOKEQQ8VGLnJaqECOaMQ516Q3CC01r6wH7a7kQ+XMJ
        p/oRfYxIo8z8E5W+h7ZjrM4w8IfLCzq/yer9nPRex/XIoUe1gAGaKDEXJFXA+vvC/7vAuGTlvwc
        OuETwjnnGd0Um86D2AEXSfNTbnSOSoDwI92ebfH8BCkEmnpSB5yOlwKMI
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr108320547wmg.164.1564479432142;
        Tue, 30 Jul 2019 02:37:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyT7Puqff4M+y2k5Mtx7q4xLZH7NRcSrUjE4WKOkUVPculWToH4x69r0DqD6kYKW5sxvGuvxBiPiSRBmKBu4oc=
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr108320512wmg.164.1564479431856;
 Tue, 30 Jul 2019 02:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190516140127.23272-1-jack@suse.cz> <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz> <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com> <20190730092939.GB28829@quack2.suse.cz>
In-Reply-To: <20190730092939.GB28829@quack2.suse.cz>
From:   John Lenton <john.lenton@canonical.com>
Date:   Tue, 30 Jul 2019 10:36:59 +0100
Message-ID: <CAL1QPZQWDx2YEAP168C+Eb4g4DmGg8eOBoOqkbUOBKTMDc9gjg@mail.gmail.com>
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
To:     Jan Kara <jack@suse.cz>
Cc:     Kai-Heng Feng <kaihengfeng@me.com>, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, jean-baptiste.lallement@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 30 Jul 2019 at 10:29, Jan Kara <jack@suse.cz> wrote:
>
> Thanks for the notice and the references. What's your version of
> util-linux? What your test script does is indeed racy. You have there:
>
> echo Running:
> for i in {a..z}{a..z}; do
>     mount $i.squash /mnt/$i &
> done
>
> So all mount(8) commands will run in parallel and race to setup loop
> devices with LOOP_SET_FD and mount them. However util-linux (at least in
> the current version) seems to handle EBUSY from LOOP_SET_FD just fine and
> retries with the new loop device. So at this point I don't see why the patch
> makes difference... I guess I'll need to reproduce and see what's going on
> in detail.

We've observed this in arch with util-linux 2.34, and ubuntu 19.10
(eoan ermine) with util-linux 2.33.

just to be clear, the initial reports didn't involve a zany loop of
mounts, but were triggered by effectively the same thing as systemd
booted a system with a lot of snaps. The reroducer tries to makes
things simpler to reproduce :-). FWIW,  systemd versions were 244 and
242 for those systems, respectively.
