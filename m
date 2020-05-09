Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2007C38A2A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0AD217BA
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jFx0UvhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgEIDR7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgEIDR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 23:17:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DCEC061A0C
        for <linux-block@vger.kernel.org>; Fri,  8 May 2020 20:17:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r22so215311pga.12
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 20:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CEMThQ8dcGo98B5wYftUlYCYdog3hWlJPyEXhQVQ1sg=;
        b=jFx0UvhOtyxphOyRrLd9qV+1teYIKCeHItRvxp8iDBVilnwoSsRna6PMPeOqHbzAYS
         nMUZ7m8kiK0+5jGs1U01O4r26bswFpCKBzNaRG587FHghBEA800XLTVGVXeTPK1zWyA3
         D2NZaumTrmjIt1ktI8beL7aaa4Wxti9hT3yh6d1Ll8yZ78Jl2UVBbfLZ2Hr5K3Tn/zeE
         PuVX0OcDqGqFYu9AQNIGrjKQnGyp7FlUqkdJtB2bS2GGg6SOm8sji6oRdQw6T7P4N03X
         on9jK8Tu0rbu3VwYOUJbFHlDlDik7lulO5877FZmxuIG3pz8OZ+gW7JEvtT9p0PiR5EQ
         SHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CEMThQ8dcGo98B5wYftUlYCYdog3hWlJPyEXhQVQ1sg=;
        b=j4TORadB8Sx5MtLglveC3TgzsBoD6F5PPNoaSeYjKRjDRzLQLXSwFbYwMF7s04Yrj3
         nbiDI3SANxz3zhh2V3j9P1kXe6esOwo5/9TnFBrfS6iTkbyDr2hvAUpL3tHMS29eS2Yk
         31aiq9WMMWtRA7vb+r6/WsGa/wDhgs6/3S9n5A+rRefj0aU8EV7v4fsuMO1UEV4bx72n
         u94OrdxaENqnwrUzIRhuAAZ0ZriMb4t/gRlKO/blyhvOhY4Y9Q4C24sb+2u7Iwgt9ZYK
         CzkpvFOrhtpnwFqtrDXbKhNN4e7Kf9/9W42f7k7OuwfsuqZgfbLwDepdy1ej1bReQWwF
         z+5g==
X-Gm-Message-State: AGi0PuY7tSBNDcICV7zDywUkGQOiWG3/OuQpihaZHaXEJOuT2kv634kM
        Dhh+JSjv28mv9E2mTTK1QH8atQ==
X-Google-Smtp-Source: APiQypJoMBGCTT2TtgpemsNE6PPTOBNJj5/6xyz82jfXs+sWnExgelkSxEhxcUFtttqmTRhqmChw2A==
X-Received: by 2002:aa7:9e05:: with SMTP id y5mr6403726pfq.220.1588994278186;
        Fri, 08 May 2020 20:17:58 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m18sm3632987pjl.14.2020.05.08.20.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 20:17:57 -0700 (PDT)
Subject: Re: [PATCH V10 00/11] blk-mq: improvement CPU hotplug
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200508214946.GB1389136@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a274f981-3779-ca0b-06c3-852d08e9e67e@kernel.dk>
Date:   Fri, 8 May 2020 21:17:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508214946.GB1389136@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/8/20 3:49 PM, Ming Lei wrote:
> On Tue, May 05, 2020 at 10:09:19AM +0800, Ming Lei wrote:
>> Hi,
>>
>> Thomas mentioned:
>>     "
>>      That was the constraint of managed interrupts from the very beginning:
>>     
>>       The driver/subsystem has to quiesce the interrupt line and the associated
>>       queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>>       until it's restarted by the core when the CPU is plugged in again.
>>     "
>>
>> But no drivers or blk-mq do that before one hctx becomes inactive(all
>> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
>> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
>>
>> This patchset tries to address the issue by two stages:
>>
>> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
>>
>> - mark the hctx as internal stopped, and drain all in-flight requests
>> if the hctx is going to be dead.
>>
>> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
>>
>> - steal bios from the request, and resubmit them via generic_make_request(),
>> then these IO will be mapped to other live hctx for dispatch
>>
>> Thanks John Garry for running lots of tests on arm64 with this patchset
>> and co-working on investigating all kinds of issues.
>>
>> Thanks Christoph's review on V7 & V8.
>>
>> Please comment & review, thanks!
>>
>> https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug
>>
>> V10:
>> 	- fix double bio complete in request resubmission(10/11)
>> 	- add tested-by tag
>>
>> V9:
>> 	- add Reviewed-by tag
>> 	- document more on memory barrier usage between getting driver tag
>> 	and handling cpu offline(7/11)
>> 	- small code cleanup as suggested by Chritoph(7/11)
>> 	- rebase against for-5.8/block(1/11, 2/11)
>> V8:
>> 	- add patches to share code with blk_rq_prep_clone
>> 	- code re-organization as suggested by Christoph, most of them are
>> 	in 04/11, 10/11
>> 	- add reviewed-by tag
>>
>> V7:
>> 	- fix updating .nr_active in get_driver_tag
>> 	- add hctx->cpumask check in cpuhp handler
>> 	- only drain requests which tag is >= 0
>> 	- pass more aggressive cpuhotplug&io test
>>
>> V6:
>> 	- simplify getting driver tag, so that we can drain in-flight
>> 	  requests correctly without using synchronize_rcu()
>> 	- handle re-submission of flush & passthrough request correctly
>>
>> V5:
>> 	- rename BLK_MQ_S_INTERNAL_STOPPED as BLK_MQ_S_INACTIVE
>> 	- re-factor code for re-submit requests in cpu dead hotplug handler
>> 	- address requeue corner case
>>
>> V4:
>> 	- resubmit IOs in dispatch list in case that this hctx is dead 
>>
>> V3:
>> 	- re-organize patch 2 & 3 a bit for addressing Hannes's comment
>> 	- fix patch 4 for avoiding potential deadlock, as found by Hannes
>>
>> V2:
>> 	- patch4 & patch 5 in V1 have been merged to block tree, so remove
>> 	  them
>> 	- address comments from John Garry and Minwoo
>>
>> Ming Lei (11):
>>   block: clone nr_integrity_segments and write_hint in blk_rq_prep_clone
>>   block: add helper for copying request
>>   blk-mq: mark blk_mq_get_driver_tag as static
>>   blk-mq: assign rq->tag in blk_mq_get_driver_tag
>>   blk-mq: support rq filter callback when iterating rqs
>>   blk-mq: prepare for draining IO when hctx's all CPUs are offline
>>   blk-mq: stop to handle IO and drain IO before hctx becomes inactive
>>   block: add blk_end_flush_machinery
>>   blk-mq: add blk_mq_hctx_handle_dead_cpu for handling cpu dead
>>   blk-mq: re-submit IO in case that hctx is inactive
>>   block: deactivate hctx when the hctx is actually inactive
>>
>>  block/blk-core.c           |  27 ++-
>>  block/blk-flush.c          | 141 ++++++++++++---
>>  block/blk-mq-debugfs.c     |   2 +
>>  block/blk-mq-tag.c         |  39 ++--
>>  block/blk-mq-tag.h         |   4 +
>>  block/blk-mq.c             | 356 +++++++++++++++++++++++++++++--------
>>  block/blk-mq.h             |  22 ++-
>>  block/blk.h                |  11 +-
>>  drivers/block/loop.c       |   2 +-
>>  drivers/md/dm-rq.c         |   2 +-
>>  include/linux/blk-mq.h     |   6 +
>>  include/linux/cpuhotplug.h |   1 +
>>  12 files changed, 481 insertions(+), 132 deletions(-)
>>
>> Cc: John Garry <john.garry@huawei.com>
>> Cc: Bart Van Assche <bvanassche@acm.org>
>> Cc: Hannes Reinecke <hare@suse.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> Hi Jens,
> 
> This patches have been worked and discussed for a while, so any chance
> to make it in 5.8 if no any further comments?

Looks like we're pretty close, I'll take a closer look at v11 when
posted.

-- 
Jens Axboe

