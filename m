Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43157 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbcEKIzW (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 11 May 2016 04:55:22 -0400
Date: Wed, 11 May 2016 10:55:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: NeilBrown <neilb@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
	axboe@fb.com, milosz@adfin.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 4/6] vfs: add the RWF_HIPRI flag for preadv2/pwritev2
Message-ID: <20160511085520.GA20377@lst.de>
References: <1457017443-17662-1-git-send-email-hch@lst.de> <1457017443-17662-5-git-send-email-hch@lst.de> <874ma8usrr.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <874ma8usrr.fsf@notabene.neil.brown.name>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 09, 2016 at 07:47:04AM +1000, NeilBrown wrote:
> On Fri, Mar 04 2016, Christoph Hellwig wrote:
> 
> > This adds a flag that tells the file system that this is a high priority
> > request for which it's worth to poll the hardware.  The flag is purely
> > advisory and can be ignored if not supported.
> 
> Here you say the flag is "advice".
> 
> >  
> > +/* flags for preadv2/pwritev2: */
> > +#define RWF_HIPRI			0x00000001 /* high priority request, poll if possible */
> 
> This text makes it sound like a firm "request" ("if possible").

"request" here is in the sense of an I/O request.  Better wording
highly welcome.

> 
> > provides lower latency, but may use additional ressources
> 
> Is this a "latency vs throughput" trade-off, or something more subtle?
> It would be nice to make the decision process as obvious as possible for
> the developer considering the use of this flag.


If you poll you can't do anything else, so you end up using CPU
cycles to wait which otherwise could do something productive.
