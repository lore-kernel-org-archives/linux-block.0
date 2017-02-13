Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8226 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbdBMQjQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 11:39:16 -0500
Date: Mon, 13 Feb 2017 09:29:42 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "axboe@fb.com" <axboe@fb.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V5 3/4] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
Message-ID: <20170213162941.GB18913@sbauer-Z170X-UD5>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
 <1487002272-17940-4-git-send-email-scott.bauer@intel.com>
 <063D6719AE5E284EB5DD2968C1650D6DB028519B@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB028519B@AcuExch.aculab.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Feb 13, 2017 at 04:30:36PM +0000, David Laight wrote:
> From: Scott Bauer Sent: 13 February 2017 16:11
> > When CONFIG_KASAN is enabled, compilation fails:
> > 
> > block/sed-opal.c: In function 'sed_ioctl':
> > block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-
> > larger-than=]
> > 
> > Moved all the ioctl structures off the stack and dynamically activate
> > using _IOC_SIZE()
> 
> Think I'd not that this simplifies the code considerably.
> AFAICT CONFIG_KASAN is a just brainf*ck.
> It at least needs annotation that copy_from_user() has properties
> similar to memset().
> So if the size matches that of the type then no guard space (etc)
> is required.
>

I don't really follow what you're saying. Do you want me to just include that
the patch cleans up the ioctl path a bit. I need to include the KASAN part since
there was build breakage and the series does fix it even if it simplifies the path
as well. As for the memset part, we never copy back to userland so there's no chance
of data leakage which is what it seems you're hinting at.

> ...
> > +	ioctl_ptr = memdup_user(arg,  _IOC_SIZE(cmd));
> > +	if (IS_ERR_OR_NULL(ioctl_ptr)) {
> > +		ret = PTR_ERR(ioctl_ptr);
> > +		goto out;
> ...
> > + out:
> > +	kfree(ioctl_ptr);
> > +	return ret;
> >  }


> 
> That error path doesn't look quite right to me.
> 
> 	David
> 

good god, this is a mess this morning. Thanks for the catch, I'll review these
more aggressively before sending out. 
