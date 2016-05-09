Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36191 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbcEIM5h (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2016 08:57:37 -0400
Date: Mon, 9 May 2016 05:57:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@ml01.01.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jeff Moyer <jmoyer@redhat.com>, Jan Kara <jack@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH 0/7] "Device DAX" for persistent memory
Message-ID: <20160509125735.GA4476@infradead.org>
References: <146274690999.10891.10714722986208180484.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <146274690999.10891.10714722986208180484.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, May 08, 2016 at 03:35:10PM -0700, Dan Williams wrote:
> Device DAX is the device-centric analogue of Filesystem DAX
> (CONFIG_FS_DAX).  It allows memory ranges to be allocated and mapped
> without need of an intervening file system or being bound to block
> device semantics.  Device DAX is strict and predictable.  Specifically
> this interface:

Can you explain the "why" a little more?

And please, if you decide to Cc me on some of the patches do it for the
whole series or none of it, but never just for some patches as that make
the cc pretty pointless.
