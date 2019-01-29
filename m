Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4870AC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DE12175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfA2Qz0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:55:26 -0500
Received: from verein.lst.de ([213.95.11.211]:47267 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfA2Qz0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 11:55:26 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B7A9468DD2; Tue, 29 Jan 2019 17:55:23 +0100 (CET)
Date:   Tue, 29 Jan 2019 17:55:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jann Horn <jannh@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
Message-ID: <20190129165523.GA14873@lst.de>
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk> <87tvhrpsqg.fsf@oldenburg2.str.redhat.com> <74fd3127-75f1-3a48-d3cb-a8f6c9bd0b74@kernel.dk> <CAG48ez0PPWP7GU5kinzejN1B3invrcxCZT2fkpnHxMK2F0pj6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0PPWP7GU5kinzejN1B3invrcxCZT2fkpnHxMK2F0pj6A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 04:38:36PM +0100, Jann Horn wrote:
> > >> +#define IORING_MAX_ENTRIES  4096
> > >
> > > Where does this constant come from?  Should it really be exposed to
> > > userspace?
> >
> > Seems pretty handy for the application to know what the limit is?
> 
> The running kernel version might be different from the kernel version
> whose headers the userspace code was compiled with. So if this is a
> limit that might change at some point in the future, and you think
> userspace wants to know the limit, some other API might be better.

If it changes it will increase, so I'm not worried it is all that
harmful.  What might be useful is a specific error code if it is too
large so that applications can check it.  Just which one?
