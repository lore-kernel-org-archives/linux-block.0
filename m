Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/5] blk-throttle: Adjust two function calls together with
 a variable assignment
To: Johannes Thumshirn <jthumshirn@suse.de>,
 SF Markus Elfring <elfring@users.sourceforge.net>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
 <7d68f93d-c14c-60aa-2b02-5005a0a62cad@users.sourceforge.net>
 <20170123091821.GC3517@linux-x5ow.site>
Cc: linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bdd7466c-2f35-3279-1287-b08ba9eb373b@kernel.dk>
Date: Mon, 23 Jan 2017 08:14:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170123091821.GC3517@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/23/2017 02:20 AM, Johannes Thumshirn wrote:
> On Sun, Jan 22, 2017 at 09:33:08AM +0100, SF Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Sat, 21 Jan 2017 22:15:33 +0100
>>
>> The script "checkpatch.pl" pointed information out like the following.
>>
>> ERROR: do not use assignment in if condition
>>
>> Thus fix the affected source code places.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
> 
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> if Jens wants doesn't mind.

I don't mind these, but I completely agree on the patches for moving the
'error' assignment. What ends up happening for those cases is that
someone adds a new section and forgets to set 'error', and then all hell
breaks lose.

So Markus, don't bother sending those patches again for the block layer
or drivers, I'm not going to take them.

-- 
Jens Axboe
