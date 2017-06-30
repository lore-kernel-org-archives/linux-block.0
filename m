Return-Path: <rgoldwyn@suse.de>
Subject: Re: [PATCH 3/3] fs: support RWF_NOWAIT for buffered reads
To: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk, axboe@kernel.dk
Cc: Milosz Tanski <milosz@adfin.com>, mgorman@suse.de,
 Volker.Lendecke@sernet.de, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20170630181521.29148-1-hch@lst.de>
 <20170630181521.29148-4-hch@lst.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <cf9a1c58-5b6d-5f2c-8a3d-de89794ed12c@suse.de>
Date: Fri, 30 Jun 2017 15:19:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170630181521.29148-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 06/30/2017 01:15 PM, Christoph Hellwig wrote:
> This is based on the old idea and code from Milosz Tanski.  With the
> aio nowait code it becomes mostly trivial now.
> 

Looks Good.
Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

-- 
Goldwyn
