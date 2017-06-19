Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/10 v13] merge request: No wait AIO
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, hch@lst.de, jack@suse.cz,
 akpm@linux-foundation.org, linux-block@vger.kernel.org
References: <20170619163348.15542-1-rgoldwyn@suse.de>
 <a3c9ac14-d04d-2dc5-c656-879c6262aa96@kernel.dk>
 <20170619233439.GL10672@ZenIV.linux.org.uk>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1de9d545-8811-4dfa-22db-f5172f122a95@kernel.dk>
Date: Mon, 19 Jun 2017 17:36:05 -0600
MIME-Version: 1.0
In-Reply-To: <20170619233439.GL10672@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 05:34 PM, Al Viro wrote:
> On Mon, Jun 19, 2017 at 05:15:16PM -0600, Jens Axboe wrote:
>> On 06/19/2017 10:33 AM, Goldwyn Rodrigues wrote:
>>> Jens,
>>>
>>> As Christoph suggested, I am sending the patches against the block
>>> tree for merge since the block layer changes had the most conflicts.
>>> My tree is at https://github.com/goldwynr/linux/tree/nowait-block
>>
>> I can merge it for 4.13, but I need Al to be happy with it first.
> 
> FWIW, it's really a matter of who gets more conflicts - I'm OK with the
> general shape of that code and it could go through either tree (or both,
> for that matter, if an immutable branch is promised).

I'm still hopeful that the write hint patchset will make it as well,
which will definitely conflict with this. So if you don't mind, I'd
like to queue it through the block tree. The block for-4.x/ branches
are not rebased.

-- 
Jens Axboe
