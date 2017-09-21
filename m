Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751436AbdIUFWU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 01:22:20 -0400
Date: Thu, 21 Sep 2017 07:22:17 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] nvme: track shared namespaces
Message-ID: <20170921052217.kmrcmsf4gttubsyd@linux-x5ow.site>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-9-hch@lst.de>
 <20170920083643.xe6dbr4iu53hhm5t@linux-x5ow.site>
 <20170920145436.GA4709@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170920145436.GA4709@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 20, 2017 at 04:54:36PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 20, 2017 at 10:36:43AM +0200, Johannes Thumshirn wrote:
> > Being one of the persons who has to backport a lot of NVMe code to older
> > kernels I'm not a huge fan of renaming nmve_ns.
> 
> The churn is main main worry.  Well and that I don't have a reall good
> name for what currently is nvme_ns either :)
> 
> > That said, I don't have a better name for nvme_ns_head (yet) but I'll try to
> > think of one as well. OTOH looking at nvme_ns_head it actaully is the list
> > head of the nvme_ns list.
> 
> But head also has connotations in the SAN world.  Maybe nvme_ns_chain?

I know that's why I didn't really like it all too much in the first place as
well. For nvme_ns_chain, it's not a chain really (the list itself is a chain,
the structure really is the list head...), but I suck at naming things so.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
