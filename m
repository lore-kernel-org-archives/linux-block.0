Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A691C28CC0
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 01:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D380F24389
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 01:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfE3B2O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 21:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfE3B2N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 21:28:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A40A083F44;
        Thu, 30 May 2019 01:28:13 +0000 (UTC)
Received: from [10.72.12.96] (ovpn-12-96.pek2.redhat.com [10.72.12.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4323B19C70;
        Thu, 30 May 2019 01:28:10 +0000 (UTC)
Subject: Re: [PATCH] nbd: fix crash when the blksize is zero
To:     Mike Christie <mchristi@redhat.com>, josef@toxicpanda.com,
        axboe@kernel.dk, nbd@other.debian.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        atumball@redhat.com
References: <20190527054438.13548-1-xiubli@redhat.com>
 <5CEED598.7080703@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <3a7e1aed-c07a-8338-73a5-8389a2fe78dc@redhat.com>
Date:   Thu, 30 May 2019 09:28:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5CEED598.7080703@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 30 May 2019 01:28:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/5/30 2:55, Mike Christie wrote:
> On 05/27/2019 12:44 AM, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> This will allow the blksize to be set zero and then use 1024 as
>> default.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   drivers/block/nbd.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 053958a..4c1de1c 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -135,6 +135,8 @@ struct nbd_cmd {
>>   
>>   #define NBD_MAGIC 0x68797548
>>   
>> +#define NBD_DEF_BLKSIZE 1024
>> +
>>   static unsigned int nbds_max = 16;
>>   static int max_part = 16;
>>   static struct workqueue_struct *recv_workqueue;
>> @@ -1237,6 +1239,14 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
>>   		nbd_config_put(nbd);
>>   }
>>   
>> +static bool nbd_is_valid_blksize(unsigned long blksize)
>> +{
>> +	if (!blksize || !is_power_of_2(blksize) || blksize < 512 ||
>> +		blksize > PAGE_SIZE)
>> +		return false;
>> +	return true;
>> +}
>> +
>>   /* Must be called with config_lock held */
>>   static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>>   		       unsigned int cmd, unsigned long arg)
>> @@ -1252,8 +1262,9 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>>   	case NBD_SET_SOCK:
>>   		return nbd_add_socket(nbd, arg, false);
>>   	case NBD_SET_BLKSIZE:
>> -		if (!arg || !is_power_of_2(arg) || arg < 512 ||
>> -		    arg > PAGE_SIZE)
>> +		if (!arg)
>> +			arg = NBD_DEF_BLKSIZE;
>> +		if (!nbd_is_valid_blksize(arg))
>>   			return -EINVAL;
>>   		nbd_size_set(nbd, arg,
>>   			     div_s64(config->bytesize, arg));
>> @@ -1333,7 +1344,7 @@ static struct nbd_config *nbd_alloc_config(void)
>>   	atomic_set(&config->recv_threads, 0);
>>   	init_waitqueue_head(&config->recv_wq);
>>   	init_waitqueue_head(&config->conn_wait);
>> -	config->blksize = 1024;
>> +	config->blksize = NBD_DEF_BLKSIZE;
>>   	atomic_set(&config->live_connections, 0);
>>   	try_module_get(THIS_MODULE);
>>   	return config;
>> @@ -1769,6 +1780,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>>   	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
>>   		u64 bsize =
>>   			nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
>> +		if (!bsize)
>> +			bsize = NBD_DEF_BLKSIZE;
>> +		if (!nbd_is_valid_blksize(bsize))
>> +			return -EINVAL;
> You can't only return here. You need to also drop the mutex, do
> nbd_put, and drop config_refs reference.
>
> Maybe you want to move this check to the beginning of the function with
> the NBD_ATTR_SIZE_BYTES sanity check since the error handling is easier
> there.

Yeah, right.

I saw your resend patch of this and that looks good to me.

Thanks
BRs
Xiubo


>
>>   		nbd_size_set(nbd, bsize, div64_u64(config->bytesize, bsize));
>>   	}
>>   	if (info->attrs[NBD_ATTR_TIMEOUT]) {
>>

