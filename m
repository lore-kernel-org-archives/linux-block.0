Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:28211 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753039AbdKFOik (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Nov 2017 09:38:40 -0500
Date: Mon, 6 Nov 2017 07:43:04 -0700
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 1/3] nvme: do not check for ns on rw path
Message-ID: <20171106144303.GA11677@localhost.localdomain>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-2-git-send-email-javier@cnexlabs.com>
 <20171103125339.GA25186@lst.de>
 <20171103150203.GA11300@localhost.localdomain>
 <20171104081825.GA19180@lst.de>
 <20171104153844.GA12777@localhost.localdomain>
 <20171106091323.GA30382@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171106091323.GA30382@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 06, 2017 at 10:13:24AM +0100, Christoph Hellwig wrote:
> On Sat, Nov 04, 2017 at 09:38:45AM -0600, Keith Busch wrote:
> > That's not quite right. For non-PI metadata formats, we use the
> > 'nop_profile', which gets the metadata buffer allocated so we can safely
> > use a metadata formatted namespace. There's no in-kernel user of the
> > allocated payload, but we still need the metadata buffer in order to
> > use the namespace at all.
> 
> You're right.  But that means we will indeed always have a matching
> integrity payload here and the check should not be needed.
> 
> Are you fine with turning it into something like:
> 
> 	if (WARN_ON_ONCE(ns->ms && !blk_integrity_rq(req)))
> 		return BLK_STS_IOERR;
> 
> ?

Yes, that looks fine. You're right that we are not supposed to be able
to get into this path for read/write since the driver sets the capacity
to 0 if a metadata format doesn't have integrity support, so hitting
this warning would indicate something has gone wrong.
