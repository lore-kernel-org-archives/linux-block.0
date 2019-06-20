Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D02C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7C920656
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="buepTK4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfFTJU2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:20:28 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33778 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTJU2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 05:20:28 -0400
Received: by mail-yw1-f65.google.com with SMTP id v15so255791ywv.0
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M2ZK4UAkDUucjPPUBXrK2NuaT1Fzx4gqYqOHCxJSRkg=;
        b=buepTK4TqojVJ4cAAmwEwombFn5o/mznfJ2uttS0nkIhVptdBWma//WNrDbauwOBtI
         3lE+MHXXzeKj7I4gL/WQ/v3eIrdTkxoSQd7y3LlzLosysah0Ii8E6e0zINrRC2GSh41M
         eqCT1E2KrbOl3FuIjA9cRDu+VDB80zHkNobbG5Vus5Nygc/9uHbFdhmHVoKNxIfB/OXI
         igSCk6aYOMXJFkCBngloBPgNjh7hHVFGj5lroWyzYx81y1sYpo9etfXe6GdUwC/54pPS
         R1LX2BMy7Wkc1nAoNGPSyQ0xh5ndBjSowUD/zxfPJjb2L8tiRvaFdCYuHYc+BozrMZnt
         gU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M2ZK4UAkDUucjPPUBXrK2NuaT1Fzx4gqYqOHCxJSRkg=;
        b=BDwaijCStw/KBQdiKQLbXvglSQNl7GAAieXUs9sRtvPm5x+wPOMccdfdnCDfgk5g9d
         6FmmPOMB46WN+2CCQbHWLYMSE2W0Kz3zpGalTMz61tGHlUQlJ6YfBgzMAWQgX6cS2XKR
         DlHYnH6ufzmP+a8Ioa2lg7pU/9MYzsccRWygLrxOA5EEvL6yvJjaX01vI52ei1w5VFTO
         /U6xojJg/v7RuK8LAxSCEP8zhZVW3X2o1ggt5VVcZjnDk9eWtqGY/exoODo14F8RNEv9
         4uWPCr95rkY/tPSnQar/ftG2vY7qmDiHpw+ZNL599L7GwNaovC59taU1mInZM39hBJyt
         tgFg==
X-Gm-Message-State: APjAAAUA3/VyXKcYU6WQY+sq4tOtUTTioQaKGvC8FGJESKWV7bzPLIX6
        O0tBOupb/Qk2tNRNzLExB13WxrHDcNzyhlNU
X-Google-Smtp-Source: APXvYqxQfjMSnQEMoMtZ0ivlEEQllsF24EvVoWdFT9RlSnC9AQXCjypMj450iRFymwHw9EwMQFhp+g==
X-Received: by 2002:a81:8745:: with SMTP id x66mr24274551ywf.75.1561022427151;
        Thu, 20 Jun 2019 02:20:27 -0700 (PDT)
Received: from ?IPv6:2600:380:5278:90d8:9c74:6b59:c9f5:5bd0? ([2600:380:5278:90d8:9c74:6b59:c9f5:5bd0])
        by smtp.gmail.com with ESMTPSA id s8sm6433645ywl.58.2019.06.20.02.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:20:26 -0700 (PDT)
Subject: Re: [PATCH 0/3] block: small fix and code cleanup for
 blk-mq-debugfs.c
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20190619220150.6271-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf3b978d-7763-52e1-d490-be3e0f870247@kernel.dk>
Date:   Thu, 20 Jun 2019 03:20:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619220150.6271-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/19 4:01 PM, Chaitanya Kulkarni wrote:
> Hi,
> 
> This is a small code clenaup patch-series which also has a fix for
> using right format-specifier for blk-mq-debugfs.c.
> 
> Please consider this for 5.3.

Looks good, applied, thanks.

-- 
Jens Axboe

