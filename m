Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdEBM1m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 08:27:42 -0400
Date: Tue, 2 May 2017 20:27:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v4 0/6] Fixup mtip32xx for scheduling
Message-ID: <20170502122731.GA26157@ming.t460p>
References: <1493398473-29872-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493398473-29872-1-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 10:54:27AM -0600, Jens Axboe wrote:
> OK, I think we're getting there now. I dropped the RQF_RESERVED
> and the tag helper, since mtip32xx can just call
> blk_rq_is_passthrough() and know it's an internal request.
> 
> We can do another cleanup series of mtip32xx making the
> internal requests use the normal blk end_io infrastructure,
> and use the provider helpers for mapping data. I think
> that should be done separately as a cleanup, keeping this series
> as a straight forward conversion.
> 
> I've tested this on the following card:
> 
> [   56.394162] mtip32xx 0000:81:00.0: Model: P320h-MTFDGAR350SAH
> 
> and it works fine for me.

Tested this patchset against the latest linus tree, works fine
on my system with mq-deadline scheduler enabled.

	Tested-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
