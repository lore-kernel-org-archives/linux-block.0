Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56883C433DF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 13:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D43F2068D
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 13:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgFANsJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:48:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48949 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgFANsJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 09:48:09 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1jfknO-0001qI-MN
        for linux-block@vger.kernel.org; Mon, 01 Jun 2020 13:48:06 +0000
Received: by mail-vs1-f70.google.com with SMTP id o2so785720vsq.18
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2020 06:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOD+hiipePIQdgLXiYnSbZNLaVWpVaybn1eHM+lji+g=;
        b=j43qM1KAeUz/5HLj3+eH8qhqSQ6HzsrQsidXJQqqx9Lh3sRs5E0YNzJfn6s5Grzbcm
         jT7kkLD5DgEO2o4T7c6lzcW6RTg18U/8vG4ZqiVVPGylV+XIjlOhsjpEIAh06EQdoYgu
         vow9kM1GvUtUr8mF/Z0VB+BE4ZAd7zRxLL+5wkBPEuu8gsbwFYk54Gza4EHgIFKeUo6x
         XOnFYlX91+LVoVIMu2Msen0fQ+PfZwYRhUYyxEcRtTY2qMB7oxR6GGb3gOgBofS1kRNW
         OazIT8xIkPryJGU1R0uXhi+pd6WmKGdpgEX70ibXnH+reUAZ2IiPr31nCFyBy2AljqZ1
         Nr7g==
X-Gm-Message-State: AOAM532x1jcUrREsP0MzfN7/qu/bw+iw6nf+I6PWesh6J4mraIEQqrjP
        HGWzRVdIefLM2g4S+Ey4p4cjiGwDD98wMyhlNsSJleA1+3JBIMTMrgcTUQBEooO2DybFUPgBZ6y
        l4RVLGD6+TYvbbZ7Xt3xdmfkS4F/K2tZ252mGjT+HrxOaxzGpIvKHIrxZ
X-Received: by 2002:ab0:28a:: with SMTP id 10mr14331370uah.131.1591019285376;
        Mon, 01 Jun 2020 06:48:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypOgkC7clHYIwJ5m7iXfzu89dL6ViuBwejeofSi+ZqpSBQF0mUDRq6oexlgDjF+JvKcYnPhZfCgy7rLYNXAj8=
X-Received: by 2002:ab0:28a:: with SMTP id 10mr14331352uah.131.1591019285131;
 Mon, 01 Jun 2020 06:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200601005520.420719-1-mfo@canonical.com> <20200601073440.GD1181806@T590>
In-Reply-To: <20200601073440.GD1181806@T590>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Mon, 1 Jun 2020 10:47:53 -0300
Message-ID: <CAO9xwp0mibE5_cpq4qaGtJBMBbouUf+jmJEQv7jF5DiL71CCjg@mail.gmail.com>
Subject: Re: [PATCH] block: check for page size in queue_logical_block_size()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

(sorry, re-sending in plain text; previous reply had HTML by mistake,
and bounced in linux-block.)

On Mon, Jun 1, 2020 at 4:34 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Sun, May 31, 2020 at 09:55:20PM -0300, Mauricio Faria de Oliveira wrote:
> > It's possible for a block driver to set logical block size to
> > a value greater than page size incorrectly; e.g. bcache takes
> > the value from the superblock, set by the user w/ make-bcache.
> >
> > This causes a BUG/NULL pointer dereference in the path:
> >
> >   __blkdev_get()
> >   -> set_init_blocksize() // set i_blkbits based on ...
> >      -> bdev_logical_block_size()
> >         -> queue_logical_block_size() // ... this value
> >   -> bdev_disk_changed()
> >      ...
> >      -> blkdev_readpage()
> >         -> block_read_full_page()
> >            -> create_page_buffers() // size = 1 << i_blkbits
> >               -> create_empty_buffers() // give size/take pointer
> >                  -> alloc_page_buffers() // return NULL
> >                  .. BUG!
> >
> > Because alloc_page_buffers() is called with size > PAGE_SIZE,
> > thus it initializes head = NULL, skips the loop, return head;
> > then create_empty_buffers() gets (and uses) the NULL pointer.
> >
> > This has been around longer than commit ad6bf88a6c19 ("block:
> > fix an integer overflow in logical block size"); however, it
> > increased the range of values that can trigger the issue.
> >
> > Previously only 8k/16k/32k (on x86/4k page size) would do it,
> > as greater values overflow unsigned short to zero, and queue_
> > logical_block_size() would then use the default of 512.
> >
> > Now the range with unsigned int is much larger, and one user
> > with an (incorrect) 512k value, which happened to be zero'ed
> > previously and work fine, hits the issue -- the zero is gone,
> > and queue_logical_block_size() does return 512k (> PAGE_SIZE)
>
> There is only very limited such potential users(loop, virtio-blk,
> xen-blkfront), so could you fix the user instead of working around
> queue_logical_block_size()?
>

Thanks for reviewing.

I can take a look at that, sure, but think the current approach may
still be useful? as it prevents the current, and future potential
users too.

Cheers,

> thanks,
> Ming
>


-- 
Mauricio Faria de Oliveira
