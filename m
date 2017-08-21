Return-Path: <gmazyland@gmail.com>
Return-Path: <gmazyland@gmail.com>
Subject: Re: [PATCH] loop: Fix freeze if configured block size is not
 supported
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, kzak@redhat.com, axboe@kernel.dk,
 hare@suse.de
References: <20170818130733.11254-1-gmazyland@gmail.com>
 <20170821184752.GB16030@vader.DHCP.thefacebook.com>
From: Milan Broz <gmazyland@gmail.com>
Message-ID: <6c88e833-cb31-0fae-ee2d-8062474554bc@gmail.com>
Date: Mon, 21 Aug 2017 21:11:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170821184752.GB16030@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/21/2017 08:47 PM, Omar Sandoval wrote:
> On Fri, Aug 18, 2017 at 03:07:33PM +0200, Milan Broz wrote:
>> The commit f2c6df7dbf9a60e1cd9941f9fb376d4d9ad1e8dd
>>
>>     loop: support 4k physical blocksize
>>
>> adds support for loop block size with only specific block sizes.
>>
>> If the size is not supported, the code returns -EINVAL keeping
>> the loop queue frozen. This causes that device could be locked
>> for a long time by processes trying to scan device (udev).
>> (And also causing subsequent LOOP_CLR_FD operations noop.)
>>
>> Fix it by using goto to proper exit location with queue unfreeze.
>>
>> (The same bug is for setting crypt attribute but this code is
>> probably no more used. Patch fixes it as well though.)
>>
>> Signed-off-by: Milan Broz <gmazyland@gmail.com>
> 
> Heh, I sent the same patch [1] only hours before :) v2 is here [2] if
> you want to give it a reviewed-by.

Yes, and I noticed it 10 seconds after I sent my patch :)
You can add reviewed by, if it helps anything...

Actually you fixed another problems there with following patches
(physical blocks sizes), we discussed this with Karel
that it need some changes because the original patch caused
that reported blocks differs between old and new kernel (lsblk -t),
even if block size was not used.

I will test them as well (we have code in cryptsetup that allocates
loop device automatically if the image is in file and I would like
to add block size setting there).

Thanks,
Milan

> 
> 1: https://marc.info/?l=linux-block&m=150303694018659&w=2
> 2: https://marc.info/?l=linux-block&m=150308446732748&w=2
> 
