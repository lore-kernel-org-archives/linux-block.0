Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E29C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 12:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA99610EA
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 12:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhJMNB2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhJMNB1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 09:01:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65075C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 05:59:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y12so9989120eda.4
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgcPZ/VE3a6UD0gwAUDDSfYNJhdyVBbycd9KeXHOYHM=;
        b=ndArNa0HmqnsRzlysy93djlVuh/kqTwrCRC04MiyCzlokwU6D0cQ3Bbx+1Msp3a0kq
         fDJVYpiLq3aFIRt7VgtW7JibN+h+Q/yN9IfOzJhAkTM/fr5cvIWR2/1cWKdtOYSA3EYm
         qZWl8LdPki4DjSLk2jLjHAErrC0Al++e3odTf+AmXTPv/EVUClim6wIPE4wk923ZlyD+
         TLHR+7NpFulvfpJW8peNGqIZRn/XRiGFn1wjGDpJXT2AFkRFATP0HMC9KWP6A7uu6Ub1
         fWThoH+Vn4zUBbvaUaXpQNuRIGYXgtY8CdRM80d7L9TWYBPAPOck4ohsweYsRFR2VdNa
         Jv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgcPZ/VE3a6UD0gwAUDDSfYNJhdyVBbycd9KeXHOYHM=;
        b=VoH4wmesJT6HzLqhntnJm6YV0Gr9uSxplUuW5JApSAG0ZKQXkefQAWbxLMJ3lb81pe
         x9C+isZt8011AtfTTwgMBUrgOMsBKtF7XH8XjDC75zTcqCmJ56+uLnh8l1fFbMcAIhi6
         VUrei42Tl4rmhP8DO4IyCMy3a4hksImOw07NfptU07rAN8An21+5yPamCThB952NTszr
         FARRgDY3cMtHJCaEMtLVr/QE/mtSrFcE6MFdpZJge0vP8QkFBSuzl5k+0BoJIegQNz7C
         DBopfyzoU/cn8BNZYHwe5vjOYKYQvrtuLrannx5zVFIdGALDe5mf5U0uAC9TssgRasIY
         6Qtg==
X-Gm-Message-State: AOAM532k8vL6cOhvtNLKKQUy4UxzFHP7J5o020M3+ev80mPA8f7wo3vt
        GDuJ5/D510hKmwWGi7GNptzRnZUnKmLZsuZN7PYo
X-Google-Smtp-Source: ABdhPJzgPADRXFXaS1vYyh2jK9MJH6mvnTgnwdfTvoN2wDEHXGVHLXkBfHUrjA74sxkLWw0zhl39qEXkT1/imAT3FrA=
X-Received: by 2002:a17:906:ce25:: with SMTP id sd5mr39252100ejb.398.1634129963024;
 Wed, 13 Oct 2021 05:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <20211004112623-mutt-send-email-mst@kernel.org>
 <20211005062359-mutt-send-email-mst@kernel.org> <20211011114041.GB16138@lst.de>
 <20211013082025-mutt-send-email-mst@kernel.org> <CACycT3skLJp1HfovKP8AvQmdxhyJNG6YFrb6kXjd48qaztHBNQ@mail.gmail.com>
 <20211013084711-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013084711-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 13 Oct 2021 20:59:12 +0800
Message-ID: <CACycT3vNOcuEZngDcUup=jugj-HJWUjSot5AkE5DYdBzPfzZZg@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kevin Wolf <kwolf@redhat.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 8:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Oct 13, 2021 at 08:34:22PM +0800, Yongji Xie wrote:
> > On Wed, Oct 13, 2021 at 8:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 01:40:41PM +0200, Christoph Hellwig wrote:
> > > > On Tue, Oct 05, 2021 at 06:42:43AM -0400, Michael S. Tsirkin wrote:
> > > > > Stefan also pointed out this duplicates the logic from
> > > > >
> > > > >         if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
> > > > >                 return -EINVAL;
> > > > >
> > > > >
> > > > > and a bunch of other places.
> > > > >
> > > > >
> > > > > Would it be acceptable for blk layer to validate the input
> > > > > instead of having each driver do it's own thing?
> > > > > Maybe inside blk_queue_logical_block_size?
> > > >
> > > > I'm pretty sure we want down that before.  Let's just add a helper
> > > > just for that check for now as part of this series.  Actually validating
> > > > in in blk_queue_logical_block_size seems like a good idea, but returning
> > > > errors from that has a long tail.
> > >
> > > Xie Yongji, I think I will revert this patch for now - can you
> > > please work out adding that helper and using it in virtio?
> > >
> >
> > Fine, I will do it.
> >
> > Thanks,
> > Yongji
>
> Great, thanks! And while at it, pls research a bit more and mention
> in the commit log what is the result of an illegal blk size?
> Is it memory corruption? A catastrophic failure?
> If it's one of these cases, then it's ok to just fail probe.
>

Sure, and I think it will be one of these cases. Will add some stack
dump in the commit log.

Thanks,
Yongji
