Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7734BC2BA1B
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598E8206B8
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgDFSLt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:11:49 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:34310 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgDFSLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 14:11:49 -0400
Received: by mail-pg1-f175.google.com with SMTP id l14so372741pgb.1
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2020 11:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5JktVFsXI/fJDUcOZe7mdHGgGWcT9Gh6AVvG4NRNchk=;
        b=LyVv03MeEP6rBDIJyu7Qtu1Q6OHAK3GgpVRp1sL/K22X+yasILWoKch2BMaL7Igmjk
         mDImwFksKti492YD8FF1pliUvqLbVtq+3onUO1O6mQxrfBKvS6N8WYCYyDB242+sOiK/
         VsLjxtl4aHAm7uxszaq7NPZpWFGoxOJOs+iTmfRcF5BFS7x4ZfGhcGphbazI2tGEQm6/
         qeid0TXts5p3RmNkYalzgBb+n7YDLh5N/JGMtY5IHHJPRyZhwHeBdKIwkIYWUOkUgfVx
         qQYjdqjYJuxV8cvbPjpRaJI+mDFchMaGAzurDD1hvdyhIkyishzZRrtt1dKfb7cKLe0M
         3ZQw==
X-Gm-Message-State: AGi0Pub0WBGOCHcT8ntD1xp4PBEqFmff94wPbD4Q4wZs7UZjh42XMZ7Y
        J4jXQxNzuab/xm06A/gNDRc=
X-Google-Smtp-Source: APiQypIwbeb3p92DctXyIwZ5bRNyHWlrY37tKyhFu36nNS5n6Jcl4Tcfotx3JJ6EZtbgPOFasc64ug==
X-Received: by 2002:a63:9143:: with SMTP id l64mr331547pge.75.1586196708075;
        Mon, 06 Apr 2020 11:11:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:de6:f05e:6a88:9257? ([2601:647:4802:9070:de6:f05e:6a88:9257])
        by smtp.gmail.com with ESMTPSA id u41sm11605906pgn.8.2020.04.06.11.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 11:11:47 -0700 (PDT)
Subject: Re: Sighting: io_uring requests on unexpected core
From:   Sagi Grimberg <sagi@grimberg.me>
To:     "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-nvme <linux-nvme@lists.infradead.org>
References: <MW3PR11MB46843ADF1AEED8FCEA66BB8FE5C70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <1b9aa822-2516-4eb8-1472-7e7b66c32d45@grimberg.me>
Message-ID: <dcf9141d-7aa6-a0bb-c2cb-e2faf9fbe5ac@grimberg.me>
Date:   Mon, 6 Apr 2020 11:11:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1b9aa822-2516-4eb8-1472-7e7b66c32d45@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CC'ing linux-nvme

On 4/3/20 2:44 PM, Sagi Grimberg wrote:
>> Hey all, Mark here again with another sighting.
> 
> Hey Mark,
> 
>> If you're all WFH like myself during this virus period maybe this will 
>> provide you with a new puzzle to solve and pass the time, while 
>> helping to educate.  Our family big into puzzles during this period.
> 
> :-)
> 
>> Here is the issue:
>> While performing an FIO test, for a single job thread pinned to a 
>> specific CPU, I can trap requests to the nvmf layer from a core and 
>> queue not aligned to the FIO specified CPU.
>> I can replicate this on the baseline of nvme-5.5-rc or nvme-5.7-rc1 
>> branches of the infradead repository, with no other patches applied.
>> For a typical 30 second 4k 100% read test there will be over 2 million 
>> packets processed, with under 100 sent by this other CPU to a 
>> different queue.  When this occurs it causes a drop in performance of 
>> 1-3%.
>> My nvmf queue configuration is 1 nr_io_queue and 104 nr_poll_queues 
>> that equal the number of active cores in the system.
> 
> Given that you pin your fio thread the high poll queue count shouldn't
> really matter I assume.
> 
>> As indicated this is while running an FIO test using io_uring for 100% 
>> random read.  And have seen this with a queue depth of 1 batch 1, as 
>> well as queue depth 32 batch 8.
>>
>>   The basic command line being:
>> /fio --filename=/dev/nvme0n1 --time_based --runtime=30 --ramp_time=10 
>> --thread --rw=randrw --rwmixread=100 --refill_buffers --direct=1 
>> --ioengine=io_uring --hipri --fixedbufs --bs=4k --iodepth=32 
>> --iodepth_batch_complete_min=1 --iodepth_batch_complete_max=32 
>> --iodepth_batch=8 --numjobs=1 --group_reporting --gtod_reduce=0 
>> --disable_lat=0 --name=cpu3 --cpus_allowed=3
>>
>> Adding monitoring within the code functions nvme_tcp_queue_request() 
>> and nvme_tcp_poll() I will see the following.  Polling from the 
>> expected CPU for different queues with different assigned CPU 
>> [queue->io_cpu].  And new queue request coming in on an unexpected CPU 
>> [not as directed on FIO invocation] indicating a queue context 
>> assigned with the same CPU value.  Note: even when requests come in on 
>> different CPU cores, all polling is from the same expected CPU core.
> 
> nvme_tcp_poll: [Queue CPU 3], [CPU 3] means that the poll is is called
> on cpu core [3] on a queue that is mapped to cpu core [3] correct?
> 
> nvme_tcp_poll: [Queue CPU 75], [CPU 3] means that the poll is is called
> on cpu core [3] on a queue that is mapped to cpu core [75] correct?
> 
>> [  524.867622] nvme_tcp:        nvme_tcp_poll: [Queue CPU 3], [CPU 3]
>> [  524.867686] nvme_tcp:        nvme_tcp_poll: [Queue CPU 75], [CPU 3]
> 
> I'm assuming that this is a poll invocation of a prior submission to
> queue that is mapped to CPU 75?
> 
>> [  524.867693] nvme_tcp:        nvme_tcp_poll: [Queue CPU 3], [CPU 3]
>> [  524.867755] nvme_tcp: nvme_tcp_queue_request: IO-Q [Queue CPU 75], 
>> [CPU 75]
> 
> This log print means that on cpu core [3] we see a request submitted on
> a queue that is mapped to cpu core [75] correct?
> 
>> [  524.867758] nvme_tcp:        nvme_tcp_poll: [Queue CPU 75], [CPU 3]
>> [  524.867777] nvme_tcp: nvme_tcp_queue_request: IO-Q [Queue CPU 3], 
>> [CPU 3]
>> [  524.867781] nvme_tcp:        nvme_tcp_poll: [Queue CPU 3], [CPU 3]
>> [  524.867853] nvme_tcp:        nvme_tcp_poll: [Queue CPU 75], [CPU 3]
>> [  524.867864] nvme_tcp:        nvme_tcp_poll: [Queue CPU 3], [CPU 3]
>>
>> So, if someone can help solve this puzzle and help me understand what 
>> is causing this behavior that would be great.  Hard for me to think 
>> this is an expected, or beneficial behavior, to have a need to use 
>> some other core/queue for less than 100 requests out of over 2 million.
> 
> I'm assuming that this phenomenon happens also without polling?
> 
> Anyways, it is unexpected to me, given that you have a queue that is
> mapped to the cpu you are pinning on, I'd expect that all request
> that are generated on this cpu would be submitted on that same
> queue..
> 
> Anyone has any insights on this?
