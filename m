Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50778 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463AbcETH6h (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 20 May 2016 03:58:37 -0400
Date: Fri, 20 May 2016 09:58:33 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/5] /dev/dax, core: file operations and dax-mmap
Message-ID: <20160520075833.GF4413@c203.arch.suse.de>
References: <146360496572.37439.6497663679891935585.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146360498206.37439.343951904240579439.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <146360498206.37439.343951904240579439.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 18, 2016 at 01:56:22PM -0700, Dan Williams wrote:
> The "Device DAX" core enables dax mappings of performance / feature
> differentiated memory.  An open mapping or file handle keeps the backing
> struct device live, but new mappings are only possible while the device
> is enabled.   Faults are handled under rcu_read_lock to synchronize
> with the enabled state of the device.
> 
> Similar to the filesystem-dax case the backing memory may optionally
> have struct page entries.  However, unlike fs-dax there is no support
> for private mappings, or mappings that are not backed by media (see
> use of zero-page in fs-dax).
> 
> Mappings are always guaranteed to match the alignment of the dax_region.
> If the dax_region is configured to have a 2MB alignment, all mappings
> are guaranteed to be backed by a pmd entry.  Contrast this determinism
> with the fs-dax case where pmd mappings are opportunistic.  If userspace
> attempts to force a misaligned mapping, the driver will fail the mmap
> attempt.  See dax_dev_check_vma() for other scenarios that are rejected,
> like MAP_PRIVATE mappings.
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Acked-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

OK from my side,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
