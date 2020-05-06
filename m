Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7D0C47257
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 09:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EFD20753
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 09:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="rjnasmRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgEFJ5p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 05:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729037AbgEFJ5d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 05:57:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1573C061A10
        for <linux-block@vger.kernel.org>; Wed,  6 May 2020 02:57:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a9so806850lfb.8
        for <linux-block@vger.kernel.org>; Wed, 06 May 2020 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IciAwSgUVdB2/0PlCfDzeZhlzx2IzeWzIis4PFV64U=;
        b=rjnasmRUS1qEdjQp+ja6ha+agOWNjFUJ0msq1PCXadJGzv7jxsQw6WX+NoEgi2nRWQ
         KCdRe7egxySgra2xJjU2E/AXfi0H7SNJVzEGctfHwMYVzWtkPFNj62uxoq3xhoRsr1Nb
         r3OhCQW9bCzOSwwCvogQnjH0NHyzKOXeCsqr4Qha1IkNlOFtq9X1SnfpNQqWE+MWQdKv
         G3UyZzqao+FN4/VlQPr4Jy/EyIAFIKuihtkJ0swRQTBVAVUNmgGrTF1xtH4wmBwyCus/
         S/+wx9Wl1EaSF62yyCN0rVRaw4bmGSaj//EWLvwNBXkV5M7+adjdhIC/5VMpESg6YA1Q
         27BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IciAwSgUVdB2/0PlCfDzeZhlzx2IzeWzIis4PFV64U=;
        b=X56g99IhE0vE84fdrIxY69/LmpAqVqLELku7x2iCq9fFrjEw3nGAedSEtDa3GuE2q1
         I2OZ7A4EG1QeHoJw+3cn2IjTCpX0JxhI+6qjtr/ISkD7rOt9H06Wg+6B5T9/uiHCObiU
         +mhYpxtAuSSinEqBOwKtFTQgmeeytVRydOUyD0GbnrWT6Mg+bmUYcSk+xKgZTKoo7FJA
         CpHGWvdi8YQHvfC5J+/SU2uMAUpmE4Bn1z+uaq5LiCa/q7MwJwCR9Px5Ewm50AWa7QI3
         0F0Q8038ZcIRbhwC/I93tD6tvOgUUvExKTEWWXoYr90JVPdHDVhRdinShb1T/4AsEhTt
         vyVQ==
X-Gm-Message-State: AGi0PuaQ3//nNgtb0GiBf7bmIZia4LXzm4XkXTCbhqfRBEX/D84WWd8c
        42bFjL+ybGaI5Q5P+DWgv4Ei2xvLrnt1ivApupuAYA==
X-Google-Smtp-Source: APiQypKjKckRZENGEavMmGfKLuKsPiGZebpMxZI0LFDcf1uG4zlU1bqJhKI4tYpjLuic788pKPSvUVEiOIwiVaqSoXY=
X-Received: by 2002:ac2:5988:: with SMTP id w8mr4606822lfn.75.1588759051401;
 Wed, 06 May 2020 02:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
 <7d73bafe-5228-b02e-5b53-4a41543aebe3@gmail.com>
In-Reply-To: <7d73bafe-5228-b02e-5b53-4a41543aebe3@gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 6 May 2020 11:57:20 +0200
Message-ID: <CAB0TPYGKmbeNt94CSMhXd0EuFpSM14DEYAwoGdhY79s=H9o1+g@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 6, 2020 at 11:44 AM Michael Kerrisk (man-pages) >
> Can we have also a patch for the loop.4 manual page please?

Ack, will do when the series lands.

Best,
Martijn

>
> Thanks,
>
> Michael
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
