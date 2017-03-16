Return-Path: <willy@infradead.org>
Date: Thu, 16 Mar 2017 06:08:24 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	sagi@grimberg.me, avi@scylladb.com, axboe@kernel.dk,
	linux-api@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/8] nowait aio: return if direct write will trigger
 writeback
Message-ID: <20170316130824.GF4033@bombadil.infradead.org>
References: <20170315215107.5628-1-rgoldwyn@suse.de>
 <20170315215107.5628-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170315215107.5628-4-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 15, 2017 at 04:51:02PM -0500, Goldwyn Rodrigues wrote:
> This introduces a new function filemap_range_has_page() which
> returns true if the file's mapping has a page within the range
> mentioned.

I thought you were going to replace this patch with one that starts
writeback for these pages but does not wait for them?
