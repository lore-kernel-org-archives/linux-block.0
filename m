Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CD1C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 22:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234C82084F
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 22:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDZWNd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfDZWNd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 18:13:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E8B44EA5B;
        Fri, 26 Apr 2019 22:13:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC9E260923;
        Fri, 26 Apr 2019 22:13:28 +0000 (UTC)
Date:   Sat, 27 Apr 2019 06:13:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] iov_iter: fix iov_iter_type
Message-ID: <20190426221322.GA31470@ming.t460p>
References: <20190426104521.30602-1-ming.lei@redhat.com>
 <20190426104521.30602-3-ming.lei@redhat.com>
 <20190426124435.GA12339@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426124435.GA12339@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 26 Apr 2019 22:13:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 05:44:35AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 26, 2019 at 06:45:21PM +0800, Ming Lei wrote:
> >  static inline enum iter_type iov_iter_type(const struct iov_iter *i)
> >  {
> > -	return i->type & ~(READ | WRITE);
> > +	return i->type & ~(READ | WRITE | ITER_BVEC_FLAG_NO_REF);
> 
> The way we handle i->type is a complete mess.  I think we need
> three different values:
> 
>    .rw (can be READ or WRITE)
>    .type (ITER_IOVEC, ITER_KVEC, ITER_BVEC, ITER_PIPE, ITER_DISCARD)
>    .flags (ITER_BVEC_FLAG_NO_REF)
> 
> .type seems to be worth an u8 on its own.  And at least as long
> as we have space rw and flags should probably be their own u8 aswell,
> although we could use accessors to fold them.

I agree we need a cleanup, which might be a bit bigger change. It should
be clean to convert them into bit fields.

This issue is quite serious, system ram can easily be leaked completely,
so could we fix the issue by the easy way first?

Thanks, 
Ming
