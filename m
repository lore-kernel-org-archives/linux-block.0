Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80370C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 21:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B33761100
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 21:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhIGVwb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhIGVwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 17:52:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC46EC061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 14:51:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v123so238936pfb.11
        for <linux-block@vger.kernel.org>; Tue, 07 Sep 2021 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nH3SqLmAKa3QWhENQjm7ZyMx9P53ELeJFuPULFmwmYg=;
        b=H7ZXRbXJljXrnm7cpoNZs5C+c9wExgUpPuj/CYPEnCc1wRRAv2naufSWcsOXTrVW/d
         vnYpWgfBT7XaQfPQVMOQbw7+HpeneZa8iUHvLjoZMHvMVG5/CM82nDayw5bXVpgV4OZP
         yO15Fbf1e4bfySK68wfNbxw5iI7V5XmQd/o048kGQhlurWUzYO1Zo5YhhnTh1NUiw3LD
         nTKT7BHPGtyh+X1NzOQXOnjqKOhg5uUOg9q3Jw09KT9tq8xcjLahK0MAC4FkNwTrliqJ
         z/UqHB4cFNopNo0FrV1oBUo05bViYzkGxmajLwj/lu18YCL8uKeujSVBMJSDXQrJv9C9
         /0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nH3SqLmAKa3QWhENQjm7ZyMx9P53ELeJFuPULFmwmYg=;
        b=I+Q8LrHx4dW0m89F0p3H5DoOk3hh6QKBiGMX/xHbMWJH6RiH3rX5eL1IN1ImCQYf5G
         cH9imKKUvxAalTDAkEwzh45zbeDGQ8CLVYC5R9yWTaUD7/Fk3E6DifrPR2sDKDbUeVi2
         PfgKK/kVtwiNqmpM7kqZMOwrpZjSc4cwujDji2baH1zUK4UJqmmS8SiIc7xYtbrumMqs
         n73qQEGWHAL4W7wT6ca+3RRvtz8nRBR1/esZBhAfRBIFLvpl1RMiMuwdIW3utIUqZn28
         g7iNnwsx2+LP8pk+368fAeBk3GqmOzeAJzLuoPV95e4SDbSmuTe28UziCpdAYlewA5zx
         mxUw==
X-Gm-Message-State: AOAM532eOszZkHXrATAMeX7a5QAbh9novEndJv/x2pClvo/ThFkt3b/z
        rJXENz6ombIeJ+AJu40Z/HiR0w2ilt9hhOU0/qJD66W9u6NrFQ==
X-Google-Smtp-Source: ABdhPJzQticURzEC6ZLKZtTPD54GWwOq15jx9XDgxfpkM7tKK6zddBBBLCDi1Ojta7RO11Q1OpJhX/OU8U5AxHAKFfM=
X-Received: by 2002:a63:1a65:: with SMTP id a37mr430496pgm.338.1631051483193;
 Tue, 07 Sep 2021 14:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210906215745.1992-1-phil@philpotter.co.uk> <YTb7f+P/HzeAJDek@infradead.org>
In-Reply-To: <YTb7f+P/HzeAJDek@infradead.org>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 7 Sep 2021 22:51:12 +0100
Message-ID: <CAA=Fs0n27T5UF2PdhZjrw1wLx_ym6MwA=fNmU9v9gDk9NwtaXQ@mail.gmail.com>
Subject: Re: [PATCH] cdrom: add linux-block list to uniform CD-ROM entry in
 MAINTAINERS file
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 7 Sept 2021 at 06:41, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Sep 06, 2021 at 10:57:45PM +0100, Phillip Potter wrote:
> > Add linux-block mailing list line to the uniform CD-ROM entry in the
> > MAINTAINERS file, as this will help submitted patches to be seen on a
> > list that is more focused without the level of traffic of the overall
> > lkml list.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you Christoph.

Regards,
Phil
