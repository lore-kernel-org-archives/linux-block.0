Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11488 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbdARRYF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 12:24:05 -0500
Date: Wed, 18 Jan 2017 10:22:16 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: willy@bombadil.infradead.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM TOPIC] Future direction of DAX
Message-ID: <20170118172216.GA20111@linux.intel.com>
References: <20170114002008.GA25379@linux.intel.com>
 <20170118052533.GA18349@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170118052533.GA18349@bombadil.infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 17, 2017 at 09:25:33PM -0800, willy@bombadil.infradead.org wrote:
> On Fri, Jan 13, 2017 at 05:20:08PM -0700, Ross Zwisler wrote:
> > We still have a lot of work to do, though, and I'd like to propose a discussion
> > around what features people would like to see enabled in the coming year as
> > well as what what use cases their customers have that we might not be aware of.
> 
> +1 to the discussion
> 
> > - Jan suggested [2] that we could use the radix tree as a cache to service DAX
> >   faults without needing to call into the filesystem.  Are there any issues
> >   with this approach, and should we move forward with it as an optimization?
> 
> Ahem.  I believe I proposed this at last year's LSFMM.  And I sent
> patches to start that work.  And Dan blocked it.  So I'm not terribly
> amused to see somebody else given credit for the idea.
> 
> It's not just an optimisation.  It's also essential for supporting
> filesystems which don't have block devices.  I'm aware of at least two
> customer demands for this in different domains.
> 
> 1. Embedded uses with NOR flash
> 2. Cloud/virt uses with multiple VMs on a single piece of hardware

Yea, I didn't mean the full move to having PFNs in the tree, just using the
sector number in the radix tree instead of calling into the filesystem.

My apologies if you feel I didn't give you proper credit.
