Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1963C7EE29
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 15:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbjEYPWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 11:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbjEYPWG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 11:22:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5566A98;
        Thu, 25 May 2023 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3ssmfPPhjZLZynXP//sBx5vsYc+zLAKwJikGSWYPm+0=; b=nt4MAsSsht78IxSABs4xkmDWo0
        EKxsw0prVbpYYsQAXeH4XMJ0x63qyDHrACDKjGmUWwQwFw95baWxLTbqrhZPi7KXXAH+6wP6XucMa
        nq+KefxK7MOXhK99ds49yXhZdWH2wJ6xjoin5d3g2rn7NWMViLGMYfJXwn46iT9GO4a5VRFSPaiNd
        KBPdPhrlWLULcchf2eZnhyQeC64cbQPOMFlWuwmQ9ClzicvdnSxdeMy+1Z0hxiR4JMndbMt6aRWcb
        H1/+oA57h6cZFx5kqK8oO3X3OGH4xwwUWHs8ru/wF7t/gy1/UGVmRjdzZzSg9i1OIOAzquLQnycIX
        zffd+X0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2Cmj-00CI4P-3g; Thu, 25 May 2023 15:21:49 +0000
Date:   Thu, 25 May 2023 16:21:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@kvack.org
Subject: Re: [PATCH] zonefs: Call zonefs_io_error() on any error from
 filemap_splice_read()
Message-ID: <ZG99DRyH461VAoUX@casper.infradead.org>
References: <3788353.1685003937@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3788353.1685003937@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 25, 2023 at 09:38:57AM +0100, David Howells wrote:
>     
> Call zonefs_io_error() after getting any error from filemap_splice_read()
> in zonefs_file_splice_read(), including non-fatal errors such as ENOMEM,
> EINTR and EAGAIN.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Link: https://lore.kernel.org/r/5d327bed-b532-ad3b-a211-52ad0a3e276a@kernel.org/

This seems like a bizarre thing to do.  Let's suppose you got an
-ENOMEM.  blkdev_report_zones() is also likely to report -ENOMEM in
that case, which will cause a zonefs_err() to be called.  Surely
that can't be the desired outcome from getting -ENOMEM!
