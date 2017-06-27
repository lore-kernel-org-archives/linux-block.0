Subject: Re: [PATCH V3] lightnvm: if LUNs are already allocated fix return
To: Rakesh Pandit <rakesh@tuxera.com>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <m@bjorling.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>,
 Frans Klaver <fransklaver@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <jg@lightnvm.io>
References: <20170627115531.GA53387@dhcp-216.srv.tuxera.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <c6c5bf85-78a5-7729-a43a-cc6ed46d184f@fb.com>
Date: Tue, 27 Jun 2017 08:22:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170627115531.GA53387@dhcp-216.srv.tuxera.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/27/2017 05:55 AM, Rakesh Pandit wrote:
> While creating new device with NVM_DEV_CREATE if LUNs are already
> allocated ioctl would return -ENOMEM which is wrong.  This patch
> propagates -EBUSY from nvm_reserve_luns which is correct response.

Thanks, applied for 4.13.

-- 
Jens Axboe
