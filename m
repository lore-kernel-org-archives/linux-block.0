Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9108EC4CEC7
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579C2208C2
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 20:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d80TQgqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfILUra (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:47:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41178 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfILUra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 16:47:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so16693881pfo.8
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2019 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a4mjeQQKYYsAEHRe62Tn5jyyKp7ZY1L4vu+tMU7d9HU=;
        b=d80TQgqfK4cHfg9+gVMc7hV9UgbZIljwpl6Xv9Evfnq7YEA3JaYN6JYXwqP11HpMkS
         UrPZMQE3yiBee7WRhJLwS9TIYhGTlhzjl1+IRp+2mRg9EYu54M27GQkvppXrC3TsM4xR
         X2NPuiB0sSAeN/GrYkZJEck/7TxK5X/J+byXrOhQ2Fu/T4Abdt4GC0EbUpzPDuZDh0R+
         MSRxVIIrVJn/uYy1NdL2WGm+iO2RpDFKMI0SCa9nba3EbNu5jhg0S8oPL38trmL+JyG2
         ma6o6aaCNjp+tUHiZilDkzy6qZ8si03a9OrXFnjplwofEJYd7nIREZLI4bqBTHgxYFDP
         qYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a4mjeQQKYYsAEHRe62Tn5jyyKp7ZY1L4vu+tMU7d9HU=;
        b=FyCuZ5zcwOe+vDW+PrcjtsMDfVLWM1t1A4vOlbD00t84FVjzXbb/PQ8t18CgqxaJjW
         3YrY1GeYXUL7CH/Pv/Xi2DNr5yGrhpV416rlzqX9DglLoyCBlYNqxzbqjV6DAZx59OU7
         YhDKza1vxJ6SnMAgQfHnl7v6EfbGQBAHBTj2SDOsQOxrN5PIZhHuLuonH3Axt4uZv4Wr
         8BfmVvrptakxknSFAZy27BPRtKPi+hCe79q2XrHpMmz7Th3FbNjk6kBxbC6qygN4KZAp
         xC4MpMQ6bCBDCJxthqM8anftQbOGyE/VzCxPspqyx02eScsYRxYdy4ynN280K21dbA1k
         riPQ==
X-Gm-Message-State: APjAAAUoVH+l/HFI1iZuTFVyIOPpVu5sWZEghgDoVa+BGLwTfrweIglw
        lF4WI4jYvKZ1cF76Et6yHUzClQ==
X-Google-Smtp-Source: APXvYqyw2NWXS1KhomCFyvlNvxvHaCSLRQk2bDfzgHtr0kgczhu2/HCHbp23IYljQWA1NztJee7/rQ==
X-Received: by 2002:a17:90a:d351:: with SMTP id i17mr663100pjx.13.1568321248398;
        Thu, 12 Sep 2019 13:47:28 -0700 (PDT)
Received: from ?IPv6:2600:380:4b35:ccb0:f0cb:c243:15f:c2c0? ([2600:380:4b35:ccb0:f0cb:c243:15f:c2c0])
        by smtp.gmail.com with ESMTPSA id j128sm35430292pfg.51.2019.09.12.13.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 13:47:26 -0700 (PDT)
Subject: Re: [PATCH 2/3] null_blk: fix module name at log message
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, m@bjorling.me, kernel@collabora.com,
        krisman@collabora.com
References: <20190911144636.226945-1-andrealmeid@collabora.com>
 <20190911144636.226945-2-andrealmeid@collabora.com>
 <a02d9e6d9c13a607bc08b71a5d5f6c2039f1c279.camel@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <943a2fc3-4812-cc41-bdff-be13ec319257@kernel.dk>
Date:   Thu, 12 Sep 2019 14:47:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a02d9e6d9c13a607bc08b71a5d5f6c2039f1c279.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/12/19 9:47 AM, Ezequiel Garcia wrote:
> Hi André, Jens,
> 
> On Wed, 2019-09-11 at 11:46 -0300, André Almeida wrote:
>> The name of the module is "null_blk", not "null". Make `pr_info()` follow
>> the pattern of `pr_err()` log messages.
>>
> 
> Instead of doing these fixes manually, it's more consistent and smarter
> to use pr_fmt. There are many examples of drivers doing that.
> 
> I don't know if this patch can be dropped, and replaced with one used pr_fmt
> or if doesn't worth the trouble.
> 
> It would be even better to also patch Documentation/process/coding-style.rst,
> in particular the printing section, making a mention to pr_fmt.

André, please address the comments in this email and from Willy. Note
that the previous patch is queued up, so you'll need to make it relative
to that.

-- 
Jens Axboe

