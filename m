Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FA2C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 21:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD9F2082D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 21:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aAZmQQl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD9F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLGV73 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:59:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45940 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLGV72 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 16:59:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so2264651pgc.12
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 13:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YKzZ8pkyikApsyET57lAqn0WzJmSnO6mC6NeUaCN6m4=;
        b=aAZmQQl+pgQt8lzjfXngPui/af0C38hjDCElUkY+WasHlP4jvAbsoE+HRhDkewukmv
         YMlo5pytilpyvjmf7RD2vu6ddFAByJZjR5weIPbpRNBRNG/jaP7QXQCWrWj1WBLj61U8
         Qe/8mGLCSylTSm6qc/XBvbwfwwO/7YVOAWa0/7yJUEWVr+CxGuUko+TmBv5R9hMq90jx
         u3S/gueI4R3U50MpObGIQAy1xwserR+3xHREGVgS1ocZERnBlemRamP6CR0Pev4B38vI
         ql4HZJmCaT8Wo1rHBgCAMYrdslj3jEGC/R/F9ZMJj0M9d8XEpQ0MeEN2oX9LZkKeO8k7
         ySRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YKzZ8pkyikApsyET57lAqn0WzJmSnO6mC6NeUaCN6m4=;
        b=JdRuVU9qhSLaTVueKU355ebmEz1PnCXbyFx/EGw9xCpaE2JCHF+QK47eNIbKadHFNi
         yyPOxQQctc6KD5Vv8eKIahdrZJhxTsUrDpXxmEDCSqh/ZffYY8M+VOhUxzfHeTmVGtHj
         U4KlXzKcUAiS+lkb5XOdTOi/bpOg8ALCZH9rU0igqNSs5JLulRBl/9ThraabbDQYV84N
         bVT7oveHGggJUmJFULlovcYwadMw+5T19jbwJ0my5my+C1fV1jKuhd6/uSOTOVcJSatV
         lRtsqSUpr0v/J57BAncV/j7OatCiJVkx8TCheoTNL53Eu97NCJaoPXf78SNcabe9F1wH
         UMxA==
X-Gm-Message-State: AA+aEWYG+QUfeSmdbCsmYUNGD5ncG7zLF4lUnqBP4/HTs8hBQjtBGEHL
        D+apbKC9p0NcR45lU2cDkOt0LA==
X-Google-Smtp-Source: AFSGD/XvqycdCEslcwS9HqZt8IHg+aBWS0jV8nRT7T7MoX92RFDF6OW5s9yst/kkLHSO0RO9dTwmKQ==
X-Received: by 2002:a65:484c:: with SMTP id i12mr3396545pgs.309.1544219967983;
        Fri, 07 Dec 2018 13:59:27 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o189sm5636474pfg.117.2018.12.07.13.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 13:59:27 -0800 (PST)
Subject: Re: [PATCHSET v5] Support for polled aio
From:   Jens Axboe <axboe@kernel.dk>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181204233729.26776-1-axboe@kernel.dk>
 <x49muphrx4u.fsf@segfault.boston.devel.redhat.com>
 <4bf3dfe4-b157-88b6-f9a3-60ad1f76328a@kernel.dk>
 <9747f14b-8361-08c0-5a1f-d4f26509083e@kernel.dk>
 <x49a7lhrv0x.fsf@segfault.boston.devel.redhat.com>
 <650ef685-0727-aaf4-aff5-adf11c06f3fa@kernel.dk>
 <c8cadb71-4e78-61d9-46b8-9403351632d7@kernel.dk>
Message-ID: <65d4cd53-8c13-3741-1994-98b1297dc714@kernel.dk>
Date:   Fri, 7 Dec 2018 14:59:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c8cadb71-4e78-61d9-46b8-9403351632d7@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 2:58 PM, Jens Axboe wrote:
> On 12/7/18 12:35 PM, Jens Axboe wrote:
>> On 12/7/18 12:34 PM, Jeff Moyer wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> BTW, quick guess is that it doesn't work so well with fixed buffers, as that
>>>> hasn't been tested. You could try and remove IOCTX_FLAG_FIXEDBUFS from the
>>>> test program and see if that works.
>>>
>>> That results in a NULL pointer dereference.  I'll stick to block device
>>> testing for now.  :)
>>
>> Good plan :-)
> 
> Took a look and fixed it up, my aio-poll branch has a fixup patch and I
> also updated an updated aio-ring.c in the same location.
> 
> Tested XFS with polling on and off, works for me.
> 
> Will take a look at FIXEDBUFS now. Note that aio-ring has some parameters
> at the top:
> 
> static int polled = 1;          /* use IO polling */
> static int fixedbufs = 0;       /* use fixed user buffers */
> 
> that you can change to try the various modes. Don't use fixedbufs = 1
> with XFS just yet :-)

Actually, with the other fixups, that works now too. At least in a quick
test...

-- 
Jens Axboe

