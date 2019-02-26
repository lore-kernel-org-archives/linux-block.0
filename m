Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C96C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2770A21848
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V4/9s7fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfBZRXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:23:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45109 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBZRXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 12:23:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id d24so11219157ljc.12
        for <linux-block@vger.kernel.org>; Tue, 26 Feb 2019 09:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RhU8uM0ad+0+mYh4+yrj9Diioag2qapPokY1EYhEhY=;
        b=V4/9s7fusoKlP5TdYrlE40KrLOJs5jr9+p0GabO7V7BSBppp76w4X4LFDhHrt7GZTI
         hyM0pPL5rAKMNj+C3UV7FuJt6YF+K1UO/NL/wFRmF8QhzrGcY8wkZWk0p1ieN546u75F
         QcPU39mz0C9u4xzEzZOG4TRF/SHIZCgHkuFsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RhU8uM0ad+0+mYh4+yrj9Diioag2qapPokY1EYhEhY=;
        b=LcFY/1seaembZg88HnZUW6KGe1aIu7c5EQVkMTCtBsXbywHNjzVMz6sxIechSutOl1
         8m+GjRtn/+qwwMEjsKGlPiYv1cCVVYuYxtknsXql5OTxZK4nLXPXAS52QyVbyA+2NzgO
         mCyaLxFSyOj2ETDf0Dx5u6Aer5pizZbsYlcKYvyxCIiAjD6hvNmzt8HdEIbeNfDU17YT
         c05Je/VMG+XOAWzEprNKVpiBIR/DkSpAdsNi9j/pVZR+BIwHsKQ+FhoLnvR1d6+ZyqHO
         Qc4HdeMw/eESXblmT9uYJ6bn3tYspTPZsFxOpOlJZebht4CjdhqsWF9jBsAtKGeGqUwW
         0AaQ==
X-Gm-Message-State: AHQUAua/yLQyswOh8rAYJOJ9Ag+x9mt7F1VVPeJJsWrN0EYOQQYI++Br
        gBQuYWgm5NYw+aFhUzisOB76w/LrIks=
X-Google-Smtp-Source: AHgI3IYEZ1bJB9P17yazdtikmtoLw0H7jFnbxx07KIz7+bZaWTp9oH4/a40bj+KqxHRiBXfGBWP/6w==
X-Received: by 2002:a2e:7a08:: with SMTP id v8mr14060217ljc.161.1551201832946;
        Tue, 26 Feb 2019 09:23:52 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t18sm3570898ljc.54.2019.02.26.09.23.52
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:23:52 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id g80so11489954ljg.6
        for <linux-block@vger.kernel.org>; Tue, 26 Feb 2019 09:23:52 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr14356563ljj.30.1551201831984;
 Tue, 26 Feb 2019 09:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20190207205730.199332-1-evgreen@chromium.org> <20190207205730.199332-3-evgreen@chromium.org>
 <yq1d0nvqeix.fsf@oracle.com> <CAE=gft6bdM2dLc9RhGYMWp8bz6_c-W8Yy-CUTM9wXe+UiYkXEw@mail.gmail.com>
In-Reply-To: <CAE=gft6bdM2dLc9RhGYMWp8bz6_c-W8Yy-CUTM9wXe+UiYkXEw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 26 Feb 2019 09:23:13 -0800
X-Gmail-Original-Message-ID: <CAE=gft4OeQwokacbX8D1t7JrawKSZGjfjNm0xZc=Qx92HqieWg@mail.gmail.com>
Message-ID: <CAE=gft4OeQwokacbX8D1t7JrawKSZGjfjNm0xZc=Qx92HqieWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] loop: Better discard support for block devices
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 10:00 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Wed, Feb 13, 2019 at 6:40 PM Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
> >
> >
> > Evan,
> >
> > > If the backing device for a loop device is a block device, then mirror
> > > the discard properties of the underlying block device into the loop
> > > device. While in there, differentiate between REQ_OP_DISCARD and
> > > REQ_OP_WRITE_ZEROES, which are different for block devices, but which
> > > the loop device had just been lumping together.
> >
> > Bubbling up the queue limits from the backing device is fine. However,
> > I'm not sure why you are requiring a filesystem to be on a
> > discard-capable device for REQ_OP_DISCARD to have an effect? Punching a
> > hole in a file is semantically the same as discarding.
> >
>
> Hi Martin,
> Thanks so much for taking a look at this patch, I was getting nervous
> it was languishing again. I got confused by this comment though. My
> intention was to not change behavior for loop devices backed by a
> regular file system file. The changes in loop_config_discard() should
> result in QUEUE_FLAG_DISCARD being set for backings of regular files
> that support f_op->fallocate(), same as before my patch. The change in
> lo_discard() to call blk_queue_discard() on the loopback queue itself
> was just shorthand to avoid duplicating all those if statements from
> loop_config_discard again. Am I missing a spot where I've implicitly
> changed the behavior for file-backed loop devices?
> -Evan

Hi Martin,
Did you get a chance to take a look at my reply? This error log
plagues our Chrome OS installer, and I'm hopeful I've found an
approach here that's upstream-friendly. But if it's not, let me know
and I can fix it.
-Evan
