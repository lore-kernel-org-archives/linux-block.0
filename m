Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E500C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 15:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C0720869
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 15:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AuMcXZWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfBJPXa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:23:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33025 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBJPX3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 10:23:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so4038631pfb.0
        for <linux-block@vger.kernel.org>; Sun, 10 Feb 2019 07:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cwOfBmCsWpM2ET3DtQtEGtek6cK7DN1HHieUktob4oI=;
        b=AuMcXZWL4HEjqA4r7F/JNZr0kRnk66YwIatOSFwyJTwng2Vt2M3YJnNNs7I92gi3M3
         TXIzp4Ay+uMC6Ojukk66fmUjC/pW+E62/qZDh+Uabv4DJDJ05OxouhYyxu/4D8/8ULpL
         G7DfW587MbMqnm+CSYBjv1wvVHAorL8h1hng3YPtC2sWZVkoiDxAMSdjd8Ski8tAr2HB
         ITsgawq1+ldxjYwuf5LneyMwXsmWs9LAtnhow59Uqw5PCVQxK29sEiADEKSyVqyTenZW
         gOgArzGPi2qri3uOWxf3lDLRUH5KtjUJtbEwIHtDAiFzIXe6HI6E5/8EBqWAsHh+pA7X
         vLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cwOfBmCsWpM2ET3DtQtEGtek6cK7DN1HHieUktob4oI=;
        b=lzdNZANAAp0CuxyJfy5WLnBUUKS9m4XkqnqUzpCBXiwkkHMrtA7iVkszDfJizOct8X
         MLt6d39yzfSW5Qr0UMZPK0cQJzAZKf97PNT8JDbIBfAHqGGG5+hDQzKGMmFnrIkNcKGU
         45b1ufJ8cDolwxTiKp/R4fxaY2ebh7xW4wlcjP8IHBLb+RPwYAa0FjT/NCVi2BsCV558
         siRHZ+NMqc6o8CRr+qV5oURT8vshveY46Pm6kN13zEefnikUNyY2YmQ38ih9RypOi2t9
         +KiVmHe0AbjM0ALaTptD/86WRZjxxQidCZVpmSE0xvhwUnFODSCAh624pPX5HCX3Pc6E
         VC4w==
X-Gm-Message-State: AHQUAuas8sQZgfcpXv7LOInF/eCKtXcoRpboM/mpxrc9YN4JfDJwZvKM
        r9eETpsOIw34emZHv9q33XZpNJMBofTgmA==
X-Google-Smtp-Source: AHgI3IaNmd+SR87Jma4nbRVFfE/SMQdjSHDkwV/9F1e9juoQb6Zp8teOIKSrFf6Fnc66WbsAaQI4ZA==
X-Received: by 2002:a63:ef50:: with SMTP id c16mr21041199pgk.3.1549812208052;
        Sun, 10 Feb 2019 07:23:28 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b26sm12132897pfe.91.2019.02.10.07.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 07:23:27 -0800 (PST)
Subject: Re: [PATCH] blk-sysfs: Rework documention of __blk_release_queue
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20190131011139.2264742-1-marcos.souza.org@gmail.com>
 <02fcaaa4-3667-7144-5ca2-4e5346380439@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <813bdf91-83de-332d-5d6b-2287039578b5@kernel.dk>
Date:   Sun, 10 Feb 2019 08:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <02fcaaa4-3667-7144-5ca2-4e5346380439@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/9/19 11:34 AM, Marcos Paulo de Souza wrote:
> Ping :)
> 
> On 1/30/19 11:11 PM, Marcos Paulo de Souza wrote:
>> The Notes section of the comment was removed, because now
>> blk_release_queue can only be executed from blk_cleanup_queue (being
>> called when the q->kobj reaches zero), and also blk_init_queue was removed
>> in a1ce35fa4985.
>>
>> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
>> ---
>>  This is basically a v2 of https://lkml.org/lkml/2019/1/14/1098
>>
>>  But, I tried to describe when this function is called, removing redundancies.
>>  Maybe it would be better placed in blk-core.c, where the q->kobj is initialized
>>  with blk_queue_ktype (which .release pointer points to blk_release_queue)?
>>
>>  block/blk-sysfs.c | 19 +++++++------------
>>  1 file changed, 7 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 590d1ef2f961..d4dea9179fa6 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -817,21 +817,16 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
>>  }
>>  
>>  /**
>> - * __blk_release_queue - release a request queue when it is no longer needed
>> + * __blk_release_queue - release a request queue
>>   * @work: pointer to the release_work member of the request queue to be released
>>   *
>>   * Description:
>> - *     blk_release_queue is the counterpart of blk_init_queue(). It should be
>> - *     called when a request queue is being released; typically when a block
>> - *     device is being de-registered. Its primary task it to free the queue
>> - *     itself.
>> - *
>> - * Notes:
>> - *     The low level driver must have finished any outstanding requests first
>> - *     via blk_cleanup_queue().
>> - *
>> - *     Although blk_release_queue() may be called with preemption disabled,
>> - *     __blk_release_queue() may sleep.
>> + *     This function is called when a block device is being de-registered. The

unregistered

>> + *     process of releasing a request queue starts with blk_cleanup_queue, which
>> + *     set the appropriate flags and the calls blk_put_queue, that decrements

s/the/then

>> + *     the reference counter of the request queue. Once the reference counter
>> + *     of the request queue reaches zero, blk_release_queue is called to release
>> + *     all allocated resources of the request queue.
>>   */
>>  static void __blk_release_queue(struct work_struct *work)
>>  {
>>


-- 
Jens Axboe

