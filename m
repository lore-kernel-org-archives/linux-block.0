Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76CBC433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 16:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiDUQ11 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 12:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiDUQLz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 12:11:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205194739D
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JHyS9vnT2EIkjt+AFtkvbVkp7/TKncnkg566HNaMeZc=; b=snbXEuiuSexN+JPZA6T335tD7L
        XHZY2Oqo6IZ5ZvZS6nAxOa2xZ2xhsC5ZgTviPYw7Pc7lsI3XQODpkAgHSMFEyN08URp7JzqYNidVi
        PrtsJrTH2dsOvI3Z5cLgB3LHDjN+Rxd8bW9D5/w9cr2xdVcrw46h09SutC1e+AB5NC1tMetlUckqd
        kWQLR309JQCsHnX5gje7ctIZ3cvYIyGmlAiSvPz7nEIc6nt0jSpL7jYr9iYs6/AjEDbE1vvZj2EYk
        gpANSPoI04oYDeDDTiolQaNyHqPin+e+IQQ9127oP/DntSjxaPHYTK8eSBSut6lhNe3rdEkxA3MMN
        C1cXJzLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhZMb-00EB4B-KI; Thu, 21 Apr 2022 16:09:01 +0000
Date:   Thu, 21 Apr 2022 09:09:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: fix "Directory XXXXX with parent 'block' already
 present!"
Message-ID: <YmGBnbYByitxF3UW@infradead.org>
References: <20220421083431.2917311-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421083431.2917311-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 21, 2022 at 04:34:31PM +0800, Ming Lei wrote:
> q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> created when adding disk, and removed when releasing request queue.
> 
> There is small window between releasing disk and releasing request
> queue, and during the period, one disk with same name may be created
> and added, so debugfs_create_dir() may complain with "Directory XXXXX
> with parent 'block' already present!"
> 
> Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> and the dir name is named with q->id from beginning, and switched to
> disk name when adding disk, and finally changed to q->id in disk_release().

Is there any good reason to not just debugfs_remove_recursive in
blk_unregister_queue and do away with all the renaming?
