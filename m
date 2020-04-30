Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092AAC83002
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 06:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FE620784
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 06:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="QRvMrhdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgD3GnP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD3GnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 02:43:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B32C035495
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 23:43:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so5383861wrv.10
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfLKPd6WdwwFQZMqYshsvE6IdIFdc2Vgh7Bb3+Jqfik=;
        b=QRvMrhdyxAmtsKtLU5lwSwPavpXqMbzey9WokLc7dB5ct6lPUIPGKhIdx9RJCLWfMS
         1VlIo5KWPZPsJ3KVU20Rtpt6pbCuDdkLEi8T8oqWhVbm0sAsX9R4OOmaQMnDreHCOvLQ
         qp0tY5FV5vxVeeJrjqmDhHTAh52d4CjFIkhmhm8n99NnGv8ZPEX7c7yEs2Q44kWqibS0
         2x1cN7BJ48LiI3Kemru2kDpYgCy7hBMu1eXtDUJxu8EeUP9baGi3I50GqH3VCC2uwDhG
         O3/ljnECBXzDIDIg9CTgCtlASko1AqC28we+6yAxeOsuAn2a/0439z+2ytS3ELUv8NZ9
         tIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfLKPd6WdwwFQZMqYshsvE6IdIFdc2Vgh7Bb3+Jqfik=;
        b=t90pC5QWVwaG8/xrFw1CPMi2BBoqUEmdT98Bptd2UW6UEEagNM6trzUlT/hXCyhU8L
         +fyNa2NTVRpjwClYxxXsfW6E3qG0frzK6i5GqL7jLP1fPcxSbqcpeh9sVl/atncEZqrc
         REN4O1CZl+gSLEMgLtviuvSQSXr5vC0Er5OZe6Snj1/vGxly669Vb6EFwBz1LsKkkDi4
         7eyXIZSq6oBTsJsjTHuhW9O+E+Jz5WEc5BtNpP3kzSN9NQhN4qDAhOayf99joukEV55F
         wopJLIEBbl411rAhUbDk8WNRIhqU3MS/5Py1VQmxxcZUw2yLlNX5yw8OpY70rXRlcQ3M
         veqA==
X-Gm-Message-State: AGi0Puaem8ewtLDzrE8u2x0OZWar661vgSuR2cCjEKSKwqIEY7Czs3QG
        rACPZRgTf9r7lMqSgu852Zxd6IHVtMcf/6O4iQGx
X-Google-Smtp-Source: APiQypLGfEl3giFfsoU/P6XTGhs3BHM5vTrm5Gava6IXSWX5Q8m8RHTDn32FvpFYv6r0345z9rRdCS7ET9tjtWz4VKA=
X-Received: by 2002:a5d:6841:: with SMTP id o1mr2039673wrw.412.1588228992516;
 Wed, 29 Apr 2020 23:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-20-danil.kipnis@cloud.ionos.com> <20200429172018.GG26002@ziepe.ca>
In-Reply-To: <20200429172018.GG26002@ziepe.ca>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 30 Apr 2020 08:43:01 +0200
Message-ID: <CAHg0HuxO+6+on6g-YRmMK8z_n7g1E7gd4fndmUb_w+A8mqBeHg@mail.gmail.com>
Subject: Re: [PATCH v13 19/25] block/rnbd: server: private header with server
 structs and functions
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 7:20 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Apr 27, 2020 at 04:10:14PM +0200, Danil Kipnis wrote:
> > +     struct idr              index_idr;
>
> No new users of idr, use xarray.
>
> Also no users of radix tree if there are any in here..

We don't use radiy tree. Will look into xarray to replace idr. Thank you.
