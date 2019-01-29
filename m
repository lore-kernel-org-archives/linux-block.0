Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6988AC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BE5214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UTW+PExj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfA2Q2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:28:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42675 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfA2Q2F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 11:28:05 -0500
Received: by mail-io1-f66.google.com with SMTP id x6so16777077ioa.9
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zxpGbxcMCq+/B93/NvqPWFuWtOMz380kNeMARwpe4wQ=;
        b=UTW+PExj36nQ5jpyusQQFqKix60QFY4KrynFGqgURbYOz+ilTsW/mt4ERiAVjFbsVY
         +T1oSO/oGa9fQsT0a6kRH7QKDeMkBxtAAlHwLkSRYY9Nx2P88tHJRW9+T+jSNCONM4dQ
         HML2xritcZJ+uvFquZsUtL4m4Kg/ofD3QkiAqn5emNKba0M2GKjxWzORp1Z7chs0pV2H
         VDppxHXSyajdxakyGnjPKZUappFZtvaSW63cdb3zdpxGGmjTJDbQq89Kzj9GzoHsP8CK
         pOIqilZgDu+e5lpz3I4/VipDfbxJaHFN399mau1NFSKaW9xYjZAr7L8m9/cMZ8zLvE5M
         +5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zxpGbxcMCq+/B93/NvqPWFuWtOMz380kNeMARwpe4wQ=;
        b=oLiCG42Z9Uyx1w29eHKwApf1oKc/VzzYZAhxJSKfXrqGdfTQza670cwaNwkipK0H4H
         uJthhSRbc3oEBCThBtaygvllUxYwdJJZdHqZ7QwWW5qHEcPWEr42tCbrKrBgcsBFYxb0
         4r6RN4jA46ceHqQNtFBwPiraekQ0HmHM9RngbOEKIRxslvMlMuZaHZmA1sTSrd68gQtN
         UQZKoOCj8jUQp4qsEjhbCvX36kRdQtru/HKCkRoK3pJ0WRk9Q5RdKWMcjzMulkxRlBnp
         XxuB7bf/6SF2e4G1VrbmrsFbFe5sQF02YCC7RkqVRSLtF4sYjEsPGaK7Sz9CDuMZe1xU
         HDtQ==
X-Gm-Message-State: AHQUAubGXQmH0KybagzDjU2UfyJXGvtb831liWkMfDeu9+PwrcPggemF
        fUfjhvGq4ZUEvVPZ/XIj91E5NwlzUV4=
X-Google-Smtp-Source: ALg8bN4tfTWb1j/X2YXKwPB0wdCGlAXJfIf6S2Zm+bcWmzMNJ2fKsuRXFW8kSNldyOWy4vbk/S8N0A==
X-Received: by 2002:a6b:4106:: with SMTP id n6mr15559876ioa.171.1548779284268;
        Tue, 29 Jan 2019 08:28:04 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q9sm14448145ioh.32.2019.01.29.08.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 08:28:03 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de>
 <2729ab43-b2bf-44b0-d41d-dbb495ddffbf@kernel.dk>
 <20190129063043.GC2996@lst.de>
 <CAK8P3a1x4BsFfacxOmaDXKOKmmQ2j0ypX2+mCNCbjH3E7nC4DQ@mail.gmail.com>
 <4b12d149-99f7-0b2e-0c3f-9b477ce48520@kernel.dk>
 <CAK8P3a38-FLBH0sp0vaebv29M5oDyiUkwwmVY+9_S3vSER9n5Q@mail.gmail.com>
 <9a66c000-62f3-7567-7919-31e61e28defa@kernel.dk>
 <CAK8P3a1=kho718OSdZ0zp5g3mwmsYbd5J-e58kDyq2QMBCak=Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4395ae02-54fe-d5fe-dea9-c50f7eaba3b1@kernel.dk>
Date:   Tue, 29 Jan 2019 09:28:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1=kho718OSdZ0zp5g3mwmsYbd5J-e58kDyq2QMBCak=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 9:26 AM, Arnd Bergmann wrote:
> On Tue, Jan 29, 2019 at 5:19 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/29/19 9:18 AM, Arnd Bergmann wrote:
>>> On Tue, Jan 29, 2019 at 4:20 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> That's good info. I am currently using set_user_sigmask() for it.
>>>> I'd really like to avoid having to pass in a sigset_t size for the
>>>> system call, however.
>>>
>>> I really wouldn't do it, given that all other signal handling interfaces
>>> are prepared for longer signal masks. You /could/ probably extend
>>> it later with a flags bit to signify a longer mask instead of using
>>> the entire register to hold the bit length, it just seems really
>>> inconsistent with all other system calls.
>>
>> Damnit! OK, I'll keep what I currently have then.
> 
> As long as you stay within the 6-argument syscall contraints,
> the cost of passing the length is basically free, right?
> 
> Is there anything else you are worried about?

My main worry is not the extra argument, more that we're at capacity
for the system call. If we wanted to add a timeout parameter, then we'd
need to bundle them up, which sucks.

But I think we're fine, I'll go with what I have.

-- 
Jens Axboe

