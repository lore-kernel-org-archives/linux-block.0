Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776F9C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A241613BF
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhE0IHP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 04:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhE0IHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 04:07:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4A9C061574
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 01:05:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e17so3045459pfl.5
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CTJO92LlAFaS91oBcJVV9BkySIxOVsEFLvnkpyaXMOI=;
        b=D+X+8tZVCjIM3ZHe1JshWPkJq5pAd2mMDAMrEp21Z2bGA+L/60ehnU9Np6nZel1UqM
         13CoHKaY0CPdMANbkS4xX5vYcf92IJ6veNRTSBlD7yegOBfvITtqyZzr/VBlCsC5CxoV
         QZ7NkkCvQkG25pK2TSQZZZr7bxMh0ZQ5GR0D1EXO6F+O4wfKs/LDLOqN5w6/A9tsLSvv
         wOwWpw12g0e5Shs9WXI6mC+o759yCIPcRr3034/R+L3KZbnOnu5R6SIEqfal24MheAaC
         pu+JkxZCvJdi1QGo/SpJjzefp09aNbcbdXQkbupZySAgbV57dAU/pxr0Z/bvJ8ul1uum
         6w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CTJO92LlAFaS91oBcJVV9BkySIxOVsEFLvnkpyaXMOI=;
        b=tvj8Z+kygiPE6T+7Xl/jYO+PcRoyX2s+NQXViqLtjbTxsK7FW9BYAXI0tKY5cxXEnP
         S0qgJHoVyo0+C5jtZk6F8WjRMxJVTh2Pj5HyI46jIUuUridyzKMKTSwT26YFK6kFcaX1
         9jCS2N5+D8f9u8fmuXyJ5sIYziUPIhbng0u3fX9ZYLocvIv/Q0CGICPWGDbGJZ6QeTIX
         rPkyOeojpmEZzrETN3SxWvsiUiqXU6eeaulEAQUd+48dPc8xD7qwsRs+kfnG8KkSDLmV
         8db3wvximSJOB+Ltw2YWt9EPU/gQOoSzUAlQtODKKYkemQhekXpEydLhK75qtVtJacCT
         GQNw==
X-Gm-Message-State: AOAM531/RZjxNDBrWMrvVlSq5kSPIIV4KJ29zTiJPbeN+Wmn+GzKD2ZU
        ThosfYxXv8furzLDnUFVgXwnOJnocVwuh3jx
X-Google-Smtp-Source: ABdhPJzVjCWkeWT4wM4S7Z5nNv89MfysPXiakHTqjAaWdtVBaQz4Jna8SC6qGTVafNGSVAYJX9GQ3A==
X-Received: by 2002:a63:7703:: with SMTP id s3mr2582336pgc.339.1622102741133;
        Thu, 27 May 2021 01:05:41 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([154.48.252.66])
        by smtp.gmail.com with ESMTPSA id h76sm1435766pfe.161.2021.05.27.01.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 01:05:40 -0700 (PDT)
Subject: Re: [PATCH 0/9] Improve I/O priority support
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <b58840a8-0122-26cd-e756-92562064075a@gmail.com>
Message-ID: <ef81558a-cab2-ca2f-dba8-e032ecdb8154@gmail.com>
Date:   Thu, 27 May 2021 16:05:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <b58840a8-0122-26cd-e756-92562064075a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/5/27 2:25 PM, Wang Jianchao wrote:
> 
> 
> On 2021/5/27 9:01 AM, Bart Van Assche wrote:
>> Hi Jens,
>>
>> A feature that is missing from the Linux kernel for storage devices that
>> support I/O priorities is to set the I/O priority in requests involving page
>> cache writeback. Since the identity of the process that triggers page cache
>> writeback is not known in the writeback code, the priority set by ioprio_set()
>> is ignored. However, an I/O cgroup is associated with writeback requests
>> by certain filesystems. Hence this patch series that implements the following
>> changes for the mq-deadline scheduler:
> Hi Bart
> 
> How about implement this feature based on the rq-qos framework ?
> Maybe it is better to make mq-deadline a pure io-scheduler.

In addition, it is more flexible to combine different io-scheduler and rq-qos policy
if we take io priority as a new policy ;)

> 
> Best regards
> Jianchao
> 
>> * Make the I/O priority configurable per I/O cgroup.
>> * Change the I/O priority of requests to the lower of (request I/O priority,
>>   cgroup I/O priority).
>> * Introduce one queue per I/O priority in the mq-deadline scheduler.
>>
>> Please consider this patch series for kernel v5.14.
>>
>> Thanks,
>>
>> Bart.
>>
>> Bart Van Assche (9):
>>   block/mq-deadline: Add several comments
>>   block/mq-deadline: Add two lockdep_assert_held() statements
>>   block/mq-deadline: Remove two local variables
>>   block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()
>>   block/mq-deadline: Improve compile-time argument checking
>>   block/mq-deadline: Reduce the read expiry time for non-rotational
>>     media
>>   block/mq-deadline: Reserve 25% of tags for synchronous requests
>>   block/mq-deadline: Add I/O priority support
>>   block/mq-deadline: Add cgroup support
>>
>>  block/Kconfig.iosched      |   6 +
>>  block/Makefile             |   1 +
>>  block/mq-deadline-cgroup.c | 206 +++++++++++++++
>>  block/mq-deadline-cgroup.h |  73 ++++++
>>  block/mq-deadline.c        | 524 +++++++++++++++++++++++++++++--------
>>  5 files changed, 695 insertions(+), 115 deletions(-)
>>  create mode 100644 block/mq-deadline-cgroup.c
>>  create mode 100644 block/mq-deadline-cgroup.h
>>
