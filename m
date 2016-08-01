Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Allow timeouts to run while queue is freezing
To: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
References: <1469767356-25193-1-git-send-email-krisman@linux.vnet.ibm.com>
 <81fa2a75-1da8-aeb6-dcce-3ae245810234@kernel.dk>
 <8760rogwmp.fsf_-_@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>,
 Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <41acd9e9-cbcc-66db-144f-0aab0e150cc0@kernel.dk>
Date: Mon, 1 Aug 2016 08:24:27 -0600
MIME-Version: 1.0
In-Reply-To: <8760rogwmp.fsf_-_@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/29/2016 11:52 AM, Gabriel Krisman Bertazi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
>
>> I can see that is an issue. Did you consider the case where
>> blk_mq_timeout_work() is entered, but we don't have any requests
>> allocated that currently hold a reference? This could happen if
>> completion races with a timeout.
>
> Hi Jens,
>
> That shouldn't be an issue, I think.  The only functional difference
> should be during queue freezes, and in this case, if the request was
> already completed by the time we touch it, we`ll only hold the queue
> freeze for a little longer, until we release the reference by the end of
> the timeout path.  should the final request be released before
> blk_mq_timeout_work acquire it's reference, q_usage_counter will reach
> zero, and the call to percpu_ref_tryget will fail the same way
> percpu_ref_tryget_live would.

Thanks, I'm happy with it, and the detailed comment is a good
improvement. I have added it for this series.

-- 
Jens Axboe
