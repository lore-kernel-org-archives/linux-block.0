Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFF8C2B9F8
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F1613FC
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 16:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhEXQ1b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhEXQ1b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 12:27:31 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B005C061574
        for <linux-block@vger.kernel.org>; Mon, 24 May 2021 09:26:03 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id j19so6041889vkj.0
        for <linux-block@vger.kernel.org>; Mon, 24 May 2021 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SP2BZdKlThSu6kHqkbL0f8O39z75p93t1CFSSb6kP6A=;
        b=AMwhxlfvIPT1+cn4mQwMmez18R53eNYMW3kdqz/2K5bTXja+CsDaiMHjH87B9vs63T
         vKcqORytD70hSj5y2ACajmqJVgY//3TpVjprFsek6Rl8xt+Qn5T63rZvuqH9j1UnEgZJ
         74TBP8KAQY3Km93Wi1us0ke7foZFeFkMY4skhhC+LOBI2T7NBg6ZP4UMR9k8AyhbvkhU
         YzjV50TNAJMHjPL/4PDR6iadZrMPBjQrkNNxwdJMDoW9tBXcgY0WvgA48SavEVckIlfE
         qAOaRvRfDBx9m0MQhdu4XfDwWZecalIlcHWHEdQr97WEOYPgSWN66mMU3bdT0y1nP46m
         hjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SP2BZdKlThSu6kHqkbL0f8O39z75p93t1CFSSb6kP6A=;
        b=Sr5YTwPj115c7+5snwcT+qOm2H9IWOjwlh//fBgFUmSvJNeQEXwN2ACoKjcgUX4PTx
         n+0aVE7NfQv1RHMeolDRsIRFGwyEPpLx2ytxyY0axSSHYKG/8wEcDPq1XZt2zAQtpqra
         QIBSX8eUCURGtshSZMuRvtZYbVqQxA7OlwULGsvO3Lf+YieY/KKoeFWlJLOH9WQ1YR6K
         ms11duth6HiIJ+4C8kFLyPGe7gfe111ahnegRumYUK/qXJ4xtjxN0Pzet6wLYDrWwzqq
         tjrW9u6Fbu8i3bIlurdMbCV7Z4e48WSPlt2wYdHUL5N9MKpy3gwLtiCj2iCEufoLzY1x
         j7Xw==
X-Gm-Message-State: AOAM533Aa28l3Yff2iYyLznphR9WJMpV8qw6xy8jRmLyi0T/zw5fNBpq
        QVQZQa1FvsTEKweRyRrryf+nllT4ueR5cFDwq6m4OUUdC6Jaa878
X-Google-Smtp-Source: ABdhPJwsNXBFGmRL6Qdv650SNJwagPUuG24dNMJGtpBJZ+17nxPEg4Pylgky7K5gV81D6DSkM24pcShGa9M1j9LcCzI=
X-Received: by 2002:a1f:9542:: with SMTP id x63mr22199896vkd.15.1621873562173;
 Mon, 24 May 2021 09:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210520133908.98891-1-damtev@yandex-team.ru> <20210520133908.98891-2-damtev@yandex-team.ru>
 <YKu4Qovv1KMplifY@stefanha-x1.localdomain> <20210524145654.GA2632@lst.de>
In-Reply-To: <20210524145654.GA2632@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 18:25:24 +0200
Message-ID: <CAPDyKFpHeiyLxU1H_gZuxivkiZCKhZ_igsbx_TxSWzUhyaEufQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions block
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Yury Kamenev <damtev@yandex-team.ru>,
        Jens Axboe <axboe@kernel.dk>, mst@redhat.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>, pbonzini@redhat.com,
        Lauri Kasanen <cand@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 May 2021 at 16:57, Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, May 24, 2021 at 03:29:22PM +0100, Stefan Hajnoczi wrote:
> > GENHD_FL_NO_PART_SCAN is not used much in other drivers. This makes me
> > wonder if the same use case is addressed through other means with SCSI,
> > NVMe, etc devices. Maybe Christoph or Jens can weigh in on whether
> > adding a bit to disable partition scanning for a virtio-blk fits into
> > the big picture?
> >
> > Is your goal to avoid accidentally detecting partitions because it's
> > confusing when that happens?
>
> I'm really confused what the use case is here.  GENHD_FL_NO_PART_SCAN
> has four users:
>
>  - the block core setting it for hidden devices, for which the concept
>    of paritions doesn't make sense.  Looking back this should have never
>    used GENHD_FL_NO_PART_SCAN, and instead the partition scanning code
>    should just check GENHD_FL_HIDDEN as well.
>  - mmc uses it for boot partitions and rpmb.  I'm not even sure how
>    these can be exposed as block devices as they don't require block
>    granularity access IIRC, but if the allow block layer access there
>    is no reason to ever set these flags.

For RPMB, we have converted them into char devices, thus
GENHD_FL_NO_PART_SCAN is never set for them. The code needs a cleanup
to clarify this.

When it comes to eMMC boot partitions, those can be read/written to as
any other block device. Although, it's unlikely that they need
partitions as they are usually very small, 512Kb or 2MB in that
ballpark. At least, that was the thinking behind it when we added
GENHD_FL_NO_PART_SCAN for them.

If you want to drop GENHD_FL_NO_PART_SCAN for eMMC boot partitions, I
don't think it will be an issue.

>  - loop is a bit of a mess.  IIRC the story is that originally the
>    loop device did not support partitions, then in 2008 support for
>    partitions was added by partitioning the minor number space, and
>    then in 2011 support for partitions without that parameter was
>    added using a new flag in the loop device creation ioctl that uses
>    the extended dev_t space added since.  But even that might be
>    something we can handled without that flag without breaking the
>    userspace ABI
>  - m64card sets it for no good reason at all
>
> In other words: in a perfect would GENHD_FL_NO_PART_SCAN would not
> exist, and it certainly should not be added to a new driver, never
> mind a protocol.
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Kind regards
Uffe
