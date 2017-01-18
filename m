Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbdARFpK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 00:45:10 -0500
Date: Tue, 17 Jan 2017 21:25:33 -0800
From: willy@bombadil.infradead.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM TOPIC] Future direction of DAX
Message-ID: <20170118052533.GA18349@bombadil.infradead.org>
References: <20170114002008.GA25379@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170114002008.GA25379@linux.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 13, 2017 at 05:20:08PM -0700, Ross Zwisler wrote:
> We still have a lot of work to do, though, and I'd like to propose a discussion
> around what features people would like to see enabled in the coming year as
> well as what what use cases their customers have that we might not be aware of.

+1 to the discussion

> - Jan suggested [2] that we could use the radix tree as a cache to service DAX
>   faults without needing to call into the filesystem.  Are there any issues
>   with this approach, and should we move forward with it as an optimization?

Ahem.  I believe I proposed this at last year's LSFMM.  And I sent
patches to start that work.  And Dan blocked it.  So I'm not terribly
amused to see somebody else given credit for the idea.

It's not just an optimisation.  It's also essential for supporting
filesystems which don't have block devices.  I'm aware of at least two
customer demands for this in different domains.

1. Embedded uses with NOR flash
2. Cloud/virt uses with multiple VMs on a single piece of hardware

