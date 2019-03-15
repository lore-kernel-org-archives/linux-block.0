Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF5CC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491A8218A1
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l3voeamv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfCOO3f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:29:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43262 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbfCOO3f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 10:29:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so6465836pfh.10
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GhZ6JEqM6OGPlOqUafs+5RJ8MCNfu/6ROv/YnY68g88=;
        b=l3voeamv6jZGeOAGko8E4Eje0cjk9b7t/1+dPYeHM/aHRf3+aAu8dujyEp4/C08XTW
         D9ykaaQzm84JoVzJvzn416WhF9zux+sxDyWyxRNHMX7K1dZj3uV7JOjmSLqS8d9DDVaF
         gkLRUjB41GkDdsomUWXZVHoZ5KbFS9n6SZye6IIfqAUydQYR+ZI9f0t6t43NiKwwep8i
         KUWZ6qBBtMLGFACzx8LP2qUGkg7grxwl+fbqzDpHRcpmpPqJLuQCQb3FcjtyxHIxg61h
         Zb1CSDeRdFg3kKX6ZG8ZeUR87nu1Qu0PrmQqpT8siYDJrz+pohTI9CpiEfRwDWXgTDN1
         tJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GhZ6JEqM6OGPlOqUafs+5RJ8MCNfu/6ROv/YnY68g88=;
        b=jmbOtSAEIKLEun8nWsf/oSvmtcSdlvdHrI75Ajgx7DtwAaZmK5i0YXRnvyEQEm7OxU
         XyOS/EABdU5K5ZgJzG4xpv03FVY2y1076KFWJ7FQVLhXPOddVZ4zwOGYHzsDSOdVxkcB
         cHMx8gao2CKYhahkpYI5BsbhV1PUjaw5j8D/Tc9n5+3tguGBRgiaIbVxy9NpE09xNhRp
         UWAiS3E7v9RzfFhZMle7NVtsRkVA0FMaQjDLMyFmI6GhTLukdrqXVgowtWswh+W6tgyO
         YXsYmY3qE7vyASQdHUAfs/mP+xwGeaL+j5D2LX/dR4xu1APIQF2l8DJqYrnDkGxCZLxb
         sMnQ==
X-Gm-Message-State: APjAAAXq38ZREpHr4uAMBPY6ZCo0JGnuQeT7/jKCl/jXB2DL8PZndQtF
        4pBg9dCSqmkx7Bt4TQxienCG1Q==
X-Google-Smtp-Source: APXvYqyU4jUhYK9pYl664Tk5wLKreFCTSie4+jQ6+syEDDg8614DQxZ9qdrPxY1C0lxzoD7IVXAzMQ==
X-Received: by 2002:aa7:818e:: with SMTP id g14mr4305675pfi.245.1552660174267;
        Fri, 15 Mar 2019 07:29:34 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v1sm4036969pff.9.2019.03.15.07.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 07:29:33 -0700 (PDT)
Subject: Re: [PATCH 15/18] blktrace: change strncpy+truncation to strlcpy
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <1531445162-19771-1-git-send-email-asmadeus@codewreck.org>
 <20190314213721.339979f0@oasis.local.home>
 <80ab6751-cd34-1da6-91c7-7558d3a17943@kernel.dk>
 <20190315063022.GA12910@nautica>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <85f295e5-d338-100b-16a6-45e28d292388@kernel.dk>
Date:   Fri, 15 Mar 2019 08:29:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315063022.GA12910@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/15/19 12:30 AM, Dominique Martinet wrote:
> Jens, Steven,
> 
> Jens Axboe wrote on Thu, Mar 14, 2019:
>> On 3/14/19 7:37 PM, Steven Rostedt wrote:
>>> I noticed this old patch in my inbox. It looks like a legit cleanup.
>>> Want to take it?
>>
>> Indeed, I've applied it. Thanks!
> 
> Thanks. I am terribly sorry about this patch series to be honest, I did
> not prepare it properly and sent too many generic patches at once but
> more importantly some were unsafe (strlcpy expects the input string to
> be validly formatted, because it basically does strlen() on it to check
> how much hasn't been copied for its return value)
> I was pointed out strscpy instead as a safer alternative.
> 
> In this case `name` comes from bdevname() which is disk_name() in
> block/partition-generic.c which is a snprintf, so we are guaranted
> null truncation from there and it should be OK, but I wanted to check
> and point it out.

Dropped.

-- 
Jens Axboe

