Return-Path: <SRS0=S7xR=XV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2F7C4360C
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 11:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41967222C4
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 11:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ps5n17nT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfIZLmP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:42:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50772 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfIZLmM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 07:42:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so2391679wmg.0
        for <linux-block@vger.kernel.org>; Thu, 26 Sep 2019 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xonFLYW+K9R2/V+E4nxIJtaZUYsUbdcdHfLF2kKtcoo=;
        b=Ps5n17nT4qWciZsC9oJ6IGnJHFHbWG4ZlXnBU/vo5CoFtTTcFz1daOUpKD/ipU4JTw
         ihs76iwMZ80RxUQMFVHFi5rvs5M1rcujs9NFUDyQiF6XVkF7SXmgG5B5WQ8wviB0n/0h
         viAE+GuDsrSXXAsyoxOa/u6wTXedWKEzGWG5iTpCje/HyXMDQP1QKsdJjeT8SaTNVvM9
         i5p1PVAP4pUIcDVmmC2qPUG+ZcG/GbmHpma7NTM9SxfdP5B5FUU7xlF/mHrARsTiCPop
         zVz4CSRj4Q1mP/877rHOBVyN5jMUa4ylMJrwXwyxxRAIiR9nZ+CFHeifrJsIveeE+ygL
         45Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xonFLYW+K9R2/V+E4nxIJtaZUYsUbdcdHfLF2kKtcoo=;
        b=CCLp+uXCspdzlEmyco9zxJjSMGQomh994m8U3o+2Uhx9gyucvjxC7lwOFjW/CzU9yO
         aiUxPGAm6M12MdEPNwZVBp24MwqhLYd/GiuYCVXGTsNthLgpQEtk4VE73HYjtB83v6L6
         RF7s4N9iQrRQhG67tp3cWmUchoc9pi2i5CchWpsITkeyXHaXJP/C6yR/kVABZA+TFfTX
         y1Qf0XJHSVLPebWPQ/dUKrvFHMx/h2a+KJBc5j6n9f/HPRpTHeiJ55fhFRX4jNKGkhpD
         kveVIn2wGUTXFuuq8Y25nzTOu+MJpapKoxr9926PUmwGAf54NYJ2miA4gKBtVkcWD6j6
         WZBQ==
X-Gm-Message-State: APjAAAUBUsEJbm8Ru/y2AIiD5wa+hZ9Z3wJIhpQRVX7J/H3gUzqvUXQc
        bN7x9pfJ5OsKOxF6SOIpBjeFBQ==
X-Google-Smtp-Source: APXvYqxnyNJu0dpuhkbD8V2MUn3DG+U46V6RIU4ma0y5/B8D4fyvBCvbpFOmizCk0WSq3Se6YEHEdw==
X-Received: by 2002:a1c:1981:: with SMTP id 123mr2593496wmz.88.1569498129864;
        Thu, 26 Sep 2019 04:42:09 -0700 (PDT)
Received: from [192.168.1.145] ([65.39.69.237])
        by smtp.gmail.com with ESMTPSA id s12sm5719744wra.82.2019.09.26.04.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:42:09 -0700 (PDT)
Subject: Re: [PATCH][next] io_uring: ensure variable ret is initialized to
 zero
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190926095012.31826-1-colin.king@canonical.com>
 <3aa821ea-3041-fb56-2458-ec643963c511@kernel.dk>
 <20190926113329.GE27389@kadam>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04262621-68fd-a4bb-ab0c-83954c03fbb0@kernel.dk>
Date:   Thu, 26 Sep 2019 13:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926113329.GE27389@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/19 1:33 PM, Dan Carpenter wrote:
> On Thu, Sep 26, 2019 at 11:56:30AM +0200, Jens Axboe wrote:
>> On 9/26/19 11:50 AM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> In the case where sig is NULL the error variable ret is not initialized
>>> and may contain a garbage value on the final checks to see if ret is
>>> -ERESTARTSYS.  Best to initialize ret to zero before the do loop to
>>> ensure the ret does not accidentially contain -ERESTARTSYS before the
>>> loop.
>>
>> Oops, weird it didn't complain. I've folded in this fix, as that commit
>> isn't upstream yet. Thanks!
> 
> There is a bug in GCC where at certain optimization levels, instead of
> complaining, it initializes it to zero.

That's awfully nice of it ;-)

Tried with -O0 and still didn't complain for me.

$ gcc --version
gcc (Ubuntu 9.1.0-2ubuntu2~18.04) 9.1.0

Tried gcc 5/6/7/8 as well. Might have to go look at what code it's
generating.

-- 
Jens Axboe

