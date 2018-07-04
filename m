Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway23.websitewelcome.com ([192.185.49.179]:36067 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932174AbeGDNqh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Jul 2018 09:46:37 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 3BED61978B
        for <linux-block@vger.kernel.org>; Wed,  4 Jul 2018 08:01:32 -0500 (CDT)
Subject: Re: [PATCH] lightnvm: pblk: mark expected switch fall-through
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180703212125.GA29262@embeddedor.com>
 <79636e4b-0932-791d-bd06-9f7bbf6d00f3@lightnvm.io>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <815c1b76-dad2-a2da-7832-bbaf02ad6be8@embeddedor.com>
Date: Wed, 4 Jul 2018 08:00:56 -0500
MIME-Version: 1.0
In-Reply-To: <79636e4b-0932-791d-bd06-9f7bbf6d00f3@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 07/04/2018 03:07 AM, Matias Bjørling wrote:
> On 07/03/2018 11:21 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/lightnvm/pblk-core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index ed9cc97..9c93334 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -264,6 +264,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
>>       switch (type) {
>>       case PBLK_WRITE:
>>           kfree(((struct pblk_c_ctx *)nvm_rq_to_pdu(rqd))->lun_bitmap);
>> +        /* fall through */
>>       case PBLK_WRITE_INT:
>>           pool = &pblk->w_rq_pool;
>>           break;
>>
> 
> Thanks Gustavo. Applied for 4.19.

Thanks, Matias.
--
Gustavo
