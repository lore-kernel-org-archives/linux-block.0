Return-Path: <BATV+0d45ca0e35774f00f1bb+5027+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 29 May 2017 01:32:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	jack@suse.com, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, axboe@kernel.dk,
	linux-api@vger.kernel.org, adam.manzanares@wdc.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/10 v9] No wait AIO
Message-ID: <20170529083217.GB1899@infradead.org>
References: <20170524164150.9492-1-rgoldwyn@suse.de>
 <20170528092728.GA14519@infradead.org>
 <acb0fc57-5005-4422-9c42-3345e892ecb2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <acb0fc57-5005-4422-9c42-3345e892ecb2@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Sun, May 28, 2017 at 09:38:27PM -0500, Goldwyn Rodrigues wrote:
> This effort focused on writes only.
> 
> >From the point of view of the application/user, reads are usually
> required to complete with success. I don't see a scenario where reads()
> would need the nowait feature. If there is a use case, I'd be happy to
> add and support it.

Both of them usually have a point.  And if they would block the
main thread we'll have to offload them to a thread pool.
