Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway21.websitewelcome.com ([192.185.46.113]:35812 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751718AbeB0WtS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 17:49:18 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id C56C24EE32054
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 15:43:07 -0600 (CST)
Subject: Re: [PATCH] nbd: fix return value in error handling path
To: Omar Sandoval <osandov@osandov.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
References: <20180212171450.GA31668@embeddedgus>
 <20180226230133.GA12208@vader.DHCP.thefacebook.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <5abe2722-6f74-04cb-d417-fc960cb1997f@embeddedor.com>
Date: Tue, 27 Feb 2018 15:43:02 -0600
MIME-Version: 1.0
In-Reply-To: <20180226230133.GA12208@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 02/26/2018 05:01 PM, Omar Sandoval wrote:
> On Mon, Feb 12, 2018 at 11:14:55AM -0600, Gustavo A. R. Silva wrote:
>> It seems that the proper value to return in this particular case is the
>> one contained into variable new_index instead of ret.
>>
>> Addresses-Coverity-ID: 1465148 ("Copy-paste error")
>> Fixes: e46c7287b1c2 ("nbd: add a basic netlink interface")
> Reviewed-by: Omar Sandoval <osandov@fb.com>

Thanks, Omar.
--
Gustavo

>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/block/nbd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 5f2a424..86258b0 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1591,7 +1591,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>>   			if (new_index < 0) {
>>   				mutex_unlock(&nbd_index_mutex);
>>   				printk(KERN_ERR "nbd: failed to add new device\n");
>> -				return ret;
>> +				return new_index;
>>   			}
>>   			nbd = idr_find(&nbd_index_idr, new_index);
>>   		}
>> -- 
>> 2.7.4
>>
