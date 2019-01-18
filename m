Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB47FC5AC81
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3472086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dunjGScR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfARTA6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:00:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43195 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbfARTA5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 14:00:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so6464747pgk.10
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 11:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yfBlyynR755OjSbhKTiQ0PqRJqFi7tSrB6SBleZABgI=;
        b=dunjGScRSr90OVJidwPBnNo2qD21x4RSKPhNQhk+RE4OsiS2QK6ex0U6qKsCvRPZcP
         82Ac3+NDJPtAtcXA+U0XrJZmzszqNbVVYHx4uWnZavjQMerox0G1qUMdvM6ZDbfnSypc
         4yDT548zulPnY6tAXD188ZKBBloISdn5SEfk4ltg9pmBFZ7UU3xkw0OS0XAOQV6ZjHjH
         4GSMuiQyPwvrGryWbQvXqSNaElNE7+H78VzT7aLz/Lgb+n+MHOxstlMKwFE28ab/aVrU
         COUuSVmN8Oomm7COoBIdqcg2MdBh0VdvNbppinB2wABXS7vrlAixzwTOJnT2gvRp58M5
         Za3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yfBlyynR755OjSbhKTiQ0PqRJqFi7tSrB6SBleZABgI=;
        b=Mfk/CE+bXNEZjg1Ql4QZc8LLyeM2igcnu4A20eWSacgQN6C8dUHVKfCrakVG8bzZLi
         hSdi3X9xqWjLxou+NLQDvpr0ioAH27RdENkoH8GSMC1fmuVJaATwfU6f3rjTVjh54kk2
         KCN8rgQ3EVME2iTtjCbYC2XDITu+LxMgl/Pc0puyCBUPMMoptm7ZTN3gUlC8iqLlp9Hl
         tajcP9QZsLQWsUxFFhbaS8aIdc/FoMJ3CN1mxZSlN2N+r461NU3BnX2wYJQlwk6xiRFV
         HGD+IzjN/9jlZh7OfuIR+nZXVXTkN33G3OUpSqxpVYPtm+GTYdMngaq8psWmIX36WgOF
         M/mw==
X-Gm-Message-State: AJcUukfH4HRaL0yOVrZBOeqhrQYVlgoIvd1Bh0kOx7sC0V5B1Edv+SK+
        avuzZt4MbrvGSu/W7mYC89cWqg==
X-Google-Smtp-Source: ALg8bN40yCEBM2MC5BRuhj3wucG/p7kSRiczSRBbL7BOFTscgPDfNjPyeZed+8ACtazyMHIj7hlRLQ==
X-Received: by 2002:a62:1a44:: with SMTP id a65mr20853577pfa.30.1547838056201;
        Fri, 18 Jan 2019 11:00:56 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id x26sm7486592pfn.50.2019.01.18.11.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 11:00:55 -0800 (PST)
Subject: Re: dd hangs when reading large partitions
To:     Bart Van Assche <bvanassche@acm.org>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <1547833876.102272.0.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f62f7e5b-c6ab-e58a-a9a9-6d4acfc38722@kernel.dk>
Date:   Fri, 18 Jan 2019 12:00:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547833876.102272.0.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/19 10:51 AM, Bart Van Assche wrote:
> On Fri, 2019-01-18 at 10:48 -0700, Jens Axboe wrote:
>> It's UFS that totally buggy, if you look at its queuecommand, it does:
>>
>>         if (!down_read_trylock(&hba->clk_scaling_lock))                         
>>                 return SCSI_MLQUEUE_HOST_BUSY;
>>
>> UFS either needs to get fixed up, or we'll want a way to do something like
>> the below.
>>
>> Marc, can you test this?
>>
>>
>> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
>> index eaf329db3973..e28c3420a9d9 100644
>> --- a/drivers/scsi/hosts.c
>> +++ b/drivers/scsi/hosts.c
>> @@ -412,6 +412,7 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>>  	shost->hostt = sht;
>>  	shost->this_id = sht->this_id;
>>  	shost->can_queue = sht->can_queue;
>> +	shost->queue_may_block = sht->queue_may_block;
>>  	shost->sg_tablesize = sht->sg_tablesize;
>>  	shost->sg_prot_tablesize = sht->sg_prot_tablesize;
>>  	shost->cmd_per_lun = sht->cmd_per_lun;
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index b13cc9288ba0..4e266af2871f 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1902,6 +1902,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>>  	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
>>  	shost->tag_set.flags |=
>>  		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
>> +	if (shost->queue_may_blocK)
>> +		shost->tag_set.flags |= BLK_MQ_F_BLOCKING;
>>  	shost->tag_set.driver_data = shost;
>>  
>>  	return blk_mq_alloc_tag_set(&shost->tag_set);
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 9ba7671b84f8..9ab354e43630 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -6981,6 +6981,7 @@ static struct scsi_host_template ufshcd_driver_template = {
>>  	.sg_tablesize		= SG_ALL,
>>  	.cmd_per_lun		= UFSHCD_CMD_PER_LUN,
>>  	.can_queue		= UFSHCD_CAN_QUEUE,
>> +	.queue_may_block	= 1,
>>  	.max_host_blocked	= 1,
>>  	.track_queue_depth	= 1,
>>  	.sdev_groups		= ufshcd_driver_groups,
>> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
>> index 6ca954e9f752..30aa7b6c4342 100644
>> --- a/include/scsi/scsi_host.h
>> +++ b/include/scsi/scsi_host.h
>> @@ -339,6 +339,11 @@ struct scsi_host_template {
>>  	 */
>>  	int can_queue;
>>  
>> +	/*
>> +	 * If the ->queuecommand() ever blocks, this should be set
>> +	 */
>> +	int queue_may_block;
>> +
>>  	/*
>>  	 * In many instances, especially where disconnect / reconnect are
>>  	 * supported, our host also has an ID on the SCSI bus.  If this is
>> @@ -584,6 +589,7 @@ struct Scsi_Host {
>>  
>>  	int this_id;
>>  	int can_queue;
>> +	int queue_may_block;
>>  	short cmd_per_lun;
>>  	short unsigned int sg_tablesize;
>>  	short unsigned int sg_prot_tablesize;
> 
> Hi Jens,
> 
> Did you perhaps want to include a change from down_read_trylock() into
> down_read() in the UFS queuecommand function in this patch?

Yeah, that should be done as well. But honestly, looking at UFS, it's in
dire need of love from someone that has some experience in writing a
driver. The locking is absolutely miserable.

For one, the clk_scaling_lock needs to die. The clock scaling change
should coordinate with the requests, not try to lock out request
handling. It's totally an upside down approach.

-- 
Jens Axboe

