Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47794 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbdFFVyQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 17:54:16 -0400
Date: Tue, 6 Jun 2017 15:40:07 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Robert Elliott <elliott@hpe.com>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 6/6] sd: add support for TCG OPAL self encrypting disks
Message-ID: <20170606214007.zx66c7rogeylptx6@sbauer-Z170X-UD5>
References: <20170604124225.27032-1-hch@lst.de>
 <20170604124225.27032-7-hch@lst.de>
 <20170605211530.aqxwigcrxgsdvmhs@sbauer-Z170X-UD5>
 <20170606095955.GC20590@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170606095955.GC20590@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 06, 2017 at 11:59:55AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 05, 2017 at 03:15:31PM -0600, Scott Bauer wrote:
> > I'm not familiar at all with ATA, but I noticed there was no unlock from suspend support
> > in the series. Does ATA not have a way to determine if we're coming out of a suspend?
> 
> I don't know, and not having a test system with a OPAL capable driver
> and suspend support I could not even test the code.
> 
> > I see there are some power-ops in scsi/sd.c, if you do want to add it you can mabe toss a
> > 
> > if (sdkp->security)
> >    opal_unlock_from_suspend(sdpk->opal_dev)
> > 
> > somewhere in the resume path? We handle null opal_devs and no unlock from suspend list
> > so calling it when nothing is set up is just a no-op.
> 
> Yeah, maybe.  We'll just need someone who could test it first.

I was given a sata drive that apparently has opal enabled on it. If it actually has opal
I can run some tests.
