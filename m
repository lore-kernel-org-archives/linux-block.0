Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9C0C433E0
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 23:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DD823123
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 23:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbhAFXep (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jan 2021 18:34:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51011 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbhAFXep (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jan 2021 18:34:45 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kxIJW-0002Np-MF
        for linux-block@vger.kernel.org; Wed, 06 Jan 2021 23:34:02 +0000
Received: by mail-wr1-f69.google.com with SMTP id n11so1812309wro.7
        for <linux-block@vger.kernel.org>; Wed, 06 Jan 2021 15:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8Hxh8M+9xeHON8o4qCfxi3CCWfqrju16jW9+glO6+M=;
        b=nmgl9Czk1JrhpaSkvEXk/nd+T9kUvjwtca7K8ggAiGsUcNpYPU6xMuT75y0O7D/9Kh
         CGhSbWmp6GtvfhdkNZ99DzpxOOOIChCqL6PRHs+unS/CVeZN6gJf/dexM4XiGZxp3Pig
         5SCF6nCPW38YUcyNibUc/lLRSl07zxFLws01hh8OTW8xfkaEjngzJR64FOesMSgJuMa/
         tQiNa0Iikqu1xsRPokEFPVmL3QDth+Lnh3PHM8U9sixzwRPzuGOharPL4tNZuyXxDUrG
         iue4VdSA+7rsNHUV+U5jY+1isnf4+duxQ+kaJFoVgQsplyw1QZtt8/ITClCylBZSgkyt
         eQWw==
X-Gm-Message-State: AOAM530R1l0zMZxZ4d0dU4qhLDtIMGljn8pNHA8JmsOh8op0os3EQLCW
        9sNrE/+rmwLoADBqaNRJyYiqn61ykDrNdOz0Nr9qYjZGRyqHPgfddo+WbnAs/WsfRUX3L1rwiwR
        BiqvEVVTE+taxwHPPRKZ/3jmc8YzkVeyj4On05hmpZHEAWKvs8G8gFN5D
X-Received: by 2002:a05:600c:21c7:: with SMTP id x7mr5449635wmj.75.1609976042128;
        Wed, 06 Jan 2021 15:34:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxn3EGx7+iXTWyLWoOG0HkDq0cfterpIm38Da94NB+JazKwS0OArXNwHUzcYBS1JxkjxgN4oTwfHWjGsjwkgk=
X-Received: by 2002:a05:600c:21c7:: with SMTP id x7mr5449624wmj.75.1609976041918;
 Wed, 06 Jan 2021 15:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20210105135419.68715-1-mfo@canonical.com> <20210106090758.GB3845805@T590>
In-Reply-To: <20210106090758.GB3845805@T590>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 6 Jan 2021 20:33:50 -0300
Message-ID: <CAO9xwp0ad6Hs2AJOLKUn-oVSp+kwHKM67saxdwv0JsrSza+C7Q@mail.gmail.com>
Subject: Re: [PATCH v2] loop: fix I/O error on fsync() in detached loop devices
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Eric Desrochers <eric.desrochers@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 6, 2021 at 6:08 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Jan 05, 2021 at 10:54:19AM -0300, Mauricio Faria de Oliveira wrote:
> > There's an I/O error on fsync() in a detached loop device
> > if it has been previously attached.
> >
> > The issue is write cache is enabled in the attach path in
> > loop_configure() but it isn't disabled in the detach path;
> > thus it remains enabled in the block device regardless of
> > whether it is attached or not.
> >
> > Now fsync() can get an I/O request that will just be failed
> > later in loop_queue_rq() as device's state is not 'Lo_bound'.
> >
> > So, disable write cache in the detach path.
> >
> > Test-case:
> >
> >     # DEV=/dev/loop7
> >
> >     # IMG=/tmp/image
> >     # truncate --size 1M $IMG
> >
> >     # losetup $DEV $IMG
> >     # losetup -d $DEV
> >
> > Before:
> >
> >     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
> >     fsync(3)                                = -1 EIO (Input/output error)
> >     Warning: Error fsyncing/closing /dev/loop7: Input/output error
> >     [  982.529929] blk_update_request: I/O error, dev loop7, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> >
> > After:
> >
> >     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
> >     fsync(3)                                = 0
>
> But IO on detached loop should have been failed, right? The magic is
> that submit_bio_checks() filters FLUSH request for queues which doesn't
> support writeback cache, and always fake a normal completion.
>

Hey Ming, thanks for taking a look at this.

Well, it depends -- currently read() works (without I/O errors) and
write() fails (ENOSPC).
Example tests are provided below.

And that's consistent before and after attach/detach; so, I thought
fsync() should follow.

> I understand that the issue is that user becomes confused with this observation
> because no such failure if they run 'parted -s /dev/loop0 print' on one detached
> loop disk if it is never attached.
>

That is indeed one of the issues. There's also a monitoring/alerting
perspective that
would benefit; e.g., sosreport runs parted, it's run on data
collection for support cases.
Now, that I/O error message is thrown in the logs, and some mon/alert
tools might not
yet have filters to ignore (detached) loop devices, and alert. It'd be
nice to deflect that.

It's not a common issue, to be honest; but the consistency point
seemed fair to me,
as essentially the current code doesn't deinitialize something it
previously initialized,
and the block device is left running with that enabled regardless.

cheers,

Setup:

    # DEV=/dev/loop7
    # IMG=/tmp/image
    # truncate --size 1M $IMG

Before attach/detach:

    # dd if=$DEV of=/dev/null
    0+0 records in
    0+0 records out
    0 bytes copied, 0.00011206 s, 0.0 kB/s

    # echo $?
    0

    # dd if=/dev/zero of=$DEV
    dd: writing to '/dev/loop7': No space left on device
    1+0 records in
    0+0 records out
    0 bytes copied, 0.000229225 s, 0.0 kB/s

    # echo $?
    1

After attach/detach: (same)

    # losetup $DEV $IMG
    # losetup -d $DEV

    # dd if=$DEV of=/dev/null
    0+0 records in
    0+0 records out
    0 bytes copied, 0.000102131 s, 0.0 kB/s

    # echo $?
    0

    # dd if=/dev/zero of=$DEV
    dd: writing to '/dev/loop7': No space left on device
    1+0 records in
    0+0 records out
    0 bytes copied, 0.000259658 s, 0.0 kB/s

    # echo $?
    1


>
> Thanks,
> Ming
>


-- 
Mauricio Faria de Oliveira
