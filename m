Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:43837 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbdBPUHI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 15:07:08 -0500
Date: Thu, 16 Feb 2017 12:07:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Scott Bauer <scott.bauer@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] opal: Use empty structure when not defined
Message-ID: <20170216200708.GA16140@infradead.org>
References: <1487204187-4004-1-git-send-email-keith.busch@intel.com>
 <20170216075812.GA7662@infradead.org>
 <20170216184528.GA3899@sbauer-Z170X-UD5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170216184528.GA3899@sbauer-Z170X-UD5>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 16, 2017 at 11:45:29AM -0700, Scott Bauer wrote:
> > +	if (check_opal_support(dev) < 0) {
> >  		pr_warn("Opal is not supported on this device\n");
> > -	opal_dev->initialized = true;
> > +		kfree(dev);
> > +		return NULL;
> 
> We're going to have to change this check_opal_support to be != 0 instead of < 0.

Yes.  And we should simply turn all these printk into pr_debug anway -
not having OPAL is a prefectly fine condition, no need to spam the log
for it.

And btw, I think we should check for bit 0 in OACS before ever doing
a security send / receive.
