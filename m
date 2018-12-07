Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2F8C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EADB20837
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LRRj6jpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EADB20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeLGWAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:00:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39990 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeLGWAj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:00:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so2404839plq.7
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=weYwy7fkXHOB7eT9HzxBdaE3S5gjZCqkrr1l0rlaHfM=;
        b=LRRj6jpXFXexP6SeC1E61QPwwgiMm8OskNyDY9XkT72FwewAQloTKyYBujHlCyGXIw
         NdcZxpQm9ds3HjN3/G8a5TwB7rYTJfmotIN2O3DaasyvdiYmOxAbSVUJEIUTjrpPxp88
         vzkxW/c8z47MaCbahfKdGBzGYz+z+5V89YdObK9thhHW8vlc1mXnRwoicr16bIYF0Tyd
         pva7oG3HZ375PBhZr61IYzJX4CSfGrmyhvho7/Hld+Mn+iqjZWHTMekHTriy60AgQIVd
         S3t0YGbZJchF3xSCaNw4n+YhaA5eYl2j2Ijx61LKvOkFpCqa+Avvec8fBRbtnGgrVYrV
         Be7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=weYwy7fkXHOB7eT9HzxBdaE3S5gjZCqkrr1l0rlaHfM=;
        b=CJt2piZqKbLDCHHxLdC3fDkmZ9F7TIa485Q8x4Qi/Mo4DkYby7Ub3LrJuoVvBbGTVH
         ozixbaUdoTQllKXf2kEaUpKig6I/nDuKMgi+EMfpZBldE54ipu0PtRl6V744DXeGlHiD
         ++OulDUnW2rdT8xccN9HvxMqqYUYEfC2LZ/RsnMa4QHFT4WAMnhXhYTfWe1NoidJTCZO
         2tUasigFHrcb4FpkjNRxNmzj8RlvGYBTtOO18uh667NrmE9ZLswjKYPsj4L7V5QNz98p
         NZ+51rcUy9lmi/cXVdNs6W4+ql/3gCRJXiCVhEbkvLedTuDDf9pWpOqbNqy8qjYp+lA7
         evkg==
X-Gm-Message-State: AA+aEWar/c9TZwO1dm9wqN3qN5E+SYl5HPd9Xm213VUCJJ5+tZ72b4jF
        lg4rxCoLnPy62TUq64MN4iQmtQ==
X-Google-Smtp-Source: AFSGD/UlFGICNkxIIKYIq6BdU/IzFX/liMxq3EPfK02jkrZ4kPzkyzaAN0mj3WTQD7EvEyWA0SKtYQ==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr3666122pln.324.1544220038795;
        Fri, 07 Dec 2018 14:00:38 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t90sm6180580pfj.23.2018.12.07.14.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:00:37 -0800 (PST)
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
Message-ID: <796e20df-3f55-af8f-58c3-45e7a6d2009a@kernel.dk>
Date:   Fri, 7 Dec 2018 15:00:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <65d4cd53-8c13-3741-1994-98b1297dc714@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 2:59 PM, Jens Axboe wrote:
> On 12/7/18 2:58 PM, Jens Axboe wrote:
>> On 12/7/18 12:35 PM, Jens Axboe wrote:
>>> On 12/7/18 12:34 PM, Jeff Moyer wrote:
>>>> Jens Axboe <axboe@kernel.dk> writes:
>>>>
>>>>> BTW, quick guess is that it doesn't work so well with fixed buffers, as that
>>>>> hasn't been tested. You could try and remove IOCTX_FLAG_FIXEDBUFS from the
>>>>> test program and see if that works.
>>>>
>>>> That results in a NULL pointer dereference.  I'll stick to block device
>>>> testing for now.  :)
>>>
>>> Good plan :-)
>>
>> Took a look and fixed it up, my aio-poll branch has a fixup patch and I
>> also updated an updated aio-ring.c in the same location.
>>
>> Tested XFS with polling on and off, works for me.
>>
>> Will take a look at FIXEDBUFS now. Note that aio-ring has some parameters
>> at the top:
>>
>> static int polled = 1;          /* use IO polling */
>> static int fixedbufs = 0;       /* use fixed user buffers */
>>
>> that you can change to try the various modes. Don't use fixedbufs = 1
>> with XFS just yet :-)
> 
> Actually, with the other fixups, that works now too. At least in a quick
> test...

And no, it does not ;-). Will take a look, we're dropping page counts where
we should not be.

-- 
Jens Axboe

