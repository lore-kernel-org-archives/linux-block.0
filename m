Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F99C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 19:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D23560F94
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 19:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhHDTdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 15:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234676AbhHDTdt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Aug 2021 15:33:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B6BB60F22;
        Wed,  4 Aug 2021 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628105616;
        bh=y2Omw3zVXcQtgbyotRETOzvpEzcb4r8pozpLHpsfwOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+cumldL/tfruVPALKCjt0OpF3oSD/VkT6/ZIBn6//UWPHYcxkoz85b8BBHrTtgP7
         kDKYipfaEzjQe+Uv/YD1HWcytShk/QZ5PsoLxrTxGDHi9e5EzuNaPGWHyaWV22VXKE
         2n9oCHey4MwI1zcziNaLg/vNZ9VatesT0eVQJyhU=
Date:   Wed, 4 Aug 2021 21:33:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2 3/3] loop: Add the default_queue_depth kernel module
 parameter
Message-ID: <YQrrjTwJXyYHJ79W@kroah.com>
References: <20210803182304.365053-1-bvanassche@acm.org>
 <20210803182304.365053-4-bvanassche@acm.org>
 <YQouvmh3rTDz2WIE@kroah.com>
 <a7a8da9f-a413-8b43-0025-34a9d7dcd3c9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a8da9f-a413-8b43-0025-34a9d7dcd3c9@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 04, 2021 at 10:38:55AM -0700, Bart Van Assche wrote:
> On 8/3/21 11:07 PM, Greg KH wrote:
> > Should we just bump it up anyway given that modern memory limits are
> > probably more now?
> 
> As mentioned in the patch description, this patch is not about saving memory
> but about reducing latency. Reducing the queue depth to control latency is a
> common approach for block storage. See e.g. the description of
> CONFIG_BLK_WBT in block/Kconfig.
> 
> You may want to know that I looked into reducing the queue depth from user
> space before I came up with this kernel patch
> (https://android-review.googlesource.com/c/platform/system/core/+/1783847/6).
> However, making that approach work requires significant changes in the
> Android SELinux sysfs labeling policy. From my point of view, modifying the
> kernel is much less painful than reworking the Android SELinux labeling
> policy.

That's not fair, do not add additional complexity to the kernel, and a
global option like this, just because your userspace configuration is
complex.

The fact that this is a global change should make it a non-starter as
that is one of the main reasons module options should never be used.

Again, we have learned from past mistakes, let's not forget them.

thanks,

greg k-h
