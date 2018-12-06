Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEFDC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8340C20868
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pihvYK5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8340C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbeLFTnC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:43:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38122 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFTnC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 14:43:02 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so3397087ith.3
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 11:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5MUMEi7zu0YmJoCgXYMz6CuFfgMJhsSYdfj4OTTyE68=;
        b=pihvYK5RnBmvoMUliduZzkEf1wvO0vYP+LsTopm4sWhGQ83tour3iCs7SajecmzXdB
         iKUnEjymiqywl3PJbnH6G6+1vBs+BDu7nsogdNpz3msl6MkHetX+msJlfBaLT5aqKstp
         jA3QINLz2VMYtisASoQWFkxHUTK9RuyxzsHWVySU5UJeGM9eKrm1Y5+XyOvs3+zJdYDP
         +33j6jQt3iiaDtd3nhl8V40N1adCBBkgjAwYNwnjM7cTdaPEjayEApUayMkLYi3gkJz2
         ZPKt6nELSRqkQHPc+jR2AnAQ1p8lL4+drbmmZfuiVlxscJDvwCCXUPBl7RG+b4Pv8b+g
         9jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5MUMEi7zu0YmJoCgXYMz6CuFfgMJhsSYdfj4OTTyE68=;
        b=n14lbG64sYu1D1AXP6e0VWLrjyf4t1U53/PWs2Qj2JsaVESJbXKqii4eeNgrjv4GAm
         FH7OBvJnH4NSLSlM1yVVOKcb3XGnQh94JEJK3hQd1STzJ0p6pQkZZUuC6KsmMdpNg3i7
         7zf+HHp5rgCLJzAhHF4BGwnQoe2m4xIgEYfw0LJGrhm5u72zmpiiekLsuJFiCb+VwBsT
         ypQ5uzSN71KqqvN9cb18MGqymrKkREi8V/WJv7fT9Md7c0kiMETNc29VwjlkUZc5c2lJ
         XXgss6F3ICtsAaLQbQ8jenMHdnY5nweYA5JFSyiPDfiWqXfcIdHIRC/vGivqUE+v+0L7
         PZMA==
X-Gm-Message-State: AA+aEWYhN+2vMFxYanF5NNtYTYXIaHVfAmC/D6UaVNIeuyv5j2j6kNmr
        AlM7v3pAWbCCxrT9bikauK+oqA==
X-Google-Smtp-Source: AFSGD/Xuf4ho9sR4vB1w/G5ruLXX0e6hUs3bptpyJzDX7VMrHBW0Soy8amjqb0tDZMMAyY7BVgSI2A==
X-Received: by 2002:a24:af07:: with SMTP id t7mr17134057ite.168.1544125380694;
        Thu, 06 Dec 2018 11:43:00 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id g10sm478496iop.25.2018.12.06.11.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:42:59 -0800 (PST)
Subject: Re: [PATCH 08/26] aio: don't zero entire aio_kiocb aio_get_req()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181204233729.26776-1-axboe@kernel.dk>
 <20181204233729.26776-9-axboe@kernel.dk>
 <x49y392fobn.fsf@segfault.boston.devel.redhat.com>
 <99b52953-091d-007c-43aa-41198b0ed747@kernel.dk>
 <x49pnuefnt0.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <72e91bed-b135-2d6a-c26a-bf65afed990c@kernel.dk>
Date:   Thu, 6 Dec 2018 12:42:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49pnuefnt0.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 12:38 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 12/6/18 12:27 PM, Jeff Moyer wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> It's 192 bytes, fairly substantial. Most items don't need to be cleared,
>>>> especially not upfront. Clear the ones we do need to clear, and leave
>>>> the other ones for setup when the iocb is prepared and submitted.
>>>
>>> What performance gains do you see from this?
>>
>> Before this, I had 1% in memset doing high IOPS. With it, that's gone.
>> 1% is a lot, when you have just one thread doing everything from submission
>> to completion.
> 
> I'm used to customers complaining about fractions of a percent, so I get
> it.  :-)  I just wanted to know we had some measurable impact, as I've
> seen bugs crop up from code like this in the past.

Oh for sure, I wouldn't do it if there wasn't a noticeable gain from this!


-- 
Jens Axboe

