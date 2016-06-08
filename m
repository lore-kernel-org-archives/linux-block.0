Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31530 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933173AbcFHW5m (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 8 Jun 2016 18:57:42 -0400
Date: Wed, 8 Jun 2016 19:05:29 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lin <mlin@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 0/2] check the number of hw queues mapped to sw queues
Message-ID: <20160608230529.GD1696@localhost.localdomain>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
 <20160608222557.GC1696@localhost.localdomain>
 <CAF1ivSbEf-069LBRLRJKDd-e7JuF3jKrZr6yu-fANFajMGR_=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF1ivSbEf-069LBRLRJKDd-e7JuF3jKrZr6yu-fANFajMGR_=w@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 08, 2016 at 03:47:10PM -0700, Ming Lin wrote:
> On Wed, Jun 8, 2016 at 3:25 PM, Keith Busch <keith.busch@intel.com> wrote:
> > I've been trying to change blk_mq_update_queue_map to do this, but it's
> > not as easy as it sounds. The following is the simplest patch I came
> > up with that gets a better mapping *most* of the time.
> 
> Not working for my case with 6 hw queues(8 cpus):
> 
> [  108.318247] nvme nvme0: 6 hw queues created, but only 5 were mapped
> to sw queues
> 
> hctx_idx 0: 0 1 4 5
> hctx_idx 1: None
> hctx_idx 2: 2
> hctx_idx 3: 3
> hctx_idx 4: 6
> hctx_idx 5: 7

Heh, not one of the good cases I see. I don't think there's a simple
change to use all contexts. Might need a larger rewrite.
