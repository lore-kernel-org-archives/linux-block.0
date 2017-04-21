Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] lightnvm: propagate pblk_init return to userspace
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
 Rakesh Pandit <rakesh@tuxera.com>
References: <20170420182356.GA7866@hercules.tuxera.com>
 <F1FB4E37-23D4-4E6B-9310-78FA4699556C@lightnvm.io>
 <c12bf1b4-3629-7c71-31fd-55468bcee3da@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <96dcf7b9-542f-4daf-7653-07cd54d0f86d@kernel.dk>
Date: Fri, 21 Apr 2017 12:41:16 -0600
MIME-Version: 1.0
In-Reply-To: <c12bf1b4-3629-7c71-31fd-55468bcee3da@lightnvm.io>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/21/2017 12:11 PM, Matias Bj�rling wrote:
> On 04/21/2017 05:07 PM, Javier Gonz�lez wrote:
>>> On 20 Apr 2017, at 20.23, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>>
>>> From userspace calling ioctl(NVM_DEV_CREATE) was returning ENOMEM for
>>> invalid arguments even though pblk (pblk_init) was returning correctly
>>> -EINVAL to nvm_create_tgt inside core.  This patch propagates the
>>> correct return value to userspace.
>>>
>>> Because pblk was introduced recently this only needs to go in 4.12.
>>>
>>> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
>>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>>>
>>
>> Looks good.
>>
>> Reviewed-by: Javier Gonz�lez <javier@cnexlabs.com>
>>
>> Javier
>>
> 
> 
> Jens, would you pick this up as well? :)

Done, thanks Rakesh.

-- 
Jens Axboe
