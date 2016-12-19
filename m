Subject: Re: [PATCH 0/2] nvme: Improvements in sysfs entry for NVMe CMBs
To: Stephen Bates <sbates@raithlin.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
Cc: sagi@grimberg.me, james_p_freyensee@linux.intel.com,
 jonathan.derrick@intel.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <aead4ef4-4fbf-10a1-c307-24abbc3fe9d6@fb.com>
Date: Mon, 19 Dec 2016 08:36:48 -0700
MIME-Version: 1.0
In-Reply-To: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/16/2016 11:54 AM, Stephen Bates wrote:
> Hi
> 
> This series adds some more verbosity to the NVMe CMB sysfs entry.
> 
> Jens I based this off v4.9 because for some reason your for-4.10/block
> is missing my original CMB commit (202021c1a63c6)?
> 
> Stephen
> 
> Stephen Bates (2):
>   nvme : Use correct scnprintf in cmb show
>   nvme: improve cmb sysfs reporting
> 
>  drivers/nvme/host/pci.c | 33 ++++++++++++++++++++++++++++++---
>  include/linux/nvme.h    |  8 ++++++++
>  2 files changed, 38 insertions(+), 3 deletions(-)

I have added 1/2, since that one is a no-brainer. For 2/2, not so sure.
Generally we try to avoid having sysfs file that aren't single value
output. That isn't a super hard rule, but it is preferable.

-- 
Jens Axboe
