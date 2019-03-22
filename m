Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BFC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 23:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA412175B
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 23:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE6ffQoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfCVXEi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:04:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44068 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfCVXEi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 19:04:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so3972760wrt.11;
        Fri, 22 Mar 2019 16:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yNupQhBJDiL9w55kNvK5Wwt3EWPpOhu4Bzz7fnsJfU=;
        b=RE6ffQooiNh/mdXQ2hs1tqSCAM4Aq98qXdu5axozCM7/hn7jo9yJPtZmTIGpY3Z0N0
         ZngXlv84TThvUlSSHmcCebyXj1qgc4lnOl77gOlCSvpYm9e4DWI+dkv1pIPJjpUocE/m
         4B5U+FqPrKTNvSka5KkclnlXFx4ZCk1J1jaZ93991yJxHjoPL65NwBmPEOKQBCUQP4PS
         Zgvx/3B50B6+vxKPvq/3emUyXTAWvAoaAmLKeqgIEnDlHXwyluH0FBT2w+Nh/Q9sHS3g
         xPAo32o5nY7JuJK0O2nOeaXkOnsfcQbcHe4g79gHViv2lmugcqF8t9UlOGLw1Sz5p5PI
         vNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yNupQhBJDiL9w55kNvK5Wwt3EWPpOhu4Bzz7fnsJfU=;
        b=O4wNgdTJ8jTgy+VvZAac30luEVnury354W6vOIJ217Z/u8lIna4JBGCXXipZvqC8/P
         fizInYBXJ0R/KMvYNXYwxxKjeEB+EM+nNg9pofyamC2srftPZhSxSYdivKSlgeHlKi6n
         b4l+COjjnAi3l5/HL377e9X5g4oxRFXLrH1hY7Ra4qbRWD/NnLHfSMIS4X2rhl2dnQF+
         YGjR7hxS/fsvPf9UlHVXs2n1HrUA/aDHMVmDRWpc/084e/jUrK49BkOs4zsgy8EKWi5A
         xkjenlCSyoUmRPRHMu0b3Zf4Frq+SVo0/AJPseDTbjkoZhzo0dhcFHS+gByJJTJiSPgd
         6OjA==
X-Gm-Message-State: APjAAAXdvpPfSbn6vyIxho9eC/Ch8VusR1aTyKbEicmCEJoIymTGZav7
        4+T21FA5oP02XE8ipqeL92LhgYdWcGgk6h3BzoqKbzBcK6s=
X-Google-Smtp-Source: APXvYqyLZ7yypqJA++uaYeiXxJCOmEh5W1bRAA0CVoOWC36tYBfTYC3huh9eQiD33PxQL2SejHz4vxxbSEcZXdy3bTY=
X-Received: by 2002:adf:d848:: with SMTP id k8mr8776509wrl.185.1553295876647;
 Fri, 22 Mar 2019 16:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190322131346.20169-1-jthumshirn@suse.de> <20190322131346.20169-4-jthumshirn@suse.de>
 <20190322140233.GC17767@lst.de> <3ab3d268-68a7-0c23-601b-d86d26aa3936@suse.de>
 <20190322213031.GD31194@localhost.localdomain>
In-Reply-To: <20190322213031.GD31194@localhost.localdomain>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 23 Mar 2019 07:04:24 +0800
Message-ID: <CACVXFVNPW1TOsCaAibc-YJHDEdK95Y8-v1rHNaab7oV=eb+8TA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] block: bio: introduce BIO_ALLOCED flag and check
 it in bio_free
To:     Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 23, 2019 at 5:30 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Mar 22, 2019 at 03:05:46PM +0100, Hannes Reinecke wrote:
> > On 3/22/19 3:02 PM, Christoph Hellwig wrote:
> > > But how do you manage to get the tiny on-stack bios split?  What kind
> > > of setup is this?
> > >
> > It's not tiny if you send a 2M file via direct-io, _and_ have a non-zero
> > MDTS setting...
>
> I see a larger request can create a bio chain (though I think 1M
> is the max that goes through _simple), but how does the stack bio

multi-page bvec is merged now, 1M isn't the max size any more.

> get used in a bio_put()? The chained bios are allocated through a
> bio_set, and their bio_end_io() calls bio_put() on themselves through
> bio_chain_endio(), but that's it. The original's endio is never modified
> from blkdev_bio_end_io_simple(), so who's calling bio_put() on the
> on-stack bio?

I have the same concern, blkdev_bio_end_io_simple() doesn't release
the bio, and this bio shouldn't be released until __blkdev_direct_IO_simple()
returns. How can any underlying driver or block layer free such bio coming
from upper layer?

thanks,
Ming Lei
