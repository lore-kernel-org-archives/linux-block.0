Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F86AC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 12:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9532082F
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 12:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEf2Xflo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfBDMbO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:31:14 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40999 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfBDMbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 07:31:13 -0500
Received: by mail-ua1-f68.google.com with SMTP id z24so4386158ual.8
        for <linux-block@vger.kernel.org>; Mon, 04 Feb 2019 04:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8tchKSQ8A4JfUDepfvG6phf89ctnL/Er9RIURtyhSE=;
        b=WEf2XfloAWq2UGe8nn5NPm1wZXCmNNd1xvxITZyx54IX3B1XqMhRtRiG5v0150S7dO
         hNdT291kUs5cZECxmktAs8qa6NlxI7gvhFFdx5fPtmbmMx72Ockgl6Aeg0JtEyDph9Mx
         uvtOESU1EVgVL47YmHeGfeVFOrFRUmWhDKccQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8tchKSQ8A4JfUDepfvG6phf89ctnL/Er9RIURtyhSE=;
        b=KDio/sU/BeOgtdltdLQb9xQQG82X/y3oaEYXYlyUQwzvYGV8eUyBUoG2TF+/ldqaUN
         Dm+G7p+DkBXVKBK8/GtX/u0pVj5NmpTHorvylZbzG9a7M849akaO7jJByUiZSn3rAxNZ
         iNrrEN1AaxojAxaU/XoMGZasdqVjbHbHgfHfCMGrFyaBNOscf6d1vC5FmrnExyJAeQGw
         IiVwuD6UZoZZq5YFrG8vyFyLmeE0BGlRaBgsrjmgQdtjEL6rfEf1HYocgeXEwyuzU/D8
         2SpAaAwLrYeJyfqN0iv0PdENJAflamfB3q+56ZSrrnkj1OYE2O34m1QzL6gARf33Xw12
         3VQA==
X-Gm-Message-State: AJcUukd9gJVQ3DUSt97syThqISMwTaxTueEjvbZEl5Sms2LyFwlnxyo9
        NW6Krd5kLQ2AW5tYe3L8zaFXirQ1k8yG2EQ28AOFcA==
X-Google-Smtp-Source: ALg8bN5zWof3qhKj4R1JhQ+mbWK/n6cpC/kScdQypSenSoSqBSS1FvqCbEb4/FC+4B29RrKXnEdsBWOgi4Wxlpq0lDA=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr21841847uan.107.1549283472819;
 Mon, 04 Feb 2019 04:31:12 -0800 (PST)
MIME-Version: 1.0
References: <1548965800-3080-1-git-send-email-zhays@lexmark.com>
 <CAPDyKFpcmyKnF-QPBV1vbTfGdSYN30GayZSA5O9Gm_EbZjfdAw@mail.gmail.com> <20190204082527.GA5953@lst.de>
In-Reply-To: <20190204082527.GA5953@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Feb 2019 13:30:37 +0100
Message-ID: <CAPDyKFoB+BV-ea4ctYixoJJvY=5f-NMm29iSTRTo5xbzKaPLgg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: handle complete_work on the system_highpri workqueue
To:     Christoph Hellwig <hch@lst.de>
Cc:     Zachary Hays <zhays@lexmark.com>, Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 4 Feb 2019 at 09:25, Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Feb 04, 2019 at 07:24:43AM +0100, Ulf Hansson wrote:
> > > The above results in multiple hung tasks that lead to failures to boot.
> > >
> > > Switching complete_work to the system_highpri queue avoids this
> > > because system_highpri is not flagged with WQ_MEM_RECLAIM. This allows
> > > the host to be released without getting blocked by other claims tasks.
> > >
> >
> > Thanks for fix and the detailed description to the problem!
>
> I don't think this is correct, though.  If you think of the swap
> (or memory reclaim of file backed pages) case on mmc, completing
> a mmc request can very much be critical for completing that memory
> reclaim.  Thus we absolutely do need a WQ_MEM_RECLAIM workqueue.
> You probably want to create a private WQ_MEM_RECLAIM workqueue in the
> mmc code for that.

Thanks for your input!

Although, I am not sure why having our own mmc workqueue, would fix
this problem. Couldn't we hit the same kind of deadlock anyways you
think?

Kind regards
Uffe
