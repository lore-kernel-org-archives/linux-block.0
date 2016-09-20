Return-Path: <linux-block-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58418 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbcITJAu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2016 05:00:50 -0400
Date: Tue, 20 Sep 2016 10:58:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alexander Gordeev <agordeev@redhat.com>
cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] genirq/msi: Add cpumask allocation to
 alloc_msi_entry
In-Reply-To: <20160920070651.GA26808@agordeev.lab.eng.brq.redhat.com>
Message-ID: <alpine.DEB.2.20.1609201058020.6905@nanos>
References: <1473862739-15032-1-git-send-email-hch@lst.de> <1473862739-15032-2-git-send-email-hch@lst.de> <20160919073057.GA31001@agordeev.lab.eng.brq.redhat.com> <20160919135007.GC28585@lst.de> <20160920070651.GA26808@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 20 Sep 2016, Alexander Gordeev wrote:
> On Mon, Sep 19, 2016 at 03:50:07PM +0200, Christoph Hellwig wrote:
> > On Mon, Sep 19, 2016 at 09:30:58AM +0200, Alexander Gordeev wrote:
> > > >  	INIT_LIST_HEAD(&desc->list);
> > > >  	desc->dev = dev;
> > > > +	desc->nvec_used = nvec;
> 
> (*)
> 
> > > > +	if (affinity) {
> > > > +		desc->affinity = kmemdup(affinity,
> > > > +			nvec * sizeof(*desc->affinity), GFP_KERNEL);
> > > > +		if (!desc->affinity) {
> > > > +			kfree(desc);
> > > > +			return NULL;
> > > > +		}
> > > > +	}
> > > 
> > > nit - should not "desc" initialization follow "desc->affinity" allocation?
> > 
> > I can't parse that sentence.  Do you mean the desc->nvec_used setup?
> 
> Yes, the inits above (*) would be useless if desc->affinity allocation failed.

And that matters how?

Thanks,

	tglx
 
