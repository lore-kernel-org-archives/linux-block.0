Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Thu, 12 May 2016 10:41:38 +0200
From: Jan Kara <jack@suse.cz>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	xfs@oss.sgi.com, linux-ext4@vger.kernel.org, linux-mm@kvack.org,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Moyer <jmoyer@redhat.com>,
	Boaz Harrosh <boaz@plexistor.com>
Subject: Re: [PATCH v7 4/6] dax: export a low-level __dax_zero_page_range
 helper
Message-ID: <20160512084138.GC10306@quack2.suse.cz>
References: <1463000932-31680-1-git-send-email-vishal.l.verma@intel.com>
 <1463000932-31680-5-git-send-email-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463000932-31680-5-git-send-email-vishal.l.verma@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed 11-05-16 15:08:50, Vishal Verma wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> This allows XFS to perform zeroing using the iomap infrastructure and
> avoid buffer heads.
> 
> [vishal: fix conflicts with dax-error-handling]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW: You are supposed to add your Signed-off-by when forwarding patches
like this...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
