Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60341C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F89213A2
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ax1HrnU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F89213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbeKUMnR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:43:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43297 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUMnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 07:43:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so3087695plb.10
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 18:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0cuZFjRXsag6sDE4s+ut7pB5OikwLNT7o3KumHXsu3U=;
        b=Ax1HrnU1hOYoRz4BTLigOklaulxzC//SIONmCiWkEVR+0buB3IvoqZmzIltsNw8yIC
         PsRHnoSj8DZyv6gQvNKwF57PA10QcE88H+NlAsQ7CATrdT4/5D8sXAxy8biNR+Z2eb2W
         jc14ZYwMUEiadz4yl3GMWjc4/q1pbhES8KqUdDnsGOqa1egJ9KvXvZg7s/16TvmlHGGf
         i8YH6ya+uqnPbU7lM/b1NzPSAevvIL4rx3wrnaWWenDHAmlrOWvcdVSSjSiyQtwSiEmU
         ttPslm/YlQsE87WIxCYqtuxoMJ+PjeZVVxXZQalE7/4zsUjKTJsMq2luE/eC3iprTADb
         CM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0cuZFjRXsag6sDE4s+ut7pB5OikwLNT7o3KumHXsu3U=;
        b=LP/P3xyrfpJJoAxgdaB9PkCS14ooYnGydqAZ3aLyS2P+1ftI/8/MOHZ2yMq5CPRnP1
         9UfL5sNHPH+zhxdqfAbyi0Nf4wz2lRlF9FMrDvSc/o2AIkrU+w2/3cHiiB6ItmFkQPSG
         5FbzwEZZ2f96i2kT61QB8ZGGK8YQ5brf55rrdyv5R5wsJUfY05EbZTKOSj0xRJGXxamY
         o8uS/se2pIdjcbUtr/meuRnclrSowE5DSKEHKL8mOV1o1KeBmU89SB2EByFFmsvYv0l1
         LufAcBz/Yg8Nz38QrTqXLR2ImVrBMSLq8k8x8NbxHKxri+R4129G//c/Id12b0XgBXdK
         lg8w==
X-Gm-Message-State: AA+aEWZ7pzmeCrWhu3560esmmI4mDtm+2M94p5xtanNdq+OJFRf00P9F
        YX6yNG2oomTBmZIKrY71sBvzwA==
X-Google-Smtp-Source: AFSGD/XbHqACI02uXYekPc8iVe8p/cG5Ohn6eCrEjjfg54PBDjDhtBcCGmP3d1a1mXPZyGeKHUo0PQ==
X-Received: by 2002:a17:902:6907:: with SMTP id j7mr4619067plk.221.1542766260997;
        Tue, 20 Nov 2018 18:11:00 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e65-v6sm58277631pfa.90.2018.11.20.18.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 18:10:59 -0800 (PST)
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-3-damien.lemoal@wdc.com>
 <20181120172126.GA28169@ming.t460p>
 <c132f449-b45f-aab8-1b57-1a45e43d22f4@kernel.dk>
 <BN3PR0401MB164000EE62FE6BFF2ABE0069E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <68806243-0094-5cbb-39fe-cea697f40b1c@kernel.dk>
Date:   Tue, 20 Nov 2018 19:10:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BN3PR0401MB164000EE62FE6BFF2ABE0069E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/20/18 4:58 PM, Damien Le Moal wrote:
> On 2018/11/21 2:31, Jens Axboe wrote:
>> I think the below should fix it, we haven't necessarily setup an
>> ioc if we're just doing as passthrough request.
>>
>>
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index 13b8dc332541..f096d8989773 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -34,9 +34,16 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
>>  void blk_mq_sched_assign_ioc(struct request *rq)
>>  {
>>  	struct request_queue *q = rq->q;
>> -	struct io_context *ioc = current->io_context;
>> +	struct io_context *ioc;
>>  	struct io_cq *icq;
>>  
>> +	/*
>> +	 * May not have an IO context if it's a passthrough request
>> +	 */
>> +	ioc = current->io_context;
>> +	if (!ioc)
>> +		return;
>> +
>>  	spin_lock_irq(&q->queue_lock);
>>  	icq = ioc_lookup_icq(ioc, q);
>>  	spin_unlock_irq(&q->queue_lock);
> 
> This seems reasonable to me, but I wonder why this problem was not triggering
> before. The previous code getting the ioc with the rq_ioc(bio) call was
> essentially the same and there was no "if (!ioc) return;" in
> blk_mq_sched_assign_ioc() before the patch.
> Any idea why this is popping up now ?
> 
> Ming,
> 
> Is this a new test your are running ? If this same problem triggers on stable
> kernels, Jens patch needs to go to stable too.

No, it's definitely introduced in your patches:

-                       if (e->type->icq_cache && rq_ioc(bio))
-                               blk_mq_sched_assign_ioc(rq, bio);
+                       if (e->type->icq_cache)
+                               blk_mq_sched_assign_ioc(rq);

Please run blktests on a series. Always. There's no excuse not to.

-- 
Jens Axboe

