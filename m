Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01762EB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjF0PuD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 11:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjF0Ptz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 11:49:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC102D4E
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DNhXlMzfKWBgFBkZ30yANyCTFf8Lff96xXL+kn62T6o=; b=iX6/GeMoFYRslacP2Roj1MqwoQ
        BY6EMiTev06iH8q6mlUhdSPWUrDKWmzPO72YDREfdPaXkIVfEUe3MHLhB30qywcc9P1gNYlPs7gDA
        AiTcLIG+dKcwSomCahBKsp0GzzuSrKKZVVTsNa9qzx4GMpyV5j+1xLAj5flZBhYA9C3AdXDe8UNVK
        qS4tzSQ4IIHyMlz3byfm+aCWbQlbmuquDKdk3FSYb432znnM/PFgBmMaki13Sez81qrPbhmTT1sQ4
        pAzs091WLB3c6wGwKfw4iq1WH+4vyN4iSxiksZ5Duuq7/hboB22F8spYjLMv4WUTEwA21VRElN3wv
        gSIGu7NQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEAx0-00DZ76-0y;
        Tue, 27 Jun 2023 15:49:54 +0000
Date:   Tue, 27 Jun 2023 08:49:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        Marc Smith <msmith626@gmail.com>
Subject: Re: [PATCH] block: flush the disk cache on BLKFLSBUF
Message-ID: <ZJsFIkpj/+CdrQ1W@infradead.org>
References: <1a33ace-57f9-9ef9-b967-d6617ca33089@redhat.com>
 <f9e830ef-adf7-4196-a46f-ba4e65cbb54d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e830ef-adf7-4196-a46f-ba4e65cbb54d@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 27, 2023 at 05:31:12PM +0200, Mikulas Patocka wrote:
> Marc Smith reported a bug where he wrote to the dm-writecache target using 
> O_DIRECT, then reset the machine without proper shutdown and the freshly 
> written data were lost. It turned out that he didn't use the fsync or 
> fdatasync syscall (and dm-writecache makes its metadata persistent on a 
> FLUSH bio).

Which so far is expected.  Even with O_DIRECT you need O_(D)SYNC or
fsync/fdatasync to persist data.

> When I was analyzing this issue, it turned out that there is no easy way 
> how to send the FLUSH bio to a block device from a command line.

xfs_io -c fsync /dev/foo

> The "blockdev --flushbufs" command also doesn't send the FLUSH bio, but I 
> would expect it to send it. Without sending the FLUSH bio, "blockdev 
> --flushbufs" doesn't really guarantee anything.

I wouldn't expect it.  It's a really weird legacy thing that calls
back up into the file system, but only if it sets s_bdev to this
device.  I don't think we should add new users of it that overload the
semantics.
