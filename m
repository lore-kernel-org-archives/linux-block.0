Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E683DC43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 16:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58BD20643
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 16:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L5Y+d1Ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfCKQp5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:45:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45115 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfCKQp5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 12:45:57 -0400
Received: by mail-io1-f65.google.com with SMTP id x9so4606553iog.12
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2019 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h4+puBwKRbj1Pw5SHsxrXcP8QFBvVhfaFAy/5DxU7ig=;
        b=L5Y+d1Ug+gV/CTnuHGEEMY0xXL69qqJp40N7MHA8g/oPYXhQX/JtUPiwozoFJGlXUM
         GTdtq/ADBTBLmbXAew0Yi7x5Npr/ddz97LZUicdmfFjRi7XzuIv1HBtLxYEAKgL4KaWp
         wneM/cX9WrJeIGr0mQjgxL3byNtwHXMfpraWzAfeZO4ntI6vh1AF08nwHq8M+0ytAQ0C
         Rq4y27huKbsNlIRCH2lzzK9U9tPLoutpMseifOKYMToKM80tUNv7rE9fPU8PGxJzPA3Z
         HahEGYBH0kAhs0ZUfvIYI9B7CGUnMTe8Cy6+NkpPqsW8kLxjWS8j2iN+BctR51F7ykra
         oVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h4+puBwKRbj1Pw5SHsxrXcP8QFBvVhfaFAy/5DxU7ig=;
        b=hzdHp1QDwAXxk+8S+xUKCtjSPgYnLICou9yLTGuMv1Ba7GcbQKWHrv59KWYt08J8Wl
         kXXM8Bc+dqNTtEeSD1SaHbcvVQ4lhqhfigqJgW96hd1v9WDVPsg8iJWWD0nqrfQs5bNy
         hmSaZCaCiRJ49JUb2gkREgPzZG9oXVcmyTcKNDbuayOYaDvtfJPOQiT+NABRXalHmx6f
         glxtzIHajakUAXIPAbJ6fyFCstdH9FmHsPcZoihSl1YLJDItAWttYch4lUMyaih0rC08
         2J65Rbx4XzLbWBiiOKoHey3BkSMiuz1QbdhCTMUw4H8ti7e+SzpGgNT58gbBUpZB7eVg
         H2pA==
X-Gm-Message-State: APjAAAUHxO0hVz3QH5meFNmTJR8P/HJnckSEG+JTa2jl3aBWXes6wshB
        empn42HAfSxAR8qYCf3lbCsKe6iugMgCZQ==
X-Google-Smtp-Source: APXvYqzIXkcusullVtByw1dnHGDpgZCisTQWz/yS1Trbd8tcFzYTOeaII5mLnWAgdHnOk8TvOARz4g==
X-Received: by 2002:a6b:fa11:: with SMTP id p17mr7978032ioh.185.1552322755407;
        Mon, 11 Mar 2019 09:45:55 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w189sm61611itw.0.2019.03.11.09.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 09:45:54 -0700 (PDT)
Subject: Re: [PATCH fio] t/io_uring: add depth options
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org
References: <20190308215959.5575-1-keith.busch@intel.com>
 <05f6756f-2298-5f88-1f44-6c6d11a82e29@kernel.dk>
 <20190311164444.GC10411@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6548644c-0652-0539-736a-0e0d12f2d329@kernel.dk>
Date:   Mon, 11 Mar 2019 10:45:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311164444.GC10411@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/19 10:44 AM, Keith Busch wrote:
> On Fri, Mar 08, 2019 at 09:31:02PM -0700, Jens Axboe wrote:
>> On 3/8/19 2:59 PM, Keith Busch wrote:
>>> Make depth options command line parameters so a recompile isn't
>>> required to see how it affects performance.
>>
>> Thanks, everything really should be command line options. But I never
>> bothered, it wasn't mean to live this long :-)
> 
> It's a nice convenient way to do some quick and light benchmarking,
> so we've been finding it very useful.

Yeah it is, which is also why I've been using it quite a bit. Quick
and easy.

> But I totally rushed this patch and just sent it once I heard it "worked",
> and it really doesn't because malloc doesn't zero the buffer. My mistake,
> kzalloc spoiled me. Here's the fix:

Applied, thanks.

-- 
Jens Axboe

