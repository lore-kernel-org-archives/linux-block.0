Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE22C433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Apr 2022 05:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiDIFRw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Apr 2022 01:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiDIFRv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Apr 2022 01:17:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C826129
        for <linux-block@vger.kernel.org>; Fri,  8 Apr 2022 22:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v5AUaXmXbfF5lrBdpvkZcFbAxCun5fHL446CBq+qPn4=; b=3yzv0B+b5AiWTVUvxQOp6I5XfM
        7te3Z0QZ9NjotZL9XDb9lV/pQObdOzPM/gU5a4EkihalsNWIwO091pEBsRO1LmbQEkhYatEmv8qcc
        uDIPhnp0Hc98F0lXlT4j4MUtqqqMEOrXNIalVA9lydLwXsUL3KmmXg/9DvJlth1Q2D7NYqUHPI1FU
        F66XDI/AFfUFtiofXf0861VcJt379gJMkuGLOCyhDnurMzR+86P1b6z0qj6gVZIk4xq6gHkoHKQNU
        iRHQCxoQ+HzDEDcAkFRj88nHpLzBjjp/wBMfuv0Pid7m5W0CdXDmJpecq56i7RqOPwaz/A7ZB9gEq
        /rFHiIpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd3Rl-002DAU-Bg; Sat, 09 Apr 2022 05:15:41 +0000
Date:   Fri, 8 Apr 2022 22:15:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dennis Zhou <dennis@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>, tj@kernel.org,
        axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: can we reduce bio_set_dev overhead due to bio_associate_blkg?
Message-ID: <YlEWfc39+H+esrQm@infradead.org>
References: <YkSK6mU1fja2OykG@redhat.com>
 <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
 <YkVBjUy9GeSMbh5Q@fedora>
 <YkVxLN9p0t6DI5ie@infradead.org>
 <YlBX+ytxxeSj2neQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlBX+ytxxeSj2neQ@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 08, 2022 at 11:42:51AM -0400, Mike Snitzer wrote:
> I think we can achieve the goal of efficient cloning/remapping for
> both usecases simply by splitting out the bio_set_dev() and leaving it
> to the caller to pick which interface to use (e.g. clone vs
> clone_and_remap).

You can just pass a NULL bdev to bio_alloc_clone/bio_init_clone.
I've been hoping to get rid of that, but if we have a clear use case
it will have to stay.
