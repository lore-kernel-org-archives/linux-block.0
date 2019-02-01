Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C41FC282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 18:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506E121872
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 18:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfBASFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:05:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56272 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfBASFt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 13:05:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gpdCA-0003kR-5C; Fri, 01 Feb 2019 18:05:42 +0000
Date:   Fri, 1 Feb 2019 18:05:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     Matt Mullins <mmullins@fb.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "avi@scylladb.com" <avi@scylladb.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
Message-ID: <20190201180541.GQ2217@ZenIV.linux.org.uk>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez0vDqDH4ks7q4L3F+xt-4kVQrN1yw34QwFAmwQyy27FTw@mail.gmail.com>
 <e9326a77-54c5-e2b8-d9e5-663261462597@kernel.dk>
 <CAG48ez17NW0GJVRC6dFcHZTgQifFz5og1XCUbXkHKhr6f=j74Q@mail.gmail.com>
 <05cb18f7a97a6151c305cdb7240c4abc995aed59.camel@fb.com>
 <CAG48ez09iOOnPz83b6HxktYHTfouS2GD6i3PfQEjp8WCp+3-VA@mail.gmail.com>
 <CAG48ez0sJys=M1MR3DBd1DJ21-qHd2W7sB8+EvjhScWbtQnizA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0sJys=M1MR3DBd1DJ21-qHd2W7sB8+EvjhScWbtQnizA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 06:23:27PM +0100, Jann Horn wrote:

> > Oh, yuck. Uuuh... can we make "struct files_struct" doubly-refcounted,
> > like "struct mm_struct"? One reference type to keep the contents
> > intact (the reference type you normally use, and the type used by
> > uring when the thread is running), and one reference type to just keep
> > the struct itself existing, but without preserving its contents
> > (reference held consistently by the uring thread)?
> 
> Something like this (completely untested); and then instead of the
> current get_files_struct(), you'd do get_files_struct_weak(), and
> while the thread is running, it protects the files_struct from dying
> with tryget_weak_files_struct() / put_files_struct().
> 
> Al, do you have opinions on this?

Yes, but they are not fit for polite company.  IMO the entire approach
is FUBAR; I'll post more detailed review, but what I'd seen so far is
a veto fodder.
