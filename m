Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:40690 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755185AbcLNKmj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2016 05:42:39 -0500
Date: Wed, 14 Dec 2016 11:20:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block_dev: don't update file access position for sync
        direct IO
Message-ID: <20161214102039.GA29959@lst.de>
References: <d78aaba0928aa012d13eb462bbfc33cdddd0621a.1481684697.git.shli@fb.com> <58920289-6947-c079-6d96-779408436aeb@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <58920289-6947-c079-6d96-779408436aeb@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 13, 2016 at 09:08:18PM -0700, Jens Axboe wrote:
> That's not great... Thanks, added.

Ooops, yeah - we're still going through ->direct_IO for block devices.
I'll take a stab at removing that, as it's just a pointless indirect
call.
