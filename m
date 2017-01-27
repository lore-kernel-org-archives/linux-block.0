Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Fri, 27 Jan 2017 17:23:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: split scsi passthrough fields out of struct request V2
Message-ID: <20170127162316.GA17059@lst.de>
References: <1485365126-23210-1-git-send-email-hch@lst.de> <20170127161114.GA501@kernel.dk> <20170127161718.GA16911@lst.de> <775aff8d-6bcc-9cc5-cfa3-dd1c157c95c5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <775aff8d-6bcc-9cc5-cfa3-dd1c157c95c5@fb.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 27, 2017 at 09:21:46AM -0700, Jens Axboe wrote:
> On 01/27/2017 09:17 AM, Christoph Hellwig wrote:
> > On Fri, Jan 27, 2017 at 09:11:14AM -0700, Jens Axboe wrote:
> >> I've queued this up for 4.11. Since some of the patches had dependencies
> >> on changes in master since for-4.11/block was forked, they are sitting
> >> in a separate branch that has both for-4.11/block and v4.10-rc5 pulled
> >> in first. for-next has everything, as usual.
> > 
> > Eww.  I just had a couple non-trivial updates that I now do again.
> > In case you haven't pushed it out yet can you let me repost first?
> 
> Why the eww?! You can't fix this with a repost.

Not because of the merge, mostly because I just spent two same
time adding all the ACKs, fixing typos and adding the removal of
the ->cmd tracing to the series and was getting ready for a repost.
