Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413F1C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 15:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27646610A2
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 15:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhJUPWI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhJUPWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 11:22:02 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F2DC061348
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 08:19:46 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso810265ota.9
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ke/Isal217nrYVex7is7Wsm/Si9EI+sElGF5Nz2ISL0=;
        b=bJ/O04URtyw/kWVLscKvP9HT2x/WuuQSD2Vx7HqZipZ3M7SNtZdqnaGiuoCW6s7LiL
         Z3tbHhkQ0XQC+BjqKN1N81oKHaz6ZT2yW+TMs5pVXEhJ/f6sbOe8Z7R3lE9M+NU90mDh
         OmNsoBO8ODggHsQ5iAd7EUrr6FxHzTrQri3mGmBA/mWcfAhDxbH3I8gcSUbras5l8XJt
         FgT8yt4TMqX8yeocSRv2ARZdm2FP0AzCcRBE5XDNnUfwxJqYb7X4IbF3ZI06zid2k5iQ
         Vr4H9nAmKH4Z7zaL8Y6Kw6IwGrSNZ/WG2AirihmoouydBPTV333Wpg+1toZD/1KZLsPF
         vrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ke/Isal217nrYVex7is7Wsm/Si9EI+sElGF5Nz2ISL0=;
        b=cK5IRRe5DPL9Al/SckyqQ9OvUt2audoK5tJ9tRRIV9dVeDNZPUBg2dg0lUjLe839lP
         cP/RqL4D7YpEfyaq/8UHAj3bwdC0E82rHqzajC5CoiRpNZGOospwbuGT3PXmzOntoDOl
         9KiMtRGSawTMKxcqbLZessrdcn5piiXDX0+xSCOpqxaad55hdhGcIRYj46J34njIF0Ve
         wp/EFo0AWKObUqBmjQLdVK/cFXXDe7RuCwJ88iN/M37+4WFZBiiG7uFNQy+OGvtAK61z
         Jwkds1838L+r8DR6gsAsQFbj4lERLtNTZT53HRDxb2Zz9O5WRbPUirAS7iwKxTaTmh63
         25/Q==
X-Gm-Message-State: AOAM530aJUBMTcEVwpmkSR8gmCIiM1oNX3D7gH/hOaq5VfDYnf3RGPcW
        Vvgex8siAyszdV73fRuXqtQ4oooV+jjzDg==
X-Google-Smtp-Source: ABdhPJxU55wAQBUy/HOxV4jiI7+Wt95enAGwuDtjPbOooiFel5bV2MwiWS59R2cdUA9xUL24thddiw==
X-Received: by 2002:a05:6830:1c74:: with SMTP id s20mr5586858otg.235.1634829586136;
        Thu, 21 Oct 2021 08:19:46 -0700 (PDT)
Received: from ?IPv6:2600:380:783a:c43c:af64:c142:4db7:63ac? ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id l19sm1229524otu.11.2021.10.21.08.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:19:45 -0700 (PDT)
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments with
 a single argument
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
 <YXElk52IsvCchbOx@infradead.org> <YXFHgy85MpdHpHBE@infradead.org>
 <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
 <YXF8X3RgRfZpL3Cb@infradead.org>
 <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk>
 <x49ee8ev21s.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6338ba2b-cd71-f66d-d596-629c2812c332@kernel.dk>
Date:   Thu, 21 Oct 2021 09:19:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <x49ee8ev21s.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/21 9:18 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/21/21 8:42 AM, Christoph Hellwig wrote:
>>> On Thu, Oct 21, 2021 at 08:34:38AM -0600, Jens Axboe wrote:
>>>> Incremental, are you happy with that comment?
>>>
>>> Looks fine to me.
>>
>> OK good, can I add your ack/review? I can send out a v3 if needed, but
>> seems a bit pointless for that small change.
>>
>> Jeff, are you happy with this one too?
> 
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 397bfafc4c25..66c6e0c5d638 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -550,7 +550,7 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
>>  		blk_mq_complete_request(rq);
>>  }
>>  
>> -static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
>> +static void lo_rw_aio_complete(struct kiocb *iocb, u64 ret)
>>  {
>>  	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
>>  
>> @@ -623,7 +623,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>>  	lo_rw_aio_do_completion(cmd);
>>  
>>  	if (ret != -EIOCBQUEUED)
>> -		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
>> +		lo_rw_aio_complete(&cmd->iocb, ret);
>>  	return 0;
> 
> I'm not sure why that was part of this patch, but I think it's fine.

Yeah, just came across that one, I can drop this part and make it a
separate patch. Just a bit dumb to not use the function rather than the
indirect call, though maybe the compiler figures it out.

> I've still got more testing to do, but you can add:
> 
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> 
> I'll follow up if there are issues.

Thanks!

-- 
Jens Axboe

