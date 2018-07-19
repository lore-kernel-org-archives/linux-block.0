Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:3963 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbeGSVDr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jul 2018 17:03:47 -0400
Date: Thu, 19 Jul 2018 14:18:56 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: "hch@lst.de" <hch@lst.de>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180719201856.GI32160@localhost.localdomain>
References: <20180718195650.GA20336@lst.de>
 <20180718205321.GA32160@localhost.localdomain>
 <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
 <20180718211711.GB32160@localhost.localdomain>
 <20180719131903.GB13129@lst.de>
 <20180719145931.GF32160@localhost.localdomain>
 <20180719155616.GG32160@localhost.localdomain>
 <7239f833438701fb6ce21d819bc7042af1bc1f8a.camel@wdc.com>
 <20180719162240.GH32160@localhost.localdomain>
 <20180719162924.GA23917@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719162924.GA23917@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 19, 2018 at 06:29:24PM +0200, hch@lst.de wrote:
> How do we get a fix into 4.18 at this part of the cycle?  I think that
> is the most important prirority right now.

Even if you were okay at this point to incorporate the concepts from
Bart's patch, it still looks like trouble for scsi (will elobrate
separately).

But reverting breaks other things we finally got working, so I'd
still vote for isolating the old behavior to scsi if that isn't too
unpalatable. I'll send a small patch shortly and see what happens.
