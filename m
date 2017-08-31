Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45013 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbdHaUPf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 16:15:35 -0400
Date: Thu, 31 Aug 2017 13:58:01 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, david.fugate@intel.com, axboe@fb.com,
        hch@infradead.org, rafael.antognolli@intel.com
Subject: Re: [PATCH] block: sed-opal: Set MBRDone on S3 resume path if TPER
 is MBREnabled
Message-ID: <20170831195759.nsnwys2lvgrxbvg4@sbauer-Z170X-UD5>
References: <20170831174238.2714-1-scott.bauer@intel.com>
 <f8da2845-bc33-8afb-2695-958b0a7425f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f8da2845-bc33-8afb-2695-958b0a7425f1@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 31, 2017 at 02:10:36PM -0600, Jon Derrick wrote:
> Hey Scott,
> > +static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
> > +{
> > +	u8 mbr_done_tf = 1;
> > +	const struct opal_step mbrdone_step [] = {
> > +		{ opal_discovery0, },
> > +		{ start_admin1LSP_opal_session, key },
> > +		{ set_mbr_done, &mbr_done_tf },
> Do you need to end_opal_session here?
>
Yep, sure do. I'll wait for Christoph to look at it tonight before spinning another.
> > +		{ NULL, }
> > +	};
> > +
