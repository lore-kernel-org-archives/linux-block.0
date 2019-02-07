Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA20C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 15:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932F521872
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 15:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="n4pFB99G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfBGP1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:27:25 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53961 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfBGP1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 10:27:25 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so601420ita.3
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 07:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3fXOh7Vtpm+ljDTmRDGf0oFspFn1OGiKztfFcuq/Tts=;
        b=n4pFB99GibY8mdUbe3hD0fqlYFV/rEP89feTrEVyUrKB5fwBYZ5nqba6Zp8KJFw5D2
         2XZO5log9tB/mrShYZZDYfgT4K9wZpos8cucCBWfLp3U3TQI0smaWljtnsbrEGXse47G
         GuCkxrDKahQKpxYvLxg0sN9ZJg16BsZuE5oqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3fXOh7Vtpm+ljDTmRDGf0oFspFn1OGiKztfFcuq/Tts=;
        b=MF/bCuLbstaeHCX6FyD02BO7IQAiGfxHWTyFWaCEzW1IgLF/ayplHopu4LFLYlPO52
         pEEPSQkrnFDRqwIf/yIbTYNdoKdyz33NZnC9MLeDXi9stz7em5osbET+PrO2sUqKfTuG
         PFMZl2O8r1s6eOti2pIwTFrPSqP9vfn0O+man7bgRARM2Bzcrs/22qI+db8jDAlXHud3
         lV2LJwUS+elvH3N9aC11/D7g8SKHYgBfYmxpmMtrUfrdkUM+bKyFUaIihlKjtn42d6tC
         ol3iwBE/blLRWIJblaHLyWARHEpCUT8TPrIQ4ZFv1Iyy7tMhlTseOciJs9b3pMUfml2A
         pKsQ==
X-Gm-Message-State: AHQUAuZIASel54iOrxZ8xl/VZcjd5KztsiKv3KmQqpnXO166acN1/9I6
        7acb2BZWnRmUw22QYDfvDFO9HF6txrZoZnXmq8oJtQ==
X-Google-Smtp-Source: AHgI3Ib8W5h3+sAglw2na15VfxaNxbvlk0EoY0/TDSDK52bP1VSy6edgccyieSDQFTLIgZpixHpAXSS6FX56AKC+My8=
X-Received: by 2002:a24:a08a:: with SMTP id o132mr5836567ite.1.1549553244872;
 Thu, 07 Feb 2019 07:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20190204025612.GR2217@ZenIV.linux.org.uk> <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
 <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk> <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
 <20190206005638.GU2217@ZenIV.linux.org.uk> <8f124de2-d6da-d656-25e4-b4d9e58f880e@kernel.dk>
 <20190207040058.GW2217@ZenIV.linux.org.uk> <20190207092253.GD19821@veci.piliscsaba.redhat.com>
 <20190207133135.GZ2217@ZenIV.linux.org.uk> <CAJfpegutRaXZ8EC_Am_PomxwdmSoH7eQkxAewaLfUrMALjym-w@mail.gmail.com>
 <20190207152002.GC2217@ZenIV.linux.org.uk>
In-Reply-To: <20190207152002.GC2217@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Feb 2019 16:27:13 +0100
Message-ID: <CAJfpegvayM_ZmuVetfYzpK+qqZJPkVzfQVRQ7OO98f1=reqiYA@mail.gmail.com>
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
        linux-aio <linux-aio@kvack.org>, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Avi Kivity <avi@scylladb.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 7, 2019 at 4:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Feb 07, 2019 at 03:20:06PM +0100, Miklos Szeredi wrote:
>
> > > Am I right assuming that this queue-modifying operation is accept(), removing
> > > an embryo unix_sock from the queue of listener and thus hiding SCM_RIGHTS in
> > > _its_ queue from scan_children()?
> >
> > Hmm... How about just receiving an SCM_RIGHTS socket (which was a
> > candidate) from the queue of the peeked socket?
>
> Right, skb unlinked before unix_detach_fds().  I was actually thinking of a stream
> case, where unlink is done after that...
>
> *grumble*
>
> The entire thing is far too brittle for my taste ;-/

If it gets used as part of io_uring, I guess it's worth a fresh look.
I wrote it without basically any experience with either networking or
garbage collecting, so no wonder it has rough edges.

Thanks,
Miklos
