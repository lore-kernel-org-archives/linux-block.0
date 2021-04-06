Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE29C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 17:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03675613C6
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 17:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbhDFRtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 13:49:18 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:33337 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbhDFRtR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 13:49:17 -0400
Received: by mail-pl1-f180.google.com with SMTP id p10so2789523pld.0
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 10:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2hIgX1t40yIC/NbmviNeT4VNtq7DWucpE4INElJm/iA=;
        b=BCfcZWGGpcmVvrJvxh1t2F6dPqv0MRheGJzvmv7EZgp7TsJDwXZujt6KCA60ovUTaG
         YpAOgP5/l9xFoASziakubJC9L4uT5j6Rl5Kd/1NYqNdD2A6oiI8xSI0Nq1Y2TLbMuFSV
         vib36QfXA/VyShlbMtFuDjGL26htXOum228QSmfVBGaqNI/P108eygDhIyMuPIDSslJ6
         N/vINSZxfWKwPZgSn+s9z9yqAHV7/n8K9BMIcqjJkt9xCcUzkRdDPQUwdn0UHqNyHZaN
         0lw4khmb1p5RCP0lkPxzEWA8mljW76sz161+k94stUGMMbWVoWSiC7hiKW/xE8WaeEs5
         qeEg==
X-Gm-Message-State: AOAM533hDzV+jhmCqWIkLMdT7iTPeCFot107WBs0MHaf5FnrIqjAM/TJ
        Me9AfLin5wyyx5+J9sgntfA=
X-Google-Smtp-Source: ABdhPJyW+8vPO26+gY31KerfyQ39Ks35dcSgFUewcyJb1n0dICB3P1jig92DggIaV94/EeYjtMYSQA==
X-Received: by 2002:a17:90b:1b44:: with SMTP id nv4mr1721776pjb.228.1617731349233;
        Tue, 06 Apr 2021 10:49:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:277d:764e:de23:a2e8? ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id y2sm3068745pji.22.2021.04.06.10.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 10:49:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 0/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210405002834.32339-1-bvanassche@acm.org>
 <a4ffb3f0-414d-ba7b-db49-1660faa37873@huawei.com>
Message-ID: <fd0359fd-37a5-1e60-0a2b-4e27d1d3ee33@acm.org>
Date:   Tue, 6 Apr 2021 10:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a4ffb3f0-414d-ba7b-db49-1660faa37873@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 1:00 AM, John Garry wrote:
> Hi Bart,
> 
>> Changes between v2 and v3:
>> - Converted the single v2 patch into a series of three patches.
>> - Switched from SRCU to a combination of RCU and semaphores.
> 
> But can you mention why we made to changes from v3 onwards (versus
> v2)?
> 
> The v2 patch just used SRCU as the sync mechanism, and the impression
> I got from Jens was that the marginal performance drop was tolerable.
> And the issues it tries to address seem to be solved. So why change?
> Maybe my impression of the performance drop being acceptable was
> wrong.

Hi John,

It seems like I should have done a better job of explaining that change.
On v2 I received the following feedback from Hannes: "What I don't
particularly like is the global blk_sched_srcu here; can't
we make it per tagset?". My reply was as follows: "I'm concerned about
the additional memory required for one srcu_struct per tag set." Hence
the switch from SRCU to RCU + rwsem. See also
https://lore.kernel.org/linux-block/d1627890-fb10-7ebe-d805-621f925f80e7@suse.de/.

Regarding the 1% performance drop measured by Jens: with debugging
disabled srcu_dereference() is translated into READ_ONCE() and
rcu_assign_pointer() is translated into smp_store_release(). On x86
smp_store_release() is translated into a compiler barrier +
WRITE_ONCE(). In other words, I do not expect that the performance
difference came from the switch to SRCU but rather from the two new
hctx->tags->rqs[] assignments.

I think that the switch to READ_ONCE() / WRITE_ONCE() is unavoidable.
Even if cmpxchg() would be used to clear hctx->tags->rqs[] pointers then
we would need to convert all other hctx->tags->rqs[] accesses into
READ_ONCE() / WRITE_ONCE() to make that cmpxchg() call safe.

Bart.
