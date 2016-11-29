Subject: Re: [PATCH 00/23] LightNVM patches for 4.10
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20161128213914.12516-1-m@bjorling.me>
From: Jens Axboe <axboe@fb.com>
Message-ID: <d2a69475-24e4-f646-773f-cac3f6cc0dbf@fb.com>
Date: Tue, 29 Nov 2016 13:00:50 -0700
MIME-Version: 1.0
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/28/2016 02:38 PM, Matias Bjørling wrote:
> Hi Jens,
>
> A bunch of patches for 4.10 have been prepared.
>
> Javier has been busy eliminating abstractions in the LightNVM
> interface. Mainly killing generic nvm_block and nvm_lun, which
> simplifies the locking mechanism within targets. He also added a couple
> of new hints and error codes that are useful for the hardware.
>
> I have a small fix to fix a wrong free, and also a larger patch that
> attaches the sysfs entries added in 4.9 to attach to the native nvme
> gendisk.
>
>
> With these patches, the pblk target is ready to be upstreamed. If
> nothing comes along to delay it, we will push it in the next cycle.
>
> Please pick up.

Applied for 4.10, thanks.

-- 
Jens Axboe
