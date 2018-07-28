Return-Path: <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] pktcdvd: Fix possible Spectre-v1 for pkt_devs
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jinbum Park <jinb.park7@gmail.com>, axboe@kernel.dk,
 bart.vanassche@wdc.com, jiufei.xue@linux.alibaba.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180728023058.GA21103@pjb1027-Latitude-E5410>
 <0f94623c-47e2-31e6-50ac-1d11ba061411@embeddedor.com>
Message-ID: <d46d997c-e0c1-a77b-a234-3f9d39d9a5b8@embeddedor.com>
Date: Fri, 27 Jul 2018 21:56:38 -0500
MIME-Version: 1.0
In-Reply-To: <0f94623c-47e2-31e6-50ac-1d11ba061411@embeddedor.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Jinbum,

I just noticed this patch does not apply to linux-next.

Please try again, but this time work from linux-next rather than from a stable tree.

Thanks
--
Gustavo

On 07/27/2018 09:47 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 07/27/2018 09:30 PM, Jinbum Park wrote:
>> User controls @dev_minor which to be used as index of pkt_devs.
>> So, It can be exploited via Spectre-like attack. (speculative execution)
>>
>> This kind of attack leaks address of pkt_devs, [1]
>> It leads an attacker to bypass security mechanism such as KASLR.
>>
>> So sanitize @dev_minor before using it to prevent attack.
>>
>> [1] https://github.com/jinb-park/linux-exploit/
>> tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c
>>
>> Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
>> ---
>> v2: Fix coding style by Gustavo.
>>
>>  drivers/block/pktcdvd.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
>> index c61d20c..8ec2eaa 100644
>> --- a/drivers/block/pktcdvd.c
>> +++ b/drivers/block/pktcdvd.c
>> @@ -67,8 +67,8 @@
>>  #include <scsi/scsi.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/device.h>
>> -
>>  #include <linux/uaccess.h>
>> +#include <linux/nospec.h>
>>  
>>  #define DRIVER_NAME	"pktcdvd"
>>  
>> @@ -2231,6 +2231,7 @@ static struct pktcdvd_device *pkt_find_dev_from_minor(unsigned int dev_minor)
>>  {
>>  	if (dev_minor >= MAX_WRITERS)
>>  		return NULL;
>> +	dev_minor = array_index_nospec(dev_minor, MAX_WRITERS);
> 
> Adding a blank line here would be even better.
> 
>>  	return pkt_devs[dev_minor];
>>  }
>>  
>>
> 
> Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Thanks
> --
> Gustavo
> 
