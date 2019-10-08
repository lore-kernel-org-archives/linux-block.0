Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56360C10F14
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 13:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E1A21721
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 13:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpNkJzNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfJHNKC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:10:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32937 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbfJHNKC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 09:10:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so17486289ljd.0
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2019 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0gdPcTc9zTKpPnIXX5UADO12BmOdj/TTDu8J1uJCxc=;
        b=TpNkJzNpX3asPIkb/R7MbcmJcw/gjiY1UPqD3gFiKk2/w/lVy/m7OUlS3Nd6TRRdyC
         dTKB/4oQu+dtfHLzOvGodHMdDHWLh1cWO2aH51jGCgK+5eZZbvlX+XRHjkvD9YUvs8eJ
         Xi6ChnJFIEX01j1f579ohF+nvwrjdBUGNZmo6OpKh9t29FlB21fSR7LQudDn470PmPSu
         ILlhMm0wTijqLnTbVczSuK1Rgfuck5tbNdPOSgjqoUa5UKR4vkOrMgA/QgBlshhz5NW5
         IQCkeT0nxvKQ/8iK9C+HM4Xsc9Z99YHuF2WkjoMasRji6fpvvLSiwZM5TuN5fbHOyf6m
         LB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0gdPcTc9zTKpPnIXX5UADO12BmOdj/TTDu8J1uJCxc=;
        b=pZEmpP91M+EyarKHPtAB+0UtHRbAYFWh6o1dw6ocdISrfoSRp2nsNOMdESHVoNPIvK
         ylQLksuduirOCbS9DCPkprklavYooBkwKJZ1rIVZySeRzyrJh4WWvN6U3hsss/04VCmB
         FWf7QFWAjK3lAEi31ZLgYmmrcFRkuy8RnXrxrg5GbfIhqsu0HRogdhvkfl7hhp6B89XW
         ez/A6yFum7zpWN/Ij7RJWcqnOW+65iZQYTyo4Mx6mJHJDQKX9FswYhuqsmE5ocmt628F
         io50J62PAGvpdL0MJozELwlElqNX4ApcIP08aN/AKh0A7h/Xvd4RMh/NvWuLT0rjuG80
         K2iA==
X-Gm-Message-State: APjAAAU8DtxYgL+l/LgPHIYRtpr6DA5EuG17i6m5prfLdkZ393JZbk1n
        CtGV2pkochBkOkCZlWi2aqsu/2qumueI/SwA7yI=
X-Google-Smtp-Source: APXvYqz4MPUnnMp86pxbd3R1Ul0iFk0TZHr2Krq5DKCi3qSzTQGvAbOGb/F64j3Xk12nX2qoIJEvBaLce2wbVqvb4sk=
X-Received: by 2002:a2e:9118:: with SMTP id m24mr2655213ljg.95.1570540200262;
 Tue, 08 Oct 2019 06:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191008125357.25265-1-9erthalion6@gmail.com> <CA+q6zcX1EiFVR8W=2rcFdb3mSRC7D+bfV44UeL5VFAvy2FEdvw@mail.gmail.com>
 <b86e5648-9464-1f1a-0faa-15b489fda26a@kernel.dk>
In-Reply-To: <b86e5648-9464-1f1a-0faa-15b489fda26a@kernel.dk>
From:   Dmitry Dolgov <9erthalion6@gmail.com>
Date:   Tue, 8 Oct 2019 15:11:01 +0200
Message-ID: <CA+q6zcWqWAWG7UqzOekEH71XGUb24WpmJqe9juK94C4wq=1xsw@mail.gmail.com>
Subject: Re: [RFC v1] io_uring: add io_uring_link trace event
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Tue, Oct 8, 2019 at 3:02 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> > If I'm missing something and it doesn't make sense, then I would be
> > glad to hear if there are any best practices or ideas, and in general
> > how to look at io_uring from the tracing point of view.
>
> I think it makes sense, and in fact I'd encourage you to expand the
> tracing so we can get better insight into io_uring doing what it should
> be doing.

Sure. I was investigating this topic for some time, and hopefully soon I can
prepare a patch with more intensive tracing for most important aspects.
