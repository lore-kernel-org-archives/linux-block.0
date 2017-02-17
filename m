Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13012 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934122AbdBQRFj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 12:05:39 -0500
Date: Fri, 17 Feb 2017 09:55:51 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, jonathan.derrick@intel.com,
        axboe@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: re-check security protocol support after reset
Message-ID: <20170217165551.GA2062@sbauer-Z170X-UD5>
References: <20170217125941.14319-1-hch@lst.de>
 <20170217125941.14319-5-hch@lst.de>
 <20170217152651.GA18275@localhost.localdomain>
 <20170217170128.GA29208@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217170128.GA29208@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 17, 2017 at 06:01:28PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 17, 2017 at 10:26:51AM -0500, Keith Busch wrote:
> > On Fri, Feb 17, 2017 at 01:59:41PM +0100, Christoph Hellwig wrote:
> > > @@ -1789,7 +1789,8 @@ static void nvme_reset_work(struct work_struct *work)
> > >  	if (result)
> > >  		goto out;
> > >  
> > > -	if ((dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) && !dev->ctrl.opal_dev) {
> > > +	kfree(dev->ctrl.opal_dev);
> > > +	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
> > >  		dev->ctrl.opal_dev =
> > >  			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
> > >  	}
> > 
> > A couple things.
> > 
> > This has a use-after-free in opal_unlock_from_suspend if the nvme
> > device had an opal_dev before, but no longer support the capability
> > after resume. So you'd want to set ctrl.opal_dev to NULL after the free.
> > 
> > But we don't want to unconditionally free it anyway during resume
> > since opal_unlock_from_suspend requires the exisiting opal_dev state
> > information saved in the 'unlk_list'.
> > 
> > Something like this instead:
> 
> Yes, that looks fine to me.  We'll probably also need the additional
> fixup Scott pointed out.

I'm working on it now. Do you want a diff like Keith did or a separate patch?
