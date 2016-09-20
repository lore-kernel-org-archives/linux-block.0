Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbcITHA5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2016 03:00:57 -0400
Date: Tue, 20 Sep 2016 09:06:52 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, tglx@linutronix.de, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] genirq/msi: Add cpumask allocation to
 alloc_msi_entry
Message-ID: <20160920070651.GA26808@agordeev.lab.eng.brq.redhat.com>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
 <1473862739-15032-2-git-send-email-hch@lst.de>
 <20160919073057.GA31001@agordeev.lab.eng.brq.redhat.com>
 <20160919135007.GC28585@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160919135007.GC28585@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 19, 2016 at 03:50:07PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 19, 2016 at 09:30:58AM +0200, Alexander Gordeev wrote:
> > >  	INIT_LIST_HEAD(&desc->list);
> > >  	desc->dev = dev;
> > > +	desc->nvec_used = nvec;

(*)

> > > +	if (affinity) {
> > > +		desc->affinity = kmemdup(affinity,
> > > +			nvec * sizeof(*desc->affinity), GFP_KERNEL);
> > > +		if (!desc->affinity) {
> > > +			kfree(desc);
> > > +			return NULL;
> > > +		}
> > > +	}
> > 
> > nit - should not "desc" initialization follow "desc->affinity" allocation?
> 
> I can't parse that sentence.  Do you mean the desc->nvec_used setup?

Yes, the inits above (*) would be useless if desc->affinity allocation failed.
