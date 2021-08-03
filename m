Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE6AC4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 05:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1EE60F8F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 05:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhHCFYL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 01:24:11 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:41849 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhHCFYK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 01:24:10 -0400
Received: by mail-pl1-f170.google.com with SMTP id z3so20988738plg.8
        for <linux-block@vger.kernel.org>; Mon, 02 Aug 2021 22:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xZqNzR/nhRxizuGm1c26yCOPw7poH5ziksttexHxFoQ=;
        b=oItI2MZjUSEpNnZa1aQNu+0J+l2r2W2K6tIvCtOugTvVGq98jJ5LkpoCpn42ZmCIwl
         m104WX0Jc7HthXadfx7WX8Qk2Fi6nRnEkgdpjOJpFfzZWDFnWIJpmpAnM7nUmpsZmjtu
         mUMfnvp9o/29fA5XiyKvm6LZAwAhJcjvWxEG8fd42iIYzs8cW1J+hIvPVmkhUlLgkrr4
         FMr8yspD2qP4P0XGXEzIq4GeEEsBpPVKDusr2FCHvc5pkK5yrBhmGR3wVQUNHCnw+mVg
         w+TK8X+4IU8oDcfsEeUDDbbYivlaLud7iWCZrJSG3uC0XhqeMpvmU+yZpHMPGKyUV5jW
         igcA==
X-Gm-Message-State: AOAM530GazQCTDdR3YOzn7Xyd/5dtYpGzXk9ntSGap+DIkLOsdDICwqa
        ok4cFHfXmnaKtzAxUKQqz6Q=
X-Google-Smtp-Source: ABdhPJzBU6eh00wQmrgMhWFGIE7vc+D4kqOGQyDndRJ3Y3RTkj5CtPKqzEUwEFipnaPPlbOh9rdN9Q==
X-Received: by 2002:a17:90b:1882:: with SMTP id mn2mr2621892pjb.213.1627968239085;
        Mon, 02 Aug 2021 22:23:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8252:5460:56c3:bc73? ([2601:647:4000:d7:8252:5460:56c3:bc73])
        by smtp.gmail.com with ESMTPSA id u13sm5416644pfn.94.2021.08.02.22.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 22:23:58 -0700 (PDT)
Subject: Re: [PATCH 1/2] loop: Prevent that an I/O scheduler is assigned
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
References: <20210803000200.4125318-1-bvanassche@acm.org>
 <20210803000200.4125318-2-bvanassche@acm.org> <YQihyvnN3msaNyDW@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <07388685-bb67-3fc9-83e2-32a4a37fec4d@acm.org>
Date:   Mon, 2 Aug 2021 22:23:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQihyvnN3msaNyDW@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/21 6:54 PM, Ming Lei wrote:
> On Mon, Aug 02, 2021 at 05:01:59PM -0700, Bart Van Assche wrote:
>> Loop devices have a single hardware queue. Hence, the block layer function
>> elevator_get_default() selects the mq-deadline scheduler for loop devices.
>> Using the mq-deadline scheduler or any other I/O scheduler for loop devices
>> incurs unnecessary overhead. Make the loop driver pass the flag
>> BLK_MQ_F_NOSCHED to the block layer core such that no I/O scheduler can be
>> associated with block devices. This approach has an advantage compared to
>> letting udevd change the loop I/O scheduler to none, namely that
>> synchronize_rcu() does not get called.
>>
>> It is intentional that the flag BLK_MQ_F_SHOULD_MERGE is preserved.
>>
>> This patch reduces the Android boot time on my test setup with 0.5 seconds.
> 
> Can you investigate why none reduces Android boot time? Or reproduce &
> understand it by a fio simulation on your setting?

Hi Ming,

The software process called apexd creates multiple loop devices while
the device is booting. Using BLK_MQ_F_NO_SCHED is faster than letting
apexd change the I/O scheduler from mq-deadline into 'none' since the
latter involves calling synchronize_rcu() once per loop device.

>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index f8486d9b75a4..9fca3ab3988d 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -2333,7 +2333,8 @@ static int loop_add(int i)
>>  	lo->tag_set.queue_depth = 128;
>>  	lo->tag_set.numa_node = NUMA_NO_NODE;
>>  	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
>> -	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
>> +	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
>> +		BLK_MQ_F_NO_SCHED;
> 
> Loop directio needs io merge, so it isn't good to set NO_SCHED
> unconditionally, see:
> 
> 40326d8a33d5 ("block/loop: allow request merge for directio mode")

Setting BLK_MQ_F_NO_SCHED only for buffered I/O mode could be tricky
since the loop driver creates a request queue before the I/O mode is
configured. Anyway, I will look into this.

Bart.
