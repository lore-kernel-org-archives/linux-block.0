Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59285 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933790AbdA0QST (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 11:18:19 -0500
Date: Fri, 27 Jan 2017 17:17:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: split scsi passthrough fields out of struct request V2
Message-ID: <20170127161718.GA16911@lst.de>
References: <1485365126-23210-1-git-send-email-hch@lst.de> <20170127161114.GA501@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170127161114.GA501@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 27, 2017 at 09:11:14AM -0700, Jens Axboe wrote:
> I've queued this up for 4.11. Since some of the patches had dependencies
> on changes in master since for-4.11/block was forked, they are sitting
> in a separate branch that has both for-4.11/block and v4.10-rc5 pulled
> in first. for-next has everything, as usual.

Eww.  I just had a couple non-trivial updates that I now do again.
In case you haven't pushed it out yet can you let me repost first?
