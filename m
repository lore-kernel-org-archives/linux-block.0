Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F29DC43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 12:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbiFQMu5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiFQMu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 08:50:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826DF37A84
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 05:50:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l4so3967617pgh.13
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yzCwp0dNQE/b6SXYRcXXgO1AIAsJ5lRGGC+6ORVDROY=;
        b=R5LwWUD6Ox9gxhW+bJaU59XX3UklaKMygCpyv8GhWOA3oFgVadGHrCmdHfOtG14n1j
         jW0H2up5Om3UH4HmfGi2znq/aX6GChEGGfrQtdOzFL6JQaJXHaGrWcrA5aFWAjJlDi90
         1qdgqHv+9rpw++7t1pgQZcbYHrRWX9Qe0UdwdVjF7y1cvwt4qFNmRCQY6cWXldIDnRyW
         N6uGjwEAXJvYgsKvzV7SB/vCW1LHijdXyQBOTPhVzY+GYBV7P1xwyS3briORtVd24sGY
         NyHQMh97NFbyQ0zdlm9UeFGs3eR/0gjbz8x7zK9pYCcIe21wF5/g1xEIvKQeigpMyWLc
         U/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yzCwp0dNQE/b6SXYRcXXgO1AIAsJ5lRGGC+6ORVDROY=;
        b=nCTq7ObdlAXAxZyVP/2d9XCfto7UjUVyxx2Dnh2aDhrTJCDi7RXV/HZKqq97T7JR+n
         3DssjobUSu0kBFKxwEnemShIde+/lj9oG1WlvR4HA8nfYOLTnmatQicvNwuXYad9KIxt
         6lAGDnlnKSoIU7ftPZYU08CyDh4K32GVDN84ENlnzzIE4Hh3zm7EcvF71id4t/rjqhqz
         I+9Lldr/ChYqOgpUAnLbC9fXNLVRVT9xHnh9hGknr786gVy5a92eP9LidylGDxMABqge
         rUJGAkCl7cwij5914hsq88+nMbQPuuoJ7bBZwUyio8YwQ/fd9/5LwiSKEMdAtZjqM7Pf
         +Ziw==
X-Gm-Message-State: AJIora/oo0kAhiFWRf3iYRRns4Min2iriQa/lPkqFfQFRM9z2yc9QXtm
        VHNuMj/MPzncwRLeeLGuFh1Q3A==
X-Google-Smtp-Source: AGRyM1vvwuyyy2CYmdzaiALPUuDkwWzrEfxiL+ysbPMQhtQl8eSAy7b5MJ77PyInp10l6BPGRehW2g==
X-Received: by 2002:a63:1a56:0:b0:405:28e3:e4fb with SMTP id a22-20020a631a56000000b0040528e3e4fbmr9160654pgm.16.1655470253801;
        Fri, 17 Jun 2022 05:50:53 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jg1-20020a17090326c100b001640594376dsm3463347plb.183.2022.06.17.05.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 05:50:52 -0700 (PDT)
Message-ID: <d76649ab-7392-33e9-13fd-785073bbfe4c@kernel.dk>
Date:   Fri, 17 Jun 2022 06:50:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] block: disable the elevator int del_gendisk
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
References: <20220614074827.458955-1-hch@lst.de>
 <20220614074827.458955-2-hch@lst.de> <YqhFiDx0/IW25bSp@T590>
 <20220614083453.GA6999@lst.de> <Yqhwv0POjMi1TNo3@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yqhwv0POjMi1TNo3@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 5:27 AM, Ming Lei wrote:
> On Tue, Jun 14, 2022 at 10:34:53AM +0200, Christoph Hellwig wrote:
>> On Tue, Jun 14, 2022 at 04:23:36PM +0800, Ming Lei wrote:
>>>>  	blk_sync_queue(q);
>>>>  	blk_flush_integrity();
>>>> +	blk_mq_cancel_work_sync(q);
>>>> +
>>>> +	blk_mq_quiesce_queue(q);
>>>
>>> quiesce queue adds a bit long delay in del_gendisk, not sure if this way may
>>> cause regression in big machines with lots of disks.
>>
>> It does.  But at least we remove a freeze in the queue teardown path.
>> But either way I'd really like to get things correct first before
>> looking into optimizations.
> 
> The removed one works at atomic mode and it is super fast.
> 
>>
>>>
>>>> +	if (q->elevator) {
>>>> +		mutex_lock(&q->sysfs_lock);
>>>> +		elevator_exit(q);
>>>> +		mutex_unlock(&q->sysfs_lock);
>>>> +	}
>>>> +	rq_qos_exit(q);
>>>> +	blk_mq_unquiesce_queue(q);
>>>
>>> Also tearing down elevator here has to be carefully, that means any
>>> elevator reference has to hold rcu read lock or .q_usage_counter,
>>> meantime it has to be checked, otherwise use-after-free may be caused.
>>
>> This is not a new pattern.  We have the same locking here as a
>> sysfs-induced change of the elevator to none which also clears
>> q->elevator under a queue that is frozen and quiesced.
> 
> Then looks this pattern has problem in dealing with the examples I
> mentioned.
> 
> And the elevator usage in __blk_mq_update_nr_hw_queues() looks one
> old problem, but easy to fix by protecting it via sysfs_lock.
> 
> And fixing blk_mq_has_sqsched() should be easy too.
> 
> I will send patches later.

Just checking in on this series, Ming did you make any progress?

-- 
Jens Axboe

