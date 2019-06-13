Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A34CC31E49
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D395820851
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fXL4Bw5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfFMPxq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:53:46 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42028 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbfFMI5I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 04:57:08 -0400
Received: by mail-yb1-f194.google.com with SMTP id c7so7514949ybs.9
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5rpwm+WXYqpS5Yt4a3EFiaLIxY1PzE0lEAcH6B/6h0A=;
        b=fXL4Bw5Kwl/mMKIWGa1cdKDK4KAo0XR2yGRH64ZJ/I1MVExg0wWUUDX3vBHTYZkjOF
         vYFKvyecLJNLSA/E7m7sTD8zh55AOz/agx/OfhCByMjAe9qffdMIJXqrpeOoxi+v3NkU
         sXmf687D6xOZ2qyVaV0Av3gvkn68lJwqr/d2PEpnz/YSD7pg1u3UtvyzLDx4Mi3w75OR
         HJJI+g/bVt6L2m1CG0hBdOwJes2EebjVxjs/giB7QyWUieZGe5ei2HyxPmHI0pV+dWgb
         1hEim2OLo6wzfu6Jcv47M0Q4ZvWL5BNXddHdsTUs3Eu/hfMQJY2po5LVVP9PbG0vjMfb
         rW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5rpwm+WXYqpS5Yt4a3EFiaLIxY1PzE0lEAcH6B/6h0A=;
        b=ap5F9+NCY3AwGq7cC0BvMNOw3Rvnk1kdiw0VkjefikFZoFXg84A4KWNplhMlKtJtCD
         mNkWhpvfKnBXbNLE5WsKpt2qYhVz9ZV5QwlfOMKAo1G+JT9uW58TKblcZQ6mNCf6sEvg
         Faa5RwZKsdADaA97bEi7OZ2ZyyWXLyXMMTSjINkUZyocd7u65MJP0X6lsc1LxQWuwu+5
         P25gd7HcNTHXiJ5V9EtaBKYvF6rlfnTihqWGq72F8yAc3D6E1enrGOQ1tz9vaiQ95akU
         J5UQO4BbZs2+iRP0G9RDcj6LFtsvvgpuh4Kdz/uSMEI83yR4/dTio/xD+n9oy3YsEItT
         WAqA==
X-Gm-Message-State: APjAAAXupYi0OCJmscq3rBiddT6/0qJY0NslwmFvRLFZR/GN0hvYD6fl
        0f8cGt2iFSMMdQkLl8OBAFK4Zw==
X-Google-Smtp-Source: APXvYqw1zJomCCuCV1QnOnfqSwphH8qY2fZ84XDZGajBAG2kedoKa5gZ+d1vm3seCvUptjeuiel9rQ==
X-Received: by 2002:a5b:b8b:: with SMTP id l11mr40277348ybq.165.1560416227034;
        Thu, 13 Jun 2019 01:57:07 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id i199sm607899ywe.89.2019.06.13.01.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:57:06 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix SQPOLL cpu check
To:     Stephen Bates <sbates@raithlin.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shhuiw@foxmail.com" <shhuiw@foxmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <5D2859FE-DB39-48F5-BBB5-6EDD3791B6C3@raithlin.com>
 <20190612092403.GA38578@lakrids.cambridge.arm.com>
 <DCE71F95-F72A-414C-8A02-98CC81237F40@raithlin.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3c9138e-bf3b-0851-a63e-f52f926d5ed8@kernel.dk>
Date:   Thu, 13 Jun 2019 02:54:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <DCE71F95-F72A-414C-8A02-98CC81237F40@raithlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/12/19 3:47 AM, Stephen  Bates wrote:
>> Aargh. My original patch [1] handled that correctly, and this case was
>> explicitly called out in the commit message, which was retained even
>> when the patch was "simplified". That's rather disappointing. :/
>    
> It looks like Jens did a fix for this (44a9bd18a0f06bba
> " io_uring: fix failure to verify SQ_AFF cpu") which is in the 5.2-rc series
> but which hasn’t been applied to the stable series yet. I am not sure how
> I missed that but it makes my patch redundant.
> 
> Jens, will 44a9bd18a0f06bba be applied to stable kernels?

Yes, we can get it flagged for stable. Greg, can you pull in the above
commit for 5.1 stable?


-- 
Jens Axboe

