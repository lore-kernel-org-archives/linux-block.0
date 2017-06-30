Subject: Re: [PATCH 00/10] lightnvm: pblk fixes for 4.13
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>, mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <e0662596-804a-bf4e-e5c9-9296e14e7087@fb.com>
Date: Fri, 30 Jun 2017 11:08:51 -0600
MIME-Version: 1.0
In-Reply-To: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/30/2017 09:56 AM, Javier González wrote:
> Hi Jens,
> 
> Here you have a second round of fixes for pblk. They are in essence bug
> fixes including a double-free reported by Dan.
> 
> There is also regression fix for pblk removal, which was introduced with
> the new metadata scheduler. This fix makes that removing a pblk instance
> takes again at most 2 seconds.
> 
> Finally, I also included a patch for double checking the L2P to verify a
> cache hit before reading from the write cache. We have experienced a
> database not issuing fsync before reading recently written metadata
> triggering a bad cache read. We verified it this week. This patch is an
> easy fix that we can make in pblk.

Applied for 4.13, thanks.

-- 
Jens Axboe
