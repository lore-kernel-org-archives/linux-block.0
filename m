Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85661C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 23:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5407A217D9
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 23:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2TYM9Ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbeLQXXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:23:51 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39716 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeLQXXv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 18:23:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id q70so8442332qkh.6;
        Mon, 17 Dec 2018 15:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1fVBVfy/g93s89oCYn5/KG5kzEYJN7gIMTDDrnaCuI=;
        b=U2TYM9RaEQXF1NRZzNKh2pzzubSjS0vC+FE18iPHz/dPbr1b+6LrcklIjSfCj+U+w2
         QLd1556fp3wX1qbWvwWE12PSa1977jcsBfZ+WkNkUQ03bUKIMGMvQKndUO8uKARH2mKE
         ruiY2kitRMmKIeJ5a9mD1SHx3GE78lhHyVW/hQSUSKjIZjGmIiCSwXIMXDv3Y2KZsUFA
         x6ORTRBQnJW3Y4TbJBmk1vnu/bwXkwtK2aZyRx8G0zKD2Jb6pmPhR7KmpKhAjy2NTZmn
         QKRELWIosJLoMH6eXgSpbij4c286+bulS3wj48+xk9e4bKoRAe9XsL8SIKvKKnUYOsVR
         1i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1fVBVfy/g93s89oCYn5/KG5kzEYJN7gIMTDDrnaCuI=;
        b=VdVIEV1tAasHJ7YZlTwXCEEQHiOKpGPSO00/xDRctqA04yE/wo00+tdDJ4yghJVuDZ
         ac7mj05uzPjSbWCeDfPctkTXzjMiTC9W2b3mTy6I89W7eb/9c6jlrkYStkJ11NQ52cCl
         jG8qYQIL74daotj7fjxkIcbW4IIEDX6C925SwX5X1mbQNmSM3fDFrHELA1xo1nnDlpeA
         KHL/Rl/sKSMo158arv9cMFKGTVN/XLL1xjCgFu/YtagxkaUa/y8XATHuKyuQk1vnJ5Rl
         JFMmecGOOumLaa7z9MiddV1LB5AuHIxV4bWqARUa12czE7uGdW3+9O7qvCVyHcBX+ifB
         nH6w==
X-Gm-Message-State: AA+aEWZxIMV5YUQSqfYGrKcEAT/W+gvNTfxTiK+ptVVoQJqG41BEtksx
        FKWs3ikjJ0gpesv9o/nvUcle0Yvj9wfArr4Jr84=
X-Google-Smtp-Source: AFSGD/WjjvTw5Ke1JEDrgx8GojIatroDwhg+XCK7y+DBAYK7idglospM8TOvRv5sloqYs5kHNijlLlR1M9X42oYWo9M=
X-Received: by 2002:a37:ea0a:: with SMTP id t10mr13769673qkj.273.1545089029875;
 Mon, 17 Dec 2018 15:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20181217160351.27903-1-dennis@kernel.org> <CANQeFDAO5PdMOrZnn0UgFHcHGvXEs7qS9Kqrk1KRCAwgfRzSOg@mail.gmail.com>
 <20181217212826.GA71824@dennisz-mbp.dhcp.thefacebook.com>
In-Reply-To: <20181217212826.GA71824@dennisz-mbp.dhcp.thefacebook.com>
From:   Liu Bo <obuil.liubo@gmail.com>
Date:   Mon, 17 Dec 2018 15:23:38 -0800
Message-ID: <CANQeFDCeRk0L2iHu=nTGXV8baP2bUc+JRba3TY6QkpKaQcY+qw@mail.gmail.com>
Subject: Re: [PATCH v3] block: fix blk-iolatency accounting underflow
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 1:28 PM Dennis Zhou <dennis@kernel.org> wrote:
>
> On Mon, Dec 17, 2018 at 11:42:28AM -0800, Liu Bo wrote:
> > On Mon, Dec 17, 2018 at 8:04 AM Dennis Zhou <dennis@kernel.org> wrote:
> > >
> > > The blk-iolatency controller measures the time from rq_qos_throttle() to
> > > rq_qos_done_bio() and attributes this time to the first bio that needs
> > > to create the request. This means if a bio is plug-mergeable or
> > > bio-mergeable, it gets to bypass the blk-iolatency controller.
> > >
> >
> > Hi,
> >
> > I have a question about merging in plug list, since plug merges are
> > done before rq_qos_throttle(), why would plug-mergeable bios bypass
> > the controller?
> >
> > thanks,
> > liubo
> >
>
> Hi Liubo,
>
> BIO_TRACKED is tagging the bio that is responsible for allocating a new
> request, so that rq_qos controllers can decide whether or not they want
> to process the bio any part of the way. I should have phrased that a
> little better in the commit message. It's not that the bio itself is
> bypassing the blk-iolatency controller, but the blk-iolatency controller
> deciding to not do anything based on the BIO_TRACKED flag. This doesn't
> change any of the function calls made on a bio/request.
>

Thanks for the explanation.
I see it now, so the mentioned series had associated all bios with a
blkg if possible so that done_bio() bumps up inflight counter even in
case a bio has been merged in a previous request.

BIO_TRACKED seems to be too generic to use, but otherwise it makes sense to me,
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

thanks,
liubo

> Thanks,
> Dennis
