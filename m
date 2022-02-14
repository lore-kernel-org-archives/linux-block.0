Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B1CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbiBNIRj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:17:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241924AbiBNIRd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 03:17:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE20606F9;
        Mon, 14 Feb 2022 00:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5FqYIgxWUIqyY2MNEh/y0z+2j4aSk4rsNe3xJDgfVFw=; b=uyL/wDoggI4tU+N2n5Bb0JSXYP
        VlM86GaV3Rn5CJERl2YUkJmklniATnMdctENn6AlItSKHqEUQwl6c/Jk5iv7R+Kg7rmqlBVrNm7vU
        doojlT9lWAyJtmQtK07KKkARX4R7aVEFJORCqWTRiQQFdOboWiADWTleRjwPDlNJCilBzpEHw681N
        rzggWkJRuxd+omjwnlcFyUm7IJCM+UblZLNvuGsoBlxKftJTfhhZJkVpYz7qi3bC7yMCDdINKLitM
        /BGXsj/MQcjaVAZtfGGzCkNQmLRAqQcyaqYt0s6gzMyu9pGHN2iXyzz0m15GyBsXJ0Z3jHWQbqoD3
        TZB5Dcyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJWXl-00DpZe-Ne; Mon, 14 Feb 2022 08:17:09 +0000
Date:   Mon, 14 Feb 2022 00:17:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] block: add filemap_invalidate_lock_killable()
Message-ID: <YgoQBTzb3b0l1SzP@infradead.org>
References: <0000000000007305e805d4a9e7f9@google.com>
 <3392d41c-5477-118a-677f-5780f9cedf95@I-love.SAKURA.ne.jp>
 <YdPzygDErbQffQMM@infradead.org>
 <8b2a61cb-4850-8bd7-3ff3-cebebefdb01b@I-love.SAKURA.ne.jp>
 <cf0d2a39-3301-ecc6-12b5-e8e204812c71@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf0d2a39-3301-ecc6-12b5-e8e204812c71@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 12, 2022 at 05:28:09PM +0900, Tetsuo Handa wrote:
> On 2022/01/04 22:26, Tetsuo Handa wrote:
> > On 2022/01/04 16:14, Christoph Hellwig wrote:
> >> On Mon, Jan 03, 2022 at 07:49:11PM +0900, Tetsuo Handa wrote:
> >>> syzbot is reporting hung task at blkdev_fallocate() [1], for it can take
> >>> minutes with mapping->invalidate_lock held. Since fallocate() has to accept
> >>> size > MAX_RW_COUNT bytes, we can't predict how long it will take. Thus,
> >>> mitigate this problem by using killable wait where possible.
> >>
> >> Well, but that also means we want all other users of the invalidate_lock
> >> to be killable, as fallocate vs fallocate synchronization is probably
> >> not the interesting case.
> > 
> > Right. But being responsive to SIGKILL is generally preferable.
> > 
> > syzbot (and other syzkaller based fuzzing) is reporting many hung task reports,
> > but many of such reports are simply overstressing.
> > 
> > We can't use killable lock wait for release operation because it is a "void"
> > function. But we can use killable lock wait for majority of operations which
> > are not "void" functions. Use of killable lock wait where possible can improve
> > situation.
> > 
> 
> If there is no alternative, can we apply this patch?

As mentioned before I do not think this patch makes sense.  If running
fallocate on the block device under the invalidate lock creates a problem
with long hold time we must get it out from under the lock, not turn one
random caller into a killable lock acquisition.
