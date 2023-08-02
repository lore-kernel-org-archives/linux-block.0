Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A3BC001DF
	for <linux-block@archiver.kernel.org>; Wed,  2 Aug 2023 17:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjHBRU6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Aug 2023 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjHBRU5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 13:20:57 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466341734
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 10:20:54 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so838049a12.1
        for <linux-block@vger.kernel.org>; Wed, 02 Aug 2023 10:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690996854; x=1691601654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWvBP1960YbNXMWrCCztB25ZWwp5CdTg2VQGhGKTwcM=;
        b=dL1VARBWLwv3AetkKgo0sNU69r0VZJ9oIZDeFO3JlP/i2x2VxhiR4avgAeOzsoCZmT
         UsF+69ySd8VcE42ckiwQWC9ItUuzT2sylHVgnHP8KZ1BpnO3rQ58InCXY4d36qyXFMru
         CpuD9b+Xvik4QqCQTFvNjfnaRkoDnbqGBTzFXpUBtlOZadUobbwO5knbO6ZDjzbByk0c
         wpDRMvTN2RB/W6Ow/63Lw9/o00II4f5Nn9/x9hVDkocgEOiKMG9y06uecGrsv3l/dUXI
         O+EKkrmIsGzHnp73G2grvq3M0740bDFFDQRdPcHFGm+IzuoJ5ggpWr8zw4r6kO5LYBr8
         LcKQ==
X-Gm-Message-State: ABy/qLb0DvlyHXztVhISf2swlXTSpyTL+a5PWkORmWLVVxiPenl7vkDk
        sRoGc9mgtuv9KP/zA+bX7tg=
X-Google-Smtp-Source: APBJJlHEuU9j/IRZoP/12BmAVl6PYLXiyS8eEq8WAfm7X4YhY1Uo2sLkknDloVXc7w0iwnCWRn73gQ==
X-Received: by 2002:a17:90b:33c2:b0:268:c5af:d253 with SMTP id lk2-20020a17090b33c200b00268c5afd253mr11404461pjb.8.1690996853569;
        Wed, 02 Aug 2023 10:20:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3b5d:5926:23cf:5139? ([2620:15c:211:201:3b5d:5926:23cf:5139])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090acc1500b002633fa95ac2sm1344037pju.13.2023.08.02.10.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 10:20:53 -0700 (PDT)
Message-ID: <c62ffa3c-9a69-48bf-4eae-d3b3cee0e02b@acm.org>
Date:   Wed, 2 Aug 2023 10:20:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 3/7] scsi: core: Retry unaligned zoned writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230731221458.437440-1-bvanassche@acm.org>
 <20230731221458.437440-4-bvanassche@acm.org> <20230802115209.GA30175@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230802115209.GA30175@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/23 04:52, Christoph Hellwig wrote:
>> +/*
>> + * Returns a negative value if @_a has a lower LBA than @_b, zero if
>> + * both have the same LBA and a positive value otherwise.
>> + */
>> +static int scsi_cmp_lba(void *priv, const struct list_head *_a,
>> +			const struct list_head *_b)
>> +{
>> +	struct scsi_cmnd *a = list_entry(_a, typeof(*a), eh_entry);
>> +	struct scsi_cmnd *b = list_entry(_b, typeof(*b), eh_entry);
>> +	const sector_t pos_a = blk_rq_pos(scsi_cmd_to_rq(a));
>> +	const sector_t pos_b = blk_rq_pos(scsi_cmd_to_rq(b));
> 
> The SCSI core has no concept of LBAs.

Agreed.

> Even assuming something like this is a good idea (and I'm very
 > doubtful) it would have to live in sd.c.

I can rename scsi_cmp_lba() into scsi_cmp_pos() or scsi_cmp_sector(). As 
you know the flow of the sector information is as follows (the below is 
incomplete):
* The filesystem allocated a bio, sets bi_sector and calls
   bio_add_page().
* The filesystem calls submit_bio() and submit_bio() calls
   blk_mq_bio_to_request() indirectly. blk_mq_bio_to_request() copies
   bio->bi_iter.bi_sector into rq->__sector.
* scsi_queue_rq() is called and prepares a SCSI CDB by calling
   sd_init_command() via a function pointer in sd_template.
* The SCSI CDB is submitted to the LLD by calling
   host->hostt->queuecommand().

Since the rq->__sector information is provided before a request is 
submitted by the SCSI core and since SCSI ULD drivers are not allowed to 
modify that information, I think it is fine to read that information in 
the SCSI core by calling blk_rq_pos().

Moving the code for sorting SCSI commands by sector into sd.c would be 
cumbersome. It could be done e.g. as follows:
* Add a new function pointer in struct scsi_driver, e.g.
   prepare_reinsert.
* In the sd driver, provide an implementation for that callback and make
   it iterate over all requests and only sort those requests related to
   the sd driver.
* In the scsi_eh_flush_done_q(), add the following logic:
   - Iterate a first time over all SCSI commands that will be reinserted
     and perform the equivalent of the shell command sort -u on the
     scsi_driver.prepare_reinsert function pointers.
   - For each distinct scsi_driver.prepare_reinsert function pointer,
     call the function it points at and pass the entire list of commands
     to that function.

My opinion is that moving the logic of sorting SCSI commands by sector
into the sd driver will result in more complicated code without 
providing a real benefit. Did I perhaps overlook something?

Thanks,

Bart.
