Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90DBC77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 16:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjEQQas (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjEQQaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 12:30:46 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CB8A4A
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 09:30:45 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64359d9c531so725129b3a.3
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 09:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341045; x=1686933045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7/vms7JefVtoIzFJP/LgN5FvhDMulnRoF4FgZuFb+4=;
        b=VoW3b2rm0gj+ONu8ct1r6gvmmm2SvM85wQI6jwarjhmpHMdHxp5SUcxi+6yfCtSOBS
         dN4b01XocdooyoSAYlXWdxPvfKLzQ8Lkz7vupkLDKxxrzzfyPGGAIPWV3AJQl3+YXWDm
         SSoNRVVWZCPqN+f87BuGLvvUuvGsoxWMYVPIXpnsIX3syqMy41PaF1r2HhIO/QV31LGh
         Penyx8NjWchS4NZCeSWZ2+es2DPAaIXN/XgAX5aZEiFyjw05DzPHTclXBLZtRuv2cDqw
         Q5m+AvblACgLfqGeS3RBqmu5nFLY70Xlkvo1omuqyj9gkb2k1N8ZQRrSs33DF4zK3aHp
         /uHw==
X-Gm-Message-State: AC+VfDz1nXEf43WI2A3WUQmt4VaopLZUHBYoy5eT8YnnyGz0zo2qwcJm
        Jfv2ShNYBUIm+moOI4UELxc=
X-Google-Smtp-Source: ACHHUZ7+l4saLGYAVpze4P/iTmQTOmr2uuJPl27kYm0ALD5DAkhk11/uiB2me8i9JkCWBc6HvRWxNA==
X-Received: by 2002:a05:6a21:6d99:b0:105:12ab:878c with SMTP id wl25-20020a056a216d9900b0010512ab878cmr20466674pzb.33.1684341044805;
        Wed, 17 May 2023 09:30:44 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x47-20020a056a000bef00b0064b0326494asm7743511pfu.150.2023.05.17.09.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:30:44 -0700 (PDT)
Message-ID: <06e87316-4b22-b275-4223-775192e5ccac@acm.org>
Date:   Wed, 17 May 2023 09:30:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 07/11] block: mq-deadline: Improve
 deadline_skip_seq_writes()
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-8-bvanassche@acm.org>
 <37120c5c-120f-3ff3-fcbf-1a52f389fe3e@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <37120c5c-120f-3ff3-fcbf-1a52f389fe3e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/23 18:06, Damien Le Moal wrote:
> On 5/17/23 07:33, Bart Van Assche wrote:
>> Make deadline_skip_seq_writes() do what its name suggests, namely to
>> skip sequential writes.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   block/mq-deadline.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>> index 6276afede9cd..dbc0feca963e 100644
>> --- a/block/mq-deadline.c
>> +++ b/block/mq-deadline.c
>> @@ -308,7 +308,7 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>>   	do {
>>   		pos += blk_rq_sectors(rq);
>>   		rq = deadline_latter_request(rq);
>> -	} while (rq && blk_rq_pos(rq) == pos);
>> +	} while (rq && blk_rq_pos(rq) == pos && blk_rq_is_seq_zoned_write(rq));
> 
> No ! The "seq write" skip here is to skip writes that are contiguous/sequential
> to ensure that we keep issuing contiguous/sequential writes belonging to
> different zones, regardless of the target zone type.
> 
> So drop this change please.

Hi Damien,

I'm fine with dropping this patch. I came up with this patch because it 
surprised me to see that deadline_skip_seq_writes() does not check the 
type of the requests that it is skipping. If e.g. a WRITE is followed by 
two contiguous READs, all three requests are skipped. Is this intentional?

Thanks,

Bart.

