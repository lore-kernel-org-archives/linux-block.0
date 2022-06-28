Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B60C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 16:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiF1Qkg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343618AbiF1QjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 12:39:03 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4362DA8F
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 09:36:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b125so10056209qkg.11
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9e+KJ1EtCj7X1qzaa/XINtZDFLFaX8Iti/jKpVWCt8A=;
        b=o3YnquN39u6amo487l0h0NBXyMnsnmaZDUv6Y7CLrnXETp80URZZsKCjDtTeB8hUTM
         KTAU5SzbZGy+NXLmHKvO6nmuHuYwh0oZV09VZLiqjndCr3keuQnYXwao69q2X+IJq2HL
         XWWhh9Q9qspVWA5LotXJ3aYk1wBwRXWIrC+BTqJxHJy9ynnyIbPiaCSIiC/eehOlMNd4
         u++MXGjEn11XKOMgjD4MBOJEnHznaj+4WQsx8FMxL2IRWPn3WPRnhWujY9/3PKXlInfl
         DhY1LHu3sG/IxJ0cJAuKehLEq0Qq9aKuHwcReTEPq442+Wi3rPfeVKuclK5N3MnTXh77
         ib3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9e+KJ1EtCj7X1qzaa/XINtZDFLFaX8Iti/jKpVWCt8A=;
        b=zo1kMgIBdcHBuFse63zbIrxobmTCywd4H0fXojrB6Vjj24+H/shfcgi6zZNZs3YsjA
         aic02O3QplAT48kWDRcL86RrfFobnobqJpRg7KA65g0Uj1aXzyHrdPpDtslZr/oNSkBV
         DLv4XF4zZ/a3sTJ1EOnu32axUnn4cvOHa9prae3fVpuXNHo9iSg0dYyDvDuqRKQ+mbud
         oBsEatsMlutiwyWVNn8CmvtTQcrSV8vF6tqtWdMF2TOMsho66UPTdqObsQUp0rQhtiTk
         u/bp57G9Zq+N59FoBjzeGumVaj5Osp7tdgP0ND8LkjfEpk8Y+xV/XPQv0INog2xG1Zk7
         bh1w==
X-Gm-Message-State: AJIora/LsccySWRWsSC6N1V5q44gh1lpH9cWIBrAw6j9kiMRQT1OsGYk
        1UKWqPmRkT1P+z8GvDhs8v9CvRYYXAvlQjlREw==
X-Google-Smtp-Source: AGRyM1tNpAGEEdEMGkjXEOmgtNpPakBy4hStxfmQs1s9zd6Eq0cYY8rKNRqc2WW1xRC6V+T6Fp92Iw==
X-Received: by 2002:a05:620a:2845:b0:6ab:8e0c:1938 with SMTP id h5-20020a05620a284500b006ab8e0c1938mr11939273qkp.315.1656434178584;
        Tue, 28 Jun 2022 09:36:18 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bm9-20020a05620a198900b006a73ad95d40sm11164011qkb.55.2022.06.28.09.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:36:17 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:36:17 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220628163617.h3bmq3opd7yuiaop@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042610.wuittagsycyl4uwa@moria.home.lan>
 <YrqyiCcnvPCqsn8F@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrqyiCcnvPCqsn8F@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 28, 2022 at 03:49:28PM +0800, Ming Lei wrote:
> On Tue, Jun 28, 2022 at 12:26:10AM -0400, Kent Overstreet wrote:
> > On Mon, Jun 27, 2022 at 03:36:22PM +0800, Ming Lei wrote:
> > > Not mention bio_iter, bvec_iter has been 32 bytes, which is too big to
> > > hold in per-io data structure. With this patch, 8bytes is enough
> > > to rewind one bio if the end sector is fixed.
> > 
> > And with rewind, you're making an assumption about the state the iterator is
> > going to be in when the IO has completed.
> > 
> > What if the iterator was never advanced?
> 
> bio_rewind() works as expected if the iterator doesn't advance, since bytes
> between the recorded position and the end position isn't changed, same
> with the end position.
> 
> > 
> > So say you check for that by saving some other part of the iterator - but that
> > may have legitimately changed too, if the bio was redirected (bi_sector changes)
> > or trimmed (bi_size changes)
> > 
> > I still think this is an inherently buggy interface, the way it's being proposed
> > to be used.
> 
> The patch did mention that the interface should be for situation in which end
> sector of bio won't change.

But that's an assumption that you simply can't make!

We allow block device drivers to be stacked in _any_ combination. After a bio is
completed it may have been partially advanced, fully advanced, trimmed, not
trimmed, anything - and bi_sector and thus also bio_end_sector() may have
changed, and will have if there's partition tables involved.
