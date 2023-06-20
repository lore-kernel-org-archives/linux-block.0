Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB7EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 14:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjFTO4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjFTO4L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 10:56:11 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11C1709
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 07:56:10 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-343a9a89205so619855ab.1
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687272969; x=1689864969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBTGnP1tMNeZ2bBTWd78SpmQMz2nsFLvJUwCiLFmeqE=;
        b=gPCMY7GK1J14+rOzq1sFeUzGX2GvjFbq5gWouVtXmJlxA0z1QT89lNcJRcKBflk0T3
         NdVidbKoh0EwUKVevlsSgOqHLQPROVj/68tCWSvMaBOnSJcW+mZhg7Kt9MjkhokD8trn
         YWt5VEuN/HgLV9+foIAhMJXFs3p/uRCoIfcim3kVtE0vOYmiv3ruND+NGIen/BgRZ+2w
         eSBoPAi3WU+IZtmpcfd9fuirOmIz4nG3lcECXxFbEUNPK32TU3oTbGlkt0Lem3IhRnkH
         s5pwJ4axqnZ8umeHnS4x+kgqPzcPjEdOFDUwh5PABkRlY0jvzW2jmxxa0ECEoNYE0xJA
         Rlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272969; x=1689864969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBTGnP1tMNeZ2bBTWd78SpmQMz2nsFLvJUwCiLFmeqE=;
        b=JUMVBqYc52jpijur+v3yfFqySxdbdLRcHHreHqEq/Ugzx/YYP8B6xU+I9NJdkjirpf
         nOFf8NCilTLwh0Cttwc1DGsXyKjFce/YxViNdtXp7aaLRzJLslpInjI7O606U8gA9Utl
         o6uuuPt0LuOoWB/iXZ2Nww3zA2PA1sVZYl+/qYIjohfol4itsNyQp06cGAoVysonNlak
         hvsbkRHQmPOTVoNhjU+ZJFJlLBu7sZYeISrD/NNuzJm8veWwvqP2svlEiqKLC7MKxEx0
         aX01jwPT07QmPgFPlZQLhUr9E1cgvqHHnTv8aSydManIxgo8b9IP/Q0+//8BWELX0ex3
         tSRQ==
X-Gm-Message-State: AC+VfDxGDMxxq0AZiqk4FudxL4tYrVbDQhy6WLNXAIEqh0FmXZVFqW5f
        GkKRhldlqOM8SI6Q8EZ8PIv8WQ==
X-Google-Smtp-Source: ACHHUZ4p3kn2ROc8tmUhoaWt7ZtkpMZc9vqxKJfYNnZOjURuEKXPZj75PLiZ13Q6zTYTnIJBlghJJQ==
X-Received: by 2002:a05:6e02:1a8c:b0:330:a1eb:c5a4 with SMTP id k12-20020a056e021a8c00b00330a1ebc5a4mr12977726ilv.1.1687272969224;
        Tue, 20 Jun 2023 07:56:09 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q9-20020a920509000000b0032afe23820bsm652157ile.17.2023.06.20.07.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 07:56:08 -0700 (PDT)
Message-ID: <0eb6721d-2502-4970-bc55-5d809c8113aa@kernel.dk>
Date:   Tue, 20 Jun 2023 08:56:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] block: mark bdev files as FMODE_NOWAIT if underlying
 device supports it
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20230509151910.183637-1-axboe@kernel.dk>
 <20230509151910.183637-3-axboe@kernel.dk> <ZFucWYxUtBvvRJpR@infradead.org>
 <8d5daf0d-c623-5918-d40e-ab3ad1c508ad@kernel.dk>
 <ZJFEz2FKuvIf8aCL@infradead.org>
 <a7a1dcc3-5aaf-53bc-7527-ba62292c44cd@kernel.dk>
 <ZJGpv4WjadjdBTmN@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZJGpv4WjadjdBTmN@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/20/23 7:29?AM, Christoph Hellwig wrote:
> On Tue, Jun 20, 2023 at 07:24:56AM -0600, Jens Axboe wrote:
>> I think we need stronger justification than that, it's much nicer to
>> have it in the open path than doing the same check over and over for
>> each IO.
>>
>> With your new proposed scheme, why can't the check and FMODE_NOWAIT set
>> still be in open?
> 
> Because I want to move the by now huge number of static flags out of
> file->f_mode and into file->f_op.flags.  It's just that with this patch
> this one flag isn't static anymore for block devices.  We could also
> do two sets of file operations assuming we never allow run-time changes
> for QUEUE_FLAG_NOWAIT.  If we care about optimizing fo async I/O on the
> few drivers not supporting QUEUE_FLAG_NOWAIT that's probably the next
> best thing.

Doing two sets of fops makes sense to me, and then hopefully down the
line we can shave it down to 1 again once everything sets FMODE_NOWAIT.

-- 
Jens Axboe

