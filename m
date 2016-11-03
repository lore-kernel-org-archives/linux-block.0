Subject: Re: [PATCH] block: drop q argument from bsg_validate_sgv4_hdr
To: Johannes Thumshirn <jthumshirn@suse.de>
References: <20161103093854.3690-1-jthumshirn@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@infradead.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f928d6a7-fa0d-4a2c-cbf1-2acaa6a2ced6@fb.com>
Date: Thu, 3 Nov 2016 07:56:58 -0600
MIME-Version: 1.0
In-Reply-To: <20161103093854.3690-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/03/2016 03:38 AM, Johannes Thumshirn wrote:
> bsg_validate_sgv4_hdr() doesn't care about the request_queue, so drop it
> from it's arguments.

Thanks, applied.

-- 
Jens Axboe
