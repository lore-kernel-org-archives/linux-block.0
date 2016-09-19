Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44116 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758527AbcISNuI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 09:50:08 -0400
Date: Mon, 19 Sep 2016 15:50:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, tglx@linutronix.de,
        keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] genirq/msi: Add cpumask allocation to
        alloc_msi_entry
Message-ID: <20160919135007.GC28585@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de> <1473862739-15032-2-git-send-email-hch@lst.de> <20160919073057.GA31001@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160919073057.GA31001@agordeev.lab.eng.brq.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 19, 2016 at 09:30:58AM +0200, Alexander Gordeev wrote:
> >  	INIT_LIST_HEAD(&desc->list);
> >  	desc->dev = dev;
> > +	desc->nvec_used = nvec;
> > +	if (affinity) {
> > +		desc->affinity = kmemdup(affinity,
> > +			nvec * sizeof(*desc->affinity), GFP_KERNEL);
> > +		if (!desc->affinity) {
> > +			kfree(desc);
> > +			return NULL;
> > +		}
> > +	}
> 
> nit - should not "desc" initialization follow "desc->affinity" allocation?

I can't parse that sentence.  Do you mean the desc->nvec_used setup?
