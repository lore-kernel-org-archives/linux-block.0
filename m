Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA49C433FF
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E0221479
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NXyWjVYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbfHHNcX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:32:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39363 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733072AbfHHNcX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 09:32:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so40128440pfn.6
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K90bXxKtwMdSHHVI94+y31QoTgVZf3bBjn6Nuaw0xTk=;
        b=NXyWjVYQzbaz8nyCohCw74QufpVP+/RLKhPR5vDT1hQDx0g03eK7roGny2FBnhmTtj
         EGQadXPhj0dB1M1OMLV7CIltECIfxI2oBqAjL86PsWvGCUqTszXMIhys4vOvGyPCfv8/
         3uRmuZzP7R6+hVBXLrIomW+NOU7i43/tCOVoISWbFADwud1ovZWV+LG4y8fT9SPRLW9T
         TqaJQ1Ntm4Z+qp2qxEg8nRjMeTKMYPIIS2odykcb+KcyRygjF2/pDPlHx5hEKeBQD461
         4QuxSd3xo2NrqVkBF5YrE8r/PYSrMi6EGyqY8dK5XUFnOgWiIIXqqGiiM/KdoSHupfBm
         snPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K90bXxKtwMdSHHVI94+y31QoTgVZf3bBjn6Nuaw0xTk=;
        b=VTS42ZpWeyE+biH70ogc61zLHou8dq6aOg6kz/O5XwFZNq8/w0dlWhR0dx8f6jf8Xw
         2ykZEeVXuPLXyfC4M9IfeuLXxcy/B9In/ATeE/tcDkzetnJ0CuIZ6MGTpIzdUejEGSPM
         oikwWSDMak3/DSr+ckB0wJCa3JKbcB5hZE9Q2XFBq6u3oJ8JpBedI1TxFpFHgMqPhtxQ
         TdIMo7JyRU1ZoqlCp8Sz9ln34z9DbovPCBgUMc9vgUtOtIZt01dR2RsQhgvccZYk4X2l
         Rh7pjkNWrz/8OpiDg7/fkXh+XMlOQUqBBCOH+FYUShZuaGKgE+58VcRsI5Dc7TeOVHzw
         e9xQ==
X-Gm-Message-State: APjAAAUnCjpLP6vnFYMDIE4s7OGRSYKKXzf9bd9ggDpFfbbpzIeKYm9I
        Ve8NBAie1s3C2MfF2fQ9u9xm/g==
X-Google-Smtp-Source: APXvYqxz+cV93HB9DiXa7nRKr4ie33O0u2MF/MAijDLTrHSjVSk7Y41IL5Z0WdgSjT1lL6DjHMvSbw==
X-Received: by 2002:a62:770e:: with SMTP id s14mr15028941pfc.150.1565271142654;
        Thu, 08 Aug 2019 06:32:22 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:186c:3a47:dc97:3ed1? ([2605:e000:100e:83a1:186c:3a47:dc97:3ed1])
        by smtp.gmail.com with ESMTPSA id k25sm80307167pgt.53.2019.08.08.06.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 06:32:21 -0700 (PDT)
Subject: Re: [BUGFIX 0/1] handle NULL return value by bfq_init_rq()
To:     Paolo Valente <paolo.valente@linaro.org>, linux@roeck-us.net
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20190807172111.4718-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba544c8b-58f5-4c60-2d11-1277179bb263@kernel.dk>
Date:   Thu, 8 Aug 2019 06:32:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807172111.4718-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/19 10:21 AM, Paolo Valente wrote:
> Hi Jens,
> this is a hopefully complete version of the fix proposed by Guenter [1].
> 
> Thanks,
> Paolo
> 
> [1] https://lkml.org/lkml/2019/7/22/824
> 
> Paolo Valente (1):
>    block, bfq: handle NULL return value by bfq_init_rq()
> 
>   block/bfq-iosched.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Jens Axboe

