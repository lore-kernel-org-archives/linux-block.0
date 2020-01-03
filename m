Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2FEC2D0C2
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 12:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBF32085B
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 12:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="GbR4Ofpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgACMea (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:34:30 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45367 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgACMea (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jan 2020 07:34:30 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so36480367iln.12
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2020 04:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQBNdebVOjJsqjvDHTeF1hVFvcu6+SpjgR+qmN5lO9I=;
        b=GbR4OfpkJPzqn0HF/BfdUrZgYJy/t9m+O7Gou3FujHO9ZXG4QlzLj7mNtmTGMqfySp
         LBropy52nKtf1GmOM9fLrVuTZKgG/IqxA9i87nz5hyKxRlVdEg7J8VLMUZ+2KtkQW3h8
         43NC2fEn0NLiASQqIvcHQQpJhJD7IWCkJe1ZyAERk1lcBHEdliM9Pz80YE1ueguF+VBV
         8FcPGKYLFgCdG3qe229vdS2FC02NFLBQkQa4R4pzkD2x0ZsY1Ow3mZT2V0PP+t2qTfmm
         88Dz6I3VkMumgl496p79a37XWXMs691TQkvq9wf0p872CLmlQ1r75WlikM9kj6lt4k5C
         w7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQBNdebVOjJsqjvDHTeF1hVFvcu6+SpjgR+qmN5lO9I=;
        b=jBp6L/mCKDNcRcR5/Uv0h87JR4FZ2xDJg0bSZ1gPklBZu8+Jur6NvRbnmBT1aCY+pt
         Vs0+DVrymaJ17WYCUjTvPNOVbAzEaX5ByVGlEaBjs8ZdvZbbkFufNjH9HTY59ioCOP9s
         +AJ25Qj7kOMS5b3/CS2A7O7CwH0cuInnmUqM+PsQHnAVDu7FI1U32289wDwjle7RdMg2
         d2UTVX5CnHouPS7o+0b8U4DORcnMIAgdmbXXq7b6i4HoR7oIMKioWB5kQ5JGtuZ1SF7m
         gg3VRcEWt8FOJKVdXonct885co2mL+e55BfGkFb1V1GhQIoKEiZgR7fTDJSvsPZyP7NA
         PsTA==
X-Gm-Message-State: APjAAAU/t7MpksS6NJKGNJDiKQMUZCQHExF3lfTarRbmUO/s9RQXa1Ac
        2Kf51C/u2mLlp3UYDFK1TTzyQILIX4Bx3WkkXJb1dg==
X-Google-Smtp-Source: APXvYqwHyBfcBx7ZF0gOT5DpfJVIq+6gyRsp0/ioGLDdv6afv/CJZ4aHA3jhQ2DbnDrghb5BtHs6dRnR4Nq4zdd5MHw=
X-Received: by 2002:a92:d2:: with SMTP id 201mr77769369ila.22.1578054869876;
 Fri, 03 Jan 2020 04:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <a56985f4-fbd3-3546-34e1-4185150f4af2@acm.org>
 <20200102182840.GF9282@ziepe.ca>
In-Reply-To: <20200102182840.GF9282@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 13:34:19 +0100
Message-ID: <CAMGffE=37tYaXSQqiSqO63tL-ZdJ3-uRem3ZBjC1q4yO5+ffbA@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] RTRS (former IBTRS) rdma transport library and
 RNBD (former IBNBD) rdma network block device
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 2, 2020 at 7:28 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Dec 30, 2019 at 06:39:00PM -0800, Bart Van Assche wrote:
> > On 2019-12-30 02:29, Jack Wang wrote:
> > > here is V6 of the RTRS (former IBTRS) rdma transport library and the
> > > corresponding RNBD (former IBNBD) rdma network block device.
> > >
> > > Changelog since v5:
> > > 1 rebased to linux-5.5-rc4
> > > 2 fix typo in my email address in first patch
> > > 3 cleanup copyright as suggested by Leon Romanovsky
> > > 4 remove 2 redudant kobject_del in error path as suggested by Leon Romanovsky
> > > 5 add MAINTAINERS entries in alphabetical order as Gal Pressman suggested
> >
> > Please always include the full changelog when posting a new version.
> > Every other Linux kernel patch series I have seen includes a full
> > changelog in version two and later versions of its cover letter.
>
> We now also like it if you include URLs to lore.kernel.org for the
> prior submissions.
>
> Jason
Will do.
