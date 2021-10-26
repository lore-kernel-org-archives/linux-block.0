Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE6EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E416103C
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 17:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbhJZR2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 13:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbhJZR15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 13:27:57 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E66C061745
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 10:25:33 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id w10so18150746ilc.13
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eRyfWMKtLbbwfUe78MgpwTKyNG2DhD4qRhOw6hMcN3A=;
        b=6jR4PITb12iW50VjhwN5AsYzKaM1pZkI7vhoOuk7YZuycenGt6jZOXKntSQ82ybm9u
         N/bHrqh23MX6Xbb1zq1XV/AISB5S2oGkQoMa4j3WaBrCig/EaZgRUUknI9WaeBz3Y3ri
         VNwihD+NCHntcFYCBBlJPsj+c7oLrWFI1nG7sul/68ihSStBAJ63dRmlzLd3K/JXjalV
         G80qv3xKqEDnQs6L3a6Z9xEYi0a4PjC2uliRki6LTViBDM1It97emYni3JZ31+Oe7c0L
         SUo+0NyVf5G00prYJPUskySyQHmaCuzPuqVLCGUza3yxmq4VHC04mjhqSi79ysXuKrOe
         M5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eRyfWMKtLbbwfUe78MgpwTKyNG2DhD4qRhOw6hMcN3A=;
        b=FVtl5807LfdfyesLS+bpAPQtd9a9Eo/ev3YKhXwF0aQKANZnFOBdGDHUXP6r9HzMn9
         CmB8ZU6hp407N7n+TlG3qSs5KnBmtd7hgFCrrgH3+PSP81xCE9bYLe/frjGR/c2xCxAb
         xpoRpAvivwO51sMyhe4LXc38oF9/Mb3ufXm64Z9zyiOmoiFHtXvzDgUX5GmjmNT5bPKF
         0ccKEvP+Dqn32p2DJDOOzgjlXJAJunF/Y2TyZ+s5MMHrDVwLkS8Vtl4IFm8P4Gi2qqEb
         ltd9esEVGvSHrAK5QtF9vGL2Fpn7mLJIEd+v9xd+69XVknzQBHN0m+SeL7w6N29WLPRx
         Kdvg==
X-Gm-Message-State: AOAM532Lgse9dk3MenKtGtu2EleGS1EkSOlEKwAv6c+MRHdet+lxi4VL
        zDMZplMoW1KQZwDhzTpIBoS6ex5FwUQbew==
X-Google-Smtp-Source: ABdhPJysundZiuH9mj4mrKaC9yQ7XDwTmT9Ji3/Q7aROlf90iW2iA+Fsqc4h7GsO1a1/+gcAYeqynw==
X-Received: by 2002:a05:6e02:10c7:: with SMTP id s7mr15851132ilj.172.1635269132859;
        Tue, 26 Oct 2021 10:25:32 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 81sm10218112iou.21.2021.10.26.10.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:25:32 -0700 (PDT)
Subject: Re: [PATCH] scsi: ufs: mark HPB support as BROKEN
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20211026071204.1709318-1-hch@lst.de>
 <99641481-523a-e5a9-db48-dac2b547b4bd@acm.org>
 <7ed11ee1f8beca9a27c0cb2eb0dcea4dbd557961.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <870e986c-08dd-2fa2-a593-0f97e10d6df5@kernel.dk>
Date:   Tue, 26 Oct 2021 11:25:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7ed11ee1f8beca9a27c0cb2eb0dcea4dbd557961.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/26/21 11:19 AM, James Bottomley wrote:
> On Tue, 2021-10-26 at 09:36 -0700, Bart Van Assche wrote:
>> On 10/26/21 12:12 AM, Christoph Hellwig wrote:
>>> The HPB support added this merge window is fundanetally flawed as
>>> it
>>                                               ^^^^^^^^^^^^
>>                                               fundanetally ->
>> fundamentally
>>
>> Since the implementation can be reworked not to use
>> blk_insert_cloned_request() I'm not sure using the word
>> "fundamentally" is appropriate.
> 
> I'm not so sure about that.  The READ BUFFER implementation runs from a
> work queue and looks fine.  The WRITE BUFFER implementation is trying
> to spawn a second command to precede the queued command which is a
> fundamental problem for the block API.  It's not clear to me that the
> WRITE BUFFER can be fixed because of the tying to the sent command ...
> but like I said, the standard is proprietary so I can't look at it to
> see if there are alternative ways of achieving the same effect.

Is there a model in which this can actually work? If not, or if we
aren't sure, I think we'd be better off just reverting the parts
involved with that block layer misuse. Simply marking it broken is a
half measure that doesn't really solve anything (except send a message).

IMHO, it should be reverted and the clone usage we currently export be
moved into dm for now. That'll prevent further abuse of this in the
future.

-- 
Jens Axboe

