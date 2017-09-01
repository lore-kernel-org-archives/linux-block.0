Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdIAHb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Sep 2017 03:31:28 -0400
Date: Fri, 1 Sep 2017 00:31:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Scott Bauer <scott.bauer@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, david.fugate@intel.com, axboe@fb.com,
        hch@infradead.org, rafael.antognolli@intel.com
Subject: Re: [PATCH] block: sed-opal: Set MBRDone on S3 resume path if TPER
 is MBREnabled
Message-ID: <20170901073127.GA9417@infradead.org>
References: <20170831174238.2714-1-scott.bauer@intel.com>
 <f8da2845-bc33-8afb-2695-958b0a7425f1@intel.com>
 <20170831195759.nsnwys2lvgrxbvg4@sbauer-Z170X-UD5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170831195759.nsnwys2lvgrxbvg4@sbauer-Z170X-UD5>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 31, 2017 at 01:58:01PM -0600, Scott Bauer wrote:
> > > +		{ set_mbr_done, &mbr_done_tf },
> > Do you need to end_opal_session here?
> >
> Yep, sure do. I'll wait for Christoph to look at it tonight before spinning another.

No additional comment from me, please just resend with that fix.
