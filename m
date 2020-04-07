Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B30DC2BB1D
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 10:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEA320719
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 10:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ei665XDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgDGKJf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:09:35 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:34606 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgDGKJf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 06:09:35 -0400
Received: by mail-io1-f52.google.com with SMTP id f3so2795220ioj.1
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2020 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etruzh97g0ePi5MmdfaX16wSZNVsPuUhCD3aCJkNyvU=;
        b=ei665XDJSqRPqhUale0X+Rdo779B/wRmekCejkih2NFpIgu5Wmje8Zdbs25btA8GH4
         BTsA6J2TZqH2J8UKZFeRXtR6mO4oW43tpck5GF1+aqTLQKg7iqzOQv3UksTcnph5gRz6
         tXk6Ojx8Lpxhx2DFh9PvnVUAWoPDO4kbayF88LGrAgtnBJZw7kK5WuY+NoPJ5Y1MIjTQ
         sKpLDESbpLj2IBl8+sM++ErRWHfq46F4YA8KziuKDes5D0XzE0+kzKsgdFOzPvPWJtxA
         HCYyq/ZKqKBXtGRke94W6RUDK/kN4mP+3ETdDo44t9blugH9itPF3bBPZ8gKwaXrSbLh
         Zjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etruzh97g0ePi5MmdfaX16wSZNVsPuUhCD3aCJkNyvU=;
        b=OfMEkxkNJ8voW3d08A0uGhfjqbnXDzpXLtMeIAdDMlBVtqi62RwsG6G9EVyvbb8krC
         oC3t1sgdf19qj3G+w+4XBrVVB0eRNq+0FojOsuZ5r6T7IKaPBOIlQUPrc9ldHZmMHQmO
         UGbxMM47Yy/Ue2ef80Xhmsas0PzrOpNaNMCT7mzUn3XInKlnMElKKDVeWG0oY7tIDymv
         r+29dAIgK7ldE7jex8U7FycVKMEoMkIdDaLYhxAii+P3zJ0d6Hj/jsS2uPPCzOWbc2NE
         5h7q6Ee/TB/vaJavfEqHTvc+AmnN7lz89vq/sPo74bc+hBziNbOwkIs5wwNkKdIiZD6G
         Dtag==
X-Gm-Message-State: AGi0PuaJJ6y3r3lK8RZF0WbnDzj7z7BvEHEKG1r2Pq5xQNMlmKu/4rve
        /Zf6HNb0AR9gG6VrlINwOij8Kw7+ZpaihQHbigxG
X-Google-Smtp-Source: APiQypIEn5fh7xJK0NbGcbZJR9Ul083PzmnN8yrz4AopBK405wrAjxXASIKwAWouEPsisisaGVm0sMwJDYBlQLeI5Sc=
X-Received: by 2002:a02:55c5:: with SMTP id e188mr1156940jab.57.1586254174040;
 Tue, 07 Apr 2020 03:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200406232440.4027-1-chaitanya.kulkarni@wdc.com> <20200406232440.4027-2-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20200406232440.4027-2-chaitanya.kulkarni@wdc.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 7 Apr 2020 12:09:23 +0200
Message-ID: <CAHg0Huz0sy7u0=eM40ca1ye6mBgVjDscx=9kxQKViN7dm51crA@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: add bio based rw helper for data buffer
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In __blkdev_issue_rw():
> +               bio = blk_next_bio(bio, nr_pages, gfp_mask);

Doesn't this already submits the bio even before the pages are added?

> +       error = __blkdev_issue_rw(b, buf, sector, nr_sects, op, opf, mask, &bio);
> +       if (!error && bio) {
> +               error = submit_bio_wait(bio);

And then the bio is submitted again in blkdev_issue_rw()...

Or do I understand it wrong?
