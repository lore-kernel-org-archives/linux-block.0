Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343CEC433ED
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0536008E
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 10:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhEQKOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbhEQKOJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 06:14:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABA7C061573;
        Mon, 17 May 2021 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lYg8w1yLBmodofpJzyH7czSJX3G8qcn/lUBXozlYfmo=; b=UQ8Es1NICSGIPUCaydyjMWO/ez
        xXqF4mZPQUlN9R/l/pPdrdFfwu7LllJDnk3GJnF+98hqDTDKNKzygj1qOmAf+sbK8cBY+uvpEozm2
        /wiNqn/EOqowphFeetCPM0tRjg2nma4BQrcJ+KmFnHMh/GsMa0bRXJw7kg5rBhBDLQDM9+cfgnOXh
        ZVAiquA9NoNkd3JXYwLBSzh9YoOYTc4vLNgpABbqtJzclWJDBoWbOoNL3jufCtnxe0P/EUW5mqMo/
        e3KI1jTcvKgxdPbdHGvF1cuKHyXjzi8acqbJcAbrQNnQgYdeRzo4W6Dgs1AYIB2oo+0m/gs0uIj++
        N2ycD2LA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1liaDo-00CnMC-Se; Mon, 17 May 2021 10:11:39 +0000
Date:   Mon, 17 May 2021 11:11:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     hch@infradead.org, Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        bvanassche@acm.org, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, jaegeuk@kernel.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yi.zhang@redhat.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v10 0/1] bio: limit bio max size
Message-ID: <YKJBWClI7sUeABDs@infradead.org>
References: <YJ0MJe1Gc5XMV1gB@infradead.org>
 <CGME20210514065054epcas1p4bd5c92a59d4010da4447ef62f65fdd4b@epcas1p4.samsung.com>
 <20210514063241.22260-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514063241.22260-1-nanich.lee@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 14, 2021 at 03:32:41PM +0900, Changheun Lee wrote:
> I tested 512MB file read with direct I/O. and chunk size is 64MB.
>  - on SCSI disk, with no limit of bio max size(4GB) : avg. 630 MB/s
>  - on SCSI disk, with limit bio max size to 1MB     : avg. 645 MB/s
>  - on ramdisk, with no limit of bio max size(4GB)   : avg. 2749 MB/s
>  - on ramdisk, with limit bio max size to 1MB       : avg. 3068 MB/s
> 
> I set ramdisk environment as below.
>  - dd if=/dev/zero of=/mnt/ramdisk.img bs=$((1024*1024)) count=1024
>  - mkfs.ext4 /mnt/ramdisk.img
>  - mkdir /mnt/ext4ramdisk
>  - mount -o loop /mnt/ramdisk.img /mnt/ext4ramdisk
> 
> With low performance disk, bio submit delay caused by large bio size is
> not big protion. So it can't be feel easily. But it will be shown in high
> performance disk.

So let's attack the problem properly:

 1) switch f2fs to a direct I/O implementation that does not suck
 2) look into optimizing the iomap code to e.g. submit the bio once
    it is larger than queue_io_opt() without failing to add to a bio
    which would be annoying for things like huge pages.
