Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34270 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbeKGAlu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Nov 2018 19:41:50 -0500
Date: Tue, 6 Nov 2018 08:14:02 -0700
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
Message-ID: <20181106151402.GA6020@localhost.localdomain>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
 <20181105120153.GD12367@ming.t460p>
 <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
 <CACVXFVNOAc1HEPmfu9n8vMjqY2hK8fVqe4Em-g+dvSRLavpO8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVNOAc1HEPmfu9n8vMjqY2hK8fVqe4Em-g+dvSRLavpO8w@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 06, 2018 at 10:56:52PM +0800, Ming Lei wrote:
> 
> This patch makes sense on >4KB PAGE_SIZE. 

Granted existing blk_queue_virt_boundary() users all appear to be at
least 4k, the block API doesn't enforce that. Some unlikely device may
require an even smaller alignment in the future, which would benefit
from this patch.

But yes, the changelog description is a bit confusing to me if the
sighting came from a 4K arch.
