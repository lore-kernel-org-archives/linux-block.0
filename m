Subject: Re: [PATCH 00/10] block: cleanup on direct access to bvec
 table(prepare for multipage bvec)
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
References: <20171208131409.11889-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <dd24b1c7-ac28-89dd-985a-bab54d8192c0@fb.com>
Date: Fri, 5 Jan 2018 12:02:10 -0700
MIME-Version: 1.0
In-Reply-To: <20171208131409.11889-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/8/17 6:13 AM, Ming Lei wrote:
> Hi,
> 
> This patchse cleans up most of direct access to bvec table in tree, and
> these patches are the follow-up of patch1 ~ 16 in the patchset of 'block:
> support multipage bvec(V3)'[1]. 
> 
> Changes against [1]:
> 1) split the cleanup patches from [1]
> 2) address comments from Christoph:
> 	- introduce bio helpers for dealing with the cleanup
> 	- move bio_alloc_pages() to bcache
> 
> 
> [1] https://marc.info/?t=150218197600001&r=1&w=2

Looks like good cleanups to me. I will apply this for 4.16, thanks.

-- 
Jens Axboe
