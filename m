Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BEAEB64D9
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 07:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbjFNHKf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 03:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbjFNHKa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 03:10:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C650098;
        Wed, 14 Jun 2023 00:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eWUrkWHehg8ICQxRCsZUMYfEcdYdO364tunQ495Yvso=; b=fOmgoR/suDSJYzFM7QGQ3/0V6w
        2xUWouRlpitPiDKfNtN55ojKs3jZqeEKtcalD8WOn90RoEaSy4ohGZmG+LwSqetUx6VtjZnilXWjE
        QMOY98rI3w/8nKp8qiRMs8oB8tq++mm2XUXUgGIYSAs92g9f9M6oTCVy8+FQzJXOZJhdxykHiYK21
        7BuPRQmAA/VGznFPs0lvDJ0tQk7dLNUMCeQTP8PlmqE8O2LK1oXMkc+ldaJVMaFcK5oD/jCQHROGA
        ltdrQesgpXbibCNssAMeSbLzH7xQs22o2AL2/f3uA3sk+UXcQDBZslyB/6GzmdFaqwghUERozcwwX
        TxxgEZ+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9KeA-00AbQR-0t;
        Wed, 14 Jun 2023 07:10:26 +0000
Date:   Wed, 14 Jun 2023 00:10:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Colin Walters <walters@verbum.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Theodore Ts'o <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZIln4s7//kjlApI0@infradead.org>
References: <20230612161614.10302-1-jack@suse.cz>
 <20230612162545.frpr3oqlqydsksle@quack3>
 <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
 <a6c355f7-8c60-4aab-8f0c-5c6310f9c2a8@betaapp.fastmail.com>
 <20230613113448.5txw46hvmdjvuoif@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613113448.5txw46hvmdjvuoif@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 13, 2023 at 01:34:48PM +0200, Jan Kara wrote:
> > It's not just syzbot here; at least once in my life I accidentally did
> > `dd if=/path/to/foo.iso of=/dev/sda` when `/dev/sda` was my booted disk
> > and not the target USB device.  I know I'm not alone =)
> 
> Yeah, so I'm not sure we are going to protect against this particular case.
> I mean it is not *that* uncommon to alter partition table of /dev/sda while
> /dev/sda1 is mounted. And for the kernel it is difficult to distinguish
> this and your mishap.

I think it is actually very easy to distinguish, because the partition
table is not mapped to any partition and certainly not an exclusively
opened one.

> 1) If user can write some image and make kernel mount it.
> 2) If user can modify device content while mounted (but not buffer cache
> of the device).
> 3) If user can modify buffer cache of the device while mounted.
> 
> 3) is the most problematic and effectively equivalent to full machine
> control (executing arbitrary code in kernel mode) these days.

If a corrupted image can trigger arbitrary code execution that also
means the file system code does not do proper input validation.

This isn't meant as an argument against protecting the write access
(which I think is good and important), but we shoudn't make this worse
than it is.

