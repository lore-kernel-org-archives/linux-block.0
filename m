Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
 <1497633883-21230-12-git-send-email-axboe@kernel.dk>
 <20170616180942.GD27996@infradead.org>
 <9811b106-a954-2481-8a66-afb25df76812@kernel.dk>
 <20170617122106.GB8320@infradead.org>
 <1ede2083-69db-a86f-8e32-43ca293e9c8e@kernel.dk>
 <20170617150303.GA15290@infradead.org>
 <b159f6cb-a272-cd06-207a-4cce8336c86d@kernel.dk>
 <20170619062557.GA2311@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <03b922f9-677e-9618-663e-09f023977fa8@kernel.dk>
Date: Mon, 19 Jun 2017 08:31:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170619062557.GA2311@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 12:25 AM, Christoph Hellwig wrote:
> On Sat, Jun 17, 2017 at 09:11:30AM -0600, Jens Axboe wrote:
>> I have two samples here, and I just tested, and both of them want it
>> assigned with nsid=0xffffffff or they will fail the writes... So I'd say
>> we're better off ensuring we do allocate them globally.
> 
> That's clearly against the spec.  I'd say go to your vendor and get
> a refund, as we Linux folks (Martin and I) fought for this so that
> we would not have to do the explicit allocations.
> 
> Another quote for from the spec:
> 
> "Streams are opened by the controller when the host issues a write
>  command that specifies a stream identifier that is not currently open.
>  While a stream is open the controller maintains context for that stream
>  (e.g., buffers for associated data). The host may determine the streams 
>  that are open using the Get Status operation."
> 
> And I think this is very important - otherwise you need to either
> allocate the stremas beforehand as your earlier patches (and we take
> away the resources from the 99% of the users not using write life
> hints), or we need the lazy allocation scheme.  And for that to be
> efficient it probably needs to be lazy per-stream allocation.  That's
> why we got the implicit open in after all.

These are just samples, so no refund possible! As you might remember,
I was pretty adamant on not wanting explicit open/close as well, back
in those days. I'll check with the vendor and see what's going on.

-- 
Jens Axboe
