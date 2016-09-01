Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:52029 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753255AbcIAONq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Sep 2016 10:13:46 -0400
Date: Thu, 1 Sep 2016 10:24:10 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/7] blk-mq: allow the driver to pass in an affinity mask
Message-ID: <20160901142410.GA10903@localhost.localdomain>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
 <1472468013-29936-5-git-send-email-hch@lst.de>
 <20160831163852.GB5598@localhost.localdomain>
 <20160901084624.GC4115@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160901084624.GC4115@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 01, 2016 at 10:46:24AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 31, 2016 at 12:38:53PM -0400, Keith Busch wrote:
> > This can't be right. We have a single affinity mask for the entire
> > set, but what I think we want is an one affinity mask for each
> > nr_io_queues. The irq_create_affinity_mask should then create an array
> > of cpumasks based on nr_vecs..
> 
> Nah, this is Thomas' creating abuse of the cpumask type.  Every bit set
> in the affinity_mask means this is a cpu we allocate a vector / queue to.

Yeah, I gathered that's what it was providing, but that's just barely
not enough information to do something useful. The CPUs that aren't set
have to use a previously assigned vector/queue, but which one?
