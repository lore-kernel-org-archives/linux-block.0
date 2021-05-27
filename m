Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B92C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 20:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F40E613DC
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 20:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbhE0UZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 16:25:08 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37759 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhE0UY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 16:24:57 -0400
Received: by mail-pg1-f180.google.com with SMTP id t193so817287pgb.4
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 13:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=37VRil15ezD8EYQD1I/UP6ydzb2I1DvPE/KwCHHZ6I8=;
        b=l6BD69LkCASB0dbS/3h7k/JOhP1mYUrHKZvtUB0H84LOtyJy7oODoJKzNBC2pum3gi
         NrPNHSeDplxabdZ8crzflfncsTAx4/DEMVN+N9ZaSadwj+yQ+6dIx1j6FEzsnqkD/bxZ
         7JJSPAadKMUH40PYvQXZLQUd63PVsckpyMvnEuLsoFzHLzNEXgSa7o5U468YHHZ6jzAY
         KhcrS1OLULNWxKOz51myB93f3gm6je1YOdE6RLoc2nbdnFew007fGmsxtrVg90MDkRIA
         kFzobN5fL3IuQSXnccXN7/QYh4a8CDbyD927hQE4FxiPFSsS2kI/D8dXeg9wALZUUG1j
         8cVw==
X-Gm-Message-State: AOAM532OxKccFWHXkCgYyzaY3FfWfI++8fKU9GEgBp6y2n9EoyNaklFX
        Y99tAX9fVdMVAA8heSGZ/Ws=
X-Google-Smtp-Source: ABdhPJwbFphEUgD+x3WrmQGsw3CezC9hDdbbYLwmZNsfLIXUfHHV1ved/0PwjG9lK2Spdhfc/n2+wg==
X-Received: by 2002:a62:7ad4:0:b029:2dc:d1a2:b093 with SMTP id v203-20020a627ad40000b02902dcd1a2b093mr176651pfc.66.1622147004045;
        Thu, 27 May 2021 13:23:24 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id i20sm2627874pgb.38.2021.05.27.13.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 13:23:23 -0700 (PDT)
Subject: Re: [PATCH 8/9] block/mq-deadline: Add I/O priority support
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-9-bvanassche@acm.org>
 <807decf3-b269-e663-f3db-394b74f1da00@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <337d6b15-4549-ec6e-a504-7b7d041d0077@acm.org>
Date:   Thu, 27 May 2021 13:23:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <807decf3-b269-e663-f3db-394b74f1da00@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 12:07 AM, Hannes Reinecke wrote:
> On 5/27/21 3:01 AM, Bart Van Assche wrote:
>> Maintain one FIFO list per I/O priority: RT, BE and IDLE. Only dispatch
>> requests for a lower priority after all higher priority requests have
>> finished. Maintain statistics for each priority level. Split the debugfs
>> attributes per priority level as follows:
>>
>> $ ls /sys/kernel/debug/block/.../sched/
>> async_depth  dispatch2        read_next_rq      write2_fifo_list
>> batching     read0_fifo_list  starved           write_next_rq
>> dispatch0    read1_fifo_list  write0_fifo_list
>> dispatch1    read2_fifo_list  write1_fifo_list
>
> Interesting question, though, wrt to request merging and realtime
> priority: what takes priority?
> Is the realtime priority more important than request merging?

We plan to use two I/O priorities: one for foreground applications and
one for background applications. We want to lower the application
startup time if background I/O is ongoing. The code that associates
different cgroups with foreground and background applications is already
available. We care more about foreground I/O being prioritized over
background I/O than about foreground I/O being real-time.

> And also the ioprio document states that there are 8 levels of class
> data, determining how much time each class should spend on disk access.
> Have these been taken into consideration?

My understanding is that the ioprio document was written before any I/O
controllers implemented I/O priorities. I'm not sure whether I/O
controllers will ever implement more than two I/O priorities. See also
commit 8e061784b51e ("ata: Enabling ATA Command Priorities"). A paper
about the benefits of I/O controllers supporting I/O priorities is
available at
https://www.usenix.org/system/files/conference/hotstorage17/hotstorage17-paper-manzanares.pdf.

>>  /*
>>   * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
>>   * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
>>   */
>>  static inline int deadline_check_fifo(struct deadline_data *dd,
>> +				      enum dd_prio prio,
>>  				      enum dd_data_dir data_dir)
>>  {
>> -	struct request *rq = rq_entry_fifo(dd->fifo_list[data_dir].next);
>> +	struct request *rq = rq_entry_fifo(dd->fifo_list[prio][data_dir].next);
>>  
>>  	/*
>>  	 * rq is expired!
> 
> I am _so_ not a fan of arrays in C.
> Can't you make this an accessor and use
> dd->fifo_list[prio * 2 + data_dir] ?

That's possible, but if the compiler can translate [prio][data_dir] into
[prio * 2 + data_dir], should I really do this myself instead of letting
the compiler generate that transformation?

Thanks,

Bart.
