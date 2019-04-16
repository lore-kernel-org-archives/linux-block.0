Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D02EC10F14
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB502064A
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 16:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="XiH4TXKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfDPQye (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:54:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38825 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfDPQyd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 12:54:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id e80so923682ote.5
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2019 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RmInYsyxg8h8urKtwZH3h+zL0n8LmC+ntY2NSp6Dtek=;
        b=XiH4TXKweOK5bQggdBSYG9PkGQsUrb38HXopZ3q1Zl7LpL8Vz9Am56vHXzLor2YfKP
         d14NNntOBV+VeVjSAyF7hbvZnd4oyIfVP1AJMrea5qkoZ8uzRMhlT9UsIHy8OAGMevnY
         jSG5bngwU/T99ckfh8BuBGBROqMO9DxVs1mUCejwOsI8x65k1rEoGTy54jsdt+Hpw7zs
         sB/e+fJqf5dOb/NwXIlj2HpsMGHv02xjxrh0Hm839/S3kkAoTI7a6P5EQ2CdGLlSY9pT
         h0KWnNIOm1/qHRUjHlO2gB0Phh6JAIJf29DfB2+tDk/pgc3Cy1/uYLZbTaGeLhruGElW
         GSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RmInYsyxg8h8urKtwZH3h+zL0n8LmC+ntY2NSp6Dtek=;
        b=haIn60Mwdnt6dKttRAU+x8K84U1KSa6alX/kUTvnpzfLHCa/LCJpxuK3GY/S/Qfk+O
         ZukD+5QpOZSWR5yCe/EEEYtBBbApO2dYp+Yh6zYbeGxp1okQPx+pgTwnnvQle9nkjlmV
         EzY8xxXlXJjjZ2DIkkGiTpJzwu1cGsusSLdUgKgb53kEouVLj///jc7yqeKpP6vAj3bH
         3unuLJ5PBr2am56aHDsgzkjPEnDW624SACQl1mpsQ90lvUaAY9IT22LZwknVg9oJrvcN
         rHNWKYGNYbizYWjl5Yfgpt3qCoFTLJpQG5Eb1C3ZH+QUWDTvM1IAqztgfufDkHZWYVn+
         c66w==
X-Gm-Message-State: APjAAAUyVbMN088eEqZ49bj/EiU1x5Dz57E+5W0qY0p2PRL6dMEUXOk1
        YFbgMifcfzd5loPkmBcIAfiYBW0ayqV7Xzn+lZ7qXw==
X-Google-Smtp-Source: APXvYqzWeVXyo4E/ADEgG/n8nh9jCa0D7rEf+XyIlDFgyh9V4nSnJF66u+zrGNhC1DjMnV5te459OBss3QYmtr670ew=
X-Received: by 2002:a9d:5c86:: with SMTP id a6mr49835114oti.118.1555433672859;
 Tue, 16 Apr 2019 09:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190411210834.4105-1-jglisse@redhat.com> <20190411210834.4105-11-jglisse@redhat.com>
 <20190415145952.GE13684@quack2.suse.cz> <20190415152433.GB3436@redhat.com> <20190416164658.GB17148@quack2.suse.cz>
In-Reply-To: <20190416164658.GB17148@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Apr 2019 09:54:21 -0700
Message-ID: <CAPcyv4iKVEty4MHt+fi3Mt5qp526vVOD1Xji=wXep_KLTZ0E8A@mail.gmail.com>
Subject: Re: [PATCH v1 10/15] block: add gup flag to bio_add_page()/bio_add_pc_page()/__bio_add_page()
To:     Jan Kara <jack@suse.cz>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 16, 2019 at 9:47 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 15-04-19 11:24:33, Jerome Glisse wrote:
> > On Mon, Apr 15, 2019 at 04:59:52PM +0200, Jan Kara wrote:
> > > Hi Jerome!
> > >
> > > On Thu 11-04-19 17:08:29, jglisse@redhat.com wrote:
> > > > From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > > >
> > > > We want to keep track of how we got a reference on page added to bi=
o_vec
> > > > ie wether the page was reference through GUP (get_user_page*) or no=
t. So
> > > > add a flag to bio_add_page()/bio_add_pc_page()/__bio_add_page() to =
that
> > > > effect.
> > >
> > > Thanks for writing this patch set! Looking through patches like this =
one,
> > > I'm a bit concerned. With so many bio_add_page() callers it's difficu=
lt to
> > > get things right and not regress in the future. I'm wondering whether=
 the
> > > things won't be less error-prone if we required that all page referen=
ce
> > > from bio are gup-like (not necessarily taken by GUP, if creator of th=
e bio
> > > gets to struct page he needs via some other means (e.g. page cache lo=
okup),
> > > he could just use get_gup_pin() helper we'd provide).  After all, a p=
age
> > > reference in bio means that the page is pinned for the duration of IO=
 and
> > > can be DMAed to/from so it even makes some sense to track the referen=
ce
> > > like that. Then bio_put() would just unconditionally do put_user_page=
() and
> > > we won't have to propagate the information in the bio.
> > >
> > > Do you think this would be workable and easier?
> >
> > It might be workable but i am not sure it is any simpler. bio_add_page*=
()
> > does not take page reference it is up to the caller to take the proper
> > page reference so the complexity would be push there (just in a differe=
nt
> > place) so i don't think it would be any simpler. This means that we wou=
ld
> > have to update more code than this patchset does.
>
> I agree that the amount of work in this patch set is about the same
> (although you don't have to pass the information about reference type in
> the biovec so you save the complexities there). But for the future the
> rule that "bio references must be gup-pins" is IMO easier to grasp for
> developers and you can reasonably assert it in bio_add_page().
>
> > This present patch is just a coccinelle semantic patch and even if it
> > is scary to see that many call site, they are not that many that need
> > to worry about the GUP parameter and they all are in patch 11, 12, 13
> > and 14.
> >
> > So i believe this patchset is simpler than converting everyone to take
> > a GUP like page reference. Also doing so means we loose the information
> > about GUP kind of defeat the purpose. So i believe it would be better
> > to limit special reference to GUP only pages.
>
> So what's the difference whether the page reference has been acquired via
> GUP or via some other means? I don't think that really matters. If say
> infiniband introduced new ioctl() that takes file descriptor, offset, and
> length and just takes pages from page cache and attaches them to their RD=
MA
> scatter-gather lists, then they'd need to use 'pin' references anyway...
>
> Then why do we work on differentiating between GUP pins and other page
> references?  Because it matters what the reference is going to be used fo=
r
> and what is it's lifetime. And generally GUP references are used to do IO
> to/from page and may even be controlled by userspace so that's why we nee=
d
> to make them different. But in principle the 'gup-pin' reference is not a=
bout
> the fact that the reference has been obtained from GUP but about the fact
> that it is used to do IO. Hence I think that the rule "bio references mus=
t
> be gup-pins" makes some sense.

+1 to this idea. I don't see the need to preserve the concept that
some biovecs carry non-GUP pages.
