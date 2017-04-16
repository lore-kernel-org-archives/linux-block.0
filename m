Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756542AbdDPQEE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2017 12:04:04 -0400
Date: Mon, 17 Apr 2017 00:03:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
Message-ID: <20170416160352.GA6349@ming.t460p>
References: <20170415123825.32716-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170415123825.32716-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Apr 15, 2017 at 08:38:21PM +0800, Ming Lei wrote:
> The 1st patch enhances BLK_MQ_F_NO_SCHED so that we can't change/
> show available io schedulers on devices which don't support io
> scheduler.
> 
> The 2nd patch passes BLK_MQ_F_NO_SCHED for avoiding one regression
> on mtip32xx, which is introduced by blk-mq io scheduler.
> 
> The last two patches introduce BLK_MQ_F_SCHED_USE_HW_TAG so that
> we can allow to use hardware tag for scheduler, then mq-deadline
> can work well on mtip32xx. Even though other devices with enough
> hardware tag space can benefit from this feature too.
> 
> The 1st two patches aims on v4.11, and the last two are for
> v4.12.

Please ignore this patchset, and I will post another serial for
mtip32xx fix.

thanks,
Ming
