Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: put the driver tag of nxt rq before first one is
 requeued
To: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1505236475-9209-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170912102302.GC15792@ming.t460p>
 <23b700aa-ed37-1081-d980-4073804f293b@oracle.com>
 <20170913012452.GA24642@ming.t460p>
 <4b7dcb10-9ec5-9a00-8d16-009e83ef7b5b@oracle.com>
 <ccda7d87-a0b9-8292-3cb7-8edcca9c7f69@kernel.dk>
 <96a21c69-cf79-58a2-2c71-2e440abf9b36@oracle.com>
 <6327de01-0bf4-7e79-59ad-f6489378bfd5@kernel.dk>
 <aebfc622-6d7d-0d07-5a13-8dae06a49bb7@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <17775b50-1bf2-26d2-c371-2eb349be85d6@kernel.dk>
Date: Tue, 12 Sep 2017 21:54:06 -0600
MIME-Version: 1.0
In-Reply-To: <aebfc622-6d7d-0d07-5a13-8dae06a49bb7@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/12/2017 09:39 PM, jianchao.wang wrote:
>> Exactly, and especially the readability is the key element here. It's
>> just not worth it to try and be too clever, especially not for
>> something like this. When you read the above, you immediately know
>> what the code does without needing a comment. That's not true for the
>> other construct.  You both have to read other parts of the function
>> to figure out what it does, AND read the entire function to ensure it
>> always does the right thing. Fragile.
> 
> Thanks for your comments , jens and ming. I＇m really appreciative of
> that.  About the fragility, do you mean the possibility that may
> release the tag of the next rq which has a driver tag itself (maybe a
> flush) ?

I mean that if you do:

if (!list_empty(list))
	blk_mq_put_driver_tag(nxt);

it's fragile code in the sense that changes elsewhere in the function
are harder to validate and/or can impact the functionality of that
simple if and tag put.

The actual release must always be safe, of course.

-- 
Jens Axboe
