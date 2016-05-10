Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49055 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbcEJOPv (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 10:15:51 -0400
Date: Tue, 10 May 2016 16:15:44 +0200
From: Jan Kara <jack@suse.cz>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-nvdimm@lists.01.org, Dan Williams <dan.j.williams@intel.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	xfs@oss.sgi.com, linux-ext4@vger.kernel.org, linux-mm@kvack.org,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Moyer <jmoyer@redhat.com>,
	Boaz Harrosh <boaz@plexistor.com>
Subject: Re: [PATCH v5 1/5] dax: fallback from pmd to pte on error
Message-ID: <20160510141544.GL11897@quack2.suse.cz>
References: <1462571591-3361-1-git-send-email-vishal.l.verma@intel.com>
 <1462571591-3361-2-git-send-email-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462571591-3361-2-git-send-email-vishal.l.verma@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri 06-05-16 15:53:07, Vishal Verma wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> In preparation for consulting a badblocks list in pmem_direct_access(),
> teach dax_pmd_fault() to fallback rather than fail immediately upon
> encountering an error.  The thought being that reducing the span of the
> dax request may avoid the error region.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

The patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
