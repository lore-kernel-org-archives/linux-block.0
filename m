Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CAFC11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA24613B4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhF3UMt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhF3UMr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 16:12:47 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3DCC061756
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 13:10:16 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id g3so2869728ilq.10
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PKhtP/3/5SYZTsSZ4hDFHrmDZFpSEMGrUmU3Xdktx0o=;
        b=LzYg+9OEvLIbb0PLpYeE22vnSWrGHr8SXluQSXwhtyRlQB3hCYI/lP8qfPrP+x6tgP
         eyfPWIoQvaz0sZWmQAfddNHp6SRXtpqu0WNh/tzzBtDd148smktMbg+a7YcfPqoMbXx1
         V7W9BOcdVtUoDjW+jEoHxJvOwLol9IdePbT2o30f0u1czQjQFgIhBDZsz40rNQ/Nioor
         2LPwzBcTJMzzbJdMf7qwMH7Vo05KnnLfbb2QvDZ6yuVkzsjwIzjeCm6hbvVtWluuLXu/
         5uwBB8SMdVimyARwVDGwUdBhc0SPVXJtemn9BLiXdyHXn4FxwTZoeLHmivdCPlYsuDeD
         nqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PKhtP/3/5SYZTsSZ4hDFHrmDZFpSEMGrUmU3Xdktx0o=;
        b=qDjV97I537uwTKhcGHP8JYM8ZLZUZfA6tdDcBIfPK1tx4c2gpL6FXmSlK6QqIl064M
         YWDcz/qlQEFC3jWpX5nohuetFVrEiU1AjAZkjnxRZ4Gie1jwb9J5Ev5hF729rWAaSve3
         zFrBS5m19PONbQ2T+85XKBkGAr3tIKTwDea4NdhRD7lzkHdOMuW4EfNeNHzCNeuwk9S/
         D+9/52Sw659Wb2roE3T6bRjJ1/JvZD+vSiRzCtOXoD5w+d+jSbnWod/dDwsSOW/MN3Fx
         seSltdCuwMGFy8L05zlHl3VME1DFImF2SPICpelXGuti6tVVizls8ahxZ19mvbt4f4Ju
         QhaQ==
X-Gm-Message-State: AOAM5335F1HPcB0GXoAkwNmiiWMmSJB2B86n+xca0Km0t1ohQHXCN8M2
        UhtrNzp87sD13QLMK4VG2WGHrM3VLvXigw==
X-Google-Smtp-Source: ABdhPJygKVczS+aX8a1t+CzKTleWGwU92FM5EbMMBowRqBsIlXrRbnmz227NJS3ykCnmut0VtTEX5g==
X-Received: by 2002:a05:6e02:50c:: with SMTP id d12mr14874630ils.84.1625083814953;
        Wed, 30 Jun 2021 13:10:14 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id e24sm1736840ioe.49.2021.06.30.13.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 13:10:14 -0700 (PDT)
Subject: Re: [GIT PULL] Block driver updates for 5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <ee6c32c8-e643-f817-bf45-1280e7f254ea@kernel.dk>
 <CAHk-=wg6axLJQuFQBNa+nMHkEdx4X75LF7_P=eC=rzKj0x2h2A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf8b1ca0-4362-dc86-3933-efd609fe3827@kernel.dk>
Date:   Wed, 30 Jun 2021 14:10:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg6axLJQuFQBNa+nMHkEdx4X75LF7_P=eC=rzKj0x2h2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/21 1:29 PM, Linus Torvalds wrote:
> On Tue, Jun 29, 2021 at 12:55 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Note that this will throw a trivial merge conflict in
>> drivers/nvme/host/fabrics.c due to the NVME_SC_HOST_PATH_ERROR addition.
> 
> Grr.
> 
> I don't mind the conflict. It's trivial, as you say.
> 
> I *do* mind what the conflict unearthed: commit 63d20f54a3d0
> ("nvme-fabrics: remove extra new lines in the switch").
> 
> That commit claims to remove new-lines. In fact, the full commit
> message explicitly says "No functionality change in this patch".
> 
> Except what it does is not just non-functional whitespace cleanup. No,
> it adds that
> 
>         case NVME_SC_HOST_PATH_ERROR:
> 
> thing that was added in mainline too by commit 4d9442bf263a
> ("nvme-fabrics: decode host pathing error for connect").
> 
> THAT is not ok. Commit messages that explicitly say one thing, and
> then do something completely different are very bad.

Agree, that's beyond ugly, I should have caught that.

-- 
Jens Axboe

