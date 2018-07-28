Return-Path: <gustavo@embeddedor.com>
To: Jinbum Park <jinb.park7@gmail.com>, axboe@kernel.dk,
 bart.vanassche@wdc.com, jiufei.xue@linux.alibaba.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180728013151.GA15457@pjb1027-Latitude-E5410>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] pktcdvd: Fix possible Spectre-v1 for pkt_devs
Message-ID: <ecede2b4-a980-3ad3-4474-d1d9db3e6a74@embeddedor.com>
Date: Fri, 27 Jul 2018 20:47:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180728013151.GA15457@pjb1027-Latitude-E5410>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jinbum,

Thanks for working on this.

Please, see some comments below.

On 07/27/2018 08:31 PM, Jinbum Park wrote:
> User controls @dev_minor which to be used as index of pkt_devs.
> So, It can be exploited via Spectre-like attack. (speculative execution)
> 
> This kind of attack leaks address of pkt_devs, [1]
> It leads an attacker to bypass security mechanism such as KASLR.
> 
> So sanitize @dev_minor before using it to prevent attack.
> 
> [1] https://github.com/jinb-park/linux-exploit/
> tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c
> 
> Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
> ---
>  drivers/block/pktcdvd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index c61d20c..665760d 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -67,8 +67,8 @@
>  #include <scsi/scsi.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
> -
>  #include <linux/uaccess.h>
> +#include <linux/nospec.h>
>  
>  #define DRIVER_NAME	"pktcdvd"
>  
> @@ -2229,9 +2229,13 @@ static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
>  
>  static struct pktcdvd_device *pkt_find_dev_from_minor(unsigned int dev_minor)
>  {
> +	unsigned int idx = 0;
> +

There is no need for a new variable in this case.

>  	if (dev_minor >= MAX_WRITERS)
>  		return NULL;
> -	return pkt_devs[dev_minor];
> +
> +	idx = array_index_nospec(dev_minor, MAX_WRITERS);
> +	return pkt_devs[idx];

Also, the following style is preferred:

if (dev_minor >= MAX_WRITERS)
	return NULL;
dev_minor = array_index_nospec(dev_minor, MAX_WRITERS);


Thanks
--
Gustavo
