Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDF5C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 07:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbiGTHr6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 03:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbiGTHrn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 03:47:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61D9541D35
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658303260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHp1uX9B2JrhaVlvosB0/JazObOhRY7VUMnQiy9p5+w=;
        b=EaihFV1KEN22opXNekCmp/oZ8qHfBtbfiawYc1sQr3P8XlRfIIH7z460H2kNy5DWxmU9/X
        cv/WlSRIGSNkmyMxCWKo/F5noSmz8A+D1FDcnKD3p0enZdHAh4q08/vfwx3GSkZ6whLxDQ
        d2lLEQFRN2YNe5SA/f2fyRGespzq3Kw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-vV1pnDacPni90Avz61Z9eA-1; Wed, 20 Jul 2022 03:47:37 -0400
X-MC-Unique: vV1pnDacPni90Avz61Z9eA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFCA885A586;
        Wed, 20 Jul 2022 07:47:36 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB2E340CFD0B;
        Wed, 20 Jul 2022 07:47:33 +0000 (UTC)
Date:   Wed, 20 Jul 2022 15:47:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] Revert "ublk_drv: fix request queue leak"
Message-ID: <YtezD/apQ1dM0n33@T590>
References: <20220718062928.335399-1-hch@lst.de>
 <20220718062928.335399-2-hch@lst.de>
 <YtalgzqC/q3JpYCR@T590>
 <20220720060705.GB6734@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720060705.GB6734@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 08:07:05AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 19, 2022 at 08:37:23PM +0800, Ming Lei wrote:
> > This change will break START_DEV/STOP_DEV, which is supposed to run
> > multiple cycles after the device is added, especially this way can
> > help to implement error recovery from userside, such as one ubq_daemon
> > is crashed/hang, the device can be recovered by sending STOP_DEV/START_DEV
> > commands again after new ubq_daemon is setup.
> 
> What is broken in START_DEV/STOP_DEV?  Please explain the semantics you
> want and what doesn't work.  FYI, there is nothing in the test suite the
> complains.  And besides the obvious block layer bug that Jens found you
> seemed to be perfectly happy with the semantics.

START_DEV calls add_disk(), and STOP_DEV calls del_gendisk(), but if 
GD_OWNS_QUEUE is set, blk_mq_exit_queue() will be called in
del_gendisk(), then the following START_DEV will stuck.

> 
> > So here we do need separated request_queue/disk, and the model is
> > similar with scsi's, in which disk rebind needs to be supported
> > and GD_OWNS_QUEUE can't be set.
> 
> SCSI needs it because it needs the request_queue to probe for what ULP
> to bind to, and it allows to unbind the ULP.  None of that is the case
> here.  And managing the lifetimes separately is a complete mess, so
> don't do it.  Especially not in a virtual driver where you don't have
> to cater to a long set protocol like SCSI.

If blk_mq_exit_queue is called in del_gendisk() for scsi, how can
re-bind work as expected since it needs one completely workable
request queue instead of partial exited one?


Thanks,
Ming

