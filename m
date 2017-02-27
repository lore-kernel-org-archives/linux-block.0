Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:14501 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbdB0SmL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 13:42:11 -0500
Date: Mon, 27 Feb 2017 13:50:17 -0500
From: Keith Busch <keith.busch@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@infradead.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] lightnvm: add generic ocssd detection
Message-ID: <20170227185016.GC5789@localhost.localdomain>
References: <20170224171649.27409-1-matias@cnexlabs.com>
 <20170225182117.GA26447@infradead.org>
 <8cce0bfd-a153-ba4e-0d84-bea29764982e@cnexlabs.com>
 <20170226064701.GA7557@infradead.org>
 <108882ac-9f55-e4f5-c04e-244848139db8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <108882ac-9f55-e4f5-c04e-244848139db8@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Feb 27, 2017 at 08:35:06PM +0200, Sagi Grimberg wrote:
> > On Sat, Feb 25, 2017 at 08:16:04PM +0100, Matias Bj�rling wrote:
> > > On 02/25/2017 07:21 PM, Christoph Hellwig wrote:
> > > > No way in hell.  vs is vendor specific and we absolutely can't overload
> > > > it with any sort of meaning.  Get OCSSD support properly standardized and
> > > > add a class code for it.  Until then it's individual PCI IDs.
> > > > 
> > > 
> > > You are right, that is the right way to go, and we are working on it. In the
> > > meantime, there are a couple of reasons I want to do a pragmatic solution:
> > 
> > Reasonable reaosons, but that's just not how standard interfaces work.
> > Either you standardize the behaviour and have a standardized trigger
> > for it, or it is vendor specific and needs to be keyed off a specific
> > vendor/device identification.
> 
> I agree, I don't see how we're allowed to use vs for that.

>From personal experience, some OEMs will put whatever they want in the
VS region for their rebranded device, making it an unreliable place to
check for a capability.
