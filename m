Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:60400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbdJFMFb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 08:05:31 -0400
Date: Fri, 6 Oct 2017 05:05:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: cope with WRITE ZEROES failing in
 blkdev_issue_zeroout()
Message-ID: <20171006120526.GA19292@infradead.org>
References: <1507129396-20458-1-git-send-email-idryomov@gmail.com>
 <1507129396-20458-3-git-send-email-idryomov@gmail.com>
 <20171005171327.GB31208@infradead.org>
 <CAOi1vP_7EaNOBXup--HPPnOOvKKi_6_ksXUqE5YmGAicjz0oWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOi1vP_7EaNOBXup--HPPnOOvKKi_6_ksXUqE5YmGAicjz0oWA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 05, 2017 at 09:32:33PM +0200, Ilya Dryomov wrote:
> This is to avoid returning -EREMOTEIO in the following case: device
> doesn't support WRITE SAME but scsi_disk::max_ws_blocks != 0, zeroout
> is called with BLKDEV_ZERO_NOFALLBACK.  Enter blkdev_issue_zeroout(),
> bdev_write_zeroes_sectors() != 0, so we issue WRITE ZEROES.  The
> request fails with ILLEGAL REQUEST, sd_done() sets ->no_write_same and
> updates queue_limits, ILLEGAL REQUEST is translated into -EREMOTEIO,
> which is returned from submit_bio_wait().  Manual zeroing is not
> allowed, so we must return an error, but it shouldn't be -EREMOTEIO if
> queue_limits just got updated because of ILLEGAL REQUEST.  Without this
> conditional, we'd get

Hmm.  I think we'd better off to just do the before the retry loop:

	if (ret && try_write_zeroes) {
		if (!(flags & BLKDEV_ZERO_NOFALLBACK))
			try_write_zeroes = false;
			goto retry;
		}
		ret = -EOPNOTSUPP;
	}
