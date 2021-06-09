Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC79C48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 16:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0751261354
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 16:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFIQ40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:56:26 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:35652 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFIQ4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 12:56:25 -0400
Received: by mail-pl1-f179.google.com with SMTP id x19so5719255pln.2
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 09:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XKd+RKYmRJ/ehnIZu3C4oSnNDXVsKmqQWXWGW+e5ErE=;
        b=RnRediUSIBGlhbReHqgcko7RetRZQEvP7u5j82W7A18/ZOHEi1ypecaMbBPhpSCwbv
         5Cb5e4laxKEGffkZQfLnjhfT1N0dyKkcE1qM54mgygBnRhf1C+1Vxps97brCL/bucTnk
         NDkVV8kkTH0BJbLyDTd236LaydjUBfgY17j5WrlaRsKM8eOT2pKmasRSNIRD9WRrq8Rt
         ziULSxioDegI56gEfCx5/ztCVUweBUH8wtUYdr0a6qJ0gUvp6u4N0Gxy1AErc0r49VQt
         3W5BmBQurwCF6uJ3K7uXuQq6ATgk7o6d/X6P9KG5ZC/7xra1jDk7xj+czCJw4JeNqBx7
         Tq+Q==
X-Gm-Message-State: AOAM530EY/wCYbI5c8yH4z6yn6BG68qEo1sFvwTM9yCKZoaMywRjtDDU
        98ORfgNAW02NZE2gGBFN5Qk=
X-Google-Smtp-Source: ABdhPJx8jTZKtIxxLBRP05vjoqgRH1cTC6PNtY8Pq0JRM3pgHNShqI+mxxEsQY9qh/+YiS34u45CMw==
X-Received: by 2002:a17:902:f291:b029:104:9bae:f569 with SMTP id k17-20020a170902f291b02901049baef569mr629133plc.13.1623257657273;
        Wed, 09 Jun 2021 09:54:17 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id v7sm144315pfi.187.2021.06.09.09.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 09:54:16 -0700 (PDT)
Subject: Re: [PATCH 10/14] block/mq-deadline: Improve the sysfs show and store
 macros
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-11-bvanassche@acm.org>
 <DM6PR04MB7081916EE79D419357373085E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8547812b-c8b5-93c1-0189-f8ce4c01ff99@acm.org>
Date:   Wed, 9 Jun 2021 09:54:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081916EE79D419357373085E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 9:46 PM, Damien Le Moal wrote:
> On 2021/06/09 8:07, Bart Van Assche wrote:
>> +#define SHOW_INT(__FUNC, __VAR)						\
>>  static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
>>  {									\
>>  	struct deadline_data *dd = e->elevator_data;			\
>> -	int __data = __VAR;						\
>> -	if (__CONV)							\
>> -		__data = jiffies_to_msecs(__data);			\
>> -	return deadline_var_show(__data, (page));			\
>> -}
>> -SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);
>> -SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1);
>> -SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);
>> -SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);
>> -SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);
>> -#undef SHOW_FUNCTION
>> +									\
>> +	return sysfs_emit((page), "%d\n", __VAR);			\
>> +}
>> +#define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__VAR))
> 
> jiffies_to_msecs() returns an unsigned int but sysfs_emit() in SHOW_INT() uses a
> %d format. That will cause problems, no ?

The corresponding store functions restrict values that represent a time
in jiffies to the interval [0, INT_MAX] milliseconds so I think that
using %d to format a time in milliseconds is fine.

Thanks,

Bart.
