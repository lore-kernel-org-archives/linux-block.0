Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69CC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 15:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979FF2086B
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 15:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bkAv2JDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979FF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeK0C1R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:27:17 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42605 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeK0C1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 21:27:17 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so14251891ioa.9
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 07:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Xles3uQo5dEAtmry91YOeyI6LbcjK0O3evrZ5aFMow=;
        b=bkAv2JDBRJcrN1sUqvfpDU9dZr2aO+p93zLHmMQ18xY8fqBvEsrOaHOzXoOI/MaFxh
         Kfg2npt+dtFbQm1A2sYkOgZM9KI+dUaxd7d9U9hWOB0b1/cdq/ZWYhXKkS1LnAGfhh2X
         a7IIumE1ZGE9k7l66VEYbteWDWnlk4matBsdCnBFAkei4Dz3Zw2bqNSJnAKQUn1BrbAV
         tQ4+PwUG9Rc3HdKfC/kXQZsfJsBg+5yoPbFkaNHBHxJS9PmsOWghObNoJM6QIC4wZW9V
         ExFhNymIFVcSilznllgb22H7YUVCma5lKp+Gja0Utktx7/x0YP09deBHB6Z6MACrZ8JJ
         Kh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Xles3uQo5dEAtmry91YOeyI6LbcjK0O3evrZ5aFMow=;
        b=OUyy0dhkgOLtYia1wQFDMmcDAN+PFo+3FVnLx7gpZKmrTLJeWBH9DMLVzI1nvxQpma
         hlU7QB1jaEXQHUWC8QQhk5a/ywrw/iYgYTPpMIE6WP1ym31qk/451z3SMSiIsDzYEJkA
         hPgVnV0u2o1y11y6bfiXXNnErrLeaQ82Lc+q5Pl3EqSicdc4K5f+PfNHySJz72K38b0N
         +U2ptXsXlW96SyG4l255i1WN86v9R1H3WIDm0oDFheAMBP23mRc6Cgcqi0uqqBeT6E95
         //gACZUF0U4SIqBf+aeTSNt4gaoSpAJmwrkYFU1HYHmpH+mH51zfeuw+OMbFYAwOPhnS
         g5MA==
X-Gm-Message-State: AA+aEWZmA34tlYdxR9DClDXyw1XpO0o8mIUsS+XVgQPUY8tATMPg4s03
        LLfBNKbod6Ww1kGdyLFHvSa3VA==
X-Google-Smtp-Source: AFSGD/Wh1KJ/y9jCjcxmEDp1fzZp5HSttq20TEG3Z7LF0kTYKX5Ej+9mePQycSqBSW4YIOLhWM9qbA==
X-Received: by 2002:a5d:9aca:: with SMTP id x10mr16624216ion.19.1543246369009;
        Mon, 26 Nov 2018 07:32:49 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k4sm197581ion.61.2018.11.26.07.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 07:32:47 -0800 (PST)
Subject: Re: [PATCHv3 2/3] scsi: Do not rely on blk-mq for double completions
To:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20181115175820.13391-1-keith.busch@intel.com>
 <20181115175820.13391-3-keith.busch@intel.com>
 <20181119085815.GB29626@infradead.org>
 <20181119151859.GB23062@localhost.localdomain>
 <20181121131212.GA7251@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <913ec33d-9aff-2c48-362f-9252ed111451@kernel.dk>
Date:   Mon, 26 Nov 2018 08:32:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121131212.GA7251@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/21/18 6:12 AM, Christoph Hellwig wrote:
> On Mon, Nov 19, 2018 at 08:19:00AM -0700, Keith Busch wrote:
>> On Mon, Nov 19, 2018 at 12:58:15AM -0800, Christoph Hellwig wrote:
>>>> index 5d83a162d03b..c1d5e4e36125 100644
>>>> --- a/drivers/scsi/scsi_lib.c
>>>> +++ b/drivers/scsi/scsi_lib.c
>>>> @@ -1635,8 +1635,11 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
>>>>  
>>>>  static void scsi_mq_done(struct scsi_cmnd *cmd)
>>>>  {
>>>> +	if (unlikely(test_and_set_bit(__SCMD_COMPLETE, &cmd->flags)))
>>>> +		return;
>>>>  	trace_scsi_dispatch_cmd_done(cmd);
>>>> -	blk_mq_complete_request(cmd->request);
>>>> +	if (unlikely(!blk_mq_complete_request(cmd->request)))
>>>> +		clear_bit(__SCMD_COMPLETE, &cmd->flags);
>>>>  }
>>>
>>> This looks a little odd to me.  If we didn't complete the command
>>> someone else did.  Why would we clear the bit in this case?
>>
>> It's only to go along with the fake timeout. If we don't clear the bit,
>> then then scsi timeout handler will believe it has nothing to do because
>> scsi did its required part. The block layer just pretends the LLD didn't
>> do its part, so scsi has to play along too.
> 
> This just looks way to magic to me.  In other word - it needs a big fat
> comment explaining the situation.
> 
>>>> +#define __SCMD_COMPLETE		3
>>>> +#define SCMD_COMPLETE		(1 << __SCMD_COMPLETE)
>>>
>>> This mixing of atomic and non-atomic bitops looks rather dangerous
>>> to me.  Can you add a new atomic_flags just for the completed flag,
>>> and always use the bitops on it for now? I think we can eventually
>>> kill most of the existing flags except for SCMD_TAGGED over the
>>> next merge window or two and then move that over as well.
>>
>> The only concurrent access is completion + timeout, otherwise access is
>> single-threaded. I'm using the atomic operations only where it is
>> needed.
>>
>> We implicitly clear the SCMD_COMPLETED flag along with SCMD_TAGGED in
>> scsi_init_command() too, and I didn't want to add new overhead with
>> new atomics.
> 
> In general mixing access types on a single field (nevermind bit)
> is going to cause us problems further down the road sooner or later.
> 
> I'd be much happier with a separate field.

Keith, will you please respin with the separate field? Would be nice
to get this merged for 4.21.

-- 
Jens Axboe

