Subject: Re: [PATCH 4/6] blk-mq: don't bypass scheduler for reserved requests
To: Christoph Hellwig <hch@lst.de>
References: <1493389911-19512-1-git-send-email-axboe@fb.com>
 <1493389911-19512-5-git-send-email-axboe@fb.com>
 <20170428144155.GD1443@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <5d51dab9-3191-2148-431f-dde6c8a89040@fb.com>
Date: Fri, 28 Apr 2017 08:45:07 -0600
MIME-Version: 1.0
In-Reply-To: <20170428144155.GD1443@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/28/2017 08:41 AM, Christoph Hellwig wrote:
> On Fri, Apr 28, 2017 at 08:31:49AM -0600, Jens Axboe wrote:
>> Instead of bypassing the scheduler for insertion of reserved requests,
>> we ensure that the request is marked as RQF_RESERVED so they driver
>> knows where it came from.
>>
>> Usually we just use the tag to know if it's reserved or not,
>> but that only works when the request has a driver tag assigned.
>> Using RQF_RESERVED can be done independently of whether or not
>> scheduling is used.
> 
> Do we really need a flag for this?  If anyone cares if a request
> is internal it can just check ->tag / ->internal_tag is smaller
> than ->nr_reserved_tags using a little helper.
> 
> I'd really like to keep the number of flags down as much as possible.

Ming had the same comment. Once we enter ->queue_rq() and later we don't
need the flag, since ->tag has been assigned and the regular helper
works fine. We can kill it. I forgot about this in the previous reply,
but it was meant to pass the fact that this was a reserved request to
get_driver_tag(), but it doesn't need that, since we already use the
regular helper against ->internal_tag.

I'll drop this patch.

-- 
Jens Axboe
