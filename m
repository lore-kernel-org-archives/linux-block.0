Subject: Re: [PATCH] block: add back plugging in __blkdev_direct_IO
To: Christoph Hellwig <hch@infradead.org>
References: <1482430845-28938-1-git-send-email-hch@lst.de>
 <b6c3764a-f43d-dc47-655f-3d38ea8276ff@fb.com>
 <20161222182912.GA22997@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, loberman@redhat.com,
 linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <3dd795f7-dd94-a71b-e797-8f0a0a655e33@fb.com>
Date: Thu, 22 Dec 2016 11:31:02 -0700
MIME-Version: 1.0
In-Reply-To: <20161222182912.GA22997@infradead.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/22/2016 11:29 AM, Christoph Hellwig wrote:
> On Thu, Dec 22, 2016 at 11:22:25AM -0700, Jens Axboe wrote:
>> On 12/22/2016 11:20 AM, Christoph Hellwig wrote:
>>> This allows sending larger than 1 MB requess to devices that support
>>> large I/O sizes.
>>
>> Thanks, I'll queue it up for this series.
> 
> btw, s/requess/request/ above as just pointed out off-list.

I fixed it up.

-- 
Jens Axboe
