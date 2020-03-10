Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F832C10DCE
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 21:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFF32253D
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583876425;
	bh=2+jDH4kDyuHQzpzFEB7OLFpaoFg+zPVBPm0XhdjGSIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WlvFYVIxS8AoESnLQ0DG8vIC1tG4qfzggwlYbwSOJR0AUzeW0oRaiWeNmok3LlCcw
	 tpFu+VfZq/Fw3KaEJocj7xOSWJKNExJv3iUv77HDdQEdQycVkZpfBEHTpDNbeUwxkr
	 dozZc40oVnynRRVD4f0PkMxvUeqwnLcZkVlwEYP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCJVkV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgCJVkV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 17:40:21 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296F7222C4;
        Tue, 10 Mar 2020 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583876420;
        bh=2+jDH4kDyuHQzpzFEB7OLFpaoFg+zPVBPm0XhdjGSIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g+kyGN2TSnZAY2YysV5uxYbL62/eIXhhTjzlw03MpPtCaHRYMMbMZxJep7q6XKLSJ
         AeWq6OoOotR/RGD4lXtx2IeMHYbvd8RqR5ziAwC2097ZRwQk4m1iY5XV0InpiQT6cZ
         buiEtZK9C/UCPMq8bUKa8aXvHFgmHV9Vqsubmk48=
Received: by mail-lj1-f177.google.com with SMTP id g12so3667197ljj.3;
        Tue, 10 Mar 2020 14:40:20 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3e5UAKSnngdj1JoneI0aaHP/xHKlXbSyoOFUu9eOTt0Et1Ya9c
        560ArSPQOEzvkn83gT2IHJ1UBB9biC03kxTLEYk=
X-Google-Smtp-Source: ADFU+vtILP3spILDIllI01MAqsStV3WJqlRqXX/qau7gyy5AXdBFui1+JVKYKhGUgEewWYU9uUPVpSVmmokl/oZ53sc=
X-Received: by 2002:a05:651c:1182:: with SMTP id w2mr119990ljo.235.1583876418295;
 Tue, 10 Mar 2020 14:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <158290150891.4423.13566449569964563258.stgit@buzz> <7133c4fb-38d5-cf1f-e259-e12b50efcb32@oracle.com>
In-Reply-To: <7133c4fb-38d5-cf1f-e259-e12b50efcb32@oracle.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 10 Mar 2020 14:40:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6xJeX3=0j69_hdaUnYXPm7VeaXHB06JM=fRZsxPweQng@mail.gmail.com>
Message-ID: <CAPhsuW6xJeX3=0j69_hdaUnYXPm7VeaXHB06JM=fRZsxPweQng@mail.gmail.com>
Subject: Re: [PATCH] block: keep bdi->io_pages in sync with max_sectors_kb for
 stacked devices
To:     Bob Liu <bob.liu@oracle.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 2, 2020 at 4:16 AM Bob Liu <bob.liu@oracle.com> wrote:
>
> On 2/28/20 10:51 PM, Konstantin Khlebnikov wrote:
> > Field bdi->io_pages added in commit 9491ae4aade6 ("mm: don't cap request
> > size based on read-ahead setting") removes unneeded split of read requests.
> >
> > Stacked drivers do not call blk_queue_max_hw_sectors(). Instead they setup
> > limits of their devices by blk_set_stacking_limits() + disk_stack_limits().
> > Field bio->io_pages stays zero until user set max_sectors_kb via sysfs.
> >
> > This patch updates io_pages after merging limits in disk_stack_limits().
> >
> > Commit c6d6e9b0f6b4 ("dm: do not allow readahead to limit IO size") fixed
> > the same problem for device-mapper devices, this one fixes MD RAIDs.
> >
> > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > ---
> >  block/blk-settings.c |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index c8eda2e7b91e..66c45fd79545 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -664,6 +664,8 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
> >               printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
> >                      top, bottom);
> >       }
> > +
> > +     t->backing_dev_info->io_pages = t->limits.max_sectors >> (PAGE_SHIFT-9);
> >  }
> >  EXPORT_SYMBOL(disk_stack_limits);
> >
> >
>
> Nitpick.. (PAGE_SHIFT - 9)
> Reviewed-by: Bob Liu <bob.liu@oracle.com>

Thanks for the fix. I fixed it based on the comments and applied it to md-next.

Jens, I picked the patch to md-next because md is the only user of
disk_stack_limits().

Please let me know if you prefer routing it via the block tree.

Thanks,
Song
