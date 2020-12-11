Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7AFC4361B
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 02:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530C923E1B
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 02:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgLKCCE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 21:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388458AbgLKCBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 21:01:48 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5D8C0613D6;
        Thu, 10 Dec 2020 18:01:07 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knXjw-000Sct-GJ; Fri, 11 Dec 2020 02:01:00 +0000
Date:   Fri, 11 Dec 2020 02:01:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iov_iter: optimise iter type checking
Message-ID: <20201211020100.GB107834@ZenIV.linux.org.uk>
References: <cover.1605799583.git.asml.silence@gmail.com>
 <9bc27cb3ef6ab49b6b2ccee3db6613838aee17af.1605799583.git.asml.silence@gmail.com>
 <20201119170340.GA6179@infradead.org>
 <ce79f47e-2ec0-ba29-a991-c537a8990dee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce79f47e-2ec0-ba29-a991-c537a8990dee@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 19, 2020 at 05:12:44PM +0000, Pavel Begunkov wrote:
> On 19/11/2020 17:03, Christoph Hellwig wrote:
> > On Thu, Nov 19, 2020 at 03:29:43PM +0000, Pavel Begunkov wrote:
> >> The problem here is that iov_iter_is_*() helpers check types for
> >> equality, but all iterate_* helpers do bitwise ands. This confuses
> >> a compiler, so even if some cases were handled separately with
> >> iov_iter_is_*(), it can't eliminate and skip unreachable branches in
> >> following iterate*().
> > 
> > I think we need to kill the iov_iter_is_* helpers, renumber to not do
> > the pointless bitmask and just check for equality (might turn into a
> > bunch of nice switch statements actually).
> 
> There are uses like below though, and that would also add some overhead
> on iov_iter_type(), so it's not apparent to me which version would be
> cleaner/faster in the end. But yeah, we can experiment after landing
> this patch.
> 
> if (type & (ITER_BVEC|ITER_KVEC))

There are exactly 3 such places, and all of them would've been just as well
with case ITER_BVEC: case ITER_KVEC: ... in a switch.

Hmm...  I wonder which would work better:

enum iter_type {
        ITER_IOVEC = 0,
        ITER_KVEC = 2,
        ITER_BVEC = 4,
        ITER_PIPE = 6,
        ITER_DISCARD = 8,
};
iov_iter_type(iter)	(((iter)->type) & ~1)
iov_iter_rw(iter)	(((iter)->type) & 1)

or

enum iter_type {
        ITER_IOVEC,
        ITER_KVEC,
        ITER_BVEC,
        ITER_PIPE,
        ITER_DISCARD,
};
iov_iter_type(iter)	(((iter)->type) & (~0U>>1))
// callers of iov_iter_rw() are almost all comparing with explicit READ or WRITE
iov_iter_rw(iter)	(((iter)->type) & ~(~0U>>1) ? WRITE : READ)
with places like iov_iter_kvec() doing
	i->type = ITER_KVEC | ((direction == WRITE) ? BIT(31) : 0);

Preferences?
