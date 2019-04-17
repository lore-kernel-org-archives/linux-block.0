Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A21C282DC
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43DC21850
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="nE8Uv15i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbfDQVys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:54:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35032 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDQVyr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 17:54:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id j132so35386oib.2
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gzMaLLaGdWl3hSChkCJQp0aKInJbM+8lmL2ZmU73jg=;
        b=nE8Uv15i9sJ9T2QCxWTOE/iQD1bpVlwdwn8GzP1/6K5ajHJB2ThscCe1BBipf81sRG
         7Ki4ZanzmXpROhRumbSMNtBcN0vgTQuSWTzTYdQPEoZGpjwEVEhJ59WUlSTFALaQX/w3
         Ao2ANSK+tabdBGgLtc8Px76vWply/4r5eKmyAhe8o5f2HGs6ABsSLSDvV9HFg1Yuv+XG
         bB6bFe5tJ3nBzUWG3kffvZ5VncmP81eRT0m7NHbSaZaiAzOell6TbvdTtFLkBs9XmX/2
         Zvzd5gGqyvR+yJ3vNotGqM57OTMZwvzIHihHOHg5eo1Kr57GoOghV8lV5p12oyDmYs7D
         VfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gzMaLLaGdWl3hSChkCJQp0aKInJbM+8lmL2ZmU73jg=;
        b=c3CgQZaXHE/iDy+rbpIx4ozPOODPMXc5B+hZh9xL6FFIjKuTdrC4OzcOzeQctHcEKr
         Q1+HX5KuGSpzhY7/kFBLxbBovb8F2byX2tKfJbQDuFfrFvEORrn/mCx+AiDxVGmIPFQ/
         //8zL7nGjwGP6oAuQjoa0/q8VsV6iQchRuINrjAJhmlLw5McStYfDn4Jd3H4cLn8wZU4
         nqP0Mk+ysaYxN/VrMbDj6tzLbmzQ2+6eS3gAjkhnYs+yrKGphV3gncGfSjekuEVOhMwg
         OA1ghOC55O5n/9PFG+mvwZ6fIZhDT3uIF0LmqjdsTnA5zaL6v5B0nLSnF+b9jov/eq90
         cBCg==
X-Gm-Message-State: APjAAAUebWauacxWhUhpuDtIZwpsk2wxj8BUHJwkTxba39wqSid38auz
        +DmfxwtBuI6QupPGegLnJSm0dURu8H4QL5iPtATwGg==
X-Google-Smtp-Source: APXvYqyqbZkKrQu9PG9OfbWt5ClCfO+XAk2lSd/W1ElRySi/w9Gfz2hltItUkNjyrAWhso6NLBnigyhcnGeWvHliB84=
X-Received: by 2002:aca:d513:: with SMTP id m19mr548506oig.73.1555538087242;
 Wed, 17 Apr 2019 14:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190411210834.4105-1-jglisse@redhat.com> <2c124cc4-b97e-ee28-2926-305bc6bc74bd@plexistor.com>
 <20190416185922.GA12818@kmo-pixel> <CAPcyv4jLrQ6evLAJzsASh=H6Tzx8E1oiF+YR3L2fOpbZYNUWGg@mail.gmail.com>
 <ccac6c5a-7120-0455-88de-ca321b01e825@plexistor.com>
In-Reply-To: <ccac6c5a-7120-0455-88de-ca321b01e825@plexistor.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Apr 2019 14:54:36 -0700
Message-ID: <CAPcyv4hgs8fC+CeLTwqbjVqFE_HFiV-UQBankMBp5NmCniuBFA@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] Keep track of GUPed pages in fs and block
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alex Elder <elder@kernel.org>, ceph-devel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, Coly Li <colyli@suse.de>,
        linux-bcache@vger.kernel.org,
        =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 16, 2019 at 12:28 PM Boaz Harrosh <boaz@plexistor.com> wrote:
>
> On 16/04/19 22:12, Dan Williams wrote:
> > On Tue, Apr 16, 2019 at 11:59 AM Kent Overstreet
> > <kent.overstreet@gmail.com> wrote:
> <>
> > This all reminds of the failed attempt to teach the block layer to
> > operate without pages:
> >
> > https://lore.kernel.org/lkml/20150316201640.33102.33761.stgit@dwillia2-desk3.amr.corp.intel.com/
> >
>
> Exactly why I want to make sure it is just a [pointer | flag] and not any kind of pfn
> type. Let us please not go there again?
>
> >>
> >> Question though - why do we need a flag for whether a page is a GUP page or not?
> >> Couldn't the needed information just be determined by what range the pfn is not
> >> (i.e. whether or not it has a struct page associated with it)?
> >
> > That amounts to a pfn_valid() check which is a bit heavier than if we
> > can store a flag in the bv_pfn entry directly.
> >
> > I'd say create a new PFN_* flag, and make bv_pfn a 'pfn_t' rather than
> > an 'unsigned long'.
> >
>
> No, please please not. This is not a pfn and not a pfn_t. It is a page-ptr
> and a flag that says where/how to put_page it. IE I did a GUP on this page
> please do a PUP on this page instead of regular put_page. So no where do I mean
> pfn or pfn_t in this code. Then why?

If it's not a pfn then it shouldn't be an unsigned long named "bv_pfn".
