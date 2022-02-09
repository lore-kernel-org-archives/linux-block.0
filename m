Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57254C4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 14:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiBIOIW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 09:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiBIOIV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 09:08:21 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1FAC0613C9
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 06:08:23 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id e7so3615079ejn.13
        for <linux-block@vger.kernel.org>; Wed, 09 Feb 2022 06:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5bx1qEtEg3EIzDv8AQCkahDWh6kYfXn3OFOgd1OTgg=;
        b=h1a3/iEzTG3qiinGOPEQEcIOyBFs0Uk8dAcTSe527i9dZNw25gmqQ1UVfVep7cjSKO
         vVEldcrrq1G4mvLimfM/OJTq3PqrlXTgCK91nS62Po3lk7IWDrvs2tXKP5XIJqHB71AW
         5jaVCe7tLS3rFIQDHT7KrOBmg1Par9XzTRo0rIufYOAacbzSiQo3oQ5VD5Ypuv9dCgjg
         5AEgfMdbxj/DfLj1H6N/fWiGYEtwTXwXfxKnXGg3r/wjIwk7Uyc0a1JS/MT50vvfERJQ
         Y3zXopwud/1nKroLaxl6MWuFUbGtuZi2g8hY5kWRSnS5/s8h9q3wuu0HtNssCArRHHBw
         n1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5bx1qEtEg3EIzDv8AQCkahDWh6kYfXn3OFOgd1OTgg=;
        b=PoXb60mvoG9duyK/b5GdV3ODVeWkk6+fYA59V5TWCxpMGVRQC41sMzECx8MfJG/iym
         LJXKshSpU/sjkBRmnHqa8nNsCeuDOBydI1BKjmIOUnFxGyiBSk3Jv3JqbjxXBapdrDkz
         D5rM2m89/Ng9CTPEKmTgzIb9q20SxsA3B/tcPWnKil6x59baswWwWWrwnv3vf8QX8iBP
         MvrdxoH+jXhSKC1iOQ/Tg3tsRxaW2aVD4QfSYMFS9UtPJrAJRCPcTp5w0vTvhjwDkZpO
         B98Os4yfsvveUXwoFQyoyuQoeIKOwrp5p/O8cIcqN+84PaFiqugm0IzNe1e/I93twjjz
         vhbw==
X-Gm-Message-State: AOAM530esmqu1tEXveKGWxzzxMW25hEi7VVpzd8yAnL26sE4zxDbfNvP
        ZxxdPMNj631GzNmsb1uULuyAXKk/4IcK9zDYns9m4g==
X-Google-Smtp-Source: ABdhPJzLJN+qYozEzQz4G3pucxfA9BKQJ8B2bDBEeDHB5sIEzgJRDkQpP0iVNBhtpmdi/dHQfGoa28HPCL5HUVirJAw=
X-Received: by 2002:a17:907:1b1c:: with SMTP id mp28mr2137509ejc.624.1644415702501;
 Wed, 09 Feb 2022 06:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20220209082828.2629273-1-hch@lst.de> <20220209082828.2629273-4-hch@lst.de>
 <CAMGffE=GMYNsw+mDt1h-BDh3JXkdrP9v2AUF7z0xE7jkumM+RQ@mail.gmail.com> <20220209140448.GA20765@lst.de>
In-Reply-To: <20220209140448.GA20765@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 9 Feb 2022 15:08:11 +0100
Message-ID: <CAMGffEm5qivscB8r+koGL7-bVxUOPr6=wLH6-RfHqzp8u2+HMw@mail.gmail.com>
Subject: Re: [PATCH 3/7] rnbd: drop WRITE_SAME support
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        target-devel@vger.kernel.org, haris.iqbal@ionos.com,
        manoj@linux.ibm.com, mrochs@linux.ibm.com, ukrishn@linux.ibm.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        drbd-dev@lists.linbit.com, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 9, 2022 at 3:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Feb 09, 2022 at 11:16:13AM +0100, Jinpu Wang wrote:
> > Hi Christoph,
> >
> >
> > On Wed, Feb 9, 2022 at 9:28 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > REQ_OP_WRITE_SAME was only ever submitted by the legacy Linux zeroing
> > > code, which has switched to use REQ_OP_WRITE_ZEROES long before rnbd was
> > > even merged.
> >
> > Do you think if it makes sense to instead of removing
> > REQ_OP_WRITE_SAME, simply convert it to REQ_OP_WRITE_ZEROES?
>
> Well, they have different semantics, so you can't just "convert" it.
> But it might make sense to add REQ_OP_WRITE_ZEROES.
Thanks, we will add support for REQ_OP_WRITE_ZEROES later.

For this patch, I've run internal tests, works fine.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thanks!
