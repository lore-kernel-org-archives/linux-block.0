Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A637C32755
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C7220835
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 14:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mpGjQoge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407467AbfIWOFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:05:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43337 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404990AbfIWOFx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 10:05:53 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so33629071iob.10
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2019 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G7YBYmECKI/gBoDO5nAZKZwYRyMYNEVEhyIASOovv84=;
        b=mpGjQogeI9U8AI7awnhSZdCM0EQ1pdVBMqn6L8SYnGQPh+XFlSfyuNdoRc/xkucca1
         9tKiyJ8ceUx47+++EK3fao6hiccSS/Q5Ae/SlJpVwoS6vriRK5F1ZMIvJo5nCkZIuOYX
         BDN32je/8OysKwqCR+2zVyBD4Zq9r51PKVKAk/yV5H1ker7sDqNI/X6DxuHpi7dYY14G
         XLYKXijrO4jeUoLHqmEFHFvuduiYkWi8IT1MlSIl3rtm9ISKkm/fIZnrLniyfqvV/OmN
         9enXOCiXhjHagfm838YZGixZWMrOLhlrEzPC+aydXsZJxMUDz6h9VBGF2eO0xTBXvxXv
         88Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G7YBYmECKI/gBoDO5nAZKZwYRyMYNEVEhyIASOovv84=;
        b=EFKOKUcOqgmCc1T4d1mdK1Vc/iOT15HEMqsxhAnyg/mjAP/azyG2fmYVM5xQnhZqUb
         OS472CwT4TmbXo//FiA0ar9ltPlrNYJtw7gmIiJzMRbZ3OBfqNTEIWHQl5UyajQ7kt1B
         F8IQKGkN5n4MkPNvL7dgjJndDvi3jp2LCBtYflqFK2aaeSEzbjafklY3T0Ot1e3zjb/w
         mj2JN+0DLM1IVAuLtU2Dr9AKaUb6/+mP1gtN+utbOzjar6JwmuH9hbFGRzaJOyxzUKuw
         F1SoK6HNP98G3ZAGnwPu15kV4vBemxXtFaLKm3I5NeRldNo8mDLIBzMEyUSE4gnLEBF0
         JPQA==
X-Gm-Message-State: APjAAAUHfz77fso4BZ6RWDYkZOou7fVH1qRgBHbcwXaUU+oByDHOx7UH
        WNaFY0fvxcE0jAXUsQPh/CVxRGBQsj1jJw==
X-Google-Smtp-Source: APXvYqw48H7aH8sBx7zjMV0bKT2krIn87gYu5IDwuQ6tgB32HXgm0MnB6eZM7BOC8ZsVsWGDImKpmA==
X-Received: by 2002:a6b:ca47:: with SMTP id a68mr775391iog.110.1569247551641;
        Mon, 23 Sep 2019 07:05:51 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m11sm9196955ioq.5.2019.09.23.07.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 07:05:50 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: add default clause for unsupported T10_PI
 types
To:     Max Gurtovoy <maxg@mellanox.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <1569103249-24018-1-git-send-email-maxg@mellanox.com>
 <6e99fefd-ff7c-e3ee-087c-ed42baa7f4f5@kernel.dk> <yq1tv955kfy.fsf@oracle.com>
 <a0505439-2bf3-3297-2e8d-5cc0b24cafee@kernel.dk>
 <423a031c-a016-96c6-97ee-fb4e49a0f247@mellanox.com>
 <ddd909c8-1309-5830-0669-371d2ae839fc@kernel.dk> <yq1o8zc5jc2.fsf@oracle.com>
 <a98735bc-3a03-0816-5fc1-abac2c6b4fc6@mellanox.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <311f238d-6d7a-4285-5a87-ea7ff2a29e7a@kernel.dk>
Date:   Mon, 23 Sep 2019 08:05:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a98735bc-3a03-0816-5fc1-abac2c6b4fc6@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/19 3:21 PM, Max Gurtovoy wrote:
> 
> On 9/22/2019 8:31 PM, Martin K. Petersen wrote:
>> Jens,
>>
>>> It's effectively the same thing, I really don't think we need (or should
>>> have) a BUG/BUG_ON for this condition. Just return an error?
>>> Just include a T10_PI_TYPE0_PROTECTION case in the switch, have it log
>>> and return an error. Add a comment on how it's impossible, if need be.
>>> I don't think it has to be more complicated than that.
>> The additional case statement is inside an iterator loop which would
>> bomb for Type 0 since there is no protection buffer to iterate
>> over. We'd presumably never reach that default: case before
>> dereferencing something bad.
>>
>> t10_pi_verify() is a static function exclusively called by helpers that
>> pass in either 1 or 3 as argument. It seems kind of silly that we have
>> to jump through hoops to silence a compiler warning for this. I would
>> prefer a BUILD_BUG_ON(type == T10_PI_TYPE0_PROTECTION) at the top of the
>> function but that does not satisfy the -Wswitch logic either.
>>
>> Anyway. Enough energy wasted on this. I'm OK with either the default:
>> case or Max' if statement approach. My objection is purely
>> wrt. introducing semantically incorrect and/or unreachable code to
>> silence compiler warnings. Seems backwards.
> 
> I agree that enough energy wasted here :)

Agree ;-)

> Attached some proposal to fix this warning.
> 
> Let me know if you want me to send it to the mailing list

OK, fine with me, I've queued it up.

-- 
Jens Axboe

