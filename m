Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D079C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D0F60FF2
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJ1P2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJ1P2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 11:28:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF42C061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 08:25:37 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d63so8634429iof.4
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wUWXhhVRru9kRKSmy99IaKlF8j2z8G347SeB+YX4Gxs=;
        b=4CAFXdcRI2I4pVOqs2NNc49cg6ljizmPxngcgvYDEqB2roEPmHKiIXM9V2JojNoIVd
         MWd6N1+UB400QlE3kCJCmy7cCL2Nic8WdIBAZIFjmPHKmHNsrgmgyM47vsCaBgxCBQqt
         s4IIRqDBhMDwCKR9Hz9bZBI9FyC1GsD/2SCh7OcQh5+8fJFWTs/DLAkj6Yj7/rUQYF+H
         qDr/RJ+NHHAD7dYlQtr/r719x3o4FKyAzumGH7kLD1pt8Yq6x/5YuJOG72+TEOvNW6f3
         sb+nddX+WUjuCsQtO+7Owx3ivqKTVpEFUq12sWZPsGI/Hqb5jD6E9YQUjNlr6ky4f7og
         x9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wUWXhhVRru9kRKSmy99IaKlF8j2z8G347SeB+YX4Gxs=;
        b=0sBygWte6i9f3IfOohQOQSa/yLBqcIoSeRq6DPYOjeD/RBEUdLj3mNbXFxhAZ9TUwB
         N76a0QfdZbWSVG4mSfpUi8jTtyfFogac4BGHPXel9osFv2YiYFxGUvvSBBDbdM8mNSYo
         cd+HGvv/l6XucidWy00+aNq/sOxSB6OBVMMyO1Sp8sYGIGwGsIujpDu0AsdTbdJY+tmg
         ZdorKLm0Ax93ehvwr0suoxOAEbYbuZwLghX0jfYtUvf8l1cs3J8ViMxI1m66WH7cGjB1
         nF+Kzc+GhIMOLeH+Zmlm6fVr+XmCYiXGbCREyjdm3k5hq+sbeUh3SgpV4YXRFGuVLMrR
         1XQQ==
X-Gm-Message-State: AOAM531C41FniF5oLHMEQQvJK1O1yN1FFRa3/wXJFwnQ3Cfe/1pu2jDJ
        TIGI+eu+d7dMnXty+aa6Og1b3Q==
X-Google-Smtp-Source: ABdhPJxSXfG3JyBU8OF9SsE7nRnkxpncTSNbc/c5msfrGSRFvghii1MYR0Uhs3T3Py0c2Njq0oYPbQ==
X-Received: by 2002:a05:6602:1651:: with SMTP id y17mr3535485iow.114.1635434737009;
        Thu, 28 Oct 2021 08:25:37 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l14sm1937279iow.27.2021.10.28.08.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 08:25:36 -0700 (PDT)
Subject: Re: [PATCH 0/3] implement direct IO with integrity
From:   Jens Axboe <axboe@kernel.dk>
To:     "Alexander V. Buev" <a.buev@yadro.com>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
References: <20211028112406.101314-1-a.buev@yadro.com>
 <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
Message-ID: <a715566f-ecab-1ecc-a3c7-7f1cd8b9c6d5@kernel.dk>
Date:   Thu, 28 Oct 2021 09:25:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 9:13 AM, Jens Axboe wrote:
> On 10/28/21 5:24 AM, Alexander V. Buev wrote:
>> This series of patches makes possible to do direct block IO
>> with integrity payload using io uring kernel interface.
>> Userspace app can utilize READV/WRITEV operation with a new 
>> (unused before) flag in sqe struct to mark IO request as 
>> "request with integrity payload". 
>> When this flag is set, the last of provided iovecs
>> must contain pointer and length of this integrity payload.
>>
>> Alexander V. Buev (3):
>>   block: bio-integrity: add PI iovec to bio
>>   block: io_uring: add IO_WITH_PI flag to SQE
>>   block: fops: handle IOCB_USE_PI in direct IO
>>
>>  block/bio-integrity.c         | 124 +++++++++++++++++++++++++++++++++-
>>  block/fops.c                  |  71 +++++++++++++++++++
>>  fs/io_uring.c                 |  32 ++++++++-
>>  include/linux/bio.h           |   8 +++
>>  include/linux/fs.h            |   1 +
>>  include/uapi/linux/io_uring.h |   3 +
>>  6 files changed, 235 insertions(+), 4 deletions(-)
> 
> A couple of suggestions on this:
> 
> 1) Don't think we need an IOSQE flag, those are mostly reserved for
>    modifiers that apply to (mostly) all kinds of requests
> 2) I think this would be cleaner as a separate command, rather than
>    need odd adjustments and iov assumptions. That also gets it out
>    of the fast path.
> 
> I'd add IORING_OP_READV_PI and IORING_OP_WRITEV_PI for this, I think
> you'd end up with a much cleaner implementation that way.

Oh, and please do CC io-uring on changes that touch it.

-- 
Jens Axboe

