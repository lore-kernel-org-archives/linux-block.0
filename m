Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Fri, 27 Jan 2017 17:34:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: split scsi passthrough fields out of struct request V2
Message-ID: <20170127163450.GA17311@lst.de>
References: <1485365126-23210-1-git-send-email-hch@lst.de> <20170127161114.GA501@kernel.dk> <20170127161718.GA16911@lst.de> <775aff8d-6bcc-9cc5-cfa3-dd1c157c95c5@fb.com> <20170127162316.GA17059@lst.de> <195e1638-7d85-0618-0101-5cfff34b91e9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <195e1638-7d85-0618-0101-5cfff34b91e9@fb.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 27, 2017 at 09:27:02AM -0700, Jens Axboe wrote:
> Feel free to repost it, I have no problem rebasing that branch as it's
> standalone for now.

Ok, I'll repost what I have right now, which is on top of a merge
of your block/for-4.11/next and your for-next from this morning
my time.

Btw, I disagred with your patch to use op_is_flush in
generic_make_request_checks - given that we clear these flags just
below I think using the helper obsfucates what's really going on.
