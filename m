Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E5FC433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 08:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245EC212CC
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 08:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="XGITdUxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390037AbgFXIBo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:01:44 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17133 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387650AbgFXIBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 04:01:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592985663; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=JiLbGdRIWCHGUD0KHsF/GW0z3P8FKCvneht+EX3ZRfQSz06nXzupdmmXEFux+UOG/K/yxOOTBYv9VQncijRIwd1xF2thXWkXqkPWp2xcXu220ozTFIRq7uikeBKNuSgeFNaRNAOGkhEBiXtA79GaQ78Y8kBF5SxNSH5B+RJ70aE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1592985663; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Z1kEwGUT/+GGDBaZtWZP+BGx3WQ8yYZ2Zup2nhDn5rE=; 
        b=nVFzIhpVLpAdwhGBEPpNTpQr/bjUdh4xSxZMUGEV5GOYPmSisJ5TcepSivECNDmhCQz90faDSsSPsUeKv9cUvh3r5n/cln/0lZ9UPQ2BhjjfC6WvGMvPryQUra+/Ej4VMKiM67j9rpdDszUxOePXJ1LTHa1IhH3oantx2PLK3Ac=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1592985663;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=Z1kEwGUT/+GGDBaZtWZP+BGx3WQ8yYZ2Zup2nhDn5rE=;
        b=XGITdUxYW6a15g8Vsnv64ggmcQiP0rRN23o1n1aiJ4iGFH/GTCuF2lRo2ZaJoSvz
        N0Xogw/zeVzLn+VcAvjCibBSBCTDdGGI3H64MU1xrn92D7X+XeP51jSD5ST9gDJu7BZ
        VO93h12Z3jthr3JhkoMjy3jAy2ATKiPLZa8IFISg=
Received: from [192.168.166.138] (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1592985661218242.83216956667889; Wed, 24 Jun 2020 16:01:01 +0800 (CST)
Subject: Re: [PATCH] block; release bip in a right way in error path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
References: <20200623140653.4226-1-cgxu519@mykernel.net>
 <20200624065003.GA15905@infradead.org>
From:   cgxu <cgxu519@mykernel.net>
Message-ID: <ad4a67ab-76db-04a4-459e-b4f9f796e3a4@mykernel.net>
Date:   Wed, 24 Jun 2020 16:01:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200624065003.GA15905@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/20 2:50 PM, Christoph Hellwig wrote:
> On Tue, Jun 23, 2020 at 10:06:53PM +0800, Chengguang Xu wrote:
>> Release bip using kfree() in error path when that was allocated
>> by kmalloc().
>>
>> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>> ---
>>   block/bio-integrity.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
>> index 23632a33ed39..538c8dc8840a 100644
>> --- a/block/bio-integrity.c
>> +++ b/block/bio-integrity.c
>> @@ -78,7 +78,11 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
>>   
>>   	return bip;
>>   err:
>> -	mempool_free(bip, &bs->bio_integrity_pool);
>> +	if (bs && mempool_initialized(&bs->bio_integrity_pool))
>> +		mempool_free(bip, &bs->bio_integrity_pool);
>> +	else
>> +		kfree(bip);
>> +
>>   	return ERR_PTR(-ENOMEM);
> 
> How about factoring out a __bio_integrity_free helper to not duplicate
> this logic?
> 

Yeah, that's better, thanks for the suggestion.


cgxu
