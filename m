Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Fri, 27 Jan 2017 11:44:53 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        dm-devel@redhat.com, Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 07/18] dm: always defer request allocation to the owner
 of the request_queue
Message-ID: <20170127164453.GB30221@redhat.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
 <1485365126-23210-8-git-send-email-hch@lst.de>
 <20170127163434.GA30221@redhat.com>
 <20170127163604.GA17337@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170127163604.GA17337@lst.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 27 2017 at 11:36am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Jan 27, 2017 at 11:34:34AM -0500, Mike Snitzer wrote:
> > Noticed after further review that it seems a bit weird to have the non
> > blk-mq support in drivers calling blk_mq_rq_to_pdu().  But I'm not sure
> > a blk_rq_to_pdu() macro to blk_mq_rq_to_pdu() is the right thing.  What
> > do you guys think?
> 
> My first version had an additional name for it, but it caused more
> confusion than help.

And renaming blk_mq_rq_to_pdu() to blk_rq_to_pdu() tree-wide would be
too much churn?

I can live with blk_mq_rq_to_pdu(); just figured I'd ask.
