Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16117 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbcLASMD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Dec 2016 13:12:03 -0500
Date: Thu, 1 Dec 2016 13:22:39 -0500
From: Keith Busch <keith.busch@intel.com>
To: Scott Bauer <scott.bauer@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, sagi@grimberg.me,
        Rafael.Antognolli@intel.com, linux-nvme@lists.infradead.org,
        axboe@fb.com, linux-block@vger.kernel.org,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de
Subject: Re: [PATCH v2 2/4] block: Add Sed-opal library
Message-ID: <20161201182239.GH21081@localhost.localdomain>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
 <20161201005006.GE21081@localhost.localdomain>
 <20161201100456.GA17592@infradead.org>
 <20161201175343.GA6554@sbauer-Z170X-UD5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161201175343.GA6554@sbauer-Z170X-UD5>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Dec 01, 2016 at 10:53:43AM -0700, Scott Bauer wrote:
> > Maybe.  I need to look at the TCG spec again (oh my good, what a fucking
> > mess), but if I remember the context if it is the whole nvme controller
> > and not just a namespace, so a block_device might be the wrong context.
> > Then again we can always go from the block_device to the controller
> > fairly easily.  So instead of adding the security operation to the
> > block_device_operations which we don't really need for now maybe we
> > should add a security_conext to the block device so that we can avoid
> > all the lookup code?
> 
> I spent some time this morning reading through the numerous specs/documents,
> with a lot of coffee.
> 
> Specifically in:
> https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_SWG_SIIS_Version_1_02_Revision_1_00_20111230.pdf
> 
> 5.5.2
> Namespace
> 
> A target that has multiple Namespaces MAY have  multiple TPers. Each TPer
> SHALL be associated with a different Namespace. Every Namespace on a device
> is not required to have a TPer, but Namespaces that support the TCG Core
> specification commands and functionality SHALL have a TPer. A TPer SHALL only
> be associated with exactly one Namespace. A Namespace MAY have no TPer.
> 
> From reading that it seems we will probably have to keep it at the block layer,
> since its possible to have a valid "Locking range 1" on n1 and a "Locking range 1"
> on n2.

Thanks for tracking that down! Specifically for NVMe, security
send/recieve requires NSID, so it is a little more difficult to get to
that if we're not using the abstracton that contains the namespace.
