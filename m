Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] Two fixes for loop devices
To: NeilBrown <neilb@suse.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <149758925866.10006.12779875832895865043.stgit@noble>
 <c70dfc69-516c-f1e8-4e39-74eff1bca176@fb.com>
 <87bmpl6hkq.fsf@notabene.neil.brown.name>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <56640935-e897-1586-5493-1cf1ffc98ba9@kernel.dk>
Date: Sun, 18 Jun 2017 09:06:49 -0600
MIME-Version: 1.0
In-Reply-To: <87bmpl6hkq.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/17/2017 10:33 PM, NeilBrown wrote:
> On Fri, Jun 16 2017, Jens Axboe wrote:
> 
>> On 06/15/2017 11:02 PM, NeilBrown wrote:
>>> Hi Jens,
>>>  one of these is a resend of a patch I sent a while back.
>>>  The other is new - loop closes files differently from close()
>>>  and in a way that can confuse NFS.
>>
>> Are you wanting to get these into 4.12, or defer to 4.13?
> 
> I'm happy either way.  I just want them to land eventually, so I can
> tick them off my list.
> 
> The conversation with Al might result in a different fix for the
> flip_close() problem, but I think that it is still more correct to call
> filp_close(), because what loop is doing is a lot like closing a file
> that it has been writing to.

I'll toss 2/2 in for now for 4.13, please resend the other once the issues
have been ironed out.

-- 
Jens Axboe
