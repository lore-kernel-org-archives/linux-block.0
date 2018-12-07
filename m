Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F88C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 21:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53B42082D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 21:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dxfN1sbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53B42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLGV6n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:58:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44919 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGV6n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 16:58:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so2535681pfh.11
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 13:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VyQpfBdxX614QNjcb9/yWO+dvXHgNpLtVbTuCHswIAw=;
        b=dxfN1sbJjae2Jg/o0KHM1BhySGcZTG3cT4YNEqOrm8a+iXnaWOoPPh1s4rf9+Acksk
         BPGzhPtKLQ9d4vUMmICgIlfw0+M7u42BCqnxnbtX3dTKFW/UfE5nd6wsF+fm+moxZNcS
         6F0IpROSSDYpuN0HbuAKtwuEYEczJkeBHUHHFplQH1IdA7OXFAKkwKb2nDkMx/jJ18GK
         0/2qshqAGSvZXN5U2UMdn2hUrqtBOw89w2zmYp0KR8vjtM5+XLAsvJvKE9C0vMcB/csj
         mwOTFOxLUT9jiiuzvskYrskqoLAtGlNl8WAp1ZZBFwMZ1XGvV8oj2e7uMBwRvEQJks8j
         nAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VyQpfBdxX614QNjcb9/yWO+dvXHgNpLtVbTuCHswIAw=;
        b=YjRi6qH+8YYEIDElwjjiW7mCUrd8t4CnoT1voAoJ1HBz08pwy074iVeA4V0wS5hYSC
         8mutSKMSasilerYm65DL3m8K0RVgVdNgOrgFoqmCu22vhAwcLCNOMRDGOW03X3fLND9Y
         1D3RJsmpBEev7hrrbeMvsNSbzeWgA3k+8REiZbDMWu7ghwpGB01aQaIhAOr+/lq6hZp6
         Ir8tqzadbPmadx96370BRpq0i/KEJiXj8yukjdynHV+aS3TbDRO2JviYkRupuD7s5Ooe
         V0GJFN0YklvpwKuZQEax7o74VxlEOxEXEqqUvCd0WhrIVRpPjY3AVk9Lo7KW55uAb4B3
         LY3g==
X-Gm-Message-State: AA+aEWb/I5gwv5JXhUBeKfRN5r9tsvjPf/w8uJmd0TOm5eTe5Lb7WAtb
        /Wi9IMHlYM2oZCmBeRCbV8SgKQ==
X-Google-Smtp-Source: AFSGD/Xpw0KddmQ/b1STjEiO1S0puD/9I4w46dZvxjUD30QrWyGPFQz+3n02SRU/yoFIQg83SUSMSQ==
X-Received: by 2002:a62:c505:: with SMTP id j5mr3878576pfg.149.1544219921976;
        Fri, 07 Dec 2018 13:58:41 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a73sm6854641pfa.7.2018.12.07.13.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 13:58:40 -0800 (PST)
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
Message-ID: <c8cadb71-4e78-61d9-46b8-9403351632d7@kernel.dk>
Date:   Fri, 7 Dec 2018 14:58:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <650ef685-0727-aaf4-aff5-adf11c06f3fa@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 12:35 PM, Jens Axboe wrote:
> On 12/7/18 12:34 PM, Jeff Moyer wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>>
>>> BTW, quick guess is that it doesn't work so well with fixed buffers, as that
>>> hasn't been tested. You could try and remove IOCTX_FLAG_FIXEDBUFS from the
>>> test program and see if that works.
>>
>> That results in a NULL pointer dereference.  I'll stick to block device
>> testing for now.  :)
> 
> Good plan :-)

Took a look and fixed it up, my aio-poll branch has a fixup patch and I
also updated an updated aio-ring.c in the same location.

Tested XFS with polling on and off, works for me.

Will take a look at FIXEDBUFS now. Note that aio-ring has some parameters
at the top:

static int polled = 1;          /* use IO polling */
static int fixedbufs = 0;       /* use fixed user buffers */

that you can change to try the various modes. Don't use fixedbufs = 1
with XFS just yet :-)

-- 
Jens Axboe

