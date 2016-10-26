Subject: Re: [PATCH] block: flush: fix IO hang in case of flood fua req
To: Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
References: <1477472235-22845-1-git-send-email-tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Kent Overstreet <kent.overstreet@gmail.com>, Jens Axboe <axboe@kernel.dk>
From: Jens Axboe <axboe@fb.com>
Message-ID: <a57aa5a0-f22b-dc10-07d9-47723ea6e880@fb.com>
Date: Wed, 26 Oct 2016 07:48:59 -0600
MIME-Version: 1.0
In-Reply-To: <1477472235-22845-1-git-send-email-tom.leiming@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/26/2016 02:57 AM, Ming Lei wrote:
> This patch fixes one issue reported by Kent, which can
> be triggered in bcachefs over sata disk. Actually it
> is a generic issue in block flush vs. blk-tag.

Looks good to me. Had to double check we don't get there for the mq 
path, but we have our own end_io for that path. Applied.

-- 
Jens Axboe
