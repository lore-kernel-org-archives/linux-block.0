Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3984C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 17:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8513C610D2
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 17:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhJ1Rrv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhJ1Rrv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 13:47:51 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00328C061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 10:45:23 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id x9so171382ilu.6
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nqvCR2bN5552JctZBnW09VLBBN76DPfLRHu4EA4nWLA=;
        b=hyykRwvj4oo1gpi9zgHXAGPqNsDcsV3DgOZw4jZZSpSIxxoESwm2foqE5+2Fqr21Pl
         /HL9Vrz062i9BP/vByI1+Tji7AFOtBuKLwWu0M3VEOunF+t1DWW+J0E6z6SBU6ncTmVF
         2WRoX7ExtcAgBQ3NKdzQnt7sg3owAqMCQFgfYdo9vbECKmR4aEfdZZzUbeW7wvj69y2v
         e/KJcHcENNbFAA60U8FPylWq1QddfoXkgrwgZ3006xCcAJtRfM3369A1CS6DWdLwkwyf
         t29TRIwXq5YuidLb8IfWPSmkg2VqwJYFX8nssr8wBRg47zHe+QC8Ft6UaZsbIG/hLsXn
         xDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nqvCR2bN5552JctZBnW09VLBBN76DPfLRHu4EA4nWLA=;
        b=wetIT+OX7yvSMCNc8IrX3vHBXWkCdu1Hbr9JfY3lOBSCGQ4pzSWh3q2RluK4SJkCDg
         pGJs5NyUpQL8xf9zaNemPV4Wr3Pl1dAIJs2XyDaYRifWWeZopcHIuFvTZcMN+DSbJCDZ
         dP85eJ5lDTz4UPfEWuPtpKYN8PwRBYi5qlzrOwYbvbgFQHYqw0awKS5DBmFc1ZeVjGcf
         3s+hd8ylBaw87H1ALYM/V80YXky5ps1SC8AzLbF1ZJHU9XYvccN8NRZUp1G7IlYHZl/d
         xn1lOyQuZ/WwjSVHGAcZGtyO2UMXViNAUznikX5MQZlH4KNTfzlFNpw5JLPWNHQOy0Jl
         cA8A==
X-Gm-Message-State: AOAM530TakwjQ6xa3/TuHD57wGDggkoU76Mz9f45abUH/g8QofYsDJcC
        0KXnUGij5rpigmZwZRvkzr/Ryg==
X-Google-Smtp-Source: ABdhPJwTo0GsDmIPSo/DC5JGZZXjisP0tBkrjOYzEY7gALmUxkpiG4fyDvrLRnKB2d6DI1w6XVqZgg==
X-Received: by 2002:a05:6e02:1a2d:: with SMTP id g13mr4526865ile.153.1635443123325;
        Thu, 28 Oct 2021 10:45:23 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r11sm2197067ill.20.2021.10.28.10.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 10:45:22 -0700 (PDT)
Subject: Re: [PATCH 0/3] implement direct IO with integrity
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Mikhail Malygin <m.malygin@yadro.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Alexander Buev <a.buev@yadro.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux@yadro.com" <linux@yadro.com>
References: <20211028112406.101314-1-a.buev@yadro.com>
 <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
 <20211028151851.GC9468@lst.de>
 <85a4c250-c189-db5f-0625-2aa4bd1305f8@kernel.dk>
 <AAD8717C-E050-47C0-B8C9-119C8F51B47D@yadro.com>
 <14dcfef2-ac21-35a2-a97b-9cee39b079a1@kernel.dk>
 <64016c86-188e-916e-662d-b33431dec946@gmail.com>
 <bc0dc601-8e5a-800a-e3c4-d2dfdabb96fb@kernel.dk>
 <e44e0928-bc01-06df-4bd7-cb120efeed50@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6afe0247-f6c4-8ab9-2b49-8c02e2704757@kernel.dk>
Date:   Thu, 28 Oct 2021 11:45:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e44e0928-bc01-06df-4bd7-cb120efeed50@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 11:11 AM, Pavel Begunkov wrote:
> On 10/28/21 17:22, Jens Axboe wrote:
>> On 10/28/21 9:56 AM, Pavel Begunkov wrote:
>>> On 10/28/21 16:50, Jens Axboe wrote:
>>>> On 10/28/21 9:44 AM, Mikhail Malygin wrote:
>>>>> Thanks for the feedback, we’ll submit and updated version of the series.
>>>>>
>>>>> The only question is regarding uapi: should we add a separate opcodes
>>>>> for read/write or use existing opcodes with the flag in the
>>>>> io_uring_sqe.rw_flags field?
>>>>>
>>>>> The flag was discussed in the another submission, where it was
>>>>> considered to be a better approach over opcodes:
>>>>> https://patchwork.kernel.org/project/linux-block/patch/20200226083719.4389-2-bob.liu@oracle.com/
>>>>
>>>> Separate opcodes is, at least to me, definitely the way to go. Just
>>>> looking at the code needing to tap into weird spots for PI is enough to
>>>> make that call. On top of that, it also allows you to cleanly define
>>>> this command and (hopefully?) avoid that weirdness with implied PI in
>>>> the last iovec.
>>>
>>> Reminds me struggles with writing encoded data to btrfs. I believe
>>> Omar did go for RWF_ENCODED flag, right?
>>
>> Exactly the same problem, yes. It ends up being pretty miserable, and
>> there's no reason to go through that misery when we're not bound by only
>> passing in an iovec.
> 
> I agree that a new opcode is better, at least we can keep the overhead
> out of the common path, but RWF_ENCODED was having similar problems
> (e.g. passing metadata in iov), so that's interesting why RWF was chosen
> in the end. Is it only to support readv/writev(2) or something else?

To shoe horn it in via an existing interface, I don't think anybody
wanted to add yet another read/write API just to cater to that.

-- 
Jens Axboe

