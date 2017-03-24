Subject: Re: [PATCH] block: remove bio_clone_bioset_partial()
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
References: <99da2cea22d37790b5ca93f07da3b16f890d16c2.1490377861.git.shli@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <7f2fa047-6ff4-84a6-c8db-97b72d8d1378@fb.com>
Date: Fri, 24 Mar 2017 12:11:44 -0600
MIME-Version: 1.0
In-Reply-To: <99da2cea22d37790b5ca93f07da3b16f890d16c2.1490377861.git.shli@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/24/2017 11:55 AM, Shaohua Li wrote:
> commit c18a1e0(block: introduce bio_clone_bioset_partial()) introduced
> bio_clone_bioset_partial() for raid1 write behind IO. Now the write behind is
> rewritten by Ming. We don't need the API any more, so revert the commit.
> 
> Jens,
> this depends on Ming's patches, so it would be great I put this to md branch.

Looks fine to me, feel free to do so.

Reviewed-by: Jens Axboe <axboe@fb.com>

-- 
Jens Axboe
