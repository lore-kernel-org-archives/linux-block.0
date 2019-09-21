Return-Path: <SRS0=12de=XQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17E6C4360D
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 23:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0AD20717
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 23:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Czj1aSCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfIUX3P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Sep 2019 19:29:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43187 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfIUX3P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Sep 2019 19:29:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so4831946pld.10
        for <linux-block@vger.kernel.org>; Sat, 21 Sep 2019 16:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U3WCGMIMBjZLay7FIwp6xMkZPcvA6SS/8hbGaRy4BMg=;
        b=Czj1aSCaL3GJtYtKPJlcL28OsVTza0DmUQArBcAX00zaRoLnqXLvEjUNa78hRKI+c/
         dgfTl0XVmJX1CGVE2+FLEqZhxKXnb53jawmXYeQ7vE5xc3Q4OOmrZTS2iSt4YUQUg2gW
         yN5cYTzVzg/gVqMTOrF5vFWH4Kc1eeG7xYx7d3yDbXd14sq+qMieXdykjk8gzA82NBmB
         Mvxl3nLB0pIfX2GsGtiRWJ8OOonNEOEkBxP0yEagpqoQLf/o3D/9Sd2hcvamB3y8Rp4Y
         jj+OrXHY57SZDwvrb8DhoASLE7GG6wo5Fmr7msiUHgj9smVIRQsITWm26ViL3dCyKq2F
         qESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U3WCGMIMBjZLay7FIwp6xMkZPcvA6SS/8hbGaRy4BMg=;
        b=EvcmqQk4pBy0l+jmP33eSDltAYCBSd7XUoFXY95i7rFEvZEEcz86Oam/V8q5ZiId2M
         EBAH9FzTzaqxi2rnkiFyAQQNrBeeFF7uBo5NPOzsssaSgnXjrR97RsmlhMgWqwMgVqK3
         JDfdr7fl7xQ2Dn13t/OZWk5z/bc4BYSY7SuhMJtmaSuW0ugbW8Z6A7iT/DaWOFMn62JZ
         W03s6KX+yDRUPYrK6tyD4pZFn79UcS5j0r6rqaas2b5AtCKUOlt6Iohquk71a5c9V3Hm
         0RjGDzIqa4/3mvm+Vt5cxMFIXpn0yKCb5poJDzdIL6HDpgMuFfLE8DJp55gqekX6Ad1y
         hSdQ==
X-Gm-Message-State: APjAAAVgti8NSlqJ3FiINi83+wT+haLpO3HNuokmqEQMvxNeCNJxdk8f
        oQJc7FAGlk/MyJzB8BJlm3nyrA==
X-Google-Smtp-Source: APXvYqy/88iFj+clk7Ev3DFK/RR+GNgIx4AHWgPNQ8yC6RRK9lZZZgsGg81KykPEtcrYoIrxLfD/ew==
X-Received: by 2002:a17:902:7244:: with SMTP id c4mr24096125pll.178.1569108553101;
        Sat, 21 Sep 2019 16:29:13 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c8sm6900041pfi.117.2019.09.21.16.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 16:29:12 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: add default clause for unsupported T10_PI
 types
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <1569103249-24018-1-git-send-email-maxg@mellanox.com>
 <6e99fefd-ff7c-e3ee-087c-ed42baa7f4f5@kernel.dk> <yq1tv955kfy.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0505439-2bf3-3297-2e8d-5cc0b24cafee@kernel.dk>
Date:   Sat, 21 Sep 2019 17:29:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <yq1tv955kfy.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/19 4:54 PM, Martin K. Petersen wrote:
> 
> Jens,
> 
>>> block/t10-pi.c: In function 't10_pi_verify':
>>> block/t10-pi.c:62:3: warning: enumeration value 'T10_PI_TYPE0_PROTECTION'
>>>                        not handled in switch [-Wswitch]
>>>         switch (type) {
>>>         ^~~~~~
>>
>> This commit message is woefully lacking. It doesn't explain
>> anything...?  Why aren't we just flagging this as an error? Seems a
>> lot saner than adding a BUG().
> 
> The fundamental issue is that T10_PI_TYPE0_PROTECTION means "no attached
> protection information". So it's a block layer bug if we ever end up in
> this function and the protection type is 0.
> 
> My main beef with all this is that I don't particularly like introducing
> a nonsensical switch case to quiesce a compiler warning. We never call
> t10_pi_verify() with a type of 0 and there are lots of safeguards
> further up the stack preventing that from ever happening. Adding a Type
> 0 here gives the reader the false impression that it's valid input to
> the function. Which it really isn't.
> 
> Arnd: Any ideas how to handle this?

Why not just add the default catch, that logs, and returns the error?
Would seem like the cleanest way to handle it to me. Since the
compiler knows the type, it'll complain if we have missing cases.

-- 
Jens Axboe

