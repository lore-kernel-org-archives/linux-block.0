Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51337 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968030AbdD1OKY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:10:24 -0400
Date: Fri, 28 Apr 2017 16:10:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH v2 0/6] Fixup mtip32xx for scheduling
Message-ID: <20170428141022.GB32073@lst.de>
References: <1493388117-15185-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493388117-15185-1-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 08:01:49AM -0600, Jens Axboe wrote:
> Round two of this patchset to cleanup. Changes since the first
> posting:

I got two mixed series in my inbox, one with two patches and one with
6.  The two patch one doesn't seem to have a cover letter.

> 
> - Mark internal commands as REQ_OP_DRV_IN. Doesn't really matter
>   what the data direction is, the important bit is that we need
>   to ensure the request is seen as a passthrough.

Yes, I think that's the right thing to do.  I'll review the details.

> - Utilize blk-mq timeout infrastructure, to avoid racing with
>   cleanup.

Nice.
