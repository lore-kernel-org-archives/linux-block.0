Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34259 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbcELIi5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 12 May 2016 04:38:57 -0400
Date: Thu, 12 May 2016 10:38:52 +0200
From: Jan Kara <jack@suse.cz>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, xfs@oss.sgi.com,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Moyer <jmoyer@redhat.com>,
	Boaz Harrosh <boaz@plexistor.com>
Subject: Re: [PATCH v7 5/6] dax: for truncate/hole-punch, do zeroing through
 the driver if possible
Message-ID: <20160512083852.GB10306@quack2.suse.cz>
References: <1463000932-31680-1-git-send-email-vishal.l.verma@intel.com>
 <1463000932-31680-6-git-send-email-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463000932-31680-6-git-send-email-vishal.l.verma@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed 11-05-16 15:08:51, Vishal Verma wrote:
> In the truncate or hole-punch path in dax, we clear out sub-page ranges.
> If these sub-page ranges are sector aligned and sized, we can do the
> zeroing through the driver instead so that error-clearing is handled
> automatically.
> 
> For sub-sector ranges, we still have to rely on clear_pmem and have the
> possibility of tripping over errors.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

The patch looks good to me now. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
