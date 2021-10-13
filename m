Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4826CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 12:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26383610D0
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 12:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhJMMgl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJMMgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 08:36:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE393C061746
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 05:34:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a25so9557880edx.8
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icmQtzGW1I9aNeYIPHd+HyscMc2NTbBX1tevUyNL3tU=;
        b=8F3RiOv1P1mDb3ddBj4vql6etzsVA/HQ8bcyDNuhobirPCXuxk5IXPSrQqZZkBo3A+
         SHKFL0Rv8ONqLvky2T3/RtxFWy4omkDz2DFJyIKLX8SIZmILoe+CflWW84y56fM0FxMe
         iP1X66dCzePfV57iNCKktzMjSPSlNgrsNosysu0GxfCJRdwwGJlbaFf/QGtQuSGyZWhr
         7BpwKeu7Cwh2MHRTm0ZAxQ245e6w3l48WzVwmsz+8G9sbiqCEcv561SGNgQmqHMtRaps
         OcZ3081EIdTBRNIHuSoOnvkgoZ+KvCUTNY+TADO4S+KxNDXYtr5dR8rfsY7+CP+Bu8Ch
         AbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icmQtzGW1I9aNeYIPHd+HyscMc2NTbBX1tevUyNL3tU=;
        b=RLmMsuvQPkL0trrJI2CELi0y0oeH25i/cBn9DXiDT58d77M+Na4KXxG97rvVsvuVEW
         akz0LvSlMThI4ED76ETK3GAfPo+6vVIZ9lTdT6MYDWesJnGy+YlWCSsr7gAROqp9sLgz
         AW6BdBaTjQd/qDwOrDC+6DSAPyhSHw/WHzBw9M6iW6wKhE4iuI39nmbXP4wZBGPJccbB
         dncI/o0IZrMEfxsR0hG4zbisQ03ZzH1lGMhsU7ouXKgWzdbMVvJM5Qx0RY0xyFf8bSwz
         zqxf/3sEYlHJlLbRCo1ob9PQ/pQVs0eytOD9RMf/BZFErRodaH6ZG1/IUWwy6NWaPuvw
         HqwQ==
X-Gm-Message-State: AOAM530TnD91r3yib/4mtHH0UGnUTLU8G+7K3JFycVhYbPo4Gt6sLeS7
        UiCK90i07AsCevkYYCMFq5ziDuyPSc9ywOULONz3
X-Google-Smtp-Source: ABdhPJyfYzVDUPCTtoyl0f5n4SxXJOTmC1gt1NZj33+zrO4ynP1olm0Bwx0j0M4Az/r6K1E6b9k1QSdeoXTTaK51Zfk=
X-Received: by 2002:a17:906:5590:: with SMTP id y16mr40139659ejp.286.1634128473086;
 Wed, 13 Oct 2021 05:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <20211004112623-mutt-send-email-mst@kernel.org>
 <20211005062359-mutt-send-email-mst@kernel.org> <20211011114041.GB16138@lst.de>
 <20211013082025-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013082025-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 13 Oct 2021 20:34:22 +0800
Message-ID: <CACycT3skLJp1HfovKP8AvQmdxhyJNG6YFrb6kXjd48qaztHBNQ@mail.gmail.com>
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

On Wed, Oct 13, 2021 at 8:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 11, 2021 at 01:40:41PM +0200, Christoph Hellwig wrote:
> > On Tue, Oct 05, 2021 at 06:42:43AM -0400, Michael S. Tsirkin wrote:
> > > Stefan also pointed out this duplicates the logic from
> > >
> > >         if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
> > >                 return -EINVAL;
> > >
> > >
> > > and a bunch of other places.
> > >
> > >
> > > Would it be acceptable for blk layer to validate the input
> > > instead of having each driver do it's own thing?
> > > Maybe inside blk_queue_logical_block_size?
> >
> > I'm pretty sure we want down that before.  Let's just add a helper
> > just for that check for now as part of this series.  Actually validating
> > in in blk_queue_logical_block_size seems like a good idea, but returning
> > errors from that has a long tail.
>
> Xie Yongji, I think I will revert this patch for now - can you
> please work out adding that helper and using it in virtio?
>

Fine, I will do it.

Thanks,
Yongji
