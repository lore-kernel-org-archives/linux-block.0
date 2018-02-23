Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] block: pass inclusive 'lend' parameter to
 truncate_inode_pages_range
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, stable@vger.kernel.org,
 Dmitry Monakhov <dmonakhov@openvz.org>
References: <20180210004617.3071-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5df369da-3890-e9d6-d444-11e2ea52a315@kernel.dk>
Date: Fri, 23 Feb 2018 15:20:24 -0700
MIME-Version: 1.0
In-Reply-To: <20180210004617.3071-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/9/18 5:46 PM, Ming Lei wrote:
> The 'lend' parameter of truncate_inode_pages_range is required to be
> inclusive, so follow the rule.
> 
> This patch fixes one memory corruption triggered by discard.

Applied, thanks.

-- 
Jens Axboe
