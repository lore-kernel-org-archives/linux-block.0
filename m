Subject: Re: [PATCH 4/8] writeback: track if we're sleeping on progress in
 balance_dirty_pages()
To: Christoph Hellwig <hch@lst.de>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-5-git-send-email-axboe@fb.com>
 <20161102145703.GH13964@lst.de>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, jack@suse.cz
From: Jens Axboe <axboe@fb.com>
Message-ID: <43669b76-06b0-8dd5-8334-a40936b47e6a@fb.com>
Date: Wed, 2 Nov 2016 08:59:20 -0600
MIME-Version: 1.0
In-Reply-To: <20161102145703.GH13964@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/02/2016 08:57 AM, Christoph Hellwig wrote:
> On Tue, Nov 01, 2016 at 03:08:47PM -0600, Jens Axboe wrote:
>> Note in the bdi_writeback structure whenever a task ends up sleeping
>> waiting for progress. We can use that information in the lower layers
>> to increase the priority of writes.
>
> Do we need to care about atomicy of multiple threads updating the value
> ?
>
> Otherwise this looks fine.

Don't think we have to care about it too much, it's a soft hint similar
wb->dirty_exceeded.

-- 
Jens Axboe
