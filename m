Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EADC33C9E
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 01:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF7A24658
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 01:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgAOBWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:22:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32868 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgAOBWr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jan 2020 20:22:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id z16so7568953pfk.0
        for <linux-block@vger.kernel.org>; Tue, 14 Jan 2020 17:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PM6QWDHPmw5kdiIrgY1FxbT/e0QV+PJ//rAEZB27p4g=;
        b=Mfh575YH9loj9ltK84HnRa3pLqEFQIiGeLRaFkg00dIpZ9f/IiF49qjl6b2S1ozq/B
         Eae7SQdguty0nj1FgDsh1nudKp8Bhlj5IdrARDY4sl9aQ9dtwY56J3Op9Qp8VuqNRhtM
         HKIBENKcPzrj1BjvyWLZS/e23aXj55Ykgmr3WB6diX1EcibdWoFDXJ2K7Nv+C2ccPWWw
         5lQ7oJygFgGX3G/PxM7yQ5PFRW0i3cdY0HH8rY2qA8AlduirU04knoJl0uT0YRaKT4Hi
         LVWGvK1SVgKi/87My5J8akzWEXz1ERrZ/wcxd0zpPJcMNXS2bITYxLkPE6Cz3H6UJ6Z9
         csLQ==
X-Gm-Message-State: APjAAAXsVDpj6EH6xaNQY3Cgh0MMKSE5ArE4IajtcL8HLtcvfnpDPjOu
        zTLb4Dk6Q1daTfsex6M21SWvvBzUP+rHCP/l+qfR/ssf
X-Google-Smtp-Source: APXvYqxZMHGMze09A1aQd5eSXisuAxZshcmQ/9sybd+Y4BM/S2H6Kgx1F9iT/EF5GhK8yU6xerE8uo3UBLJrLuj4LS4=
X-Received: by 2002:aa7:8f3d:: with SMTP id y29mr29328628pfr.183.1579051367083;
 Tue, 14 Jan 2020 17:22:47 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.11.1909251814220.15810@mx.ewheeler.net>
 <alpine.LRH.2.11.1912201829300.26683@mx.ewheeler.net> <alpine.LRH.2.11.1912270137420.26683@mx.ewheeler.net>
 <alpine.LRH.2.11.1912271946380.26683@mx.ewheeler.net> <20200107103546.asf4tmlfdmk6xsub@reti>
 <20200107104627.plviq37qhok2igt4@reti> <20200107122825.qr7o5d6dpwa6kv62@reti> <20200114215248.GK41220@gmail.com>
In-Reply-To: <20200114215248.GK41220@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
Date:   Tue, 14 Jan 2020 20:22:35 -0500
Message-ID: <CAMM=eLfODVMDtGahspZsGsBM5Ty_dt+8idJVTyeudzHZQqsDdA@mail.gmail.com>
Subject: Re: kernel BUG at drivers/md/persistent-data/dm-space-map-disk.c:178
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LVM2 development <lvm-devel@redhat.com>, markus.schade@gmail.com,
        Joe Thornber <ejt@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Joe Thornber <joe.thornber@gmail.com>,
        Eric Wheeler <dm-devel@lists.ewheeler.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 14, 2020 at 4:53 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jan 07, 2020 at 12:28:25PM +0000, Joe Thornber wrote:
> > On Tue, Jan 07, 2020 at 10:46:27AM +0000, Joe Thornber wrote:
> > > I'll get a patch to you later today.
> >
> > Eric,
> >
> > Patch below.  I've run it through a bunch of tests in the dm test suite.  But
> > obviously I have never hit your issue.  Will do more testing today.
> >
> > - Joe
> >
> >
> >
> > Author: Joe Thornber <ejt@redhat.com>
> > Date:   Tue Jan 7 11:58:42 2020 +0000
> >
> >     [dm-thin, dm-cache] Fix bug in space-maps.
> >
> >     The space-maps track the reference counts for disk blocks.  There are variants
> >     for tracking metadata blocks, and data blocks.
> >
> >     We implement transactionality by never touching blocks from the previous
> >     transaction, so we can rollback in the event of a crash.
> >
> >     When allocating a new block we need to ensure the block is free (has reference
> >     count of 0) in both the current and previous transaction.  Prior to this patch we
> >     were doing this by searching for a free block in the previous transaction, and
> >     relying on a 'begin' counter to track where the last allocation in the current
> >     transaction was.  This 'begin' field was not being updated in all code paths (eg,
> >     increment of a data block reference count due to breaking sharing of a neighbour
> >     block in the same btree leaf).
> >
> >     This patch keeps the 'begin' field, but now it's just a hint to speed up the search.
> >     Instead we search the current transaction for a free block, and then double check
> >     it's free in the old transaction.  Much simpler.
> >
>
> I happened to notice this patch is on the linux-dm/for-next branch
> (https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=for-next&id=2137c0dcc04b24efb4c38d4b46b7194575718dd5)
> and it has:
>
>         Reported-by: Eric Biggers <ebiggers@google.com>
>
> This is wrong, I didn't report this.  I think you meant to put:
>
>         Reported-by: Eric Wheeler <dm-devel@lists.ewheeler.net>
>
> - Eric (the other one)

Fixed it up, not sure how that happened, sorry about that!
