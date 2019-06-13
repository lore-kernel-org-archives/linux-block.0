Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EDC31E4A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D2C2147A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="I2qiTsSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbfFMPsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:48:45 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40717 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731724AbfFMJSF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 05:18:05 -0400
Received: by mail-yw1-f67.google.com with SMTP id b143so8056427ywb.7
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C9W1Qz3t46bHMVmSJR2+Th4eAYsoKHPTPbwDTawPP+g=;
        b=I2qiTsSBPEyV0/Lsno96EJVy54JgU7rRXTF6gBm6YfEQBNiJ0NuoTeIzeEwjTGKZVH
         LQarNKf/eI8vSwZAP9Q5isCwAU2K/Pj+gkHPoByqBGWDKgE5ewlcfHKHTPmKn7NjXLzp
         4v5y7uWBIGLJj8gpL+CsSY3HneuHAwd3qsmx0IqU+PV9EW8xUOZW90K5TLLFAdRRASgn
         5wrUTCcHeqoi4/vy8bYBVwJ3AtIrzArHhvOdMQknAUCREtEwfHC2iQzUGvJyaiU4uW8t
         w/yCHHejnABB13Mgk1gIFPDiEagiVV3VL0geZ3KAC2s37kRkNAJIipNszhlzQwM7HLNg
         rQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C9W1Qz3t46bHMVmSJR2+Th4eAYsoKHPTPbwDTawPP+g=;
        b=XxiX3Z0I5G/XEuKe49YnFZHpIm4JIq79+VO9FjIxycFlNeGGpuvuONIlt7gTVNq3/Q
         3I3gDGGkDMzwF6gBxkHDsbyBaL3NJUQDI+pa9lm1OjEmIwPDk6IzrUKDsDHNEZCm1v90
         soel3ArqkdR8c2Kvb3rmZ0zUcvtaeapzmTvyuK3Gmaq5mlbzA+saHkFzH5VIIpcwcHkA
         /Wi+NIC5nabvTXtSFTfq8AgGNXPeHQs3acID7ef/NfLZVFx+BO6NmPBzAf7uCSM+Luhb
         GzKjfWvWWUzJpFMQDzFHPHaDwT2JHFzI3EuDsCrLmjiZ7Kx/j4DTcxEqiq4Jlj22H4TR
         larg==
X-Gm-Message-State: APjAAAWbYEFw8EWiSx7SBJR1XviIzd9JoaNbRSPSgLymvAPoWM1LzSIr
        l7zr/igCNApjuNCppe6EtRzBjA==
X-Google-Smtp-Source: APXvYqwmL3n0HHONOVIrGmXf0EeeQlTfYl4OpM4/4zht0ADZfJW4rn88VhBU/i0zBsitH+6xfnFUog==
X-Received: by 2002:a81:5e8b:: with SMTP id s133mr11254024ywb.149.1560417484508;
        Thu, 13 Jun 2019 02:18:04 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id f6sm629356ywe.81.2019.06.13.02.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 02:18:03 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix SQPOLL cpu check
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shhuiw@foxmail.com" <shhuiw@foxmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
References: <5D2859FE-DB39-48F5-BBB5-6EDD3791B6C3@raithlin.com>
 <20190612092403.GA38578@lakrids.cambridge.arm.com>
 <DCE71F95-F72A-414C-8A02-98CC81237F40@raithlin.com>
 <b3c9138e-bf3b-0851-a63e-f52f926d5ed8@kernel.dk>
 <20190613091430.GA28704@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6379ecd2-2a31-3362-6b1e-67913ba781da@kernel.dk>
Date:   Thu, 13 Jun 2019 03:15:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613091430.GA28704@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/19 3:14 AM, Greg Kroah-Hartman wrote:
> On Thu, Jun 13, 2019 at 02:54:45AM -0600, Jens Axboe wrote:
>> On 6/12/19 3:47 AM, Stephen  Bates wrote:
>>>> Aargh. My original patch [1] handled that correctly, and this case was
>>>> explicitly called out in the commit message, which was retained even
>>>> when the patch was "simplified". That's rather disappointing. :/
>>>     
>>> It looks like Jens did a fix for this (44a9bd18a0f06bba
>>> " io_uring: fix failure to verify SQ_AFF cpu") which is in the 5.2-rc series
>>> but which hasn’t been applied to the stable series yet. I am not sure how
>>> I missed that but it makes my patch redundant.
>>>
>>> Jens, will 44a9bd18a0f06bba be applied to stable kernels?
>>
>> Yes, we can get it flagged for stable. Greg, can you pull in the above
>> commit for 5.1 stable?
> 
> Now snuck in for the next 5.1.y release, thanks.

Thanks Greg!

-- 
Jens Axboe

