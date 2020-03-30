Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E619C2D0E9
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 10:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E5320578
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 10:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="c16+qdET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgC3Kol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:44:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38274 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgC3Kol (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 06:44:41 -0400
Received: by mail-io1-f65.google.com with SMTP id m15so17223842iob.5
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2020 03:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IbOGrt0Fj4NYF3EWqyfkLqlBUBr/YJhc4WhdXCsREU=;
        b=c16+qdETJIOPqlNcm3XubxoDAMMm3mNE4voViPIVa1hokryeKVGll1fIc941+NF8GW
         91j5rOlB38BJn6JI6Z8NRWJpA8Ax7q2trj/nKX0KVibkxqrKHF6eVTuc4cUybhOzeMKZ
         SCJAg5bat2oGIBj2b2SS/p2Lf8YXlObUqiNv1qwPT9S1D/+ypaI8WMrkVU5Vcy8l/hZU
         z7WnxkbOpFvk/GB2YZjHISOyq0qHbuEjs1IAxGaGIJhtVlwljXXqF1FkRTbWSzi1ig59
         oyANOQHxCNiavUVgNC7oflKTwbNgvl9nBKsKqwp+mN9TeJPj6W9GV4qjsllrhvJ/fsdP
         Vo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IbOGrt0Fj4NYF3EWqyfkLqlBUBr/YJhc4WhdXCsREU=;
        b=aomE0BQB88fcTWjgu2g1DiAzIY+uqDaODpuV09L7z8uP3zT4sYsrOkjDB4p70gufk0
         WYehQaiKCHv8o6hIhickSQO5mCsL1OFE4ObbmwTs9+wwkmhOeh6MDfNElPzDDqHePs0R
         8q/l/9+SciqbeH9zeoTtrfntPovhjbOfDllDXVkqXpS+cuBLEwqNxqlhpoOtYutGLHjq
         IFd3v4o7wIIE3GhGJyTh4GzQgiGCOfudt6AydEemBolCAYfTyn1+Vgi+01PsddXOjvmX
         jdg7O1y6CZlpm/OIKaMgL5PP4fIJI5+c9EKQen5O2bjt6mdMC7oOT67VslF7pJFfvyyI
         kgVw==
X-Gm-Message-State: ANhLgQ3rS1jmz4Ve0Xv//300Vfi4ToLhO7eZSacj9SZaAUX+lylnbxTv
        q8yw+z8Y2Ju7n1HycWNJIytj9CJ1HkpsTvySuLsrHA==
X-Google-Smtp-Source: ADFU+vsCHoOKRh0SdFhPaKogBAD9pBeQ4tUJ7zncCd/3GrhvRYbEGI8zfyXXSOROPGqaGwbwAkq2zJ0hO7/RNxOyQIY=
X-Received: by 2002:a6b:b70a:: with SMTP id h10mr10138917iof.54.1585565079727;
 Mon, 30 Mar 2020 03:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-16-jinpu.wang@cloud.ionos.com> <15f25902-1f5a-a542-a311-c1e86330834b@acm.org>
 <20200328082953.GB16355@infradead.org> <bbba2682-0221-4173-9d00-b42d4f91f3b8@acm.org>
 <20200329150524.GA13909@infradead.org>
In-Reply-To: <20200329150524.GA13909@infradead.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 30 Mar 2020 12:44:28 +0200
Message-ID: <CAMGffE=Oz+x8PCG3NK4Oo+Y1oDV70XbhSF9oVy8q=Z5+ZwnCGQ@mail.gmail.com>
Subject: Re: [PATCH v11 15/26] block: reexport bio_map_kern
To:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya.Kulkarni@wdc.com
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 29, 2020 at 5:05 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Mar 28, 2020 at 09:16:55AM -0700, Bart Van Assche wrote:
> > There are more users in the Linux kernel of bio_add_pc_page() than only
> > bio_map_kern(), e.g. the SCSI target pass-through code
> > (drivers/target/target_core_pscsi.c). The code that uses bio_map_kern()
> > is in patch 22/26: "block/rnbd: server: functionality for IO submission
> > to file or block dev". Isn't that use case similar to the SCSI
> > pass-through code? I think the RNBD server code also implements storage
> > target functionality.
>
> No, it is not at all.  The RNBD case submits normal read/write bios, for
> which bio_map_kerl is the wrong interfac given that it
> uses bio_add_pc_page.  Read, write and other non-passthrough requests
> must use bio_add_page instead.
Thanks for comments, Christoph.
If I understood you correctly, so the right way is to construct bio
similar to bio_map_kern, but we have to use bio_add_page instead of
bio_add_pc_page?

As mentioned by Bart also Chaitanya, looks it's reasonable to add a
helper for normal READ|WRITE operation to map and submit bio from the
data buffer,
but sure can be done later.

Thanks!
