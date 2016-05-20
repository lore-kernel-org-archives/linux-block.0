Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51053 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166AbcETIBj (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 20 May 2016 04:01:39 -0400
Date: Fri, 20 May 2016 10:01:36 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, hch@lst.de,
	linux-block@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/5] /dev/dax, pmem: direct access to persistent memory
Message-ID: <20160520080136.GG4413@c203.arch.suse.de>
References: <146360496572.37439.6497663679891935585.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146360497642.37439.12866290214925858506.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <146360497642.37439.12866290214925858506.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 18, 2016 at 01:56:16PM -0700, Dan Williams wrote:
> Device DAX is the device-centric analogue of Filesystem DAX
> (CONFIG_FS_DAX).  It allows memory ranges to be allocated and mapped
> without need of an intervening file system.  Device DAX is strict,
> precise and predictable.  Specifically this interface:
> 
> 1/ Guarantees fault granularity with respect to a given page size (pte,
> pmd, or pud) set at configuration time.
> 
> 2/ Enforces deterministic behavior by being strict about what fault
> scenarios are supported.
> 
> For example, by forcing MADV_DONTFORK semantics and omitting MAP_PRIVATE
> support device-dax guarantees that a mapping always behaves/performs the
> same once established.  It is the "what you see is what you get" access
> mechanism to differentiated memory vs filesystem DAX which has
> filesystem specific implementation semantics.
> 
> Persistent memory is the first target, but the mechanism is also
> targeted for exclusive allocations of performance differentiated memory
> ranges.
> 
> This commit is limited to the base device driver infrastructure to
> associate a dax device with pmem range.
> 
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
