Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF6CCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 13:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiGNNYv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbiGNNYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:24:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6A354660
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jliN/tozn+pVmQVLzUjT7BxezT/oqw0Ytn9JI0tWJGg=; b=q9X7zyizn2ib6XsGHi3nYyJ9s3
        1S+8uO5rODOkivQGu7kzBy7Q0KXbdbY7286sQ3JoXGpZCAgnhq7fuzc4q8dKuYhm0z6Rv/MEngDPR
        1amJVTQv5F+y7QDBmERKS9jyKhYhe30FZc9N4ogFwu3IY3SYk00FCzG4JNg7XQBQB1ZCA0z1e/kjM
        Wn9AuW67hhaGO+LUYTybk9o2X1VMzBSNQqc7LmMpQvdFFF0KuqFxOC9/FnmJf26NpJjNP3dnl23r3
        wUt1CmKllGLBkv9zQGlDW2Ct/FzJe2tVAkot8QkI9DCl/yMya4VbR7RR7kUhQh+kjp6cEhc61s1Kg
        MCoHKqiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oByp3-00Eghl-5U; Thu, 14 Jul 2022 13:24:05 +0000
Date:   Thu, 14 Jul 2022 06:24:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Message-ID: <YtAY9SdtFpZ0r6+M@infradead.org>
References: <20220714103201.131648-1-ming.lei@redhat.com>
 <47f6931d-5bb3-bc7e-51db-ef2e9d54d01b@kernel.dk>
 <YtAVraMgY9XsJ8JU@T590>
 <8afcfc87-966e-4e19-8b09-a9f25cd8e442@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afcfc87-966e-4e19-8b09-a9f25cd8e442@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 07:14:52AM -0600, Jens Axboe wrote:
> >> -	blk_cleanup_queue(ub->ub_queue);
> >> +	blk_put_queue(ub->ub_queue);
> > 
> > I guess you run test on for-next, and it should work by just replacing
> > two blk_cleanup_queue with blk_mq_destroy_queue().
> 
> Ah yes, that does the trick. I think I'll migrate the driver to the core
> branch instead to avoid these issues.

Please drop it for now.  It's pretty clear it did not have enough
review yet.  I'll try to allocate some time today or tomorrow to
go through it.
