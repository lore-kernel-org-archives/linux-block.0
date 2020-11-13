Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3829C4742C
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 21:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D1322252
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 21:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SIqtSJpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKMVDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVDK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 16:03:10 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B2C0613D1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 13:03:09 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q5so8656836pfk.6
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 13:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1zoui9BUZXUZOqrTWaBrZykGcY0FRSZnrRzqMJQ8RwA=;
        b=SIqtSJpDMUZf6A0Bp680OWghtTzBxCyFEittkvDw3lqzYn2Ps6IVbUdF4Bf3m1dHhb
         /AsZrlSawXqvZfYZLk1N+1S43FCJPaOfMoqY9qoujbZiA6QWbaEsBAV+otmmbcKGB8uI
         s3C2sYFRUEPz+dC1Kq9kik/qnrNy+NNJPscbllkTJ7YtOLUIz5k0eVizc3mfmSP+sLta
         xJd2RATiOoXhTf+2TvePEngYQ7CNZ7PsTd4FUrL8YoF6TkAMthadpjk6+HVaLmvhsqEJ
         FaPHfuDCO6cHzEUungyCmh3arO6bio30A9vmD/A9kTmX0KS/1Up9Zc2wqdsHsoFMlPk3
         NeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1zoui9BUZXUZOqrTWaBrZykGcY0FRSZnrRzqMJQ8RwA=;
        b=cbBpFSUI/vqEocwM0SGHgcNSW2OOf8Gu1PYsH/6tpWbOYGsJsvY0w0HCm85BjwFYtC
         WqYLB7dEOyAj+JP3mknR687jUsssI7JiM865iAWJIoLA4GoqErs9Gyy4tcF2kUXqBxW1
         SL5YgXbT4F2R310HVhuYOKpPb17JT9Qb5YA/AFngHFuwOme5rIHnOOxWey2y71q+pNbC
         AiKcJ/bZZijvrP7nsgNdAvE0FA47pE25lndVDtH08lGPHZ1WKpGEd3L3qdiM7FCo3pCx
         Im42ulWZZhzC1aPC7IbczREWk+lkiafOvKcSg/7PtGnwfTKorM3cO5gakTvFzHN52NBO
         ip5Q==
X-Gm-Message-State: AOAM530Bpqb0W5LhNUJRGkZWFiPqlZganDPqiyO27TC8Yhc9u8vKzHZP
        gEEZLp4pr28OJmCVHUPusGQ/kNJo2o+6Gw==
X-Google-Smtp-Source: ABdhPJy9RxMN3SjWuODbONNveEfQJhguQEGd2j8B+Qx6ue32McdtKQK4nHihEq6cvGxKB+/5V9axzg==
X-Received: by 2002:a63:161a:: with SMTP id w26mr3316313pgl.17.1605301388725;
        Fri, 13 Nov 2020 13:03:08 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d2sm11265021pjj.37.2020.11.13.13.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:03:08 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To:     Sagi Grimberg <sagi@grimberg.me>,
        Rachit Agarwal <rach4x0r@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Rachit Agarwal <ragarwal@cs.cornell.edu>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Rachit Agarwal <ragarwal@cornell.edu>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
Date:   Fri, 13 Nov 2020 14:03:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/20 1:34 PM, Sagi Grimberg wrote:
> 
>> I haven't taken a close look at the code yet so far, but one quick note
>> that patches like this should be against the branches for 5.11. In fact,
>> this one doesn't even compile against current -git, as
>> blk_mq_bio_list_merge is now called blk_bio_list_merge.
> 
> Ugh, I guess that Jaehyun had this patch bottled up and didn't rebase
> before submitting.. Sorry about that.
> 
>> In any case, I did run this through some quick peak testing as I was
>> curious, and I'm seeing about 20% drop in peak IOPS over none running
>> this. Perf diff:
>>
>>      10.71%     -2.44%  [kernel.vmlinux]  [k] read_tsc
>>       2.33%     -1.99%  [kernel.vmlinux]  [k] _raw_spin_lock
> 
> You ran this with nvme? or null_blk? I guess neither would benefit
> from this because if the underlying device will not benefit from
> batching (at least enough for the extra cost of accounting for it) it
> will be counter productive to use this scheduler.

This is nvme, actual device. The initial posting could be a bit more
explicit on the use case, it says:

"For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
terms of IOPS per core over "noop" I/O scheduler."

which made me very skeptical, as it sounds like it's raw device claims.

Does beg the question of why this is a new scheduler then. It's pretty
basic stuff, something that could trivially just be added a side effect
of the core (and in fact we have much of it already). Doesn't really seem
to warrant a new scheduler at all. There isn't really much in there.

>>> [5] https://github.com/i10-kernel/upstream-linux/blob/master/dss-evaluation.pdf
>>
>> Was curious and wanted to look it up, but it doesn't exist.
> 
> I think this is the right one:
> https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf
> 
> We had some back and forth around the naming, hence this was probably
> omitted.

That works, my local results were a bit worse than listed in there though.
And what does this mean:

"We note that Linux I/O scheduler introduces an additional kernel worker
thread at the I/O dispatching stage"

It most certainly does not for the common/hot case.

-- 
Jens Axboe

