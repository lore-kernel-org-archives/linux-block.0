Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151DFC433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Apr 2022 06:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379429AbiDVGq3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Apr 2022 02:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444379AbiDVGq2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Apr 2022 02:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7F9D50E0C
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650609814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/DxhYoCHdp20VSErL/dpjfGLHO1zuzg+O4MIWra3xE=;
        b=EyjdIVA/n1iFZEhSWY6JT6FlLzNeQa9yyEf3XnNm49OxfQThyPeSwSQIMvZx1L3CTnHbWR
        387TA21zHp4ofwbPuIuUMyCgfDf7XKaCcWXKzpJbiAVY5Rv62KMnff96Ll1i3Oun1BAMEC
        VWGPbPH4zecvDzsANBRbJfOiWZNz2jU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-j7rRCXoXN16KIhvLSLJ-eQ-1; Fri, 22 Apr 2022 02:43:31 -0400
X-MC-Unique: j7rRCXoXN16KIhvLSLJ-eQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B64386B8A6;
        Fri, 22 Apr 2022 06:43:31 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50D5EC2811D;
        Fri, 22 Apr 2022 06:43:25 +0000 (UTC)
Date:   Fri, 22 Apr 2022 14:43:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: fix "Directory XXXXX with parent 'block' already
 present!"
Message-ID: <YmJOiCifWa7CDy/e@T590>
References: <20220421083431.2917311-1-ming.lei@redhat.com>
 <YmGBnbYByitxF3UW@infradead.org>
 <YmIalwWdv30FgmKE@T590>
 <YmJFmUyBczk42j15@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmJFmUyBczk42j15@infradead.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 21, 2022 at 11:05:13PM -0700, Christoph Hellwig wrote:
> On Fri, Apr 22, 2022 at 11:01:43AM +0800, Ming Lei wrote:
> > Please see the following reasons:
> > 
> > 1) disk_release_mq() calls elevator_exit()/rq_qos_exit(), and the two
> > may trigger UAF if q->debugfs_dir is removed in blk_unregister_queue().
> 
> Well.  The debugfs_remove_recursive already removes all underlying
> entries, so the extra debugfs_remove_recursive calls there can just
> go away.
> > 
> > 2) after deleting disk, blktrace still should/can work for tracing
> > passthrough request.
> > 
> > 3) "debugfs directory deleted with blktrace active" in block/002 could
> > be triggered
> 
> Well, 3 just tests 2, so these are really one.
> 
> But how is blktrace supposed to work after the disk is torn down
> anyway? Pretty much all actual block trace traces reference the
> gendisk and/or block device which are getting freed at that point.
> So doing any blktrace action after the gendisk is released will
> lead to memory corruption.  For everyting but SCSI the race windows
> are probably small enough to not be seen by accident, but if you
> unbind the SSI ULP this should be fairly reproducible.

blktrace opens the bdev, so it is safe to trace until blktrace closes
the bdev. And del_gendisk() does happen before releasing disk, that
is why I don't think it is good to remove q->debugfs_dir inside
del_gendisk().


thanks,
Ming

