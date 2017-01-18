Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbdARGHm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 01:07:42 -0500
Date: Tue, 17 Jan 2017 22:07:40 -0800
From: willy@bombadil.infradead.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-block@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Subject: Re: [LSF/MM TOPIC] Future direction of DAX
Message-ID: <20170118060740.GE18349@bombadil.infradead.org>
References: <20170114002008.GA25379@linux.intel.com>
 <20170118052533.GA18349@bombadil.infradead.org>
 <CAPcyv4jNz=1QdPPtM2A=3avGtVvZG=2d9JC-JD_F6u+-CYQN4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4jNz=1QdPPtM2A=3avGtVvZG=2d9JC-JD_F6u+-CYQN4g@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 17, 2017 at 10:01:30PM -0800, Dan Williams wrote:
> >> - Jan suggested [2] that we could use the radix tree as a cache to service DAX
> >>   faults without needing to call into the filesystem.  Are there any issues
> >>   with this approach, and should we move forward with it as an optimization?
> >
> > Ahem.  I believe I proposed this at last year's LSFMM.  And I sent
> > patches to start that work.  And Dan blocked it.  So I'm not terribly
> > amused to see somebody else given credit for the idea.
> 
> I "blocked" moving the phys to virt translation out of the driver
> since that mapping lifetime is device specific.

The problem is that DAX currently assumes that there *is* a block driver,
and it might be a char device or no device at all (the two examples I
gave earlier).

> However, I think caching the file offset to physical sector/address
> result is a great idea.

OK, great.  The lifetime problem I think you care about (hotplug) can be
handled by removing all the cached entries for every file on every file
on that block device ... I know there were prototype patches for that;
did they ever get merged?
