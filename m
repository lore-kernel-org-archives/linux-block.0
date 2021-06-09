Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF1C48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 17:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51365613CA
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 17:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhFIR1w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:27:52 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:33787 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhFIR1v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 13:27:51 -0400
Received: by mail-pg1-f170.google.com with SMTP id e20so8135723pgg.0
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 10:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v6AYe6MkOpHxPc27lTfpnBr3knCITA2Elr/J/NcVqhM=;
        b=m+N+06WwzlH/vMlSWS4UkG6Y11E2kF6iL1CgSoyhWWu/kryIcY6dK2a+plbE1FpK8j
         RMNzVUL4aCRymQifRzbtAgSNtzNAhwCgQXFO98A0P9KSSPalVze0r01WYQgtNc/QK8Bf
         KaziDNhIlMS8r3YZogOvduA05Mg+yHruO8zRABQoLsxQqj2E050qej+IEWud9P8AWdI4
         tF+zUcllRWqLZ/msyB3KSsusxwTuzuc2i1zIQPKdAk/GVZQ+XzlUuABedsSuwjZJVzW8
         DlOzmdfoW8zJcHnNkr6+3aOmDkoUMAcc8jrTMT9vX7W6wpWsOvF77rY/gZDEnTruNkWE
         iyOw==
X-Gm-Message-State: AOAM532j+m198at0h5CrVJYIy/zaJUUeoJYyfKk3CKfGfVBFAwtuHY1b
        s00Qxn7kp6TWshD52BJS5+Ls2sEDX9c=
X-Google-Smtp-Source: ABdhPJyMGmtop5uo8rixwwRjSgvZXadBBNbXYFo8dEKnAaiQVvXv58xFKjORdUFP3aeRgEBzfNZ0gA==
X-Received: by 2002:a62:5c1:0:b029:2a9:7589:dd30 with SMTP id 184-20020a6205c10000b02902a97589dd30mr842538pff.66.1623259546949;
        Wed, 09 Jun 2021 10:25:46 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id m2sm265944pjf.24.2021.06.09.10.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 10:25:46 -0700 (PDT)
Subject: Re: [PATCH 12/14] block/mq-deadline: Add I/O priority support
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-13-bvanassche@acm.org>
 <DM6PR04MB70818D0058A0B1249AC7EBFCE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7fa81169-6c94-f7b1-f086-6f2caa775d41@acm.org>
Date:   Wed, 9 Jun 2021 10:25:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB70818D0058A0B1249AC7EBFCE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 10:03 PM, Damien Le Moal wrote:
> On 2021/06/09 8:07, Bart Van Assche wrote:
>>  struct deadline_data {
>>  	/*
>>  	 * run time data
>>  	 */
>>  
>>  	/*
>> -	 * requests (deadline_rq s) are present on both sort_list and fifo_list
>> +	 * Requests are present on both sort_list[] and fifo_list[][]. The
>> +	 * first index of fifo_list[][] is the I/O priority class (DD_*_PRIO).
>> +	 * The second index is the data direction (rq_data_dir(rq)).
>>  	 */
>>  	struct rb_root sort_list[DD_DIR_COUNT];
>> -	struct list_head fifo_list[DD_DIR_COUNT];
>> +	struct list_head fifo_list[DD_PRIO_COUNT][DD_DIR_COUNT];
> 
> Would it make sense to pack these 2 into a sub structure ? e.g.:
> 
> struct deadline_lists {
> 	struct rb_root sort_list;
> 	struct list_head fifo_list[DD_PRIO_COUNT];
> };
> 
> struct deadline_data {
> 	...
> 	/*
> 	 * Requests are present on both sort_list[] and fifo_list[][]. The
> 	 * first index of fifo_list[][] is the I/O priority class (DD_*_PRIO).
> 	 * The second index is the data direction (rq_data_dir(rq)).
>  	 */
> 	struct deadline_lists	lists[DD_DIR_COUNT];
 The deadline_fifo_request() function and several other functions
examine both directions so I think that grouping per direction would
complicate these functions. Grouping per I/O priority might help to make
these functions easier to read. Do you want me to look further into this?

>> +	struct deadline_data *dd = q->elevator->elevator_data;
>> +	const u8 ioprio_class = dd_rq_ioclass(next);
>> +	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>> +
>> +	if (next->elv.priv[0]) {
>> +		dd_count(dd, merged, prio);
>> +	} else {
>> +		WARN_ON_ONCE(true);
>> +	}
> 
> No need for the curly brackets I think.

I can leave these out but you may want to know that leaving the curly
brackets out from this patch will make it necessary to introduce these
in the next patch in this series.

>> +/* Number of requests queued for a given priority level. */
>> +static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>> +{
>> +	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
> 
> This also includes requests that are being executed on the device. Is that OK ?

Yes, and that's on purpose. Please note that this function is only used
to export statistics to user space.

Thanks,

Bart.
