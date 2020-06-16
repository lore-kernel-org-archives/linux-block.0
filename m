Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228C6C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F6820756
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZPuqXA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgFPDYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 23:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgFPDYV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 23:24:21 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB2DC061A0E
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 20:24:20 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u23so14885441otq.10
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 20:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vN+PIRvXpEDMYX5ahGs8/syC2Ss/q434jgA/XHAfWCs=;
        b=hZPuqXA0zeemOPFHX1NDEElhpkRpt03zla08pfa3vcTisfeBXxOEJrG3WrA3LTjL6l
         SWNcigxXK0Xu8CSOJkX0nMSPzIOCzDXZ2UDYjPrpsDZkpjlgkeCHW3+gX8dpMogecFm+
         pRLA60pu5LeFfnb2TTaUzIS2qjATCVuYWI3CTmH+23wBHiAMlsd0qxy5mca/8UG58wlN
         5h57+8CwH4Xi37DFWbREzpx76/lm28ieN+tszYtdORAqP8fUag41lqN+C9WLWerC/A54
         oAnnog2LAM1EW0Oao1+9RnbkDdPseUe3lqr2dqsAiJI874SI+LVWkded97lKTTkm3C/2
         /sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vN+PIRvXpEDMYX5ahGs8/syC2Ss/q434jgA/XHAfWCs=;
        b=nAanqKi7f1nrgy3/QAlqmR/O5vM6WCavozWbRyhl1YPZQdx94ivr58qweG9cLvUww5
         qYyN+fBFPJu6T7ChcHLBDpmHGxVzhePUvH4BnUTTDfXfkEpsxGq2HgZ6Ww+REGbLRsHc
         de8xMykaC0LQMNiihaThJvZZ71NmOQqzqFPvI8UP4g1r6jt6/UD+gXs+JhVjRDjiqiNE
         lWPN4iQV3p+r6oxnwPfOI55m2bKuFZZnfx7RjHADlr6VBiOXhv1cLdakGPSJ8nKEK2lo
         E+5uFhAnZySuNhyYXageyzfRwWmk2QzrRp2x3OL5lmeeI2fe0LItq6xNJNkzSjyKwRlk
         p/MA==
X-Gm-Message-State: AOAM531Z3z2rHjspdEaC9QtCGemPtiox8d3Zrsg+zNjM4MVaOaI7Re5X
        td8bmIJ7eJPer5JVY/bmLj/kxZ7umcBS1DJnEFFA8hIF
X-Google-Smtp-Source: ABdhPJxwiLP1xSF+k203OR6ftEa3nWC1lqt7LsoKfgyvFk4tMYmhtn4yQWY2nmO+WVfDOs1goxVDi2ilaDVa0yiTwnM=
X-Received: by 2002:a9d:6e0a:: with SMTP id e10mr907824otr.171.1592277859654;
 Mon, 15 Jun 2020 20:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
 <20200616024028.GE27192@T590> <CAD+ocbyJ7hfC-UyO5MupgnzbPbVAVO5b1Ff-+xgHLin_FXCE-w@mail.gmail.com>
In-Reply-To: <CAD+ocbyJ7hfC-UyO5MupgnzbPbVAVO5b1Ff-+xgHLin_FXCE-w@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 15 Jun 2020 20:24:08 -0700
Message-ID: <CAD+ocbzP70UXWRdhx-j2=+DdGihEbP94Djksij_Ykzgaayim3Q@mail.gmail.com>
Subject: Re: [PATCH] block: add split_alignment for request queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After taking a closer look, I don't see chunk_sectors being accounted
for in the splitting code. If I understand correctly, the implementation
of chunk_sectors is such that it allows for one big IO to go through.
In other words, it tries to avoid the splitting code if possible. But,
it doesn't seem to guarantee that when an IO is split, it will be
split at configured alignment. With commit
07173c3ec276cbb18dc0e0687d37d310e98a1480 ("block: enable multipage
bvecs"), we now see bigger multi-page IOs. So, if an app sent out
multiple writes, those all would get combined into one big IO.
"chunk_requests" would allow that one big IO to go through *ONLY IF*
the total size is < max_sectors. If that's not the case, chunk_sectors
doesn't seem to have control on how this big IO will now be split.
Please correct me if I'm wrong.


On Mon, Jun 15, 2020 at 7:50 PM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Thanks for the feedback everyone, I totally overlook chunk_sectors and
> it sounds like that's exactly what we want. I'll send another patch
> where that becomes writable.
>
>
> On Mon, Jun 15, 2020 at 7:40 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Jun 15, 2020 at 05:56:33PM -0700, Harshad Shirwadkar wrote:
> > > This feature allows the user to control the alignment at which request
> > > queue is allowed to split bios. Google CloudSQL's 16k user space
> > > application expects that direct io writes aligned at 16k boundary in
> > > the user-space are not split by kernel at non-16k boundaries. More
> > > details about this feature can be found in CloudSQL's Cloud Next 2018
> > > presentation[1]. The underlying block device is capable of performing
> > > 16k aligned writes atomically. Thus, this allows the user-space SQL
> > > application to avoid double-writes (to protect against partial
> > > failures) which are very costly provided that these writes are not
> > > split at non-16k boundary by any underlying layers.
> > >
> > > We make use of Ext4's bigalloc feature to ensure that writes issued by
> > > Ext4 are 16k aligned. But, 16K aligned data writes may get merged with
> > > contiguous non-16k aligned Ext4 metadata writes. Such a write request
> > > would be broken by the kernel only guaranteeing that the individually
> > > split requests are physical block size aligned.
> > >
> > > We started observing a significant increase in 16k unaligned splits in
> > > 5.4. Bisect points to commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
> > > ("block: enable multipage bvecs"). This patch enables multipage bvecs
> > > resulting in multiple 16k aligned writes issued by the user-space to
> > > be merged into one big IO at first. Later, __blk_queue_split() splits
> > > these IOs while trying to align individual split IOs to be physical
> > > block size.
> > >
> > > Newly added split_alignment parameter is the alignment at which
> > > requeust queue is allowed to split IO request. By default this
> > > alignment is turned off and current behavior is unchanged.
> > >
> >
> > Such alignment can be reached via q->limits.chunk_sectors, and you
> > just need to expose it via sysfs and make it writable.
> >
> > Thanks,
> > Ming
> >
