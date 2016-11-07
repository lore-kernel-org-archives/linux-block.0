Subject: Re: [RFC, PATCH] pktcdvd: don't scribble over the bvec array
To: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1477551884-25062-1-git-send-email-hch@lst.de>
 <20161107154251.GA12856@infradead.org>
Cc: petero2@telia.com, linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <23bc2d63-4835-0ccc-5605-59bae2f35fa5@fb.com>
Date: Mon, 7 Nov 2016 08:50:38 -0700
MIME-Version: 1.0
In-Reply-To: <20161107154251.GA12856@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/07/2016 08:42 AM, Christoph Hellwig wrote:
> Jens, is this something you could consider for 4.10?

Trying to wrap my head around it. I think it looks good. Problem is that
I'm not sure anyone has the hardware to test it. Looking at the -git
history, the driver hasn't been touched in at least 6 years  (I stopped
at 2010) except for updating it for in-kernel changes.

I'll apply this for 4.10, and mark the driver as
unmaintained/deprecated.

-- 
Jens Axboe
