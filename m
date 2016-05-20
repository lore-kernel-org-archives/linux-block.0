Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932526AbcETJlw (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 20 May 2016 05:41:52 -0400
Date: Fri, 20 May 2016 17:41:48 +0800
From: Xiong Zhou <xzhou@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@ml01.01.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, hch@lst.de,
	linux-block@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/5] /dev/dax, pmem: direct access to persistent memory
Message-ID: <20160520094148.GE5035@dhcp12-144.nay.redhat.com>
References: <146360496572.37439.6497663679891935585.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146360497642.37439.12866290214925858506.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
> ---
>  drivers/Kconfig                     |    2 
>  drivers/Makefile                    |    1 
>  drivers/dax/Kconfig                 |   25 +++
>  drivers/dax/Makefile                |    4 +
>  drivers/dax/dax.c                   |  253 +++++++++++++++++++++++++++++++++++
>  drivers/dax/dax.h                   |   24 +++
>  drivers/dax/pmem.c                  |  158 ++++++++++++++++++++++

An entry in MAINTAINERS for these new files ?

Thanks,
Xiong
