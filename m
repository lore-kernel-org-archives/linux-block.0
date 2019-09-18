Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CC5C4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 06:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAF6218AE
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 06:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+rtTKk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfIRGKV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:10:21 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42201 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfIRGKU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 02:10:20 -0400
Received: by mail-ua1-f66.google.com with SMTP id r19so1946247uap.9
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTBwbLii9b70VDIiu2pkAKMCAWF61Wo+h6WzPYHryB4=;
        b=T+rtTKk5TFAHOQsUgV/It9GsfiXKaB+bhfa5dN/sLkCoY4OmhkyktixzO9f+8YwHkk
         cEwMurZ/Mg+6d/IyWE/VoTFh6ibwd0Mwl6dha6HSGU+9F+3oa3E4SG8ssP4tJD2gAj2Z
         CgfhsGf+P+xpNd67ACMjlLHF9Vo5pLWNL+0rS9zkvOMFSZdZhpHuEdLXnjGXRBDdZa05
         gMHUHQCZdMtNI95/7aMMVk9PajYLgBwdgoxrI69ssFUOuabdzO4bzrjNDV04fRzwiUtG
         OU6mo3S5DUmnJ0GDQ58haSoMZ17PjkKDKF6Z+zaNrgrM1JI3wMct87apJQWCU/YgECc4
         x8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTBwbLii9b70VDIiu2pkAKMCAWF61Wo+h6WzPYHryB4=;
        b=l4WGA+Mz1YVhqZweViklcYQHTxN9qG/cFbAsfpy/zPQME89t42FRw/X2tlbYhFJ9W2
         iPy4QX79wRLUVi6gxeigh0IIseH3v66K+6sL+6vw8wb1hfH1GsRfi6fTLM7Y62Q42HAP
         wPfhG89Vwz/lIMfripHUOmwP9Jzc/XqVd2ukfSJIcBDrn/slPSUoAVU3zDySJ7Wlflcg
         IyPkhSW9gbX4eyeXN53G0xJGvL/QYXpKQBjkR3XRMuPnqN5/KSqgi8KlmtvKJMfJF9mv
         +8gv7Wb1Ktc2LFM5q5n4J0WA/QEcRkEU3bjzvDVeoa6QpMgSSik1UWwt7ItD202Q/CM9
         uKXQ==
X-Gm-Message-State: APjAAAU07Ce/d9xAuX0FdwQ5V93Nm2zLHhPsgcMJrU3fPLA7+0IXxQmi
        bXojkGmVfXzTZ+iBSmvs+bCQ/bf23rvD13O4Xx2jAg==
X-Google-Smtp-Source: APXvYqw3WNN2Dndv9EUbQn4aZiKazwu1E6YluB67ZhBYYekBU3g4MWLJvI2vAwQzbc1TVbrUGcur2tykCtit3Ev9e/k=
X-Received: by 2002:ab0:1856:: with SMTP id j22mr1425618uag.19.1568787019751;
 Tue, 17 Sep 2019 23:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org> <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
In-Reply-To: <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Sep 2019 08:09:42 +0200
Message-ID: <CAPDyKFrHeEb77F-U3W1HdSj3_rrMyi66XCt73By3OoLOVa65bQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
To:     Tejun Heo <tj@kernel.org>, Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched" <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org, Angelo Ruocco <angeloruocco90@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tejun, Paolo,

On Tue, 17 Sep 2019 at 23:32, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Sep 17, 2019 at 06:51:48PM +0200, Paolo Valente wrote:
> > When bfq was merged into mainline, there were two I/O schedulers that
> > implemented the proportional-share policy: bfq for blk-mq and cfq for
> > legacy blk. bfq's interface files in the blkio/io controller have the
> > same names as cfq. But the cgroups interface doesn't allow two
> > entities to use the same name for their files, so for bfq we had to
> > prepend the "bfq" prefix to each of its files. However no legacy code
> > uses these modified file names. This naming also causes confusion, as,
> > e.g., in [1].
> >
> > Now cfq has gone with legacy blk, so there is no need any longer for
> > these prefixes in (the never used) bfq names. In view of this fact, this
> > commit removes these prefixes, thereby enabling legacy code to truly
> > use the proportional share policy in blk-mq.
>
> So, I wrote the iocost switching patch and don't have a strong
> interest in whether bfq prefix should get dropped or not.  However, I
> gotta point out that flipping interface this way is way out of the
> norm.
>
> In the previous release cycle, the right thing to do was dropping the
> bfq prefix but that wasn't possible because bfq's interface wasn't
> compatible at that point and didn't made to be compatible in time.

Sounds like we really should send those relevant patches for stable,
to set the correct ground. Then using a symlink, to make sure we don't
brake current ABI, right?

[...]

Kind regards
Uffe
