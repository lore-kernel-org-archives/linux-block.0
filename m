Subject: Re: [RFC, PATCH] pktcdvd: don't scribble over the bvec array
To: Christoph Hellwig <hch@infradead.org>
References: <1477551884-25062-1-git-send-email-hch@lst.de>
 <20161107154251.GA12856@infradead.org>
 <23bc2d63-4835-0ccc-5605-59bae2f35fa5@fb.com>
 <20161121130217.GA23406@infradead.org>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <8b1de2af-0cc5-2630-8088-bacfa1c708c5@fb.com>
Date: Mon, 21 Nov 2016 09:32:12 -0700
MIME-Version: 1.0
In-Reply-To: <20161121130217.GA23406@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/21/2016 06:02 AM, Christoph Hellwig wrote:
> On Mon, Nov 07, 2016 at 08:50:38AM -0700, Jens Axboe wrote:
>> I'll apply this for 4.10, and mark the driver as
>> unmaintained/deprecated.
>
> Btw, I didn't see this part in the tree yet.

Didn't get around to adding this deprecation note, I'll do that now.

-- 
Jens Axboe
