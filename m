Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL 00/37] lightnvm patches for 4.17
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 keith.busch@intel.com, javier@cnexlabs.com
References: <20180329220524.30363-1-mb@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2926fe22-ff91-67a0-ffba-0b0707e2b798@kernel.dk>
Date: Thu, 29 Mar 2018 17:30:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/29/18 4:04 PM, Matias Bjørling wrote:
> Hi Jens,
> 
> Here is a bunch of patches for 4.17. They include:
> 
>  - Open-Channel 2.0 support by Javier and I.
>  - Lots of refactoring patches to enable 2.0 support.
>  - Fixes to pblk from Hans, Markus, and Dan.
>  - Introduction of write amplication and padding counters. From Hans.
>  - Fix from Johannes to unify the permission checks for the lightnvm
>    ioctls.
>  - Fixes from Heiner for bad block initialization and
>    over-provisioning validation.
> 
> Please pick up when convenient.

Applied, thanks.

-- 
Jens Axboe
