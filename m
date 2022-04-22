Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1135C433F5
	for <linux-block@archiver.kernel.org>; Fri, 22 Apr 2022 06:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379367AbiDVGII (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Apr 2022 02:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444206AbiDVGIG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Apr 2022 02:08:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6851CB26
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 23:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4sKR9E542mk3yvpv+nEyggq1aD8JcHolJYbz4ZoUuWg=; b=dKOe+w321v/gz2kw1Ofyu4UZxv
        b+jr9tZmU78fMrG1g9QhAO91QdNVS5Fp0FrxrtnhH4fpBhBtxLV5hZK6f0jJBjTcSHD/nApJqp94I
        kaiseMO766CyBLozUsstxtofENTkSgyUHrUimZ/U7xMdx0MtMSyYj2XtGyggss0EmiZquY6oiqXYe
        tXoSsdTq+JR6O9Kmdo/Wv1q58brb7wkOt1X6WD5jGo2IRp6LY4YkjkzB32ktlfFLdZQqGdRS8ohwo
        8N6fAB+3Hp6yY0DSbsgtAzwAdiDbuzKKYhRTg8s+d57NJR1m20+X+Tzsz9DYA82leuZ75OrpUFdWF
        nZc8/Sag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhmPp-00GMu1-FT; Fri, 22 Apr 2022 06:05:13 +0000
Date:   Thu, 21 Apr 2022 23:05:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: fix "Directory XXXXX with parent 'block' already
 present!"
Message-ID: <YmJFmUyBczk42j15@infradead.org>
References: <20220421083431.2917311-1-ming.lei@redhat.com>
 <YmGBnbYByitxF3UW@infradead.org>
 <YmIalwWdv30FgmKE@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmIalwWdv30FgmKE@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 22, 2022 at 11:01:43AM +0800, Ming Lei wrote:
> Please see the following reasons:
> 
> 1) disk_release_mq() calls elevator_exit()/rq_qos_exit(), and the two
> may trigger UAF if q->debugfs_dir is removed in blk_unregister_queue().

Well.  The debugfs_remove_recursive already removes all underlying
entries, so the extra debugfs_remove_recursive calls there can just
go away.
> 
> 2) after deleting disk, blktrace still should/can work for tracing
> passthrough request.
> 
> 3) "debugfs directory deleted with blktrace active" in block/002 could
> be triggered

Well, 3 just tests 2, so these are really one.

But how is blktrace supposed to work after the disk is torn down
anyway?  Pretty much all actual block trace traces reference the
gendisk and/or block device which are getting freed at that point.
So doing any blktrace action after the gendisk is released will
lead to memory corruption.  For everyting but SCSI the race windows
are probably small enough to not be seen by accident, but if you
unbind the SSI ULP this should be fairly reproducible.
