Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49863 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbcEJO3m (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 10:29:42 -0400
Date: Tue, 10 May 2016 16:29:36 +0200
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
	Boaz Harrosh <boaz@plexistor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v5 5/5] dax: fix a comment in dax_zero_page_range and
 dax_truncate_page
Message-ID: <20160510142936.GO11897@quack2.suse.cz>
References: <1462571591-3361-1-git-send-email-vishal.l.verma@intel.com>
 <1462571591-3361-6-git-send-email-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462571591-3361-6-git-send-email-vishal.l.verma@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri 06-05-16 15:53:11, Vishal Verma wrote:
> The distinction between PAGE_SIZE and PAGE_CACHE_SIZE was removed in
> 
> 09cbfea mm, fs: get rid of PAGE_CACHE_* and page_cache_{get,release}
> macros
> 
> The comments for the above functions described a distinction between
> those, that is now redundant, so remove those paragraphs
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
