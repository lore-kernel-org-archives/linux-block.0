Return-Path: <SRS0=zsIv=D4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098D2C388F9
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 16:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B486521D7B
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 16:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qAnN66Pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437728AbgJUQYT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 12:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437608AbgJUQYT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 12:24:19 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA80BC0613CE
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2020 09:24:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u8so4145205ejg.1
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2020 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gOwLOinKxfS8Q7pKCJNt4sF+c6ZgP4dy5YmMvKFVL4=;
        b=qAnN66PpKcpHn9YzLKihJgVOkQ9RiPSnoahXPav8UFjfvTvYdnOJugMx+Fd4ph9kHp
         Oro5Qq1x7si+5H+KJWJevoJW2PHn8HhJAqRLzFSXOSgl79BDmY2AGJXBq0iiIUil78+M
         QysAFxNAXgaq/Mfg5kA/0QDMB4VRDlGFuK1DSc+fErnKb3L0gfZ+4VEFg0V7CyQQ7Myx
         qeo8gGSTenyT+jW3xqn8pKqyQzwMS+8RqvOWuqowUB5/1uULNeDD9IyXJHsQOwlNL0h6
         4SoyROAEGF6wAKzdCiIMKhtkonzXdK+mP6RB+X4yyJd9uj4fp1tIq731Z14sHGErjeC2
         4AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gOwLOinKxfS8Q7pKCJNt4sF+c6ZgP4dy5YmMvKFVL4=;
        b=b0+wiuqS8WmmTKvlB+decMSU1sspSUDYjL2DRMBTlc3/0RNcs/jMpbv5hY/ZdPenwc
         FndIYs5GuCPVxan0V/Afp++tnE4wdiY9DmP7wZUUEuXT39lmBM+aEAY8rK3j3QPfAHw0
         bBtb68Er6ys2w3wcNnMA9nkkBubJI+mi8wUl/iJQISF8iBQarlLjT33j732D6d5nBRhu
         Q0eR2r/3h3z61wUy5z9iG7jZ+SFkNGSE6q79JU++J0e9GIZObQUfSVHaMaCCmzQ79JEo
         Q/kcMf7GGhJAgc+cMYuP/qBNgaioqCUCQMTRn3K//vo3/zYB842dICE/3vUAtnZqveJL
         wUnQ==
X-Gm-Message-State: AOAM531l0Dseeg8epDA9MFpkjdWLvXZwD9ycQre8y//+TnF/dPj9bn//
        PDgKWmJ0Iw7xKh4EyDiz1QAaAWrQbDItsg+GMWPBnBvCdLq3ag==
X-Google-Smtp-Source: ABdhPJxdbZlz7qjHcsJyG3VwrTEzzzv1Xnm7a3x75REVedoliNewQfm4hBXe15u3vhqNhzOv2lGigBFvNc+AOMCjKO4=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr4164002ejz.341.1603297457480;
 Wed, 21 Oct 2020 09:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com> <CAMM=eLf+2VYHB6vZVjn_=GA5uXJWKL-d6PuCpHEBPz=_Loe58A@mail.gmail.com>
In-Reply-To: <CAMM=eLf+2VYHB6vZVjn_=GA5uXJWKL-d6PuCpHEBPz=_Loe58A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 21 Oct 2020 09:24:06 -0700
Message-ID: <CAPcyv4hj2iPmf4YNdJLZqHMh2B10hbkSnk_9BAAACbG_LFKfBQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>, Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 21, 2020 at 7:24 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> Hey Dan,
>
> On Fri, Oct 16, 2020 at 6:38 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
> > (nmeeramohide) <nmeeramohide@micron.com> wrote:
> >
> > > (5) Representing an mpool as a /dev/mpool/<mpool-name> device file provides a
> > > convenient mechanism for controlling access to and managing the multiple storage
> > > volumes, and in the future pmem devices, that may comprise an logical mpool.
> >
> > Christoph and I have talked about replacing the pmem driver's
> > dependence on device-mapper for pooling.
>
> Was this discussion done publicly or private?  If public please share
> a pointer to the thread.
>
> I'd really like to understand the problem statement that is leading to
> pursuing a pmem native alternative to existing DM.
>

IIRC it was during the hallway track at a conference. Some of the
concern is the flexibility to carve physical address space but not
attach a block-device in front of it, and allow pmem/dax-capable
filesystems to mount on something other than a block-device.

DM does fit the bill for block-device concatenation and striping, but
there's some pressure to have a level of provisioning beneath that.

The device-dax facility has already started to grow some physical
address space partitioning capabilities this cycle, see 60e93dc097f7
device-dax: add dis-contiguous resource support, and the question
becomes when / if that support needs to extend across regions is DM
the right tool for that?
