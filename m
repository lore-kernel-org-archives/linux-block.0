Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DFDC5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjAIXzu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjAIXzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:55:49 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D7940C19
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:55:47 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id z4-20020a17090a170400b00226d331390cso11522329pjd.5
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4eT7STAEGWF9XGpmgfrdHkB/LSnWJ2RBsrYsPGWa04=;
        b=7j7LjDcbBRe0xEiPG3PIXiQ/d3vI75he2mtYDfoniO0QnmkDrWd57OWM7cE9YO3zuD
         aM90x9Dn0vKyb5MhJhVSMNHgz0wOP85yCXpiwbdno88VwUDiubUTri9MeaWSckgcfinz
         e3q9vih0Qb7v0TP+i0lDjksh79UPrqRZu/gA/iXb4vKOmiGHViMqxj16YmoHFuLAtQfN
         mM4dAgMhNLX1XcxWd6a+T7OpgW1q6mFFHmTjZZ8rLF+xerUBkZFnQIsMecTDG3PMadvE
         EerQ1Jpc4g3USqVtTHic4+w5jadnoqnwGNkORUGurASUFwnxZQ00QmocjMnkdVLT8gWB
         +lxg==
X-Gm-Message-State: AFqh2kq2TYtEHyOHw8vHI17qS96PNKLI8aTSqNj28EYHUQlX3EEUQUys
        Ik0FZjFsnBkuBaZTddETUSU=
X-Google-Smtp-Source: AMrXdXsCTVe5W+/l58i/ukp2J1metSt10QHBMlr4qKGNaNvH5WW177HTuK8Jr4xp6zBBfymdTMuYKg==
X-Received: by 2002:a17:90a:f3cc:b0:226:daad:8c88 with SMTP id ha12-20020a17090af3cc00b00226daad8c88mr14079395pjb.16.1673308547367;
        Mon, 09 Jan 2023 15:55:47 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:9f06:14dd:484f:e55c? ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id z14-20020a634c0e000000b0049c8aa4211asm5663358pga.8.2023.01.09.15.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 15:55:46 -0800 (PST)
Message-ID: <a87675d6-6d8a-00d0-64c3-ab5c3a888121@acm.org>
Date:   Mon, 9 Jan 2023 15:55:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 7/8] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-8-bvanassche@acm.org>
 <ea52044b-13ef-d71b-a14a-6e1bebe59638@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ea52044b-13ef-d71b-a14a-6e1bebe59638@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 15:51, Damien Le Moal wrote:
> On 1/10/23 08:27, Bart Van Assche wrote:
>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>> index 47dafe6b8a66..cd90b54a6597 100644
>> --- a/drivers/scsi/sd.c
>> +++ b/drivers/scsi/sd.c
>> @@ -1207,6 +1207,9 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>   	cmd->transfersize = sdp->sector_size;
>>   	cmd->underflow = nr_blocks << 9;
>>   	cmd->allowed = sdkp->max_retries;
>> +	if (blk_queue_pipeline_zoned_writes(rq->q) &&
>> +	    blk_rq_is_seq_zone_write(rq))
>> +		cmd->allowed += rq->q->nr_requests;
>>   	cmd->sdb.length = nr_blocks * sdp->sector_size;
>>   
>>   	SCSI_LOG_HLQUEUE(1,
> 
> Aouch... The amount of IO errors logged in the the kernel log will not be
> pretty, no ?
> 
> At least for scsi disks, the problem is that a write may partially fail
> (the command hit a bad sector). Such write failure will cause all queued
> writes after it to fail and no amount of retry will help. Not sure about
> UFS devices though. Can you get a partial failure ?

Although the UFS specification supports residuals, one of the open bugs 
in the UFS driver is that the residual field from the UFS device 
response is ignored. I think this means that no UFS device vendor cares 
enough about partial failures to implement support for partial failures.

Please let me know if you want me to look into suppressing error 
messages triggered by this new retry mechanism.

Thanks,

Bart.
