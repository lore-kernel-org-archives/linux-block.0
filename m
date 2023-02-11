Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF54C636CC
	for <linux-block@archiver.kernel.org>; Sat, 11 Feb 2023 15:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBKPpz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Feb 2023 10:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBKPpy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Feb 2023 10:45:54 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE06211F3
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 07:45:53 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id o8so7188445pls.11
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 07:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676130353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URAULDYPzqAW97Y0PuplWJohpXIirsB9YQQXPMjjzpY=;
        b=sBJ+YwaV2n0RFHk8Y9Rpu/8yLeCmnq1N6FPLmD9pwFPgQO5gEkJNBB7nLGaoYx7727
         +7efnkZPrlFDsWn/EQM3gLHEqv6381clJAdxW4Wp8ZbeT7LFfE9kRPZ4qSNJSPeoiXhq
         m0w4kudyE6twZB5402aKKZqTfizXQiq9MFKZW/z7c0ZbeYgEFadO+OY3agjb9nywcL8c
         2+TxpViSKam5jFYf1WEnN0OaqnQu0+5/SMiydAUzPykLysrIfIXpmYFJe7emNErhSko+
         G2JDZgp8PmLHjq/H/8cdwbQ1fPEFq/NzkwlbtWBSmnIyG9cXgApnp1HP+pCeLyfgMAWc
         KweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676130353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URAULDYPzqAW97Y0PuplWJohpXIirsB9YQQXPMjjzpY=;
        b=S7TOjaqBKAUy41Lh8D3CvD3IfIA/CdQJ7hH3kR/s6I1bD+LnLG2eC4/95ffTuyGRVU
         +HDqjNw6ZUwA+pbEd0ESNlh2NWbxciByPQ5Uij+72o4vVEZuDwzMCiFxSmOAvUM9gcol
         oXHg+Hw/XRSArlEjsuAUzIHbriLm8Q6+/yPAym/hWLesoXjxFuGoh3ngsLxIXYFmvbeI
         y7OsDlT5pccgOaaZyauTJV442ZZdW2+kSAd9JY/nl42K0amkyMiK0pZBTLGyoHKPqomM
         sh4GboEYGCp/1xrO2hjyAB9077dWrha4IkOH1O4XcKt9uiibmJlXJ/ZPboaltRsJYfFP
         ukzQ==
X-Gm-Message-State: AO0yUKWztmrfn6EiDgbTzDCfbEsnjH6FtCCqf34sTkqh/PrJhxdEGg6Y
        NDHXDR0QvA0zX0opPUmdSsoVWg==
X-Google-Smtp-Source: AK7set9CgOhpXds7lnGYivQ5KdUVR59HIU/U7v0p5Md0ZFY1020GBouNNWHLxl4UJPAjmvUdFtSJIg==
X-Received: by 2002:a17:903:428a:b0:19a:84b0:4845 with SMTP id ju10-20020a170903428a00b0019a84b04845mr2122958plb.5.1676130352985;
        Sat, 11 Feb 2023 07:45:52 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902c58e00b00198e6257921sm481709plx.269.2023.02.11.07.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 07:45:52 -0800 (PST)
Message-ID: <480b4e28-c37a-2af4-e491-d048379ecb98@kernel.dk>
Date:   Sat, 11 Feb 2023 08:45:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 0/4] io_uring: add IORING_OP_READ[WRITE]_SPLICE_BUF
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
References: <20230210153212.733006-1-ming.lei@redhat.com>
 <95efc2bd-2f23-9325-5a38-c01cc349eb4a@kernel.dk> <Y+ckE5Fly4gt7q2d@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+ckE5Fly4gt7q2d@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/23 10:13 PM, Ming Lei wrote:
> On Fri, Feb 10, 2023 at 02:54:29PM -0700, Jens Axboe wrote:
>> On 2/10/23 8:32 AM, Ming Lei wrote:
>>> Hello,
>>>
>>> Add two OPs which buffer is retrieved via kernel splice for supporting
>>> fuse/ublk zero copy.
>>>
>>> The 1st patch enhances direct pipe & splice for moving pages in kernel,
>>> so that the two added OPs won't be misused, and avoid potential security
>>> hole.
>>>
>>> The 2nd patch allows splice_direct_to_actor() caller to ignore signal
>>> if the actor won't block and can be done in bound time.
>>>
>>> The 3rd patch add the two OPs.
>>>
>>> The 4th patch implements ublk's ->splice_read() for supporting
>>> zero copy.
>>>
>>> ublksrv(userspace):
>>>
>>> https://github.com/ming1/ubdsrv/commits/io_uring_splice_buf
>>>     
>>> So far, only loop/null target implements zero copy in above branch:
>>>     
>>> 	ublk add -t loop -f $file -z
>>> 	ublk add -t none -z
>>>
>>> Basic FS/IO function is verified, mount/kernel building & fio
>>> works fine, and big chunk IO(BS: 64k/512k) performance gets improved
>>> obviously.
>>
>> Do you have any performance numbers?
> 
> Simple test on ublk-loop over image in btrfs shows the improvement is
> 100% ~ 200%.

That is pretty tasty...

>> Also curious on liburing regression
>> tests, would be nice to see as it helps with review.
> 
> It isn't easy since it requires ublk device so far, it looks like
> read to/write from one device buffer.

It can't be tested without ublk itself? Surely the two new added ops can
have separate test cases?

-- 
Jens Axboe


