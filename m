Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD0BC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D41920837
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cGCvGG1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D41920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLGWGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:06:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45978 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGWGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:06:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so2405869plm.12
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Anhwt+C9akh30RhORKpKbwJOLtjOXVqUixoKeJeO8F8=;
        b=cGCvGG1j9zvJ2ktr5bljiNZ8icSyAdZHVXAhQTv1lAxAjc0qvlmHXbcsp5oqfK/+En
         5WqF77ri82zDiNjLpnqg0guU2NRU3tfFJc4xz1QDmGgPtQA/EOrt2rQdJg1tOGgfPiii
         Ap4K9bFaR3KFy8oHFa5m2TRpYicq+ycHJnFhEyK351jfOQSZyf9554sn1N45kLfnrhrn
         2Ll6IMspHNGEyK5D+l3dnu/V3y9jT30/RPn6Ez/iVVEsVjbkJTr88SFsBOubShLrF/sG
         8PeK2AYOeqWJGUueHbQ9dyKLkFlpP/T+DPZDw1atwRjCTa81jGOBNTBrdRs7XBtTV3Lg
         pW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Anhwt+C9akh30RhORKpKbwJOLtjOXVqUixoKeJeO8F8=;
        b=WaNZv38LaAssWddLaMU5F/3CJrt/Mjne4se0msf32r+eM5/hvs4qeajH+4Wp5ah8st
         7xSpk243F8gUhZByKGcdtJivyw2ke/S6PcbxolRVMk3uWuanlrBQ37FsCE1pzb9y9EsP
         Z8fDMcOEYs+o5cfXRl/DbXZZW0AOJL6GOnrJHmodhJzvmiu8pYxVwf3IfDky8Cbo5Kz6
         jFfd/0xskkm+pGREphHPMCyZX3u0SeD50v4Wz8/thFY6Gi20avx2fTbRAtt4A5PEeoZC
         qFQVTJW1OxDFTidwiWRZiWksKDIu+2RnXcYZuDTh2TTJjHo8+vbe2KePRUhZA7k/Z7o2
         DYyA==
X-Gm-Message-State: AA+aEWYY83r4ovXaN/TB9JKeEAjYzg8AggVZZj1nEqgUZ/Tz2qsv0+N1
        L41bvhaY+UfPpdotFLYcm0dnig==
X-Google-Smtp-Source: AFSGD/WFxP6xts3hLXOc8Z20lEwPr8gKAwRuwkc8o4496SNWsbqAbf2WaUU7OrTQ/JxPm0z+vFa88w==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21mr3829071plo.183.1544220372884;
        Fri, 07 Dec 2018 14:06:12 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v14sm10684256pgf.3.2018.12.07.14.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:06:12 -0800 (PST)
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
 <65d4cd53-8c13-3741-1994-98b1297dc714@kernel.dk>
 <796e20df-3f55-af8f-58c3-45e7a6d2009a@kernel.dk>
Message-ID: <03b82fbf-e4cb-6a80-503c-bc043bdd9e8a@kernel.dk>
Date:   Fri, 7 Dec 2018 15:06:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <796e20df-3f55-af8f-58c3-45e7a6d2009a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 3:00 PM, Jens Axboe wrote:
> On 12/7/18 2:59 PM, Jens Axboe wrote:
>> On 12/7/18 2:58 PM, Jens Axboe wrote:
>>> On 12/7/18 12:35 PM, Jens Axboe wrote:
>>>> On 12/7/18 12:34 PM, Jeff Moyer wrote:
>>>>> Jens Axboe <axboe@kernel.dk> writes:
>>>>>
>>>>>> BTW, quick guess is that it doesn't work so well with fixed buffers, as that
>>>>>> hasn't been tested. You could try and remove IOCTX_FLAG_FIXEDBUFS from the
>>>>>> test program and see if that works.
>>>>>
>>>>> That results in a NULL pointer dereference.  I'll stick to block device
>>>>> testing for now.  :)
>>>>
>>>> Good plan :-)
>>>
>>> Took a look and fixed it up, my aio-poll branch has a fixup patch and I
>>> also updated an updated aio-ring.c in the same location.
>>>
>>> Tested XFS with polling on and off, works for me.
>>>
>>> Will take a look at FIXEDBUFS now. Note that aio-ring has some parameters
>>> at the top:
>>>
>>> static int polled = 1;          /* use IO polling */
>>> static int fixedbufs = 0;       /* use fixed user buffers */
>>>
>>> that you can change to try the various modes. Don't use fixedbufs = 1
>>> with XFS just yet :-)
>>
>> Actually, with the other fixups, that works now too. At least in a quick
>> test...
> 
> And no, it does not ;-). Will take a look, we're dropping page counts where
> we should not be.

Forgot to add the BIO_HOLD_PAGES check in iomap, it works now. Pushed out
that fix, will also need folding.

-- 
Jens Axboe

