Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51487 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936287AbdD1Ol5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:41:57 -0400
Date: Fri, 28 Apr 2017 16:41:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH 4/6] blk-mq: don't bypass scheduler for reserved
        requests
Message-ID: <20170428144155.GD1443@lst.de>
References: <1493389911-19512-1-git-send-email-axboe@fb.com> <1493389911-19512-5-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493389911-19512-5-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 08:31:49AM -0600, Jens Axboe wrote:
> Instead of bypassing the scheduler for insertion of reserved requests,
> we ensure that the request is marked as RQF_RESERVED so they driver
> knows where it came from.
> 
> Usually we just use the tag to know if it's reserved or not,
> but that only works when the request has a driver tag assigned.
> Using RQF_RESERVED can be done independently of whether or not
> scheduling is used.

Do we really need a flag for this?  If anyone cares if a request
is internal it can just check ->tag / ->internal_tag is smaller
than ->nr_reserved_tags using a little helper.

I'd really like to keep the number of flags down as much as possible.
