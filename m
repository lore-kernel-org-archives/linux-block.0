Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A66CC004C0
	for <linux-block@archiver.kernel.org>; Sat, 21 Oct 2023 05:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjJUFIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Oct 2023 01:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUFIw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Oct 2023 01:08:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED231BF;
        Fri, 20 Oct 2023 22:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z8f9uaKwD9ppL0C1CqjKBJdH1gJN+2UHJiY2wGmwdxA=; b=Vy9fRtEKCTjI8FDUW5pt/h3hbe
        NhaaVm6bQmr6DXy+p81klmEehmrI35qJ7hxpaIt5/jEHYZ6b1pXPBZ/bsp2h6VvyVr861ZOV3ePas
        B1zk1Ho42Kue7H7KhuAkoNKrHZcQXTOrmpa0z+9hLsu2LaDUYmwMqBGWItieLEvVKLJ7DOj+yvx78
        LiPoXYyuw83dGgyxDZXnMGQW4Aj0Y1hT2KflGs7MPM4RXDAkoIboGQ2G81yttk3KhIQF+4iMe3Dp3
        BE/mmXWZyoOeRHiCuUnTjmxg9Tx+Tj7uf0+uvW80odS6yZ+dZ86ylW83eWDM+bjAtQXhM+u9UUxpH
        K9utjqJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qu4E1-00HIF4-NU; Sat, 21 Oct 2023 05:08:37 +0000
Date:   Sat, 21 Oct 2023 06:08:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/18] fs/buffer.c: use accessor function to translate
 page index to sectors
Message-ID: <ZTNc1SIMOkU+CCvX@casper.infradead.org>
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-5-hare@suse.de>
 <ZTLW9jOJ0Crt/ZD3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTLW9jOJ0Crt/ZD3@casper.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 20, 2023 at 08:37:26PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 01:04:56PM +0200, Hannes Reinecke wrote:
> > Use accessor functions block_index_to_sector() and block_sector_to_index()
> > to translate the page index into the block sector and vice versa.
> 
> You missed two in grow_dev_page() (which I just happened upon):

I have fixes here.  The key part of the first patch is:

 static sector_t folio_init_buffers(struct folio *folio,
-               struct block_device *bdev, sector_t block, int size)
+               struct block_device *bdev, int size)
 {
        struct buffer_head *head = folio_buffers(folio);
        struct buffer_head *bh = head;
        bool uptodate = folio_test_uptodate(folio);
+       sector_t block = folio_pos(folio) / size;
        sector_t end_block = blkdev_max_block(bdev, size);

(and then there's the cruft of removing the arguments from
folio_init_buffers)

The second patch is:

 static bool grow_buffers(struct block_device *bdev, sector_t block,
                unsigned size, gfp_t gfp)
 {
-       pgoff_t index;
-       int sizebits;
-
-       sizebits = PAGE_SHIFT - __ffs(size);
-       index = block >> sizebits;
+       loff_t pos;
[...]
-       if (unlikely(index != block >> sizebits)) {
+       if (check_mul_overflow(block, size, &pos) || pos > MAX_LFS_FILESIZE) {

I'll send a proper patch series tomorrow once the fstests are done
running.
