Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC025C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 12:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE89F214DA
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 12:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1MKMdna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbfBDMx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:53:29 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33100 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbfBDMx0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 07:53:26 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so8414589vsc.0
        for <linux-block@vger.kernel.org>; Mon, 04 Feb 2019 04:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=falmGGWbTjlW++QiGUP8TIzJm41mxEmbqBMAE9DmBOY=;
        b=H1MKMdnaswW2680Ki5zHh9Zm9Zn/Sz7WGSdQlZsJhT9sQMtRQSYbv14ipRBnVpwP2h
         x4kn2cEskzF1VF6Vf2sUEuKA7SpCpQ3OhZj/aGt6EDRAid4wlnm9ZLJLmH1ZKM52U0zd
         LRPPLsDCl6izjXifIkLcHQoydUQjt715awp6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=falmGGWbTjlW++QiGUP8TIzJm41mxEmbqBMAE9DmBOY=;
        b=U9YTr7cNnePJkE+XhXkzQcbGZyIt+5kJ12DEBzxH6Pty9mqqrR114DkKMU15ZO9Ya7
         VKPm1yWjx6uN2a6o180EaP033uq5Gm20JpCb2olFtrM9qlsbJ2micKTp6Enz0ulQiqgi
         JJI3FVhCMSistufisEXcWoWA3Ci2Ulf8o/u0sX5MYT9ucBgxkEBL5GE84jG+oyH4z5C2
         2VTeOqjwDpPyd01LtCnI/SdCX/jVlyZzsIdFQ9F4nqDA3KkveTjZ8ODnjgoO8iWFGaog
         nqIcFZXpD5zZV5vdhTPMYpWX7IU0S9eOLIBM679OSC4yHtB7fh8dKgCy7jMnmT56ASUr
         jxGA==
X-Gm-Message-State: AJcUukfVzPGHdycrIBDApLW+SG7lIUWZySjEclgCreBgDs+wnIBRsBVi
        x4wmtZo/6NdBLiECrXQ6zBNcc38ee52t5VAtnNk21A==
X-Google-Smtp-Source: ALg8bN7RSlp61CI0RUA1xZTjo0xi5r9IGUACkZNwREw4spjwmdNRQERGxHrRzevnB16sHweXIxy1F+5EoNO33ooJJQY=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr19030427vsc.34.1549284805380;
 Mon, 04 Feb 2019 04:53:25 -0800 (PST)
MIME-Version: 1.0
References: <1548965800-3080-1-git-send-email-zhays@lexmark.com> <CAPDyKFpcmyKnF-QPBV1vbTfGdSYN30GayZSA5O9Gm_EbZjfdAw@mail.gmail.com>
In-Reply-To: <CAPDyKFpcmyKnF-QPBV1vbTfGdSYN30GayZSA5O9Gm_EbZjfdAw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Feb 2019 13:52:49 +0100
Message-ID: <CAPDyKFqmZGzbMEuumLiv_RJm-9ESZPoCuYZSkPAaM9S4wzsEvw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: handle complete_work on the system_highpri workqueue
To:     Zachary Hays <zhays@lexmark.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 4 Feb 2019 at 07:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Jens, Christoph, Adrian, Linus
>
> On Thu, 31 Jan 2019 at 21:16, Zachary Hays <zhays@lexmark.com> wrote:
> >
> > The kblockd workqueue is created with the WQ_MEM_RECLAIM flag set.
> > This generates a rescuer thread for that queue that will trigger when
> > the CPU is under heavy load and collect the uncompleted work.
> >
> > In the case of mmc, this creates the possibility of a deadlock as
> > other blk-mq is also run on the same queue. For example:
> >
> > - worker 0 claims the mmc host
> > - worker 1 attempts to claim the host
> > - worker 0 schedules complete_work to release the host
> > - rescuer thread is triggered after time-out and collects the dangling
> >   work
> > - rescuer thread attempts to complete the work in order starting with
> >   claim host
> > - the task to release host is now blocked by a task to claim it and
> >   will never be called

A second thought about this.

Claiming and releasing the host, is a bit special managed in case the
claiming is done to serve a block I/O request. The mmc host is
actually re-claimable for these cases, which is needed to allow us to
operate on two I/O requests simultaneously - for the same mmc host.

mmc_claim_host() shouldn't even have to wait to retrieve access to the
mmc host for these cases. So, it's a bit weird that you observes this
deadlock/hang.

Perhaps there is a problem internally with __mmc_claim_host() and
mmc_release_host(), that we have overlooked when we introduced the
re-claimable host for the block I/O path. There is a wait queue in
there, perhaps that isn't working as we expect with this scenario...

> >
> > The above results in multiple hung tasks that lead to failures to boot.
> >
> > Switching complete_work to the system_highpri queue avoids this
> > because system_highpri is not flagged with WQ_MEM_RECLAIM. This allows
> > the host to be released without getting blocked by other claims tasks.
> >
>

[...]

Kind regards
Uffe
