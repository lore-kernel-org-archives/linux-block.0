Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V3] block: drain queue before waiting for q_usage_counter
 becoming zero
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, chenxiang <chenxiang66@hisilicon.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Wen Xiong <wenxiong@us.ibm.com>
References: <20171129235635.20292-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4134703e-d732-6d13-07ab-534f44e0bbc3@kernel.dk>
Date: Fri, 5 Jan 2018 09:10:26 -0700
MIME-Version: 1.0
In-Reply-To: <20171129235635.20292-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/29/17 4:56 PM, Ming Lei wrote:
> Now we track legacy requests with .q_usage_counter in commit 055f6e18e08f
> ("block: Make q_usage_counter also track legacy requests"), but that
> commit never runs and drains legacy queue before waiting for this counter
> becoming zero, then IO hang is caused in the test of pulling disk during IO.
> 
> This patch fixes the issue by draining requests before waiting for
> q_usage_counter becoming zero, both Mauricio and chenxiang reported this
> issue, and observed that it can be fixed by this patch.

Better late than never, added for 4.15, thanks Ming.

-- 
Jens Axboe
