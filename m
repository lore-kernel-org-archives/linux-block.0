Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27D8C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 18:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9330B2075C
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 18:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nOlLWX69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfCMS6d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:58:33 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34852 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfCMS6d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 14:58:33 -0400
Received: by mail-it1-f193.google.com with SMTP id 188so608283itb.0
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2019 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mY5M7BA9U9nxwGY7YRZZ1Q+nc8AMmjIiIchCYP8z9xI=;
        b=nOlLWX69va7sNyYuix4lBLeCTkKTI6HnRgeIJygmQ8cw7ED6nkdBDokRGiszoLOUoq
         4OPKssWB/1csbo6689Hs0titqP3J531MUXNoG5AYvMsP37eYPoTIbLzSDGikyMhS58h0
         ivaV87r11+tuYld7H8K9S3vOuBfqgi1mW6ngwzhqxPzG1cCrRe0PE7lGgTYTbplConQa
         yvpQQSTqwUZUkZTF3W7ajrTU02Ku4YEE6rvvu1zP2F/T6lppbUNn6XIp16dvXCn5Cbip
         O5opEZEke/g7qlfLTocBA9nyUjyNyAYpqFNUz7q8UwY6RjskwrGRkQMb5q7r1HpRu8E9
         9dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mY5M7BA9U9nxwGY7YRZZ1Q+nc8AMmjIiIchCYP8z9xI=;
        b=aVPqp+MJ5l1y4RHNGqhV4fYClmp9ImKZ47XHlsE6YUZwhe9HwaRiFl1eh9PCS5b9Qt
         tH7C+Napn4KuTeWtGwPIRuC/vaafYPr9FvbZar8ULD0hd02iS0XxJRxFPmW0peE8hj2y
         e9XCui9bjxS/3SGbRUiiJjNNQECf1iOE5yW1jxzjncWnnoxLLHg3pawzA5qis3tPQ5zy
         PYU1EXnysfgrqdKAw6i3fbzvsYdyL0eOB4S9SaeRy/LnPNmBNUE/G2Ohd2BTN0ApWofo
         icT68LtPmq2h9epRrI7+dJ3QRLRkvufR8tCOd7ffM/iqWdQR4zMjxvPnOWdKqOjYIG9M
         +Blg==
X-Gm-Message-State: APjAAAWC/C4x5RFeUBszaDFV7RLxalzZsE3sUfHffYiyRSoDoBNfVHtV
        DWp0SgiWPENz0PvpIM/7Oc5avg==
X-Google-Smtp-Source: APXvYqyuX+8hXC3B7JpiP6MPq8JqbSCaW9gWwualUw/ho+3HIZYzFEIq3MQEMIOLI67pJMsJmALnYA==
X-Received: by 2002:a24:1091:: with SMTP id 139mr2769124ity.110.1552503512388;
        Wed, 13 Mar 2019 11:58:32 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a77sm1470519itc.5.2019.03.13.11.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:58:31 -0700 (PDT)
Subject: Re: [PATCH 10/17] nvmet-fc: fix issues with targetport assoc_list
 list walking
To:     James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Nigel Kirkland <nigel.kirkland@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>
References: <20190313175510.20725-1-hch@lst.de>
 <20190313175510.20725-11-hch@lst.de>
 <73182b96-5113-005a-fb18-7cc126de8b69@broadcom.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d373705c-95a4-0eb6-0b15-317328db7b33@kernel.dk>
Date:   Wed, 13 Mar 2019 12:58:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <73182b96-5113-005a-fb18-7cc126de8b69@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/13/19 12:53 PM, James Smart wrote:
> On 3/13/2019 10:55 AM, Christoph Hellwig wrote:
>> From: James Smart <jsmart2021@gmail.com>
>>
>> There are two changes:
>>
>> 1) The logic in the __nvmet_fc_free_assoc() routine is bad. It uses
>> "safe" routines assuming pointers will come back valid.  However, the
>> intervening next structure being linked can be removed from the list and
>> the resulting safe pointers are bad, resulting in NULL ptrs being hit.
>>
>> Correct by scheduling a work element to perform the association delete,
>> which can be done while under lock.
>>
>> 2) Prior patch that added the work element scheduling left a possible
>> reference on the object if the work element couldn't be scheduled.
>>
>> Correct by doing the put on a failing schedule_work() call.
>>
>> Signed-off-by: Nigel Kirkland <nigel.kirkland@broadcom.com>
>> Signed-off-by: James Smart <jsmart2021@gmail.com>
>> Reviewed-by: Ewan D. Milne <emilne@redhat.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/nvme/target/fc.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
>> index 1e9654f04c60..8d34aa573d5b 100644
>> --- a/drivers/nvme/target/fc.c
>> +++ b/drivers/nvme/target/fc.c
>> @@ -1143,10 +1143,8 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
>>   				&tgtport->assoc_list, a_list) {
>>   		if (!nvmet_fc_tgt_a_get(assoc))
>>   			continue;
>> -		spin_unlock_irqrestore(&tgtport->lock, flags);
>> -		nvmet_fc_delete_target_assoc(assoc);
>> -		nvmet_fc_tgt_a_put(assoc);
>> -		spin_lock_irqsave(&tgtport->lock, flags);
>> +		if (!schedule_work(&assoc->del_work))
>> +			nvmet_fc_tgt_a_put(assoc);
>>   	}
>>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>>   }
>> @@ -1185,7 +1183,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
>>   		nvmet_fc_tgtport_put(tgtport);
>>   
>>   		if (found_ctrl) {
>> -			schedule_work(&assoc->del_work);
>> +			if (schedule_work(&assoc->del_work))
>> +				nvmet_fc_tgt_a_put(assoc);
>>   			return;
>>   		}
>>   
> V1 was checked in 
> (http://lists.infradead.org/pipermail/linux-nvme/2019-February/022193.html
> V2 was skipped 
> (http://lists.infradead.org/pipermail/linux-nvme/2019-February/022540.html)
> 
> V2 changes the last
> +            if (schedule_work(&assoc->del_work))
> to
> +            if (!schedule_work(&assoc->del_work))
> 
> 
> Jens - can you do this manual fixup ?

Fixed up.

-- 
Jens Axboe

