Return-Path: <axboe@kernel.dk>
Subject: Re: Treat REQ_FUA and REQ_PREFLUSH as synchronous
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
References: <20170502102123.GE13916@quack2.suse.cz>
 <20170502144505.GA29623@infradead.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f4bedc20-7b27-bfa9-76c6-c34c8c3e816b@kernel.dk>
Date: Tue, 2 May 2017 08:49:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170502144505.GA29623@infradead.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/02/2017 08:45 AM, Christoph Hellwig wrote:
> On Tue, May 02, 2017 at 12:21:23PM +0200, Jan Kara wrote:
>> it makes sense to treat REQ_FUA and REQ_PREFLUSH ops as synchronous in
>> op_is_sync() since callers cannot rely on this anyway... Thoughts?
> 
> I'm fine with treating them as sync.

Yes me too. It makes sense to do so implicitly, and it avoids having
to go and add REQ_SYNC in a bunch of places. That will also be more
error proof in the future.

Jan, will you send a patch for that?

-- 
Jens Axboe
