Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9372 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932975AbdBPVCq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 16:02:46 -0500
Date: Thu, 16 Feb 2017 13:52:44 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] opal: Use empty structure when not defined
Message-ID: <20170216205244.GC3732@sbauer-Z170X-UD5>
References: <1487204187-4004-1-git-send-email-keith.busch@intel.com>
 <20170216075812.GA7662@infradead.org>
 <20170216184528.GA3899@sbauer-Z170X-UD5>
 <20170216200708.GA16140@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170216200708.GA16140@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 16, 2017 at 12:07:08PM -0800, Christoph Hellwig wrote:
> On Thu, Feb 16, 2017 at 11:45:29AM -0700, Scott Bauer wrote:
> > > +	if (check_opal_support(dev) < 0) {
> > >  		pr_warn("Opal is not supported on this device\n");
> > > -	opal_dev->initialized = true;
> > > +		kfree(dev);
> > > +		return NULL;
> > 
> > We're going to have to change this check_opal_support to be != 0 instead of < 0.
> 
> Yes.  And we should simply turn all these printk into pr_debug anway -
> not having OPAL is a prefectly fine condition, no need to spam the log
> for it.
> 
> And btw, I think we should check for bit 0 in OACS before ever doing
> a security send / receive.

That sounds reasonable. It can go in the nvme_send_recv function before we
actually attempt to send anything. The code paths fall nicely in that when
we attempt to look for support we have to do a discovery0 which will fail
on the OACS bit and we'll deallocate everything.

I'll spin this up now.
