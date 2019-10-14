Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D13C4CECE
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 19:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A86217D9
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 19:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rYs88hir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfJNTy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:54:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34941 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbfJNTy2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 15:54:28 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so40712308iop.2
        for <linux-block@vger.kernel.org>; Mon, 14 Oct 2019 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RMUgYU5Umi/jThAXUy/ctU8Hvay29k1XXC53CiKmvUw=;
        b=rYs88hirip+xZ1dp/fbiKdqoYzOB/D2Hf4rmixikGWM4DyohSylRXcNg9ex12FR1ry
         XsxgehhEYtDb8atEFOjFkuLiLBwXAl6tIWK3dq8/Ol87OsOUI2ka9eAjCPqWWhpgZ0q2
         +2geiLoiSiyh+oMhqHFAs9iTu1k9sUy3BUVHzP56cnTcqOSdlu1FHvmhTflRd2ox90xt
         7njldiv7NodUyVeYA9AkBZ39kRjQzeiPYU8876ZGrA5yiPusodGgRUIgrlMLe5p6kgu+
         yaiMy/nzhKdgJnRpoKXLbtKiEzz7IP+Qj9S/OuIwboh4v2YfnNd66yUV7eV1sDTDTkeK
         25yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RMUgYU5Umi/jThAXUy/ctU8Hvay29k1XXC53CiKmvUw=;
        b=uizrnQqOcKTXa/V3YfCxii9i38jS96Ic2ex+HmyWpqQELgHAlJNvUrRThkuI+42cGy
         Tlb66dLt2r26ji1vxGUqbrY4bxU6Ebj4ST+RAjjvXfKg1BudYoYIBROjGz5XTrVP8Ule
         GlIFjJpVW9PX1x5e2Jjq27lAQV0TUq11ixa78Iw5RN6EMsYizZcctQzWIFTo49eCX8/f
         H4Kik8wTXe3jJs8yr7P8CM6NiyPkqrkoYqbmyuToY2ZTX8ZRMMo+nyGgygLivm0V7mPL
         uq5z//mr7PBO/vVH1Vidt12ZtfJGuEWF1L9qqoIqOHqOLAE21doNlYUihYf/bMsEQvt0
         Jgog==
X-Gm-Message-State: APjAAAVqG4YC7dSiL45KqZ3y+SKZw5uFyvC8whZeNj7SIDiuPg+PaMCX
        JNUYyApGINvAHH67iByJvqamTA==
X-Google-Smtp-Source: APXvYqzRmdNYMrsJrHKXvslQjAS9FIQfFOu6cd+gXO5yZ1+slXnvKl0eX+2Wh1Lh0QpyC0AQKs94qQ==
X-Received: by 2002:a92:5dc5:: with SMTP id e66mr2948205ilg.48.1571082865646;
        Mon, 14 Oct 2019 12:54:25 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i18sm2165601ilc.34.2019.10.14.12.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 12:54:24 -0700 (PDT)
Subject: Re: [PATCH V2] block: Fix elv_support_iosched()
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20191008223954.6084-1-damien.lemoal@wdc.com>
 <BYAPR04MB581615B3209B75F0BE608700E7900@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dae83811-e2ce-9343-624b-209bf617b5a7@kernel.dk>
Date:   Mon, 14 Oct 2019 13:54:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB581615B3209B75F0BE608700E7900@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/19 6:03 PM, Damien Le Moal wrote:
> On 2019/10/09 7:40, Damien Le Moal wrote:
>> A BIO based request queue does not have a tag_set, which prevent testing
>> for the flag BLK_MQ_F_NO_SCHED indicating that the queue does not
>> require an elevator. This leads to an incorrect initialization of a
>> default elevator in some cases such as BIO based null_blk
>> (queue_mode == BIO) with zoned mode enabled as the default elevator in
>> this case is mq-deadline instead of "none".
>>
>> Fix this by testing for a NULL queue mq_ops field which indicates that
>> the queue is BIO based and should not have an elevator.
>>
>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>> Changes from V1:
>> * Test if q->mq_ops is NULL to identify BIO based queues
>>
>>   block/elevator.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/elevator.c b/block/elevator.c
>> index 5437059c9261..076ba7308e65 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -616,7 +616,8 @@ int elevator_switch_mq(struct request_queue *q,
>>   
>>   static inline bool elv_support_iosched(struct request_queue *q)
>>   {
>> -	if (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
>> +	if (!q->mq_ops ||
>> +	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
>>   		return false;
>>   	return true;
>>   }
>>
> 
> Jens,
> 
> Ping ? This was not in your rc3 pull request...

Yeah that missed -rc3, I've queued it up for -rc4. Thanks!

-- 
Jens Axboe

