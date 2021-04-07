Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E849C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 18:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF54561245
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 18:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhDGSnF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 14:43:05 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:38877 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhDGSnE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 14:43:04 -0400
Received: by mail-pl1-f180.google.com with SMTP id y2so9800170plg.5
        for <linux-block@vger.kernel.org>; Wed, 07 Apr 2021 11:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgCGcQ+QJl8AIKGEDZ1APMyvOOeQntXyn/Tdt7c6+Xk=;
        b=ZLX+UQ2yXnLTJL1/q7+2/zm6xP3fHZsAu1Yz2KUNfLfyydAVwI46MajyijPVK60a9u
         tuqu28yebYovdnx4olyGvPf3l44gFGYK2L+utJ5NFFRm7Rn/ydMIIdxdLehHKbii3CFi
         W260bw0uJmTYI+NvoqoOvzIuBSrxlf9E3nLfRrN3QwTNjH8kY/tPx4jt2SkJpQxg3ZPa
         mBqmJjiCaQKVGHBxJUFvNLgoA132bJyu+5K7fIDhpDnV75Silab0/tOlWy6s3OyvYXBH
         ZI5qvdwZ1m4vPYrf8yPvuZlRzrcdPyXj9zX6WA1YVyXmjy/fFODBe41778S90+wjqFBN
         1/uw==
X-Gm-Message-State: AOAM533cOMqZRHfQuLtG1Pt4XdQXEoUKqpJ9hEzGV5FyHGXL5hD86Rcz
        jHBEDrXpbs94FZ+Zt6gIa54=
X-Google-Smtp-Source: ABdhPJxus5STLd3feb1P9jZLg27Ex1g6icTntRaJo8w/kYSEA3goEs9mP9mNKfq+M2pXtOD6ydj3/A==
X-Received: by 2002:a17:902:a610:b029:e6:5eda:c39e with SMTP id u16-20020a170902a610b02900e65edac39emr4116749plq.11.1617820974341;
        Wed, 07 Apr 2021 11:42:54 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id y8sm22386432pfp.140.2021.04.07.11.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 11:42:53 -0700 (PDT)
Subject: Re: [PATCH v6 2/5] blk-mq: Introduce atomic variants of
 blk_mq_(all_tag|tagset_busy)_iter
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Khazhy Kumykov <khazhy@google.com>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-3-bvanassche@acm.org>
 <31402243-57ca-8fa5-473a-d5ce20774c50@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1610af81-ce46-26c4-5aae-d84aba5cf1f5@acm.org>
Date:   Wed, 7 Apr 2021 11:42:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <31402243-57ca-8fa5-473a-d5ce20774c50@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/21 9:57 AM, John Garry wrote:
> On 06/04/2021 22:49, Bart Van Assche wrote:
>> Since in the next patch knowledge is required of whether or not it is
>> allowed to sleep inside the tag iteration functions, pass this context
>> information to the tag iteration functions. I have reviewed all 
>> callers of
>> tag iteration functions to verify these annotations by starting from the
>> output of the following grep command:
>>
>>      git grep -nHE 'blk_mq_(all_tag|tagset_busy)_iter'
>>
>> My conclusions from that analysis are as follows:
>> - Sleeping is allowed in the blk-mq-debugfs code that iterates over tags.
>> - Since the blk_mq_tagset_busy_iter() calls in the mtip32xx driver are
>>    preceded by a function that sleeps (blk_mq_quiesce_queue()), 
>> sleeping is
>>    safe in the context of the blk_mq_tagset_busy_iter() calls.
>> - The same reasoning also applies to the nbd driver.
>> - All blk_mq_tagset_busy_iter() calls in the NVMe drivers are followed 
>> by a
>>    call to a function that sleeps so sleeping inside 
>> blk_mq_tagset_busy_iter()
>>    when called from the NVMe driver is fine.
> 
> Hi Bart,
> 
>> - scsi_host_busy(), scsi_host_complete_all_commands() and
>>    scsi_host_busy_iter() are used by multiple SCSI LLDs so analyzing 
>> whether
>>    or not these functions may sleep is hard. Instead of performing that
>>    analysis, make it safe to call these functions from atomic context.
> 
> Please help me understand this solution. The background is that we are 
> unsure if the SCSI iters callback functions may sleep. So we use the 
> blk_mq_all_tag_iter_atomic() iter, which tells us that we must not 
> sleep. And internally, it uses rcu read lock protection mechanism, which 
> relies on not sleeping. So it seems that we're making the SCSI iter 
> functions being safe in atomic context, and, as such, rely on the iter 
> callbacks not to sleep.
> 
> But if we call the SCSI iter function from non-atomic context and the 
> iter callback may sleep, then that is a problem, right? We're still 
> using rcu.

Hi John,

Please take a look at the output of the following grep command:

git grep -nHEw 'blk_mq_tagset_busy_iter|scsi_host_busy_iter'\ drivers/scsi

Do you agree with me that it is safe to call all the callback functions 
passed to blk_mq_tagset_busy_iter() and scsi_host_busy_iter() from an 
atomic context?

Thanks,

Bart.
