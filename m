Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] (Xen) stable/for-jens-4.7 for v4.7-rc5
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
 linux-block@vger.kernel.org
References: <20160629163949.GA5631@char.us.oracle.com>
Cc: bob.liu@oracle.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57741E63.7050003@kernel.dk>
Date: Wed, 29 Jun 2016 13:15:47 -0600
MIME-Version: 1.0
In-Reply-To: <20160629163949.GA5631@char.us.oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/29/2016 10:39 AM, Konrad Rzeszutek Wilk wrote:
> Hey Jens,
>
> Please git pull the 'stable/for-jens-4.7' branch which is based on your
> 'for-4.7/drivers' branch. It will nicely merge in your 'for-linus' branch:
>
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.7
>
> which has one fix for migration of guest. We found that if we migrate the
> guest from a host that has multi-queue to an older (or vice-versa) we would
> lose outstanding I/Os as we did not recreate all the queues properly and lost
> the I/Os.
>
> Please pull!

Pulled, thanks.

-- 
Jens Axboe
