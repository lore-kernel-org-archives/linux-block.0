Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeKEVVe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Nov 2018 16:21:34 -0500
Date: Mon, 5 Nov 2018 20:01:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
Message-ID: <20181105120153.GD12367@ming.t460p>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 05, 2018 at 12:50:50PM +0100, Johannes Thumshirn wrote:
> On 05/11/2018 11:55, Ming Lei wrote:
> > On Mon, Nov 05, 2018 at 11:23:01AM +0100, Johannes Thumshirn wrote:
> >> With drivers like iSer we are seeing a lot of bio splitting and smaller I/Os
> >> being submitted to the driver.
> >>
> >> The root cause of this issue that the virtual boundary mask code does not take
> >> into consideration that some of the memory segments in the SG list may have
> >> come from a huge memory page that is being managed in the SG list as 4K
> > 
> > I guess you mean something like 64K PAGE_SIZE, instead of huge page.
> 
> No I mean like a 2M page from an upper layer.

If you mean the real huge page, this patch shouldn't have made a difference
because bio_vec->bv_offset is in [0, PAGE_SIZE), and iSer sets virt
boundary as 4K - 1.

However, things will change after multipage bvec is introduced.

Thanks,
Ming
