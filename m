Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2A2C433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 07:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbiEaHaL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 03:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244516AbiEaH35 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 03:29:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE539939A8
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K3IIGrHj7fjo4AlVvtPY2FKY+sVLKTdmgmPW6/W++j4=; b=bWoiAqnhNgQXQkri5A5/FSqOYi
        c3NJE/csSwpvYUoLhD/vzXHVTgfXhpVV94iRWpUcL5PkTElonlpWMx/cDEmJQ3Y1x92JIRGMPvhQ4
        oF/16lTYoMQOsS0lzrdvMRBuY/gnq93rc0/Sg51rF39LFHkPQPO8Ly7C40iBv07z9eNax25BprfAV
        oLGBqA8+b9tl4vrNfcqVAj1bPsxHCGLjrw8culh7CcBm+2jNRExpQcrZNY89p+VS+S843qYBhWXqk
        4MX7nrTYMOFBhgZdrExVnBlhoHoYpdw72wIKQeZx2Wgl4fxjGOTsGbW0RcnsfgBcq10273fdcXO66
        RshOzIIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvwK5-009hME-Qa; Tue, 31 May 2022 07:29:49 +0000
Date:   Tue, 31 May 2022 00:29:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block: avoid to serialize blkdev_fallocate
Message-ID: <YpXD7czdGOmj1r4w@infradead.org>
References: <20220512134814.1454451-1-ming.lei@redhat.com>
 <20220516095239.pgk6uda376agnrjw@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516095239.pgk6uda376agnrjw@quack3.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 16, 2022 at 11:52:39AM +0200, Jan Kara wrote:
> * This way processes calling discard / zeroout can easily starve process
>   wanting to do read which does not seem ideal. Somewhat related is that I
>   know that Christoph wanted to modify how we use filemap_invalidate_lock()
>   so that huge zeroouts performed by actually writing zeros will not block
>   readers for ages and this seems to be going in somewhat opposite direction
>   favoring writers even more.
> * I suspect this is going to upset lockdep (and lock owner tracking for the
>   purposes of spinning) pretty badly because the lock owner may be returning
>   to userspace without unlocking the lock.

Yes to all of the above.  I think we need to just pick a smaller
defauly zeroout size (and make that tunable) to avoid holding the lock
over really long operations.  Or turn the invalidate lock into a range
lock..
