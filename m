Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/4] blk-mq-tag: check for NULL rq when iterating tags
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
 <1501790516-6924-2-git-send-email-axboe@kernel.dk>
 <1501792140.2922.14.camel@wdc.com>
 <549d568a-b32a-5d6c-7788-3f26a2ce58a2@kernel.dk>
Message-ID: <b1c18f36-87ea-fee8-e88b-03ecdfdf22af@kernel.dk>
Date: Thu, 3 Aug 2017 14:40:23 -0600
MIME-Version: 1.0
In-Reply-To: <549d568a-b32a-5d6c-7788-3f26a2ce58a2@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/03/2017 02:35 PM, Jens Axboe wrote:
>> I agree with what you wrote in the description of this patch.
>> However, since I have not yet found the code that clears tags->rqs[],
>> would it be possible to show me that code?
> 
> Since it's been a month since I wrote this code, I went and looked
> too.  My memory was that we set/clear it dynamically since we added
> scheduling, but looks like we don't clear it. The race is still valid
> for when someone runs a tag check in parallel with someone allocating
> a tag, since there's a window of time where the tag bit is set, but
> ->rqs[tag] isn't set yet. That's probably the race I hit, not the
> completion race mentioned in the change log.

Rewrote the commit message:

http://git.kernel.dk/cgit/linux-block/commit/?h=mq-inflight&id=1908e43118e688e41ac8656edcf3e7a150f3f5081

-- 
Jens Axboe
