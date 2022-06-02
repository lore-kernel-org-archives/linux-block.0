Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F08DC43334
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 08:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiFBITR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 04:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiFBITO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 04:19:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F39FF1
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 01:18:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k36-20020a05600c1ca400b0039c2a3394caso678039wms.2
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2022 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=grBv/gpdLam/wFPbL6YIo2ry7eetDeeb1gTECl6N5a0=;
        b=e+JfYtJUswtJB0x8AUiFMyZUjpBuIgki6tjiKQkbEvFjujCQo2sSU2IpdLbTxjZzGf
         DGPUUuWxaQ2oZ/qlncmtlAIqODbKjyLQyZIH3ILINgLZdqPiB+9OcYmfxZ5e1yOZGDVz
         JQHBa0ibO6Q47Cb/hux7noKKg9qNMwGB1wHrKfoRLBSs8vMIlBpeegC9nfI1mwPwCKgu
         IEnsF6qZ6nIobllJjjd6V8/hMiBN2tWpy8TNqdYTcJDMw1ETljCq/KzRkaRhQZ2dNIxn
         YXgDD43SUcRO4QlWkWCYqqVkmEctRY/AXCw7kmyOMpdq3rkl29tPafdPz1v21R8uE8mu
         JmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=grBv/gpdLam/wFPbL6YIo2ry7eetDeeb1gTECl6N5a0=;
        b=jwf3puP+rA1WVA4wMPoKBEjVGK+rJSOg68z2OWeoJIXnIwLk3+O2SMlh2DxMyj2CbT
         BK2ugAKN+6RdLzwgzp//G+2Eaz0vsABzDTHatDOGhgTm9h1/dJED+LVoGLzPH6J1RbBo
         91VpzchOlFK3ObBYXbCILlfzfrQCrEweeRB/gQ4Jsw8zF2mMVI6Epdl7Twu0f4JJY/n6
         kgDkJmv06JsQZqt1eSO3yXlok4pdem0hBA6X/GfNu5KSE2bWIbRssVwh1UJQg3TYLR20
         eAMFJN7H5vZcz6rvdtzRwe7PUFaXMkor/6s3/2UjNxS7M5GgxA6HBBBW1GvxT9Hqjyoi
         YI1w==
X-Gm-Message-State: AOAM533xyyHOYb2J9mWhJ7vHeSqAlk1XqzpQD0MLCvLmVaWC2JnjFFn4
        bSw/KUOFHNS0LKuKFRlMbpDSRX20jriX6789
X-Google-Smtp-Source: ABdhPJxPBSxtMAL0eFt5HtWjrSQGq6vvRTkHzimcZatsdY+SMZ31DPKqDNJcbU2ReLbfFuBYvhvQrA==
X-Received: by 2002:a05:600c:acf:b0:397:345f:fe10 with SMTP id c15-20020a05600c0acf00b00397345ffe10mr2909296wmr.15.1654157936135;
        Thu, 02 Jun 2022 01:18:56 -0700 (PDT)
Received: from [10.40.36.78] ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5084000000b002102f2fac37sm3786342wrt.51.2022.06.02.01.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 01:18:55 -0700 (PDT)
Message-ID: <7cf7a9ce-525d-3b90-2b49-6eae6189da6e@kernel.dk>
Date:   Thu, 2 Jun 2022 02:18:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: bioset_exit poison from dm_destroy
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, david@fromorbit.com
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com> <YpcBgY9MMgumEjTL@infradead.org>
 <Ypd0DnmjvCoWj+1P@redhat.com> <Yphw2n3ERoFsWgEe@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yphw2n3ERoFsWgEe@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/2/22 2:12 AM, Christoph Hellwig wrote:
> On Wed, Jun 01, 2022 at 10:13:34AM -0400, Mike Snitzer wrote:
>> Please take the time to look at the code and save your judgement until
>> you do.  That said, I'm not in love with the complexity of how DM
>> handles bioset initialization.  But both you and Jens keep taking
>> shots at DM for doing things wrong without actually looking.
> 
> I'm not taking shots.  I'm just saying we should kill this API.  In
> the worse case the caller can keep track of if a bioset is initialized,
> but in most cases we should be able to deduct it in a nicer way.

Yeah ditto, it's more an observation on needing something like
this_foo_was_initialized() is just a bad way to program it to begin
with. The caller should know this already, rather than us needing
functions and state in the struct to tell you about it.

>> DM uses bioset_init_from_src().  Yet you've both assumed double frees
>> and such (while not entirely wrong your glossing over the detail that
>> there is intervening reinitialization of DM's biosets between the
>> bioset_exit()s)
> 
> And looking at the code, that use of bioset_init_from_src is completely
> broken.  It does not actually preallocated anything as intended by
> dm (maybe that isn't actually needed) but just uses the biosets in
> dm_md_mempools as an awkward way to carry parameters.  And completely
> loses bringing over the integrity allocations.  And no, this is not
> intended as a "cheap shot" against Jens who did that either..
> 
> This is what I think should fix this, and will allow us to remove
> bioset_init_from_src which was a bad idea from the start:

Based on a quick look, seems good to me.

-- 
Jens Axboe

